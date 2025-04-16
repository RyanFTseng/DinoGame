module Pixel_Generation_Circuit (
    output reg [9:0] oRed,
    output reg [9:0] oGreen,
    output reg [9:0] oBlue,
    input [9:0] iVGA_X,
    input [9:0] iVGA_Y,
    input iVGA_CLK,
    input iRST_N,
	 input iJUMP
);

    // Parameters matching pixel_generation
    parameter SQUARE_SIZE = 16;            // Width of square sides in pixels
    parameter SQUARE_VELOCITY_POS = 20;     // Set position change value for positive direction
    parameter SQUARE_VELOCITY_NEG = -10;    // Set position change value for negative direction
    parameter X_MAX = 630;                 // Right border of display area
    parameter Y_MAX = 300;                 // Bottom border of display area
    parameter TOP_BORDER_OFFSET = 20;      // Offset from the top of the screen
    parameter LEFT_BORDER_OFFSET = 20;     // Offset from the left side of the screen
    parameter SQ_RGB = 12'hFF0;            // Yellow square (red + green)
    parameter BG_RGB = 12'h00F;            // Blue background
	 parameter GROUND_RGB = 12'hCA7;  							// Light brown color
	 parameter GAMEOVER_RGB = 12'hF00;            // Blue background

	 parameter DINO_SIZE = 32;
	 parameter DINO_RGB = 12'h0F0;         	   // dino color
	 parameter DINO_VELOCITY_POS = 4;    	 // Set position change value for positive direction
    parameter DINO_VELOCITY_NEG = -6;    		// Set position change value for negative direction
	 parameter DINO_START_X = 300;
	 parameter DINO_START_Y = 300-(DINO_SIZE/2);
	 parameter TOP_CEILING = 220;
	 

    // Square boundaries and position
    reg [9:0] sq_x_reg = 0, sq_y_reg = 300;  // Regs to track top-left position of the square
    reg [9:0] x_delta_reg = SQUARE_VELOCITY_POS, y_delta_reg = 2; // Velocity regs for X and Y directions
	 
	 //dino boundaries and position
    reg [9:0] dino_x_reg = 300, dino_y_reg = 250;  // Regs to track top-left position of the square
    reg [9:0] x_dino_delta_reg = 2, y_dino_delta_reg = 2; // Velocity regs for X and Y directions

    wire refresh_tick;  // Generate a tick at the end of each frame
    assign refresh_tick = (iVGA_Y == Y_MAX && iVGA_X == 0);  // Trigger when frame ends
	 
	 //point counter
	 reg [9:0] score = 0;
	 

    // Square boundaries
    wire [9:0] sq_x_l, sq_x_r, sq_y_t, sq_y_b;
    assign sq_x_l = sq_x_reg;
    assign sq_y_t = sq_y_reg;
    assign sq_x_r = sq_x_l + SQUARE_SIZE - 1;
    assign sq_y_b = sq_y_t + SQUARE_SIZE - 1;
	 
	 // Dino boundaries
    wire [9:0] dino_x_l, dino_x_r, dino_y_t, dino_y_b;
    assign dino_x_l = dino_x_reg;
    assign dino_y_t = dino_y_reg;
    assign dino_x_r = dino_x_l + DINO_SIZE - 1;
    assign dino_y_b = dino_y_t + DINO_SIZE - 1 ;
	 
	 reg [15:0] dino_data_reg; // Register to store dino ROM output
	 wire [15:0] dino_data;  // Output from dino_rom
    reg [3:0] dino_row;    // Row address for dino_rom (3-bit for 8 rows)
    reg dino_pixel;        // Whether the current pixel is part of the dino
	 reg [3:0] dino_col; // 3-bit register to address 8 columns (0-7)

    // Instantiate the dino_rom module
    dino_rom dino_rom_inst (
        .addr(dino_row),
        .data(dino_data)
    );
	 
	 //score and text signals
	 wire [3:0] dig0, dig1;
	 reg d_inc; 
	 reg d_clr;
	 wire [3:0] text_on;
	 wire [11:0] text_rgb;
	 reg [11:0] rgb_next;
	 
	 
	 
	 // instantiate score display(
    score_display text_unit(
        .clk(iVGA_CLK),
        .x(iVGA_X),
        .y(iVGA_Y),
        .dig0(dig0),
        .dig1(dig1),
        .text_on(text_on),
        .text_rgb(text_rgb));	
		  
	//instantiate the score counter
	 m100_counter counter_unit(
    .clk(iVGA_CLK),
    .reset(iRST_N),
    .d_inc(d_inc_pulse),  // Use the single-cycle pulse
    .d_clr(d_clr),
    .dig0(dig0),
    .dig1(dig1)
	);
		  
	 	  
	reg d_inc_pulse;
	reg inc_state;

	// Sequential logic for pulse generation
	always @(posedge iVGA_CLK or negedge iRST_N) begin
		 if (!iRST_N) begin
			  d_inc_pulse <= 1'b0;
			  inc_state <= 1'b0;
		 end
		 else if(collision)begin
			d_clr <= 1'b1;
			
		 end
		 else begin
			  d_inc_pulse <= 1'b0;  // Default to 0 each cycle unless condition is met
			  d_clr<= 1'b0;	
			  if (sq_x_r < DINO_START_X-32) begin
					if (!inc_state) begin
						 d_inc_pulse <= 1'b1;  // Pulse only on the first cycle
						 inc_state <= 1'b1;    // Set state to indicate condition has been met
					end
			  end
			  else begin
					inc_state <= 1'b0;  // Reset state when the condition is no longer met
			  end
		 end
	end
	 

    // signal if square is at pixel when drawing onto screen
    wire sq_on;
    assign sq_on = (sq_x_l <= iVGA_X) && (iVGA_X <= sq_x_r) &&
                   (sq_y_t <= iVGA_Y) && (iVGA_Y <= sq_y_b);
						 
	 // signal if dino is at pixel when drawing onto screen
    wire dino_on;
    assign dino_on = (dino_x_l <= iVGA_X) && (iVGA_X <= dino_x_r) &&
                   (dino_y_t <= iVGA_Y) && (iVGA_Y <= dino_y_b);
						 
	 //ground signal
	 wire ground_on;
    assign ground_on = (316 <= iVGA_Y);
						 
	 // Collision detection
	 wire collision_x, collision_y, collision;
	 assign collision_x = (sq_x_r >= dino_x_l) && (sq_x_l <= dino_x_r);
	 assign collision_y = (sq_y_b >= dino_y_t) && (sq_y_t <= dino_y_b);
	 assign collision = collision_x && collision_y;
	 
	 // random bit generation
		reg [3:0] lfsr;   // 4-bit LFSR register
		wire rand_bit;

		always @(posedge iVGA_CLK or negedge iRST_N) begin
			 if (!iRST_N) begin
				  lfsr <= 4'b1011;  // Initial seed for the LFSR
			 end else begin
				  // Update LFSR: simple feedback polynomial (X^4 + X^3 + 1)
				  
				  lfsr <= {lfsr[2:0], lfsr[3] ^ lfsr[2]};
			 end
		end

		assign rand_bit = lfsr[0]; // Use the least significant bit of LFSR as random bit (0 or 1)

    // Position update logic for square (runs on refresh tick)
    always @(posedge iVGA_CLK or negedge iRST_N)
    begin
        if (!iRST_N) begin
            // Reset square to starting position and reset velocities
            sq_x_reg <= Y_MAX; // Start from the defined offset from the left
            sq_y_reg <= sq_y_reg;   // Start from the defined offset from the top
            x_delta_reg <= SQUARE_VELOCITY_NEG;
            y_delta_reg <= 2;
        end
        else if (refresh_tick) begin
            // Update square position based on velocity
            sq_x_reg <= sq_x_reg + x_delta_reg;
				
            // Check for X boundary collisions
            if (sq_x_l < LEFT_BORDER_OFFSET) begin
                sq_x_reg <= X_MAX; // Reset square to offset from left
					 if(rand_bit) begin
						sq_y_reg = 300;
					 end
					 else begin
						sq_y_reg = 230;
					 end
                //x_delta_reg <= SQUARE_VELOCITY_POS; // Move right
            end
            else if ((sq_x_r > X_MAX) || (d_clr == 1'b1))  begin
                sq_x_reg <= X_MAX - SQUARE_SIZE; // Reset square to right edge
					 if(d_clr == 1'b1) begin
						sq_y_reg <= 300; // Reset square to right edge
					 end
					 if(x_delta_reg> -30) begin
						x_delta_reg = x_delta_reg-1; // Move left
					 end
            end
        end
    end
	 
	 

	 
	 // Position update logic for dino (runs on refresh tick)
    always @(posedge iVGA_CLK or negedge iRST_N)
    begin
        if (!iRST_N) begin
            // Reset square to starting position and reset velocities
            dino_x_reg <= DINO_START_X; // Start from the defined offset from the left
            dino_y_reg <= DINO_START_Y;   // Start from the defined offset from the top
            y_dino_delta_reg <= 0;  // initial jump velocity
		 end
        else if (refresh_tick) begin
            // Update loop for dino position based on velocity
            dino_y_reg <= dino_y_reg + y_dino_delta_reg;
				
            // Boundary collision detection and velocity change
            // Check for Y boundary collisions
            if (iJUMP) begin //no jump signal
					 if(dino_y_reg >= DINO_START_Y) begin // check if bottom of dino is below floor
						dino_y_reg <= DINO_START_Y;
						y_dino_delta_reg <= 0;
						
					 end
					 else if(dino_y_b <= Y_MAX) begin		 //check if top of dino is above ceiling
						y_dino_delta_reg <= DINO_VELOCITY_POS;  // Move down
					 end
                
            end
            else if (!iJUMP) begin //jump is pressed 
					 if(dino_y_reg >= DINO_START_Y ) begin	//check if bottom of dino is above ground
						y_dino_delta_reg <= DINO_VELOCITY_NEG;  // Move up
					 end
					 if(dino_y_t <= TOP_CEILING) begin // check if top of dino hits ceiling
						y_dino_delta_reg <= DINO_VELOCITY_POS;			//move down
					 end
            end          
        end
    end
	 
	 
    // RGB color control
    always @(posedge iVGA_CLK or negedge iRST_N)
    begin
        if (!iRST_N) begin
            oRed <= 0;
            oGreen <= 0; 
            oBlue <= 0;
        end
        else begin
            if (sq_on) begin
					if(x_delta_reg > X_MAX) begin
						// Square is visible, set RGB to yellow (scaling 4-bit colors to 10-bit outputs)
                oRed   <= {SQ_RGB[11:8], SQ_RGB[11:8], 2'b00};  // Scale 4-bit to 10-bit
                oGreen <= {SQ_RGB[7:4], SQ_RGB[7:4], 2'b00};    // Scale 4-bit to 10-bit
                oBlue  <= {SQ_RGB[3:0], SQ_RGB[3:0], 2'b00};    // Scale 4-bit to 10-bit
					end
            end
				else if (dino_on) begin
						// Calculate row and column indices within the dino bitmap, scaling if necessary
							 dino_row = (iVGA_Y - dino_y_reg) >> 1; // Divide by 2 to scale to 16x16 size
							 dino_col = (iVGA_X - dino_x_reg) >> 1; // Divide by 2 to scale to 16x16 size

							 // Check boundaries to ensure indices are within 0-15
							 if (dino_row < 16 && dino_col < 16) begin
								  dino_pixel = dino_data[15 - dino_col]; // Access bit in the current row
							 end else begin
								  dino_pixel = 0; // Default to background when out of bounds
							 end

							 // Set colors based on dino_pixel (1 for dinosaur, 0 for background)
							 if (dino_pixel) begin
									if(!collision) begin
								  // Display dino color when pixel is active
									  oRed   <= {DINO_RGB[11:8], DINO_RGB[11:8], 2'b00};
									  oGreen <= {DINO_RGB[7:4], DINO_RGB[7:4], 2'b00};
									  oBlue  <= {DINO_RGB[3:0], DINO_RGB[3:0], 2'b00};
								  end
								  else if(collision) begin
									  oRed   <= {GAMEOVER_RGB[11:8], GAMEOVER_RGB[11:8], 2'b00};
									  oGreen <= {GAMEOVER_RGB[7:4], GAMEOVER_RGB[7:4], 2'b00};
									  oBlue  <= {GAMEOVER_RGB[3:0], GAMEOVER_RGB[3:0], 2'b00};
								  end
							 end else begin
								  // Background color when not on dino pixel
								  oRed   <= {BG_RGB[11:8], BG_RGB[11:8], 2'b00};
								  oGreen <= {BG_RGB[7:4], BG_RGB[7:4], 2'b00};
								  oBlue  <= {BG_RGB[3:0], BG_RGB[3:0], 2'b00};
							 end
				end
				else if(text_on) begin
					oRed   <= {text_rgb[11:8], text_rgb[11:8], 2'b00};
					oGreen <= {text_rgb[7:4], text_rgb[7:4], 2'b00};
					oBlue  <= {text_rgb[3:0], text_rgb[3:0], 2'b00};
				end
				else if(ground_on) begin
					oRed   <= {GROUND_RGB[11:8], GROUND_RGB[11:8], 2'b00};
					oGreen <= {GROUND_RGB[7:4], GROUND_RGB[7:4], 2'b00};
					oBlue  <= {GROUND_RGB[3:0], GROUND_RGB[3:0], 2'b00};
				end
				//set to background color by default
            else begin
                // Background color (blue)
                oRed   <= {BG_RGB[11:8], BG_RGB[11:8], 2'b00};  // Scale 4-bit to 10-bit
                oGreen <= {BG_RGB[7:4], BG_RGB[7:4], 2'b00};    // Scale 4-bit to 10-bit
                oBlue  <= {BG_RGB[3:0], BG_RGB[3:0], 2'b00};    // Scale 4-bit to 10-bit
            end
        end
    end
endmodule
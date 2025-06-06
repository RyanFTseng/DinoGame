module ascii_rom(
	input clk, 
	input wire [10:0] addr,
	output reg [7:0] data
	);

	(* rom_style = "block" *)	// Infer BRAM

	reg [10:0] addr_reg;
	
	always @(posedge clk)
		addr_reg <= addr;
		
	always @*
		case(addr_reg)
			// code x30 (0)
			11'h300: data = 8'b00000000;	//
			11'h301: data = 8'b00000000;	//
			11'h302: data = 8'b00111000;	//  ***  
			11'h303: data = 8'b01101100;	// ** **
			11'h304: data = 8'b11000110;	//**   **
			11'h305: data = 8'b11000110;	//**   **
			11'h306: data = 8'b11000110;	//**   **
			11'h307: data = 8'b11000110;	//**   **
			11'h308: data = 8'b11000110;	//**   **
			11'h309: data = 8'b11000110;	//**   **
			11'h30a: data = 8'b01101100;	// ** **
			11'h30b: data = 8'b00111000;	//  ***
			11'h30c: data = 8'b00000000;	//
			11'h30d: data = 8'b00000000;	//
			11'h30e: data = 8'b00000000;	//
			11'h30f: data = 8'b00000000;	//
			// code x31 (1)
			11'h310: data = 8'b00000000;	//
			11'h311: data = 8'b00000000;	//
			11'h312: data = 8'b00011000;	//   **  
			11'h313: data = 8'b00111000;	//  ***
			11'h314: data = 8'b01111000;	// ****
			11'h315: data = 8'b00011000;	//   **
			11'h316: data = 8'b00011000;	//   **
			11'h317: data = 8'b00011000;	//   **
			11'h318: data = 8'b00011000;	//   **
			11'h319: data = 8'b00011000;	//   **
			11'h31a: data = 8'b01111110;	// ******
			11'h31b: data = 8'b01111110;	// ******
			11'h31c: data = 8'b00000000;	//
			11'h31d: data = 8'b00000000;	//
			11'h31e: data = 8'b00000000;	//
			11'h31f: data = 8'b00000000;	//
			// code x32 (2)
			11'h320: data = 8'b00000000;	//
			11'h321: data = 8'b00000000;	//
			11'h322: data = 8'b11111110;	//*******  
			11'h323: data = 8'b11111110;	//*******
			11'h324: data = 8'b00000110;	//     **
			11'h325: data = 8'b00000110;	//     **
			11'h326: data = 8'b11111110;	//*******
			11'h327: data = 8'b11111110;	//*******
			11'h328: data = 8'b11000000;	//**
			11'h329: data = 8'b11000000;	//**
			11'h32a: data = 8'b11111110;	//*******
			11'h32b: data = 8'b11111110;	//*******
			11'h32c: data = 8'b00000000;	//
			11'h32d: data = 8'b00000000;	//
			11'h32e: data = 8'b00000000;	//
			11'h32f: data = 8'b00000000;	//
			// code x33 (3)
			11'h330: data = 8'b00000000;	//
			11'h331: data = 8'b00000000;	//
			11'h332: data = 8'b11111110;	//*******  
			11'h333: data = 8'b11111110;	//*******
			11'h334: data = 8'b00000110;	//     **
			11'h335: data = 8'b00000110;	//     **
			11'h336: data = 8'b00111110;	//  *****
			11'h337: data = 8'b00111110;	//  *****
			11'h338: data = 8'b00000110;	//     **
			11'h339: data = 8'b00000110;	//     **
			11'h33a: data = 8'b11111110;	//*******
			11'h33b: data = 8'b11111110;	//*******
			11'h33c: data = 8'b00000000;	//
			11'h33d: data = 8'b00000000;	//
			11'h33e: data = 8'b00000000;	//
			11'h33f: data = 8'b00000000;	//
			// code x34 (4)
			11'h340: data = 8'b00000000;	//
			11'h341: data = 8'b00000000;	//
			11'h342: data = 8'b11000110;	//**   **  
			11'h343: data = 8'b11000110;	//**   **
			11'h344: data = 8'b11000110;	//**   **
			11'h345: data = 8'b11000110;	//**   **
			11'h346: data = 8'b11111110;	//*******
			11'h347: data = 8'b11111110;	//*******
			11'h348: data = 8'b00000110;	//     **
			11'h349: data = 8'b00000110;	//     **
			11'h34a: data = 8'b00000110;	//     **
			11'h34b: data = 8'b00000110;	//     **
			11'h34c: data = 8'b00000000;	//
			11'h34d: data = 8'b00000000;	//
			11'h34e: data = 8'b00000000;	//
			11'h34f: data = 8'b00000000;	//
			// code x35 (5)
			11'h350: data = 8'b00000000;	//
			11'h351: data = 8'b00000000;	//
			11'h352: data = 8'b11111110;	//*******  
			11'h353: data = 8'b11111110;	//*******
			11'h354: data = 8'b11000000;	//**
			11'h355: data = 8'b11000000;	//**
			11'h356: data = 8'b11111110;	//*******
			11'h357: data = 8'b11111110;	//*******
			11'h358: data = 8'b00000110;	//     **
			11'h359: data = 8'b00000110;	//     **
			11'h35a: data = 8'b11111110;	//*******
			11'h35b: data = 8'b11111110;	//*******
			11'h35c: data = 8'b00000000;	//
			11'h35d: data = 8'b00000000;	//
			11'h35e: data = 8'b00000000;	//
			11'h35f: data = 8'b00000000;	//
			// code x36 (6)
			11'h360: data = 8'b00000000;	//
			11'h361: data = 8'b00000000;	//
			11'h362: data = 8'b11111110;	//*******  
			11'h363: data = 8'b11111110;	//*******
			11'h364: data = 8'b11000000;	//**
			11'h365: data = 8'b11000000;	//**
			11'h366: data = 8'b11111110;	//*******
			11'h367: data = 8'b11111110;	//*******
			11'h368: data = 8'b11000110;	//**   **
			11'h369: data = 8'b11000110;	//**   **
			11'h36a: data = 8'b11111110;	//*******
			11'h36b: data = 8'b11111110;	//*******
			11'h36c: data = 8'b00000000;	//
			11'h36d: data = 8'b00000000;	//
			11'h36e: data = 8'b00000000;	//
			11'h36f: data = 8'b00000000;	//
			// code x37 (7)
			11'h370: data = 8'b00000000;	//
			11'h371: data = 8'b00000000;	//
			11'h372: data = 8'b11111110;	//*******  
			11'h373: data = 8'b11111110;	//*******
			11'h374: data = 8'b00000110;	//     **
			11'h375: data = 8'b00000110;	//     **
			11'h376: data = 8'b00000110;	//     **
			11'h377: data = 8'b00000110;	//     **
			11'h378: data = 8'b00000110;	//     **
			11'h379: data = 8'b00000110;	//     **
			11'h37a: data = 8'b00000110;	//     **
			11'h37b: data = 8'b00000110;	//     **
			11'h37c: data = 8'b00000000;	//
			11'h37d: data = 8'b00000000;	//
			11'h37e: data = 8'b00000000;	//
			11'h37f: data = 8'b00000000;	//
			// code x38 (8)
			11'h380: data = 8'b00000000;	//
			11'h381: data = 8'b00000000;	//
			11'h382: data = 8'b11111110;	//*******  
			11'h383: data = 8'b11111110;	//*******
			11'h384: data = 8'b11000110;	//**   **
			11'h385: data = 8'b11000110;	//**   **
			11'h386: data = 8'b11111110;	//*******
			11'h387: data = 8'b11111110;	//*******
			11'h388: data = 8'b11000110;	//**   **
			11'h389: data = 8'b11000110;	//**   **
			11'h38a: data = 8'b11111110;	//*******
			11'h38b: data = 8'b11111110;	//*******
			11'h38c: data = 8'b00000000;	//
			11'h38d: data = 8'b00000000;	//
			11'h38e: data = 8'b00000000;	//
			11'h38f: data = 8'b00000000;	//
			// code x39 (9)
			11'h390: data = 8'b00000000;	//
			11'h391: data = 8'b00000000;	//
			11'h392: data = 8'b11111110;	//*******  
			11'h393: data = 8'b11111110;	//*******
			11'h394: data = 8'b11000110;	//**   **
			11'h395: data = 8'b11000110;	//**   **
			11'h396: data = 8'b11111110;	//*******
			11'h397: data = 8'b11111110;	//*******
			11'h398: data = 8'b00000110;	//     **
			11'h399: data = 8'b00000110;	//     **
			11'h39a: data = 8'b11111110;	//*******
			11'h39b: data = 8'b11111110;	//*******
			11'h39c: data = 8'b00000000;	//
			11'h39d: data = 8'b00000000;	//
			11'h39e: data = 8'b00000000;	//
			11'h39f: data = 8'b00000000;	//
			// code x3a (:)
			11'h3a0: data = 8'b00000000;	//
			11'h3a1: data = 8'b00000000;	//
			11'h3a2: data = 8'b00000000;	//
			11'h3a3: data = 8'b00000000;	//
			11'h3a4: data = 8'b00011000;	//   **
			11'h3a5: data = 8'b00011000;	//   **
			11'h3a6: data = 8'b00000000;	//
			11'h3a7: data = 8'b00000000;	//
			11'h3a8: data = 8'b00011000;	//   **
			11'h3a9: data = 8'b00011000;	//   **
			11'h3aa: data = 8'b00000000;	//   
			11'h3ab: data = 8'b00000000;	//   
			11'h3ac: data = 8'b00000000;	//
			11'h3ad: data = 8'b00000000;	//
			11'h3ae: data = 8'b00000000;	//
			11'h3af: data = 8'b00000000;	//
			
			// code x43 (C)
			11'h430: data = 8'b00000000;	//
			11'h431: data = 8'b00000000;	//
			11'h432: data = 8'b01111100;	// *****
			11'h433: data = 8'b11111110;	//*******
			11'h434: data = 8'b11000000;	//**
			11'h435: data = 8'b11000000;	//**   
			11'h436: data = 8'b11000000;	//**
			11'h437: data = 8'b11000000;	//**
			11'h438: data = 8'b11000000;	//** 
			11'h439: data = 8'b11000000;	//** 
			11'h43a: data = 8'b11111110;	//*******
			11'h43b: data = 8'b01111100;	// *****
			11'h43c: data = 8'b00000000;	//
			11'h43d: data = 8'b00000000;	//
			11'h43e: data = 8'b00000000;	//
			11'h43f: data = 8'b00000000;	//
			// code x45 (E)
			11'h450: data = 8'b00000000;	//
			11'h451: data = 8'b00000000;	//
			11'h452: data = 8'b11111110;	//*******
			11'h453: data = 8'b11111110;	//*******
			11'h454: data = 8'b11000000;	//**
			11'h455: data = 8'b11000000;	//**   
			11'h456: data = 8'b11111100;	//******
			11'h457: data = 8'b11111100;	//******
			11'h458: data = 8'b11000000;	//** 
			11'h459: data = 8'b11000000;	//** 
			11'h45a: data = 8'b11111110;	//*******
			11'h45b: data = 8'b11111110;	//*******
			11'h45c: data = 8'b00000000;	//
			11'h45d: data = 8'b00000000;	//
			11'h45e: data = 8'b00000000;	//
			11'h45f: data = 8'b00000000;	//
			// code x4f (O)
			11'h4f0: data = 8'b00000000;	//
			11'h4f1: data = 8'b00000000;	//
			11'h4f2: data = 8'b01111100;	// *****
			11'h4f3: data = 8'b11111110;	//*******
			11'h4f4: data = 8'b11000110;	//**   **
			11'h4f5: data = 8'b11000110;	//**   **
			11'h4f6: data = 8'b11000110;	//**   **
			11'h4f7: data = 8'b11000110;	//**   **
			11'h4f8: data = 8'b11000110;	//**   **
			11'h4f9: data = 8'b11000110;	//**   **
			11'h4fa: data = 8'b11111110;	//*******
			11'h4fb: data = 8'b01111100;	// *****
			11'h4fc: data = 8'b00000000;	//
			11'h4fd: data = 8'b00000000;	//
			11'h4fe: data = 8'b00000000;	//
			11'h4ff: data = 8'b00000000;	//
			
			// code x52 (R)
			11'h520: data = 8'b00000000;	//
			11'h521: data = 8'b00000000;	//
			11'h522: data = 8'b11111100;	//******
			11'h523: data = 8'b11111110;	//*******
			11'h524: data = 8'b11000110;	//**   **
			11'h525: data = 8'b11000110;	//**   **
			11'h526: data = 8'b11111110;	//*******
			11'h527: data = 8'b11111100;	//******   
			11'h528: data = 8'b11011000;	//** **  
			11'h529: data = 8'b11001100;	//**  ** 
			11'h52a: data = 8'b11000110;	//**   **
			11'h52b: data = 8'b11000110;	//**   **
			11'h52c: data = 8'b00000000;	//
			11'h52d: data = 8'b00000000;	//
			11'h52e: data = 8'b00000000;	//
			11'h52f: data = 8'b00000000;	//
			// code x53 (S)
			11'h530: data = 8'b00000000;	//
			11'h531: data = 8'b00000000;	//
			11'h532: data = 8'b01111100;	// *****
			11'h533: data = 8'b11111110;	//*******
			11'h534: data = 8'b11000000;	//**   
			11'h535: data = 8'b11000000;	//**   
			11'h536: data = 8'b11111100;	//******
			11'h537: data = 8'b01111110;	// ******   
			11'h538: data = 8'b00000110;	//     **  
			11'h539: data = 8'b00000110;	//     **
			11'h53a: data = 8'b11111110;	//*******  
			11'h53b: data = 8'b01111100;	// ***** 
			11'h53c: data = 8'b00000000;	//
			11'h53d: data = 8'b00000000;	//
			11'h53e: data = 8'b00000000;	//
			11'h53f: data = 8'b00000000;	//
			
		endcase
endmodule
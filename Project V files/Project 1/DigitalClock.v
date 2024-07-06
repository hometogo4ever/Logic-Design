`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:58:20 12/13/2023 
// Design Name: 
// Module Name:    DigitalClock 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DigitalClock(
    input CLK,
	 input s6,
	 //input s5,
	 input s4,
	 input s3,
	 input s2,
	 input s1,
	 output [6:0] d1,
	 output [6:0] d2,
	 output [6:0] d3,
	 output [6:0] d4,
	 output [6:0] d5,
	 output [6:0] d6,
	 output [5:0] led
    );
	 
	 //stabilized asynchronous chattering signals
	 wire stablemode;
	 wire stableset;
	 wire stableup;
	 wire stabledown;
	 //wire stablewhat;
	 wire stablereset;
	 
	 stabilizer sb1 (CLK,s1, stablemode);
	 stabilizer sb2 (CLK,s2, stableset);
	 stabilizer sb3 (CLK,s3, stableup);
	 stabilizer sb4 (CLK,s4, stabledown);
	 //stabilizer sb5 (CLK,s5, stablewhat);
	 stabilizer sb6 (CLK,s6, stablereset);
	 
	 wire [6:0] d11;
	 wire [6:0] d12;
	 wire [6:0] d13;
	 wire [6:0] d14;
	 wire [6:0] d15;
	 wire [6:0] d16;
	 
	 wire [6:0] d21;
	 wire [6:0] d22;
	 wire [6:0] d23;
	 wire [6:0] d24;
	 wire [6:0] d25;
	 wire [6:0] d26;
	
	wire [5:0] l;
	 
	 wire clk1;
	 secondcounter sc1 (CLK, clk1);
	 
	 //Clock data 
	 wire [4:0] h;
	 wire [5:0] m;
	 wire [5:0] s;
	 wire [4:0] ih;
	 wire [5:0] im;
	 wire hout;
	 wire mout;
		
	wire h1224;
	wire rawdisplayset;
	wire [2:0] level;
	wire displaymode;
	
	LightCounter lc1 (displaymode, CLK, stablereset, stableup, stabledown, level);
	ModeCounter mc1 (displaymode, CLK, stablereset, stableset, h1224);
	
	wire [6:0] d31;
	wire [6:0] d32;
	wire [6:0] d33;
	wire [6:0] d34;
	wire [6:0] d35;
	wire [6:0] d36;
	
	assign d31 = h1224?7'b0110000:7'b1101101;
	assign d32 = h1224?7'b1101101:7'b0110011;
	assign d33 = 7'b0010111;
	LevelDemux ld1 (level, d36);

	//clock set data : initial begin signal
	 wire cset;
	 wire clockon;
	 wire hset;
	 wire mset;
	 
	 //Counter for clock
	 Counter second (clockon, clk1, 59, stablereset, cset, s,s, sout);
	 Counter minute (clockon, sout, 59, stablereset, cset, im,m, mout);
	 Counter hour (clockon, mout, 23, stablereset, cset, ih,h, hout);
	 
	 //clock set data : status ON signal
	 wire rawcset;
	 wire rawhset;
	 wire rawmset;
	 
	 // initial begin signal for clock, calender
	 wire coff;
	 wire caloff;
	  
	  // which to express : clock or calender
	 wire sel;
	 wire sel2;
	 
	 //caledner set data : initial begin signal
	 wire calset;
	 wire calenderon;
	 wire dset;
	 wire monset;
	 wire yset;
	 wire wset;
	 
	 //calender set data : permanent signal
	 wire rawcalset;
	 wire rawyset;
	 wire rawmonset;
	 wire rawdset;
	 wire rawwset;
		
	 // status Finite State Machine for overall operation
	 clockFSM fsm1 (h1224, CLK, stableset, stablereset,stablemode, 
						clockon,calenderon,
						rawhset, rawmset, rawcset,
						rawyset, rawmonset, rawdset,rawwset, rawcalset,
						sel, sel2, displaymode);
	 
	 //Making Permanent signal to pulse signal
	 PulseGenerator pgc (clk1, rawcset, cset);
	 PulseGenerator pgc2 (CLK, rawhset, hset);
	 PulseGenerator pgc3 (CLK, rawmset, mset);
	 PulseGenerator pgc5(CLK, !clockon, coff);
	 
	 //Display for clock mode
	 Selector sl (h1224, ih, im, s, h, m, s, clk1, clockon, rawhset, rawmset, rawsset,0, d11, d12, d13, d14, d15, d16);
	 
	 // Plus Minus Counter for clock setting
	 PMCounter pmh (rawhset,CLK,coff, stableup, stabledown, 23,  h, ih);
	 PMCounter pmm (rawmset,CLK,coff, stableup, stabledown, 59,  m, im);
	 
	 //Calender
	 
	 //Calender counter data
	 wire [6:0] y;
	 wire [3:0] mon;
	 wire [4:0] d;
	 wire [2:0] w;
	 wire [6:0] iy;
	 wire [3:0] imon;
	 wire [4:0] id;
	 wire [2:0] iw;
	 wire dout;
	 wire monout;
	 wire yout;
	wire trash;
	wire [4:0] max;
	wire [4:0] imax;
	
	Maximum m1 (y, mon, max);
	Maximum m2 (iy, imon, imax);
	
	// Calender counter
	Counter dayc (calenderon, hout, max,stablereset, calset, id,d, dout);
	Counter monthc (calenderon, dout, 11, stablereset, calset, imon,mon, monout);
	Counter yearc (calenderon, monout, 99, stablereset, calset, iy,y, yout);
	Counter weekc (calanderon, dout, 6, stablereset, calset, iw,w,trash);

	// Pernament data to pulse signal
	PulseGenerator pgcal (clk1, rawcalset, calset);
	PulseGenerator pgc22 (CLK, rawdset, dset);
	PulseGenerator pgc23 (CLK, rawmonset, monset);
	PulseGenerator pgc24 (CLK, rawyset, yset);
	PulseGenerator pgc26 (CLK, rawwset, wset);
	PulseGenerator pgc25(CLK, !calenderon, caloff);

	// diplay for calander
	Selector sl2 (0, iy, imon, id, y, mon, d, clk1, calenderon, rawyset, rawmonset, rawdset,1, d21, d22, d23, d24, d25, d26);
	LEDSelector s13 (w, iw, calenderon, rawwset, l, clk1);

	//Plus minus counter for calander mode
	PMCounter pmy (rawyset,CLK,caloff, stableup, stabledown, 99, y, iy);
	PMCounter pmmon (rawmonset,CLK,caloff, stableup, stabledown, 11, mon, imon);
	PMCounter pmd (rawdset,CLK,caloff, stableup, stabledown, imax,d, id);
	PMCounter pmw (rawwset,CLK,caloff, stableup, stabledown, 6,w, iw);
	
	
	 
	wire clk2;
	ClockAdjust cdds1 (CLK,level, clk2);
	
	assign d1 = (sel2?d31:(sel ? d11 : d21))	*clk2;
	assign d2 = (sel2?d32:(sel ? d12 : d22))	*clk2;
	assign d3 = (sel2?d33:(sel ? d13 : d23))	*clk2;
	assign d4 = (sel2?d34:(sel ? d14 : d24))	*clk2;
	assign d5 = (sel2?d35:(sel ? d15 : d25))	*clk2;
	assign d6 = (sel2?d36:(sel ? d16 : d26))	*clk2;
	assign led = l * clk2;
endmodule

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
	 
	 wire [6:0] d41;
	 wire [6:0] d42;
	 wire [6:0] d43;
	 wire [6:0] d44;
	 wire [6:0] d45;
	 wire [6:0] d46;
	
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
	 wire mset;
	 
	 //Counter for clock
	 Counter second (clockon, clk1, 59, stablereset, cset, s,s, sout);
	 Counter minute (clockon, sout, 59, stablereset, mset, im,m, mout);
	 Counter hour (clockon, mout, 23, stablereset, cset, ih,h, hout);
	 
	 //clock set data : status ON signal
	 wire rawcset;
	 wire rawhset;
	 wire rawmset;
	 
	 
	 // initial begin signal for clock, calender
	 wire coff;
	  
	  // which to express : clock or calender
	 wire sel;
	 wire sel2;
	 
	 wire alset;
	 wire rawalset;
	 wire rawahset;
	 wire rawamset;
	 wire alarmon;
	 wire isalarm;
	 
	 // Alarm var
	 wire [6:0] alarmh;
	wire [6:0] alarmm;
	wire [6:0] ialarmh;
	wire [6:0] ialarmm;
	wire aloff;
	wire isalarm2;
	wire amset;
		
		wire activated;
	AlarmChecker dk1 (CLK, stablereset, stableup, sel, clockon, alarmon, h, alarmh, m, alarmm,isalarm, activated);
		
	 // status Finite State Machine for overall operation
	 clockFSM fsm1 (h1224, CLK, stableset, stablereset,stablemode,
						clockon,alarmon,
						rawhset, rawmset, rawcset,
						rawalset, rawahset, rawamset,
						sel, sel2, displaymode);
	 
	 //Making Permanent signal to pulse signal
	 PulseGenerator pgc (clk1, rawcset, cset);
	 PulseGenerator psf (CLK, !rawmset, mset);
	 PulseGenerator pgc5(CLK, !clockon, coff);
	 
	 //Display for clock mode
	 Selector sl (h1224, ih, im, s, h, m, s, clk1, clockon, rawhset, rawmset, rawsset,0, d11, d12, d13, d14, d15, d16);
	 
	 // Plus Minus Counter for clock setting
	 PMCounter pmh (rawhset,CLK,coff, stableup, stabledown, 23,  h, ih);
	 PMCounter pmm (rawmset,CLK,coff, stableup, stabledown, 59,  m, im);
	 
	 //Alarm
	AlarmControl ac1 (CLK, alarmon, stablereset,stableup, alset,ialarmh, isalarm ,alarmh);
	AlarmControl ac2 (CLK, alarmon, stablereset,stableup, amset,ialarmm, isalarm2 ,alarmm);	
	
	PulseGenerator pgcs24w (CLK, rawalset, alset);
	PulseGenerator pgcs26w (CLK, !rawamset, amset);
	 PulseGenerator pgc25a(CLK, !alarmon, aloff);
	 
	PMCounter pmasdah (rawahset, CLK, aloff, stableup, stabledown, 23, alarmh, ialarmh);
	PMCounter pfah2 (rawamset, CLK, aloff, stableup, stabledown, 59, alarmm, ialarmm);
	AlarmSelector as1 (isalarm, ialarmh, ialarmm, alarmh, alarmm, clk1, alarmon, rawahset, rawamset, d21, d22, d23, d24, d25, d26);
	
	
	//StopWatch
	wire clk4;
	MiliSecondCount msc (CLK, clk4);
	wire [5:0] swm;
	wire [5:0] sws;
	wire [6:0] swms;
	wire swmsout;
	wire swsout;
	wire swmout;
	wire stopsig;
	Stopmirror asmdipf (stableset, stopsig, swms, sws, swm);
	
	Counter stopwatchmils (!stopsig, clk4, 99, stablereset, swset, 0,swms, swmsout);
	Counter stopwatchsecond (!stopsig, swmsout, 59, stablereset, swset, 0,sws, swsout);
	Counter stopwatchminute (!stopsig, swsout, 59, stablereset, swset, 0, swm, swmout);
	
	StopwatchDisplay swd (swms, sws, swm, d41, d42, d43, d44, d45, d46);
	
	
	wire clk2;
	wire clk3;
	assign clk3 = !(clk1 * activated);
	ClockAdjust cdds1 (CLK,level, clk2);
	assign d1 = (sel2?(sel ? d41 : d31):(sel ? d11 : d21))	*clk2*clk3;
	assign d2 = (sel2?(sel ? d42 : d32):(sel ? d12 : d22))	*clk2*clk3;
	assign d3 = (sel2?(sel ? d43 : d33):(sel ? d13 : d23))	*clk2*clk3;
	assign d4 = (sel2?(sel ? d44 : d34):(sel ? d14 : d24))	*clk2*clk3;
	assign d5 = (sel2?(sel ? d45 : d35):(sel ? d15 : d25))	*clk2*clk3;
	assign d6 = (sel2?(sel ? d46 : d36):(sel ? d16 : d26))	*clk2*clk3;
	assign led = l * clk2;
	
endmodule

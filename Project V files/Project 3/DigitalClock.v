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
	 input s5,
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
	 wire stablewhat;
	 wire stablereset;
	 
	 stabilizer sb1 (CLK,s1, stablemode);
	 stabilizer sb2 (CLK,s2, stableset);
	 stabilizer sb3 (CLK,s3, stableup);
	 stabilizer sb4 (CLK,s4, stabledown);
	 stabilizer sb5 (CLK,s5, stablewhat);
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
	
	wire [5:0] l1;
	 
	 wire clk1;
	 secondcounter sc1 (CLK, clk1);
	 wire [2:0] num;

	  // which to express : clock or calender
	 wire sel;

	 // status Finite State Machine for overall operation
	 clockFSM fsm1 (CLK, stableset, stablereset,stablemode,stableup,
						num,
						sel);
	 
	//StopWatch
	wire clk4;
	MiliSecondCount msc (CLK, clk4);
	wire [6:0] swm;
	wire [6:0] sws;
	wire [6:0] swms;
	wire swmsout;
	wire swsout;
	wire swmout;
	wire stopsig;
	
	wire [20:0] dat1;
	wire [20:0] dat2;
	wire [20:0] dat3;
	wire [20:0] dat4;
	wire [20:0] dat5;
	
	wire on1;
	wire on2;
	wire on3;
	wire on4;
	wire on5;
	
	Stopmirror asmdipf (stableset, stopsig, swms, sws, swm);
	
	Counter stopwatchmils (!stopsig, clk4, 99, stablereset, swset, 0,swms, swmsout);
	Counter stopwatchsecond (!stopsig, swmsout, 59, stablereset, swset, 0,sws, swsout);
	Counter stopwatchminute (!stopsig, swsout, 59, stablereset, swset, 0, swm, swmout);
	
	Assignator asgn (stopsig,swm, sws, swms, dat1, dat2, dat3, dat4, dat5, on1, on2, on3, on4, on5, stablewhat, stablereset, stabledown);
	pausedisplay pdp (num, swm, sws,swms, dat1, dat2, dat3, dat4, dat5,!(clk1*!stopsig), on1, on2, on3, on4, on5, d11, d12, d13, d14, d15, d16, l1);
	
	
	assign d1 = (sel ? d11 : d21);
	assign d2 = (sel ? d12 : d22);
	assign d3 = (sel ? d13 : d23);
	assign d4 = (sel ? d14 : d24);
	assign d5 = (sel ? d15 : d25);
	assign d6 = (sel ? d16 : d26);
	assign led = l1;
	
endmodule

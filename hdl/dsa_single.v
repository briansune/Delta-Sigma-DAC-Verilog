// =====================================================================
//  ____         _                 ____                      
// | __ )  _ __ (_)  __ _  _ __   / ___|  _   _  _ __    ___ 
// |  _ \ | '__|| | / _` || '_ \  \___ \ | | | || '_ \  / _ \
// | |_) || |   | || (_| || | | |  ___) || |_| || | | ||  __/
// |____/ |_|   |_| \__,_||_| |_| |____/  \__,_||_| |_| \___|
// 
// =====================================================================

`timescale 1ns / 1ps


module dsa_single #(
	parameter dac_bw = 16
)(

	input	wire				clk,
	input	wire				rst_n,
	input	wire	[15 : 0]	din,
	output	wire				dout
);
	
	localparam bw_ext = 2;
	localparam bw_tot = dac_bw + bw_ext;
	
	reg						dout_r;
	reg						dac_dout;
	
	reg signed		[bw_tot-1 : 0]	DAC_acc_1st;
	
	wire signed		[bw_tot-1 : 0]	max_val = (2**(dac_bw - 1) - 1);
	wire signed		[bw_tot-1 : 0]	min_val = -(2**(dac_bw - 1));
	wire signed		[bw_tot-1 : 0]	dac_val = (!dout_r) ? max_val : min_val;
	
	wire signed		[bw_tot-1 : 0]	in_ext = {{bw_ext{din[dac_bw - 1]}}, din};
	wire signed		[bw_tot-1 : 0]	delta_s0_c0 = in_ext + dac_val;
	wire signed		[bw_tot-1 : 0]	delta_s0_c1 = DAC_acc_1st + delta_s0_c0;

	always@(posedge clk)begin
		if(!rst_n)begin
			DAC_acc_1st <= 'd0;
		end else begin
			DAC_acc_1st <= delta_s0_c1;
		end
	end
	
	always@(posedge clk)begin
		if(!rst_n)begin
			dout_r		<= 1'b0;
			dac_dout	<= 1'b0;
		end else begin
			dout_r		<= delta_s0_c1[bw_tot-1];
			dac_dout	<= ~dout_r;
		end
	end
	
	assign dout = dout_r;
	
endmodule
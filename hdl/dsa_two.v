// =====================================================================
//  ____         _                 ____                      
// | __ )  _ __ (_)  __ _  _ __   / ___|  _   _  _ __    ___ 
// |  _ \ | '__|| | / _` || '_ \  \___ \ | | | || '_ \  / _ \
// | |_) || |   | || (_| || | | |  ___) || |_| || | | ||  __/
// |____/ |_|   |_| \__,_||_| |_| |____/  \__,_||_| |_| \___|
// 
// =====================================================================


`timescale 1ns / 1ps


module dsa_two #(
	parameter dac_bw = 16,
	parameter osr = 6
)(

	input wire clk,
	input wire rst_n,
	input wire [15:0] din,
	output wire dout
);
	
	localparam mid_val = 2**(dac_bw - 1) + 2**(osr + 2);
	
	localparam bw_ext = 2;
	localparam bw_tot = dac_bw + bw_ext;
	
	reg						dout_r;
	reg						dac_dout;
	
	reg signed		[bw_tot-1 : 0]	DAC_acc_1st;
	
	wire signed		[bw_tot-1 : 0]	max_val = mid_val;
	wire signed		[bw_tot-1 : 0]	min_val = -mid_val;
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
	
	localparam bw_tot2 = bw_tot + osr;
	
	reg signed		[bw_tot2-1 : 0]	DAC_acc_2nd;
	
	wire signed		[bw_tot2-1 : 0]	max_val2 = mid_val;
	wire signed		[bw_tot2-1 : 0]	min_val2 = -mid_val;
	wire signed		[bw_tot2-1 : 0]	dac_val2 = (!dout_r) ? max_val2 : min_val2;
	
	wire signed		[bw_tot2-1 : 0]	in_ext2 = {{osr{delta_s0_c1[bw_tot - 1]}}, delta_s0_c1};
	wire signed		[bw_tot2-1 : 0]	delta_s1_c0 = in_ext2 + dac_val2;
	wire signed		[bw_tot2-1 : 0]	delta_s1_c1 = DAC_acc_2nd + delta_s1_c0;
	
	always@(posedge clk)begin
		if(!rst_n)begin
			DAC_acc_2nd <= 'd0;
		end else begin
			DAC_acc_2nd <= delta_s1_c1;
		end
	end
	
	always@(posedge clk)begin
		if(!rst_n)begin
			dout_r		<= 1'b0;
			dac_dout	<= 1'b0;
		end else begin
			dout_r		<= delta_s1_c1[bw_tot2-1];
			dac_dout	<= ~dout_r;
		end
	end
	
	assign dout = dout_r;
	
endmodule

# Delta-Sigma-DAC-Verilog

## The measurements are conducted on Spartan 7 Xilinx FPGA with LPF setting - (680R, 1nF).

Oscillscope Measure:

![image](https://user-images.githubusercontent.com/29487339/164624808-22d7779e-76fe-42bc-9464-762ff3e42899.png)

Single Stage Delta-Sigma DAC:

What bitwidth is required on the first stage?

This is commonly considered with i.e. 16bit Input + 2bit.

![image](https://user-images.githubusercontent.com/29487339/164623849-5d9b166e-4096-4519-b08d-78ae2487f0d7.png)

Two Stage Delta-Sigma DAC:

There are a major question when designing the ΔΣ DAC:

What bitwidth is required on the second stage?

My approach is considering 1st stage output i.e. [16bit + 2bit] + log_2(over_sample_freq / filter_freq) + 2^s.

Where, s = 2

![image](https://user-images.githubusercontent.com/29487339/164624610-c9ede55b-ccbb-4a3d-80c1-b08f9f5b3e32.png)



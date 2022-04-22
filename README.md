# Delta-Sigma-DAC-Verilog

## The measurements are conducted on Spartan 7 Xilinx FPGA with LPF setting - (680R, 1nF).

## Common questions:

Why it work?

> 1 bit flip-flop the basic building block of a R-2R DAC hences it is a DAC because it can convert logic to voltage.

> Of cause it is just limited to 0 - low voltage, 1 - high voltage.

> When it is modulated with a carrier frequency it start to make all senses that it can be a really good DAC.

Why two stages?

> The best answer can be referenced from : https://www.beis.de/Elektronik/DeltaSigma/1stOrderDisadvantages.html

> In short when 0 or max (-ve, +ve) is insert to the DAC, the output will result in high tone amputitude that can be reduce via 2 stages.

Oscillscope Measure:

![image](https://user-images.githubusercontent.com/29487339/164624808-22d7779e-76fe-42bc-9464-762ff3e42899.png)

Single Stage Delta-Sigma DAC:

## Resource on FPGA:
![image](https://user-images.githubusercontent.com/29487339/164648001-f8835f9f-b554-4de4-a872-9f509e6d14c2.png)

What bitwidth is required on the first stage?

This is commonly considered with i.e. 16bit Input + 2bit.

![image](https://user-images.githubusercontent.com/29487339/164623849-5d9b166e-4096-4519-b08d-78ae2487f0d7.png)

Two Stage Delta-Sigma DAC:

## Resource on FPGA:
![image](https://user-images.githubusercontent.com/29487339/164648891-c9bbf9a4-4b72-4ec6-b07a-804beaba7988.png)

There are a major question when designing the ΔΣ DAC:

What bitwidth is required on the second stage?

My approach is considering 1st stage output i.e. [16bit + 2bit] + log_2(over_sample_freq / filter_freq) + 2^s.

Where, s = 2

![image](https://user-images.githubusercontent.com/29487339/164624610-c9ede55b-ccbb-4a3d-80c1-b08f9f5b3e32.png)



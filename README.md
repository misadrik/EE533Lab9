# EE533 Lab9

Class Project work together with Zhi Liu and Bennet Cowdin
Responsible for the Convertable FIFO(SRAM) Design.

In this lab, based on what we design during Lab8, we replace the Data Memory with our special fifo_SRAM. 
We made some changes such as, change the equility checker to 8 bits, which allow us use branch equal to sent a dataprocessed signal to fifo. This problem troubles us a lot. And of cause, it have some side effects by making this change. In the future, we may make another change.to change back to 64 bit checker

## Convertable FIFO SRAM
For now, I use schematic to design this FIFO(SRAM).
The Memory is True Dual Port Block. We have a 64bit wide SRAM to store the data and 8-bit wide SRAM to store the CTRL bits. Our design is based on the IDS drop  FIFO and the following schematic.

When there’s no packet store in the SRAM, the FIFO full signal is 0 and NetFPGA has the full access to the SRAM. One a packet is written into the FIFO the FIFO_FULL signal is raised and then then the FIFO become a SRAM and pipeline has the full access to read data from the SRAM and modify the data and store data back according to the SRAM. After all the packet is modified. A data_processed signal is sent. Once the signal arrived, The FIFO read raised, the read counter is enabled and output its data to the Output Queue. The Pipeline can’t write to the 8-bit wide CTRL bit.

**During the Input:**
Once the First_Word signal or the Last_word signal comes. The register is enabled and store the current counter number. This values will be used in the future packet data process.
**During the output:**
There is a equality checker to check the last_addr from the Last_word Register and the output of the read Counter. Once there’s a match the output enable will be reset to 0, as well as the FIFO full signal.
There’s a few things need to note during this design.
1.	During the data input, since data has to go through the fallthrough_smallfifo, once the last packet is written into the SRAM, then the read_enable of small fifo should be disabled.
2.	During the output, we need to take care of the out_rdy and out_wr. The out_wr should change according to the out_rdy. Since the out_rdy is input from the next stage, it can raise at anytime.
3.	Once the FIFO function is not work, the counter should not work.

//Mevawala Vishwa Nitin --> 20BEC068
//UART --> Universal Asynchronous receiver and transmitter
//UART_TOP Module


module uart(tx_clk,rx_clk,ticks,baud_selector,reset,input_clk,
				tx_busy,tx_valid,tx_input,tx_data,tx_enable,
				rx_error,rx_busy,rx_valid,rx_data,rx_enable,rx_input);

input input_clk,reset;

output ticks,tx_clk,rx_clk;
output [1:0] baud_selector;

input tx_enable,tx_data;
output tx_busy,tx_valid;

///transmit data
output [9:0] tx_input;

input rx_enable,rx_input;

//flags
output rx_error,rx_busy,rx_valid;
output [7:0] rx_data;
				
baudrategen b1(.tx_clk(tx_clk),.rx_clk(rx_clk),.ticks(ticks),.baud_selector(baud_selector),
					.reset(reset),.input_clk(input_clk));
uarttransmitter u1(.tx_busy(tx_busy),.tx_valid(tx_valid),.tx_input(tx_input),.tx_data(tx_data),
						 .tx_enable(tx_enable),.clk(tx_clk),.reset(reset));
uartreceiver t1(.rx_error(rx_error),.rx_busy(rx_busy),.rx_valid(rx_valid),.rx_data(rx_data),
					 .rx_enable(rx_enable),.rx_input(rx_input),.ticks(ticks),.clk(rx_clk),.reset(reset));

endmodule

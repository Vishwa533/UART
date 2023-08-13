//Mevawala Vishwa Nitin --> 20BEC068
//UART --> Universal Asynchronous receiver and transmitter
//UART_BAUDRATE GENERATOR


module baudrategen(tx_clk,rx_clk,ticks,baud_selector,reset,input_clk);

input input_clk,reset;

output reg ticks=0,tx_clk=0,rx_clk=0;
output [1:0] baud_selector;

//transmitter counter
reg [14:0] tx_count=15'd0;

//receiver counter
reg [10:0] rx_count=11'd0;

//ticks generator counter
reg [3:0] rx_tick_counter=4'd0;


//constants for transmitter
parameter tx_baud2400  = 15'd20834,
			 tx_baud4800  = 15'd10417,     // from the formula: f/baud rate
			 tx_baud9600  = 15'd5209,
			 tx_baud19200 = 15'd2605;
			 
//constants for receiver
parameter rx_baud2400  = 11'd1303,
			 rx_baud4800  = 11'd652,   // from the formula: (f/16*baud rate)-1
			 rx_baud9600  = 11'd326,
			 rx_baud19200 = 11'd163;
			 
			 
//maximum count calculation
reg [14:0] tx_maxcount=tx_baud9600;  // default baud rate
reg [10:0] rx_maxcount=rx_baud9600;


//selection for baudrate
always @(*)
begin
case(baud_selector)

2'd0:
begin
tx_maxcount = tx_baud2400;
rx_maxcount = rx_baud2400;
end
2'd1:
begin
tx_maxcount = tx_baud4800;
rx_maxcount = rx_baud4800;
end
2'd2:
begin
tx_maxcount = tx_baud9600;
rx_maxcount = rx_baud9600;
end
2'd3:
begin
tx_maxcount = tx_baud19200;
rx_maxcount = rx_baud19200;
end
endcase
end


//transmitter clock generator
always @(posedge input_clk or negedge reset)
begin
if(!reset)
begin
tx_clk=1'd0;
tx_count=15'b0;
end

else
begin
tx_count = tx_count + 15'd1;
tx_clk=1'd0;

if(tx_count == tx_maxcount)
begin
tx_clk = 1'd1;
tx_count = 15'd0;
end

end

end


//receiver clock generator
always @(posedge input_clk or negedge reset)
begin
if(!reset)
begin
rx_clk=1'd0;
rx_count=11'b0;
end

else
begin
rx_count = rx_count + 11'd1;
rx_clk=1'd0;

if(rx_count == rx_maxcount)
begin
rx_clk = 1'd1;
rx_count = 11'd0;
end

end

end


//receiver ticks
 always @(posedge rx_clk or negedge reset)
 begin
 if(!reset)
 begin
 rx_tick_counter = 4'd0;
 ticks = 1'd0;
 end
 else
 begin
 rx_tick_counter = rx_tick_counter + 4'd1;
 ticks = 1'd0;
 if(rx_tick_counter == 4'd8)
 ticks = 1'd1;
 
 else if(rx_tick_counter == 4'd16)
 rx_tick_counter = 4'd0;
 
 end 
 
 end

endmodule

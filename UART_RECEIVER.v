//Mevawala Vishwa Nitin --> 20BEC068
//UART --> Universal Asynchronous receiver and transmitter
//UART_RECEIVER --> SIPO ( Serial In Parallel Out )


module uartreceiver(rx_error,rx_busy,rx_valid,rx_data,rx_enable,rx_input,ticks,clk,reset);

input rx_enable,rx_input,ticks,clk,reset;

//flags
output rx_error,rx_busy,rx_valid;

output reg [7:0] rx_data;

//states
parameter  ideal=3'd0,
				start=3'd1,
				data=3'd2,
				stop=3'd3,
				error=3'd4;
				
reg [2:0] current_state;

//counter for data state
reg [3:0] count=4'd8;

//array for storing the data
reg [7:0] array;

//flag instantiation
assign rx_error = (current_state==error)?1:0;
assign rx_busy = (current_state==data)?1:0;
assign rx_valid = ((current_state==stop) && (ticks==1) && (rx_input==1))?1:0;

always @(posedge clk or negedge reset)
begin
if(!reset)

begin
current_state = ideal;
end

else
begin

case(current_state)
ideal:
begin
if(rx_enable==1)
current_state = start;
else
current_state=ideal;
end

start:
begin
if(ticks==1)
begin
if(rx_input==0) //Start bit '0'
current_state=data;
else
current_state=error;
end

end

data:
begin
if(ticks==1)
begin
count=count-4'd1;
array[count]=rx_input; //Receiving data

if(count==4'd0) 
current_state=stop; // 8-bit data Recieved
end

end

stop:
begin
if(ticks==1)
begin
if(rx_input==1)
current_state = ideal;
else
current_state=error;
end
end

error:
begin
current_state=ideal;
end

endcase

end

end

endmodule


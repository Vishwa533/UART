//Mevawala Vishwa Nitin --> 20BEC068
//UART --> Universal Asynchronous receiver and transmitter
//UART_TRANSMITTER --> PISO ( Parallel In Serial Out )


module uarttransmitter(tx_busy,tx_valid,tx_input,tx_data,tx_enable,clk,reset);
input tx_enable,tx_data,clk,reset;

output tx_busy,tx_valid; //Flages

///transmit data
output reg [9:0] tx_input;

//states
parameter  ideal=3'd0,
				start=3'd1,
				data=3'd2,
				stop=3'd3,
				error=3'd4;

//Count for the data transmission of 8-bit				
reg [2:0] current_state;


//flag instantiation
assign tx_busy = (current_state==data)?1:0;
assign tx_valid = (current_state==stop)?1:0;


//counter
reg [2:0] count=3'd0;


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
if(tx_enable==1)
current_state=start;
else
current_state=error;
end

start:
begin
tx_input[count] = 0; // start bit as '0'
current_state=data; // start to transmit 8-bit of data
end

data:
begin
count=count+3'd1; // Start the counter till 8-bit of data transmission
tx_input[count]=tx_data;

if(count==3'd8)
current_state=stop;
end

stop:
begin
count=3'd9;
tx_input[count] = 1; // Stop bit as '1'
current_state=ideal;
end

error:

begin
current_state = ideal;
end

endcase

end
end
endmodule

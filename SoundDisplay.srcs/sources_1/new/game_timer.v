`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2020 03:54:40 PM
// Design Name: 
// Module Name: try
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module game_timer(


    input basys_clock,
    input [11:0] mic_in,
    output reg [15:0] led,
    output reg timer_result = 0);

    reg [5:0] led_counter = 6'd0;
    reg [15:0] counter = 0;
    reg flag = 0;
    
    
    always @(posedge basys_clock)
    begin
        counter <= counter + 1;
        
        
        case (led_counter)
        6'd0: led<= 16'b1111111111111111; 
        6'd1: led<= 16'b0111111111111111;
        6'd2: led<= 16'b0011111111111111;
        6'd3: led<= 16'b0001111111111111;
        6'd4: led<= 16'b0000111111111111;
        6'd5: led<= 16'b0000011111111111;
        6'd6: led<= 16'b0000001111111111;
        6'd7: led<= 16'b0000000111111111;
        6'd8: led<= 16'b0000000011111111;
        6'd9: led<= 16'b0000000001111111;
        6'd10: led<= 16'b0000000000111111; 
        6'd11: led<= 16'b0000000000011111;
        6'd12: led<= 16'b0000000000001111;
        6'd13: led<= 16'b0000000000000111;
        6'd14: led<= 16'b0000000000000011;
        6'd15: led<= 16'b0000000000000001;
        6'd16: begin led<= 16'b0000000000000000; timer_result <= 1;end
        default : begin
        led_counter <= 16;
        end
        
        
    endcase
        flag <= (mic_in[11]==1)? (counter % 8192 ==0 ? 1:0): (mic_in[10]==1)? (counter % 16384 ==0 ? 1:0): ((mic_in[9]==1)? (counter % 32768 ==0 ? 1:0): 0);
        
        led_counter <= (flag == 1)?(led_counter ==16 ? led_counter : led_counter + 1):led_counter;


    end



endmodule 

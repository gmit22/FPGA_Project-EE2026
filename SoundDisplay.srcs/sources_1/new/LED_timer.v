`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/29/2020 12:35:09 AM
// Design Name: 
// Module Name: LED_timer
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


module LED_timer(
    input clock, // input a 20Khz clock
    input [11:0]mic_in,
    output reg [15:0] led
    );
    
    reg [1:0]flag;
    reg [14:0] counter;
    reg [4:0] led_counter;
    
    always @(clock) begin
    
        counter <= (counter == 16384)? 0 : counter + 1;
        flag <= (mic_in[11]==1)? (counter%4096==0):((mic_in[10] == 1) ? (counter%8192 == 0):((mic_in[11] == 1)?(counter%16384 ==0):0));
        
        led_counter <= (flag == 1)? led_counter + 1 : 0;
        
        
        case(led_counter)
        0 : led = 16'b1111111111111111;
        1:  led = 16'b0111111111111111;
        2:  led = 16'b0011111111111111;
        3:  led = 16'b0001111111111111;
        4:  led = 16'b0000111111111111;
        5:  led = 16'b0000011111111111;
        6:  led = 16'b0000001111111111;
        7:  led = 16'b0000000111111111;
        8:  led = 16'b0000000011111111;        
        9:  led = 16'b0000000001111111;
        10: led = 16'b0000000000111111;
        11: led = 16'b0000000000011111;
        12: led = 16'b0000000000001111;
        13: led = 16'b0000000000000111;
        14: led = 16'b0000000000000011;
        15: led = 16'b0000000000000001;
        16: led = 16'b0000000000000000;
        default : led_counter = 16 ;
        endcase       
        
    end       
    
    
    
    
    
endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 12:36:50 AM
// Design Name: 
// Module Name: clock_oled1
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


module clk_oled1(
    input basys_clock,
    
    output reg clk6p25m = 0,
    
    output[15:0] oled_data
    );
    
    assign oled_data=16'h07E0;
    
    reg [2:0] count=0;
        always @ (posedge basys_clock)
        begin
        count<=(count==7)?0:count+1;
        clk6p25m<=(count==0)?~clk6p25m:clk6p25m;
        end
    
    
        
    endmodule


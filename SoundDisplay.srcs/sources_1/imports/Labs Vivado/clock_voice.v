`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 12:17:45 AM
// Design Name: 
// Module Name: clock_voice
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


module clk_voice(
    input basys_clock,
    output reg out_clk=0
    );
    reg [11:0] count=0;
    always @ (posedge basys_clock)
    begin
        count<= count+1;
        out_clk<=(count==0)?~out_clk:out_clk;
    end
endmodule

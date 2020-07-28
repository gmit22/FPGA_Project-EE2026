`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2020 12:56:38 AM
// Design Name: 
// Module Name: dff_module
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


module dff_module( input dff_clock, input D,output reg Q =0);
    
    always @ (posedge dff_clock)
    begin
        Q <= D;   //output is equal to the input, and Q declared as reg to be usedin always block
     end   
endmodule

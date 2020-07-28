`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/25/2020 08:01:14 PM
// Design Name: 
// Module Name: coordinate_system
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


module coordinate(
    input [12:0] pixel_index,
    output [6:0] x,
    output [5:0] y
    );

    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
    
endmodule
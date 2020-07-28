`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.03.2020 12:12:38
// Design Name: 
// Module Name: oled_mux
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


module oled_mux(input FastClk, input [13:0] pixelindex, input [15:0] switch, output [15:0] oled_data);
wire [15:0] temp_oled_data1;
wire [15:0] temp_oled_data2;

wire [15:0] oled_display_data;

thin_oled_borders ob1(FastClk,pixelindex,temp_oled_data1);
thick_oled_borders ob2(FastClk,pixelindex,temp_oled_data2);

assign oled_display_data = ((switch[14])? 16'b1111_1101_1100_1011:
                            ((switch[15])? 16'b0000_0111_1111_0101:
                              ((switch[0])? temp_oled_data1 : 
                              ((switch[1])? temp_oled_data2 : 16'd0))));

oled_volume_bar_indicator ob3(FastClk,switch,oled_display_data,pixelindex,oled_data);
endmodule

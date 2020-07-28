`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: 
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
        // Connect to this signal from Audio_Capture.v
    // Delete this comment and include other inputs and outputs here
    output rgb_cs, rgb_sdin, rgb_sclk, rgb_cn, rgb_resn, rgb_vccen, rgb_pmoden,
    input CLK100MHZ,
    input pushbutton
    );
    wire clock1, reset; 
    wire [15:0] oled_data;
    wire f_b, s_p1, s_p2, p_i, t_s;
    clk_oled1 clk(CLK100MHZ, clock1, oled_data[15:0]);
    sp_dff(CLK100MHZ, pushbutton, reset); 
    Oled_Display Oled(
    .clk(clock1), .reset(reset), .pixel_data(oled_data[15:0]),
    .frame_begin(f_b), 
    .sending_pixels(s_p1), 
    .sample_pixel(s_p2), 
    .pixel_index(p_i), 
    .cs(rgb_cs), .sdin(rgb_sdin), .sclk(rgb_sclk), .d_cn(rgb_cn), .resn(rgb_resn), .vccen(rgb_vccen), .pmoden(rgb_pmoden), 
    .teststate(t_s)
    );  
endmodule
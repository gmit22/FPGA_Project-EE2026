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
////////////////////////////////////////////////////////////////////////////////


module Top_Student 
(   input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,   // Connect to this signal from Audio_Capture.v
    input basysclk,
    input pushbutton,
    output [11:0] LEDS,
    input [15:0] sw,
    output rgb_cs, rgb_sdin, rgb_sclk, rgb_cn, rgb_resn, rgb_vccen, rgb_pmoden
 );

    wire clk_20khz;
    wire clk6p25m;
    wire [15:0] oled_data;
    wire [11:0] mic_in;
    wire reset;
    wire frame_begin, sending_pixels, sampling_pixel;
    wire [12:0] pixel_index;
    wire [4:0] test_state;
    
   // assign oled_data = {mic_in[11:7],6'b0,mic_in[11:7]};
   //  assign oled_data = 16'b111111111111111;// for the borders 
   //  assign oled_data = 16'b0000011111111111; //back
   // assign oled_data = 
  clock_oled oledclk(basysclk,clk6p25m);
 // oled_mux OM(clk6p25m,pixel_index,sw,oled_data);
    //oled_borders(clk6p25m,pixel_index,oled_data);
  oled_volume_bar_indicator OB(clk6p25m,sw,pixel_index,oled_data);
    
    clk_voice voice(basysclk,clk_20khz); 
    Audio_Capture audio(basysclk, clk_20khz,J_MIC3_Pin3,J_MIC3_Pin1,J_MIC3_Pin4,mic_in);
   // multiplexer mux(switch1,mic_in,LEDS);
    sp_dff debounceC(basysclk,pushbutton,reset);
     Oled_Display oled(.clk(clk6p25m), .reset(reset), .pixel_data(oled_data),.frame_begin(frame_begin),.sending_pixels(sending_pixels),.sample_pixel(sampling_pixel), .pixel_index(pixel_index), 
       .cs(rgb_cs), .sdin(rgb_sdin), .sclk(rgb_sclk), .d_cn(rgb_cn), .resn(rgb_resn), .vccen(rgb_vccen), .pmoden(rgb_pmoden), 
       .teststate(test_state)
       );  
       
endmodule
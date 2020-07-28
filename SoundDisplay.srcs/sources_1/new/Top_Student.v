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


module Top_Student 
(
    input basysclk,
    
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,   // Connect to this signal from Audio_Capture.v

    input btnC,btnL,btnR,btnD,
    output reg [15:0] LEDS,
    input [15:0]switch,
    output rgb_cs, rgb_sdin, rgb_sclk, rgb_cn, rgb_resn, rgb_vccen, rgb_pmoden,
    output reg [6:0] segment,
    output reg [3:0] anode
 );

    wire clk_20khz,clk6p25m;
    
    wire reset,btnL_output,btnR_output,btnD_output;
       
    wire [15:0] oled_data,oled_data_bar, oled_data_circ, oled_data_game;
    
    wire [11:0] mic_in;
    wire [3:0] an_bar,an_circ,an_game;//initializeing different wires to be used for anodes
    wire[6:0] seg_bar, seg_circ,seg_game;//initializeing different wires to be used for segment    
    wire [15:0]led_bar,led_circle,led_counter;
    
    wire frame_begin, sending_pixels, sampling_pixel;
    wire [12:0] pixel_index;
    wire [6:0] x, y;
    wire [4:0] test_state;     
    
    wire led_timer;
    
    //assign oled_data = {mic_in[11:7],6'b0,mic_in[11:7]};
    clk_voice voice(basysclk,clk_20khz); 
    clock_oled oledclk(basysclk,clk6p25m);
    
    // co-ordinate system
    coordinate coord (.pixel_index(pixel_index), .x(x), .y(y));
    
    //setup to read the microphone data
    Audio_Capture audio(basysclk, clk_20khz,J_MIC3_Pin3,J_MIC3_Pin1,J_MIC3_Pin4,mic_in);
    
    sp_dff debounceC(basysclk,btnC,reset);
    sp_dff debounce_left(basysclk,btnL,btnL_output);
    sp_dff debounce_right(basysclk,btnR,btnR_output);
    sp_dff debounce_down(basysclk,btnD,btnD_output);
    
   // volume_indicator bars(clk_20khz, clk6p25m, switch, mic_in, x, y, led_bar,seg_bar,an_bar,oled_data_bar);
    
    //vol_indicator_circle circ(clk_20khz,clk6p25m ,switch , mic_in,x,y,led_circle,seg_circ,an_circ,oled_data_circ);
      
      GameUI(basysclk,clk6p25m,btnL_output, btnR_output,btnD_output,pixel_index,oled_data_game,an_game,seg_game, led_timer);    
      
      
      Oled_Display oled(.clk(clk6p25m), .reset(reset), .pixel_data(oled_data),.frame_begin(frame_begin),.sending_pixels(sending_pixels),.sample_pixel(sampling_pixel), .pixel_index(pixel_index), 
                .cs(rgb_cs), .sdin(rgb_sdin), .sclk(rgb_sclk), .d_cn(rgb_cn), .resn(rgb_resn), .vccen(rgb_vccen), .pmoden(rgb_pmoden), 
                .teststate(test_state)
                );
      //oled_volume(basysclk, switch,pixel_index, oled_data); 
      
      game_timer( clk_20khz,mic_in,led_counter, led_timer);        
    
    
    assign oled_data = oled_data_game;   
    always @(*) begin
        segment<= seg_game;
        anode <= an_game;
        LEDS <= led_counter;
        
    end
       
       
       
endmodule
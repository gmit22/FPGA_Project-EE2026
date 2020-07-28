`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2020 02:38:09 PM
// Design Name: 
// Module Name: vol_indicator_circle
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


module vol_indicator_circle(
input mic_clock,
    input oled_clock,
    input [15:0]sw, 
    input [11:0] mic_in,
    input [6:0]x,
    input [6:0]y,
    output reg [15:0] LED,
    output reg [6:0] segment,
    output reg [3:0] anode,
    output reg [15:0] oled_data
    );
    
    
    reg [12:0] counter = 0;
    reg [11:0] peak_volume = 12'b0;
    
    reg [6:0] seg_1 = 7'b0000000;
    reg [6:0] seg_10 = 7'b0000000;
    
    reg [15:0] led;
    reg [15:0] leds;
    
    reg [12:0] frequency = 0;
    
    reg [7:0] count_300 = 0;
    
    reg [15:0] border,background,colourHigh,colourMid,colourLow;
    
    
    always @(*)
    begin
        case({sw[5:4]})
            2'b01: begin
                background = {5'd29, 6'd58, 5'd25};
                border = 16'h0000;   
                colourHigh = {5'd19, 6'd47, 5'd24};               
                colourMid = {5'd5, 6'd30, 5'd30};
                colourLow = {5'd4, 6'd16, 5'd11};         
            end
            2'b10:begin
                background = {5'd29, 6'd56, 5'd21};
                border = 16'hFFFF;
                colourHigh = {5'd22, 6'd58, 5'd15};               
                colourMid = {5'd6, 6'd50, 5'd10};
                colourLow = {5'd8, 6'd30, 5'd9};
                            
            end
            2'b11: begin
                background = {5'd6, 6'd14, 5'd10};
                border = {5'd31, 6'd54, 5'd22};   
                colourHigh = {5'd31, 6'd41, 5'd22};               
                colourMid = {5'd18, 6'd32, 5'd22};
                colourLow = {5'd10, 6'd21, 5'd15}; 
            end
            default :
            begin
                background <= 16'h0000;
                border <= 16'b1111111111111111; 
                colourLow <= 16'h3FE0;     
                colourMid <= 16'hFFC0;
                colourHigh <= 16'hF800;    
            end
        endcase      
    end
    
    
    
    
    
    
    always @(posedge mic_clock) begin
    /*begin //peak finding algorithm, can think of using clock here to check peaks after different intervals
        if (frequency == 0) peak_volume =0;
        else if (mic_in > peak_volume) peak_volume = mic_in;
        else peak_volume = peak_volume;
    end*/
    
        peak_volume = (frequency==0)?0:(mic_in>peak_volume?mic_in:peak_volume);
        frequency <=  (frequency == 3999) ? 0 : frequency + 1; // 10Hz frequency
               
        if (sw[2:1] ==2'b01) 
        begin
            anode <= (anode == 4'b0111) ? 4'b1011 : 4'b0111;
            segment <= (anode == 4'b0111) ? seg_1: seg_10; 
        end
        
        if (sw[2:1] == 2'b10) begin
            anode <= (anode == 4'b1011) ? 4'b1101 : 4'b1011;
            segment <= (anode == 4'b1011) ? seg_1: seg_10; 
        end
        
        if (sw[2:1] == 2'b11) begin
            anode <= (anode == 4'b1101)?4'b1110: 4'b1101;
            segment <= (anode == 4'b1101)?seg_1:seg_10;            
        end                     
    
        if (peak_volume >= 3967) begin
        if (~sw[9]) leds <= 16'b1111111111111111;
            led <= 16'b1111111111111111;
            seg_10 <= 7'b1111001;
            seg_1 <= 7'b0000010;       
        end
        
        else if (peak_volume>3839) begin
        if (~sw[9]) leds <= 16'b0111111111111111;
            led <= 16'b0111111111111111;
            seg_10 <= 7'b1111001;
            seg_1 <= 7'b0010010;
        end
        
        else if (peak_volume>3711) begin
        if (~sw[9]) leds <= 16'b0011111111111111;
            led <= 16'b0011111111111111;
            seg_10 <= 7'b1111001;
            seg_1 <= 7'b0110001;
        end
        
        else if (peak_volume>3583) begin
        if (~sw[9]) leds <= 16'b0001111111111111;
            led <= 16'b0001111111111111;
             seg_10 <= 7'b1111001;
             seg_1 <= 7'b0110000;
        end
        
        else if (peak_volume>3455) begin
        if (~sw[9]) leds <= 16'b0000111111111111;
            led <= 16'b0000111111111111;
            seg_10 <= 7'b1111001;
            seg_1 <= 7'b0100100;
        end
        
        else if (peak_volume>3327) begin
        if (~sw[9]) leds <= 16'b0000011111111111;
            led <= 16'b0000011111111111;
            seg_10 <= 7'b1111001;
            seg_1 <= 7'b1111001;
        end
                    
        else if (peak_volume>3199) begin
        if (~sw[9]) leds <= 16'b0000001111111111;
            led <= 16'b0000001111111111;
            seg_10 <= 7'b1111001;
            seg_1 <= 7'b1000000;
        end
        
        else if (peak_volume>3071) begin
        if (~sw[9]) leds <= 16'b0000000111111111;
            led <= 16'b0000000111111111;
            seg_10 <= 7'b1000000;
            seg_1 <= 7'b0010000;
        end                    
        
        else if (peak_volume>2943) begin
        if (~sw[9]) leds <= 16'b0000000011111111;
            led <= 16'b0000000011111111;
            seg_10 <= 7'b1000000;
            seg_1<= 7'b0000000;
        end     
        
        else if (peak_volume>2815) begin
        if (~sw[9]) leds <= 16'b0000000001111111;
            led <= 16'b0000000001111111;
            seg_10 <= 7'b1000000;
            seg_1 <= 7'b1111000;
        end
        
        else if (peak_volume>2687) begin
        if (~sw[9]) leds <= 16'b0000000000111111;
            led <= 16'b0000000000111111;
            seg_10 <= 7'b1000000;
            seg_1 <= 7'b0000010;
        end
        
        else if (peak_volume > 2559) begin
        if (~sw[9]) leds <= 16'b0000000000011111;
            led <= 16'b0000000000011111;
            seg_10 <= 7'b1000000;
            seg_1 <= 7'b0010010;
        end
        
        else if (peak_volume > 2431) begin
        if (~sw[9]) leds <= 16'b0000000000001111;
            led <= 16'b0000000000001111;
            seg_10 <= 7'b1000000;
            seg_1 <= 7'b0011001;
        end
        
        else if (peak_volume > 2333) begin
        if (~sw[9]) leds <= 16'b0000000000000111;
            led <= 16'b0000000000000111;
            seg_1 <= 7'b0110000;
            seg_10 <= 7'b1000000;
        end
        
        else if (peak_volume > 2250) begin
        if (~sw[9]) leds <= 16'b0000000000000011;
            led <= 16'b0000000000000011;
            seg_1 <= 7'b0100100;
            seg_10 <= 7'b1000000;
        end
        
        else if (peak_volume > 2147) begin
            if (~sw[9]) leds <= 16'b0000000000000001;
            led <= 16'b0000000000000001;
            seg_1 <= 7'b1111001;
            seg_10 <= 7'b1000000;
        end
        
        else 
        begin
            if (~sw[9]) leds <= 16'b0000000000000000;
            led <= 16'b0000000000000000;
            seg_1 <= 7'b1000000;
            seg_10<= 7'b1000000;
        end
       
    if (sw[0]==0) 
    begin
        LED <= {4'b0000,mic_in};
        seg_1 <= 7'b1111111;
        seg_10 <= 7'b1111111;
        
    end else begin
            if (frequency == 0)    
            begin
    //            segment <=seg_1;
                LED <= led;
            end
        end            
    end
    
    
    
     always @(posedge oled_clock) begin //changing background colour
           
           oled_data <= background;
           if ((sw[7:6]) == 2'b01)  begin // thin
               if((y == 0 || y == 63)||(x == 0 || x == 95)) begin 
                   oled_data <= border;
               end  
           end
           if ((sw[7:6])==2'b10)  begin 
               if(y <= 2 || y >= 61||x <= 1 || x >= 93) begin 
                   oled_data <= border;
               end
           end
           
           if (y > 2 && y < 61 && x > 2 && x < 93) begin
           
           case (led)
           16'b0000000000000001: 
           if ((x-48)*(x-48) + (y-32)*(y-32) <= 121)
           begin
               oled_data <= colourLow;
           end
           
           16'b0000000000000011: 
              if ((x-48)*(x-48) + (y-32)*(y-32) <= 144)
              begin
                  oled_data <= colourLow;
              end
           16'b0000000000000111: 
             if ((x-48)*(x-48) + (y-32)*(y-32) <= 169)
             begin
                 oled_data <= colourLow;
             end   
           16'b0000000000001111: 
            if ((x-48)*(x-48) + (y-32)*(y-32) <= 196)
            begin
                oled_data <= colourLow;
            end   
           16'b0000000000011111: 
            if ((x-48)*(x-48) + (y-32)*(y-32) <= 225)
            begin
                oled_data <= colourLow;
            end   
           16'b0000000000111111: 
            if ((x-48)*(x-48) + (y-32)*(y-32) <= 256)
            begin
                oled_data <= colourMid;
            end
           
           16'b0000000001111111: 
            if ((x-48)*(x-48) + (y-32)*(y-32) <= 289)
            begin
                oled_data <= colourMid;
            end
            
           16'b0000000011111111: 
            if ((x-48)*(x-48) + (y-32)*(y-32) <= 324)
            begin
                oled_data <= colourMid;
            end 
           16'b0000000111111111: 
             if ((x-48)*(x-48) + (y-32)*(y-32) <= 361)
             begin
                 oled_data <= colourMid;
             end                
           16'b0000001111111111: 
              if ((x-48)*(x-48) + (y-32)*(y-32) <= 400)
              begin
                  oled_data <= colourMid;
              end               
           16'b0000011111111111: 
               if ((x-48)*(x-48) + (y-32)*(y-32) <= 441)
               begin
                   oled_data <= colourMid;
               end             
           16'b0000111111111111: 
                if ((x-48)*(x-48) + (y-32)*(y-32) <= 484)
                begin
                    oled_data <= colourHigh;

                end            
           16'b0001111111111111: 
                 if ((x-48)*(x-48) + (y-32)*(y-32) <= 529)
                 begin
                     oled_data <= colourHigh;
                 end 
           16'b0011111111111111: 
                  if ((x-48)*(x-48) + (y-32)*(y-32) <= 576)
                  begin
                      oled_data <= colourHigh;
                  end 
           16'b0111111111111111: 
                   if ((x-48)*(x-48) + (y-32)*(y-32) <= 625)
                   begin
                       oled_data <= colourHigh;
                   end 
           16'b1111111111111111: 
                    if ((x-48)*(x-48) + (y-32)*(y-32) <= 676)
                    begin
                        oled_data <= colourHigh;
                    end
           default: oled_data <= 16'h0000;                                      
           endcase
           
           
           
      
     end
     end
endmodule

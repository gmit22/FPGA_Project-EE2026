`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2020 14:33:38
// Design Name: 
// Module Name: oled_volume_bar_indicator
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


module oled_volume_bar_indicator(input clock, input [15:0] switch, input [12:0] pixelindex, output reg [15:0] oled_data);

reg [7:0] x_coordinate = 0;
reg [6:0] y_coordinate = 0;

wire [15:0] background;

//for respective background colours 
assign background = ((switch[14])? 16'hFDCB:
                     (switch[15])? 16'h07F6: 16'd0);



always@(posedge clock)begin
    y_coordinate = pixelindex/96;
    x_coordinate = pixelindex%96;
    
   if(switch == 16'd0)
    begin
      oled_data = 16'd0;
    end 
    
    //background and borders 
   if(switch[0])//border 1
    begin
        if(y_coordinate == 0 || y_coordinate == 63)
            begin 
                oled_data <= 16'hFFFF;
            end  
        
        else if(x_coordinate == 0 || x_coordinate == 95)
            begin 
                oled_data <= 16'hFFFF;
            end    
        
        else 
            begin 
                oled_data <= background;
            end 
    end

    if(switch[1])//border 2
    begin
        if(y_coordinate <= 1 || y_coordinate >= 62)
            begin 
                oled_data <= 16'hFFFF;
            end  
        
        else if(x_coordinate <= 1 || x_coordinate >= 94)
            begin 
                oled_data <= 16'hFFFF;
            end    
        
        else 
            begin 
                oled_data = 16'd0;
            end
    end
    
    
    //volume bars 
if(switch[0]) //bar1 
begin
if(y_coordinate > 48 && y_coordinate <51)
begin 
if(x_coordinate > 34 && x_coordinate < 60)
    begin
    oled_data <= 16'h3FE0;
    end
end            
end

if(switch[1]) // bar2
begin
if(y_coordinate > 45 && y_coordinate < 48) begin 
if(x_coordinate > 34 && x_coordinate < 60) begin
oled_data <= 16'h3FE0;
end

end            
end      

if(switch[2])// bar3
begin

if(y_coordinate > 42 && y_coordinate < 45)
begin 
if(x_coordinate > 34 && x_coordinate < 60)
    begin
    oled_data <= 16'h3FE0;
    end

end            
end      

if(switch[3]) //bar4
begin

if(y_coordinate > 39 && y_coordinate < 42)
begin 
 if(x_coordinate > 34 && x_coordinate < 60)
     begin
     oled_data <= 16'h3FE0;
     end

end            
end

if(switch[4]) //bar5
begin

if(y_coordinate > 36 && y_coordinate < 39)
begin 
if(x_coordinate > 34 && x_coordinate < 60)
    begin
    oled_data <= 16'h3FE0;
    end


end            
end      

if(switch[5]) //bar6
begin

if(y_coordinate > 33 && y_coordinate < 36)
begin 
 if(x_coordinate > 34 && x_coordinate < 60)
     begin
     oled_data <= 16'h3FE0;
     end


end            
end    

if(switch[6]) //bar7
begin

if(y_coordinate > 30 && y_coordinate < 33)
begin 
if(x_coordinate > 34 && x_coordinate < 60)
    begin
    oled_data <= 16'hFFC0;
    end

end            
end      

if(switch[7]) //bar8
begin

if(y_coordinate > 27 && y_coordinate < 30)
begin 
 if(x_coordinate > 34 && x_coordinate < 60)
     begin
     oled_data <= 16'hFFC0;
     end

end            
end     

if(switch[8]) //bar9
begin

if(y_coordinate > 24 && y_coordinate < 27)
begin 
  if(x_coordinate > 34 && x_coordinate < 60)
      begin
      oled_data <= 16'hFFC0;
      end

end            
end      

if(switch[9]) //bar10
begin

if(y_coordinate > 21 && y_coordinate < 24)
begin 
if(x_coordinate > 34 && x_coordinate < 60)
    begin
    oled_data <= 16'hFFC0;
    end


end            
end       

if(switch[10]) //bar11
begin

if(y_coordinate > 18 && y_coordinate < 21)
begin 
if(x_coordinate > 34 && x_coordinate < 60)
    begin
    oled_data <= 16'hFFC0;
    end

end            
end    

if(switch[11])// bar12
begin
if(y_coordinate > 15 && y_coordinate < 18)
begin 
if(x_coordinate > 34 && x_coordinate < 60)
    begin
    oled_data <= 16'hF800;
    end
end
end     

if(switch[12])//bar13
begin

if(y_coordinate > 12 && y_coordinate < 15)
begin 
if(x_coordinate > 34 && x_coordinate < 60)
    begin
    oled_data <= 16'hF800;
    end

end            
end     

if(switch[13]) //bar14
begin

if(y_coordinate > 9 && y_coordinate < 12)
begin 
 if(x_coordinate > 34 && x_coordinate < 60)
     begin
     oled_data <= 16'hF800;
     end

end            
end     

if(switch[14]) //bar15
begin

if(y_coordinate > 6 && y_coordinate < 9)
begin 
if(x_coordinate > 34 && x_coordinate < 60)
    begin
    oled_data <= 16'hF800;
    end

end            
end      

if(switch[15]) //bar16
begin

if(y_coordinate > 3 && y_coordinate < 6)
begin 
if(x_coordinate > 34 && x_coordinate < 60)
    begin
    oled_data <= 16'hF800;
    end

end            
end 
end
endmodule

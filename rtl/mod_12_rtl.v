
module mod12_counter(clk,rst,datain,dataout,load,mode); 
 input [3:0]datain; 
 input clk,rst,load,mode; 
 output reg [3:0]dataout; 
 
 always@(posedge clk) 
  begin 
   if(rst) 
    dataout <= 4'b0000; 
   else 
   begin 
    if(load && datain < 12) 
     dataout <= datain; 
    else 
    begin 
     if(mode) 
     begin 
      if(dataout == 4'b1011) 
       dataout <= 4'b0000; 
      else 
       dataout <= dataout + 1; 
     end 
     else 
     begin 
      if(dataout == 4'b0000) 
       dataout <= 4'b1011; 
      else 
       dataout <= dataout - 1; 
     end 
    end 
   end 
  end 
endmodule

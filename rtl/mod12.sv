
module mod12(count_if.DUTn du); 
 
 always@(posedge du.clk) 
  begin 
   if(du.rst) 
    du.dataout <= 4'b0000; 
   else 
   begin 
    if(du.load && du.datain < 12) 
     du.dataout <= du.datain; 
    else 
    begin 
     if(du.mode) 
     begin 
      if(du.dataout == 4'b1011) 
       du.dataout <= 4'b0000; 
      else 
       du.dataout <= du.dataout + 1; 
     end 
     else 
     begin 
      if(du.dataout == 4'b0000) 
       du.dataout <= 4'b1011; 
      else 
       du.dataout <= du.dataout - 1; 
     end 
    end 
   end 
  end 
endmodule


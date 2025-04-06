 interface count_if(input bit clk); 
 
  bit [3:0]datain; 
  logic [3:0]dataout; 
  bit rst; 
  bit load; 
  bit mode; 
 
clocking dr_cb@(posedge clk); 
default input #2 output #1; 
	output rst; 
	output datain; 
	output load; 
	output mode; 
endclocking 

clocking wr_cb@(posedge clk); 
	default input #2 output #1; 
	input rst; 
	input datain; 
	input load; 
	input mode; 
endclocking 

clocking rd_cb@(posedge clk); 
	default input #2 output #1; 
	input dataout; 
endclocking 

modport drv(clocking dr_cb); 
modport wr_mon(clocking wr_cb); 
modport rd_mon(clocking rd_cb); 
modport DUTn(input clk,datain,rst,load,mode, output dataout); 
endinterface

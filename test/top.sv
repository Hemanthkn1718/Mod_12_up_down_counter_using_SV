//`include test.sv
module top(); 
	import pkg::*;
	reg clk=1'b0; 
	count_if duv_if(clk); 
	//con_env te; 
	mod12_counter DUV(.clk(clk),.datain(duv_if.datain),.load(duv_if.load),.mode(duv_if.mode),.rst(duv_if.rst),.dataout(duv_if.dataout)); 

	//mod12 DUV(duv_if);
	test te;
	
	//count_1_ext cou1;
	
	initial
		forever #10 clk=~clk; 
	
	initial 
	begin 

			 
	`ifdef VCS
         $fsdbDumpvars(0, top);
        `endif

	if($test$plusargs("TEST1"))
            begin
                te=new(duv_if,duv_if,duv_if); 
		no_of_trans=50; 
		te.build(); 
		te.run(); 
		$finish; 
            end
	/*if($test$plusargs("TEST2"))
            begin
                cou1=new(duv_if,duv_if,duv_if); 
		no_of_trans=50; 
		cou1.build(); 
		cou1.run(); 
		$finish; 
            end
	if($test$plusargs("TEST3"))
            begin
                te=new(duv_if,duv_if,duv_if); 
		no_of_trans=50; 
		te.build(); 
		te.run(); 
		$finish; 
            end*/
	end 
endmodule

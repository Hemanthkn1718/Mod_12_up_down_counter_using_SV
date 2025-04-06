//import pkg::*;

class test; 
	virtual count_if.drv dr_if; 
	virtual count_if.wr_mon wrmon_if; 
	virtual count_if.rd_mon rdmon_if; 
	con_env env; 
	function new ( virtual count_if.drv dr_if, 
		virtual count_if.wr_mon wrmon_if, 
		virtual count_if.rd_mon rdmon_if); 
			this.dr_if=dr_if; 
			this.wrmon_if=wrmon_if; 
			this.rdmon_if=rdmon_if; 
			env=new(dr_if,wrmon_if,rdmon_if); 
	endfunction 
	virtual task build(); 
		env.build(); 
	endtask 
	virtual task run(); 
		env.run(); 
	endtask 
endclass 


/*class count_1 extends trans;
	constraint reset_r1{rst == 1;}  
endclass

class count_1_ext extends test;

	count_1 c1;
	function new ( virtual count_if.drv dr_if, 
			virtual count_if.wr_mon wrmon_if, 
			virtual count_if.rd_mon rdmon_if); 
		super.new(dr_if,wrmon_if,rdmon_if); 
	endfunction 
	
	virtual task build();
	      super.build();
   	endtask: build
	
	 virtual task run();  
      		c1 = new();
      		env.gen_h.tr = c1;
      		super.run();
   	endtask: run      
   
endclass*/

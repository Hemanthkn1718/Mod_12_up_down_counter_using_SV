package pkg; 
	int no_of_trans=10;
	
    `include "mod_12_trans.sv"
    `include "mod_12_gen.sv"
    `include "mod_12_wr_drv.sv"   
    `include "mod_12_wr_mon.sv" 
    `include "mod_12_rd_mon.sv"
    `include "mod_12_ref_model.sv"
    `include "mod_12_score_board.sv"
    `include "mod_12_env.sv" 
    `include "test.sv" 
endpackage 


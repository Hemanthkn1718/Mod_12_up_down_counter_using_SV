class con_env;
    virtual count_if.drv wr_drv_if;
    virtual count_if.rd_mon rd_mon_if;
    virtual count_if.wr_mon wr_mon_if;

    mailbox #(trans) gen2dr = new();
    mailbox #(trans) wrmon2rm = new();
    mailbox #(trans) rm2sb = new();
    mailbox #(trans) rdmon2sb = new();

    function new(virtual count_if.drv wr_drv_if,virtual count_if.wr_mon wr_mon_if,virtual count_if.rd_mon rd_mon_if);
        this.wr_drv_if = wr_drv_if;
	this.wr_mon_if = wr_mon_if;
        this.rd_mon_if = rd_mon_if;
    endfunction

    cou_gen gen_h;
    write_driver wr_drv_h;
    write_monitor wr_mon_h;
    read_monitor rd_mon_h;
    count_model ref_model_h;
    count_sb sb_h;

     virtual task build ();
        gen_h = new(gen2dr);
        wr_drv_h = new(wr_drv_if,gen2dr);
        wr_mon_h = new(wr_mon_if,wrmon2rm);
        rd_mon_h = new(rd_mon_if,rdmon2sb);
        ref_model_h = new(wrmon2rm,rm2sb);
        sb_h = new(rm2sb,rdmon2sb);
     endtask

     virtual task rest_counter();
        @(wr_drv_if.dr_cb);
            wr_drv_if.dr_cb.rst<=1'b1;
        repeat(2)
            @(wr_drv_if.dr_cb);
        wr_drv_if.dr_cb.rst<=1'b0;
     endtask

     virtual task start();
	fork
        	gen_h.start();
        	wr_drv_h.start(); 
        	wr_mon_h.start(); 
        	rd_mon_h.start(); 
        	ref_model_h.start();
        	sb_h.start();
	 join_none
     endtask

     virtual task stop();
        wait(sb_h.DONE.triggered);
     endtask

     virtual task run();
        rest_counter();
        start();
        stop();
        sb_h.report();
     endtask


   
endclass //env

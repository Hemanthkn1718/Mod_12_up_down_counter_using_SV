class write_driver; 
	virtual count_if.drv dr_if; 
	trans data2duv; 
	mailbox #(trans)gen2dr; 
	function new(virtual count_if.drv dr_if, mailbox #(trans) gen2dr); 
		this.dr_if=dr_if; 
		this.gen2dr=gen2dr; 
	endfunction 
	virtual task drive(); 
		begin 
			@(dr_if.dr_cb); 
			dr_if.dr_cb.rst <= data2duv.rst; 
			dr_if.dr_cb.load <= data2duv.load; 
			dr_if.dr_cb.datain <= data2duv.datain; 
			dr_if.dr_cb.mode <= data2duv.mode;

			repeat(2)
				@(dr_if.dr_cb); 	 
		end 
	endtask 
	virtual task start(); 
		fork 
			forever 
				begin 
					gen2dr.get(data2duv); 
					drive(); 
				end 
		join_none; 
	endtask 
endclass

 

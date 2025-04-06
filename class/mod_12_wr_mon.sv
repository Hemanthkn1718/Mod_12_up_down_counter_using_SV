class write_monitor; 
	virtual count_if.wr_mon wr_mon_if; 
	trans wr_data; 
	trans data2rm; 
	mailbox #(trans) wrmon2rm; 
	function new(virtual count_if.wr_mon wr_mon_if,
				 mailbox #(trans)wrmon2rm); 
		this.wr_mon_if=wr_mon_if; 
		this.wrmon2rm=wrmon2rm; 
		this.wr_data=new(); 
	endfunction 
	virtual task monitor(); 
		begin 
			@(wr_mon_if.wr_cb) 
				begin 
					wr_data.rst = wr_mon_if.wr_cb.rst;
					wr_data.mode = wr_mon_if.wr_cb.mode; 
					wr_data.load = wr_mon_if.wr_cb.load; 
					wr_data.datain = wr_mon_if.wr_cb.datain; 
					wr_data.display("from write monitor"); 
					//$display("data in write monitor=%0d",wr_data.datain);
				end 
			end 
	endtask 
	virtual task start(); 
		fork 
			forever 
				begin 
					monitor(); 
					data2rm=new wr_data; 
					wrmon2rm.put(data2rm); 
				end 
		join_none 
	endtask 
endclass 



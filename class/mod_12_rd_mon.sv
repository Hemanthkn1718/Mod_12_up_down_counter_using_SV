class read_monitor; 
	virtual count_if.rd_mon rdmon_if; 
	trans data2sb; 
	trans rd_data; 
	mailbox #(trans) mon2sb; 
	function new(virtual count_if.rd_mon rdmon_if,mailbox #(trans)mon2sb); 
		this.rdmon_if=rdmon_if; 
		this.mon2sb=mon2sb; 
		this.rd_data=new(); 
	endfunction 
	virtual task monitor(); 
		begin 
			@(rdmon_if.rd_cb); 
				begin 
					rd_data.dataout=rdmon_if.rd_cb.dataout; 
					rd_data.display("from the read monitor");
					//$display("data out in read_monitor is = %0d"rd_data.dataout); 
				end 
		end 
	endtask 
	virtual task start(); 
		fork 
			forever
			begin 
				monitor(); 
				data2sb=new rd_data; 
				mon2sb.put(data2sb); 
			end 
		join_none 
	endtask 
endclass 

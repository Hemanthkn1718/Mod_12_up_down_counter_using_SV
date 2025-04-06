class count_sb; 
	event DONE; 
	trans sb_data; 
	trans rm_data; 
	trans cov_data; 
	mailbox #(trans) rm2sb; 
	mailbox #(trans) rdm2sb; 
	static int ref_data=0; 
	static int rmdata=0; 
	static int data_verified=0; 
	covergroup counter_coverage; 
		option.per_instance=1;
		resetn   : coverpoint cov_data.rst;//{bins rst={[0:1]};} 
		Load     : coverpoint cov_data.load;  
		Mode     : coverpoint cov_data.mode; 
		IN       : coverpoint cov_data.datain { bins datain  = {[0:11]};} 
		OUT      : coverpoint cov_data.dataout { bins dataout  = {[0:11]};} 
		ldxdin   : cross Load,IN; 
		moxldxin : cross Mode,Load,IN; 
	endgroup 
	
	function new(mailbox #(trans) rm2sb, mailbox #(trans) rdm2sb); 
		this.rm2sb=rm2sb; 
		this.rdm2sb=rdm2sb; 
		counter_coverage=new(); 
	endfunction 
	
	virtual task start(); 
		fork 
			forever 
			begin 
				rm2sb.get(rm_data); 
			//rm_data.display("REF2SCO");
				ref_data++; 
				rdm2sb.get(sb_data); 
		//	sb_data.display("RDMON2SCO");
				rmdata++; 
				check(sb_data); 
			end 
		join_none 
	endtask 
	virtual task check(trans rdata); 
		if(rm_data.dataout==rdata.dataout) 
			$display("data matched"); 
		else 
			$display("data not matched");  
		cov_data=rm_data; 
		counter_coverage.sample(); 
		data_verified++; 
		if(data_verified >= no_of_trans) 
		begin 
			$display("%0d",data_verified);
			$display("done is triggered");
			-> DONE; 
		end 
	endtask 
	virtual function void report(); 
		$display("data from read monitor = %d",rmdata); 
		$display("data from refence model = %d",ref_data); 
		$display("data verified = %d",data_verified); 
	endfunction 
endclass

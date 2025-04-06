class cou_gen; 
	trans tr; 
	trans data2send; 
	mailbox #(trans) gen2dr; 
	function new(mailbox #(trans) gen2dr); 
		this.gen2dr=gen2dr; 
		this.tr=new(); 
	endfunction 
	virtual task start(); 
		fork 
			begin 
				for(int i=0;i<no_of_trans;i++) 
					begin 
						assert(tr.randomize()); 
						data2send=new tr; 
						gen2dr.put(data2send); 
					end 
			end 
		join_none 
	endtask 
endclass

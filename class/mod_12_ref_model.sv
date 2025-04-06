class count_model; 
	trans w_data; 
	static logic [3:0] ref_count=0; 
 
	mailbox #(trans) wrmon2rm; 
	mailbox #(trans) rm2sb; 
 
	function new( mailbox #(trans) wrmon2rm, mailbox #(trans) rm2sb); 
		this.wrmon2rm=wrmon2rm; 
 		this.rm2sb=rm2sb; 
	endfunction 
 
	virtual task count_mod(trans model_counter); 
	begin 
 		if(model_counter.rst==1) 
  		ref_count<=0; 
 		else 
 		begin 
 			if(model_counter.load) 
			begin
    				ref_count <=model_counter.datain; 
   				//wait(model_counter.load==0) 
				//begin
			end
			else begin
           				if(model_counter.mode==1) 
            				begin 
                 				if(ref_count>12) 
                   					ref_count<=4'b0000; 
                 				else 
                   					ref_count<=ref_count+1'b1; 
            				end 
          				else if(model_counter.mode==0) 
             				begin 
                  				if(ref_count==0) 
                    					ref_count<=4'd11; 
                  				else  
                    					ref_count<=ref_count-1'b1; 
            				end 
      				
			end 
		end 
	end
	endtask 
 
	virtual task start(); 
  	fork 
    	forever 
     		begin 
         		wrmon2rm.get(w_data); 
			//w_data.display("WRMON2REF");
        		 count_mod(w_data); 
         		w_data.dataout=ref_count; 
         		rm2sb.put(w_data); 
      		end 
  	join_none 
	endtask 
 
endclass

/*
class count_model; 
	trans w_data; 
	static logic [3:0] ref_count=0; 
 
	mailbox #(trans) wrmon2rm; 
	mailbox #(trans) rm2sb; 
 
	function new( mailbox #(trans) wrmon2rm, mailbox #(trans) rm2sb); 
		this.wrmon2rm=wrmon2rm; 
 		this.rm2sb=rm2sb; 
	endfunction 
 
	virtual task count_mod(trans model_counter); 
	begin 
 	if(model_counter.rst==1) 
  		ref_count<=0; 
 	else 
 	begin 
 	if(model_counter.load) 
    	ref_count <=model_counter.datain; 
   	wait(model_counter.load==0) 
       	begin 
           if(model_counter.mode==1) 
             begin 
                 if(ref_count>12) 
                   ref_count<=4'b0000; 
                 else 
                   ref_count<=ref_count+1'b1; 
             end 
          else if(model_counter.mode==0) 
             begin 
                  if(ref_count==0) 
                    ref_count<=4'd11; 
                  else  
                    ref_count<=ref_count-1'b1; 
            end 
      	end 
	end 
	end 
	endtask 
 
	virtual task start(); 
  	fork 
    	forever 
     	begin 
         	wrmon2rm.get(w_data); 
        	 count_mod(w_data); 
         	w_data.dataout=ref_count; 
         	rm2sb.put(w_data); 
      	end 
  	join_none 
	endtask 
 
endclass
*/


class trans; 
	rand bit rst; 
	rand bit mode; 
	rand bit load; 
	rand bit [3:0]datain; 
	bit [3:0]dataout; 
	static int  no_of_rst; 
	static int  no_of_load; 
	static int  no_of_upcount; 
	static int  no_of_downcount; 
	constraint data_range{datain inside{[0:11]};} 
	constraint load_ra{load dist{1:=30 , 0:=70};} 
	constraint mode_ra{mode dist{0:=50 , 1:=50};} 
	constraint reset_dist{rst == 1;}// dist{1:=30, 0:=70};} 
	function void display(input string message); 
		$display("--------------%0t--------------%s-----------------------------",$time,message); 
		$display("datain=%d",datain); 
		$display("dataout=%d",dataout); 
		$display("mode=%d",mode); 
		$display("load=%d",load); 
		$display("reset=%d",rst); 
		$display("------------------------------------------------------------------------------"); 
	endfunction 
	function void post_randomize(); 
		if(this.rst==1||this.rst==0) 
		no_of_rst++; 
		if(this.load==1 || this.load==0) 
		no_of_load++; 
		if(this.mode==1) 
		no_of_upcount++; 
		if(this.mode==0) 
		no_of_downcount++; 
		this.display("randomized data"); 
	endfunction 
endclass



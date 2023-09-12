module tb_regfile(output err);
	
	reg [15:0] tw_data;
	reg [15:0] tr_data;
	reg [2:0] tr_addr;
	reg [2:0] tw_addr;
	reg tw_en;
 	reg tclk;
        reg err1;

	assign err = err1;

	regfile DUT (
			 .w_data(tw_data),
			 .w_addr(tw_addr),
			 .w_en(tw_en),
			 .r_addr(tr_addr),
			 .clk(tclk),
			 .r_data(tr_data)
			);

	initial begin 

	//write in R1
	tw_addr = 3'b001;
	//enable write
        tw_data = 16'b1000000000000000;
	tw_en = 1'b1;

	tr_addr = 3'b001;

	//update by rising edge of the clk
	tclk = 1'b1;
	
	#5;
	//Turn off the clk
	tclk = 1'b0;

	#5;
	
	$display ("%b has been written to R1", (16'b1000000000000000));
	$display ("The value is %b, we expected %b", tr_data, (16'b1000000000000000));
        if (tr_data == 16'b1000000000000000)
        err1 = 1'b0;
        else
        err1 = 1'b1;
        #5;
        $display ("err is %b, we expected %b", err, (1'b0));
        #5;

        //test whether it writes when enable to zero
        //write in R2
	tw_addr = 3'b001;
	//set enable to zero 
        tw_data = 16'b0001000000000000;
	tw_en = 1'b0;
        tr_addr = 3'b001;
 
        #5;
        tclk = 1'b1;
        #5;
        tclk = 1'b0;
        #5;
        tclk = 1'b1;
        #5;


        $display ("%b has been written to R1", (16'b0001000000000000));
	$display ("The value is %b, we expected %b", tr_data, (16'b1000000000000000));
        if (tr_data == 16'b0001000000000000)
        	 err1 = 1'b0;
        else
        	err1 = 1'b1;
        
        $display ("err is %b, we expected %b", err, (1'b0));
        #5;
        $stop;

	end
endmodule: tb_regfile


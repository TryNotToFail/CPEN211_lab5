module tb_shifter(output err);

  reg [15:0] test_shift_in;
  reg [15:0] test_shift_out;
  reg [1:0] test_shift_op;
  reg error;
  assign err = error;

  shifter DUT (
	 	 .shift_in(test_shift_in),
	 	 .shift_op(test_shift_op),
	 	 .shift_out(test_shift_out)
		);

  initial begin
 	//a random number and right shift 
    	test_shift_in = 16'b1100000000000011;
    	test_shift_op = 2'b01;
	error = 1'b0;
    	$display ("Number enters %b", 16'b1100000000000011);
	
     	//wait
     	#5;
	
	if (test_shift_out != 16'b1000000000000110) begin
		error = 1'b1;
	end

     	$display ("Shift out is %b, we expected %b", test_shift_out, (16'b1000000000000110));

	#5;

	//left shift
	test_shift_op = 2'b10;
	
	#5;

	if (test_shift_out != 16'b0110000000000001) begin
		error = 1'b1;
	end

	$display("Shift out is %b, we expected %b", test_shift_out, (16'b0110000000000001));

	#5;

	//Non-shifted 
	test_shift_op = 2'b00;
	
	#5;

	if (test_shift_out != 16'b1100000000000011) begin
		error = 1'b1;
	end
	
	$display("Shift out is %b, we expected %b", test_shift_out, (16'b1100000000000011));
	
	#5;
	//left shift with MSB[15]

	test_shift_op = 2'b11;
	
	#5;

	if (test_shift_out != 16'b1110000000000001) begin
		error = 1'b1;
	end
	
	$display("Shift out is %b, we expected %b", test_shift_out, (16'b1110000000000001));

  end
endmodule: tb_shifter

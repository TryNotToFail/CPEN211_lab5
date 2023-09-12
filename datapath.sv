module datapath(input clk, input [15:0] datapath_in, input wb_sel,
                input [2:0] w_addr, input w_en, input [2:0] r_addr, input en_A,
                input en_B, input [1:0] shift_op, input sel_A, input sel_B,
                input [1:0] ALU_op, input en_C, input en_status,
                output [15:0] datapath_out, output Z_out);
  // your implementation here

	wire [15:0] w_data;
	wire [15:0] r_data;
	reg [15:0] A_out;
	reg [15:0] B_out;
      wire [15:0] shift_in;
	reg [15:0] shift_out;
	wire [15:0] val_A;
	wire [15:0] val_B;
	wire [15:0] ALU_out;
	reg [15:0] data_out;
	wire Z;
	reg Z_result;
        reg [15:0] ALU_out1;
        reg Z1;
        reg [15:0] m[0:7];
	
	assign datapath_out = data_out;
	assign Z_out = Z_result;
	
	//first muxes select in and out
	assign w_data = wb_sel ? datapath_in : datapath_out;
	
	//regfile	
        assign r_data = m[r_addr];
        always_ff @(posedge clk) if (w_en) m[w_addr] <= w_data;
	
	//register A, B, C and Z
	always @ (posedge clk) begin
		if (en_A) A_out <= r_data;
		if (en_B) B_out <= r_data;
		if (en_C) data_out <= ALU_out;
		if (en_status) Z_result <= Z;
	end
	
	//shifter 
	 always_comb begin
	 case(shift_op)
	  2'b00: shift_out = shift_in;
	  2'b01: shift_out = shift_in << 1;
	  2'b10: shift_out = shift_in >> 1;
	  2'b11: begin 
		 shift_out = shift_in >> 1;
		 shift_out[15] = shift_in[15];
		 end
	 endcase 
         end
								
	//Muxes A and B
	wire [15:0] value = {11'b0,datapath_in[4:0]};
	
	assign val_A = sel_A ? 16'b0 : A_out;
	assign val_B = sel_B ? value : B_out;
	
	//ALU_op
	
        always @(*)
        begin
        case(ALU_op)
        2'b00: ALU_out1 = val_A+val_B;
        2'b01: ALU_out1 = val_A-val_B;
        2'b10: ALU_out1 = val_A&val_B;
        2'b11: ALU_out1 = ~val_B;

        endcase

        if (ALU_out1 == 16'b0)
        Z1 = 1;
        else
        Z1 = 0;
        end

        assign Z = Z1;
        assign ALU_out = ALU_out1;
	
endmodule: datapath

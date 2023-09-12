module tb_ALU(output err);

reg [1:0] sim_ALU_op;
reg [15:0] sim_val_A;
reg [15:0] sim_val_B;

reg [15:0] sim_ALU_out;
reg sim_Z;
reg err1;

assign err = err1;

ALU DUT (.val_A(sim_val_A), .val_B(sim_val_B), .ALU_op(sim_ALU_op), .ALU_out(sim_ALU_out), .Z(sim_Z));

initial begin
sim_val_A = 16'b0000000000000000;
sim_val_B = 16'b0000000000000000;

#5;

//Our first test: trying ADDING
sim_ALU_op = 2'b00;
sim_val_A = 16'b0000000000000000;
sim_val_B = 16'b0000000000000000;

#5;
$display ("Output is %b, we expected %b", sim_ALU_out, (16'b0000000000000000+16'b0000000000000000));
$display ("Z is %b, we expected %b", sim_Z, (1'b1)); 
if (sim_ALU_out == 16'b0000000000000000+16'b0000000000000000)
err1 = 1'b0;
else
err1 = 1'b1;
#5;
$display ("err is %b, we expected %b", err, (1'b0));

//Our second test: trying Substracting
sim_ALU_op = 2'b01;
sim_val_A = 16'b0000000000000000;
sim_val_B = 16'b0000000000000000;
#5;

$display ("Output is %b, we expected %b", sim_ALU_out, (16'b0000000000000000-16'b0000000000000000));
$display ("Z is %b, we expected %b", sim_Z, (1'b1)); 
if (sim_ALU_out == 16'b0000000000000000-16'b0000000000000000)
err1 = 1'b0;
else
err1 = 1'b1;
#5;
$display ("err is %b, we expected %b", err, (1'b0));

//Try changing our inputs, note that we are still substracting!
sim_val_A = 16'b0001000000000000;
sim_val_B = 16'b0000010000100010;
#5;

$display("Output is %b, we expected %b", sim_ALU_out, (16'b0001000000000000-16'b0000010000100010));
$display ("Z is %b, we expected %b", sim_Z, (1'b0)); 
if (sim_ALU_out == 16'b0001000000000000-16'b0000010000100010)
err1 = 1'b0;
else
err1 = 1'b1;
#5;
$display ("err is %b, we expected %b", err, (1'b0));
#5;

//Try ANDing
sim_ALU_op = 2'b10;
sim_val_A = 16'b0000000000000000;
sim_val_B = 16'b0000000000000000;
#5;

$display ("Output is %b, we expected %b", sim_ALU_out, (16'b0&16'b0));
$display ("Z is %b, we expected %b", sim_Z, (1'b1)); 
if (sim_ALU_out == (16'b0&16'b0))
err1 = 1'b0;
else
err1 = 1'b1;
#5;
$display ("err is %b, we expected %b", err, (1'b0));

//Try NOTB
sim_ALU_op = 2'b11;
sim_val_A = 16'b0000000000000000;
sim_val_B = 16'b0000000000000000;
#5;

$display ("Output is %b, we expected %b", sim_ALU_out, (~16'b0000000000000000));
$display ("Z is %b, we expected %b", sim_Z, (1'b0)); 
if (sim_ALU_out == ~16'b0000000000000000)
err1 = 1'b0;
else
err1 = 1'b1;
#5;
$display ("err is %b, we expected %b", err, (1'b0));
#5;

$stop;

end
endmodule: tb_ALU

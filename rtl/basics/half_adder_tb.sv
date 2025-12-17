module half_adder_tb;
//declare signals
logic a,b;
logic sum,carry;

//instantiate
half_adder dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

initial begin
    $display("Starting half adder test");
    $display("Time  |  A  |  B  |  Sum  |  Carry  ");
    $display("------------------------------------");

    //Test case 1 : A = 0, B = 0
    a = 0;
    b = 0;
    #10; //wait --> so that signal settles
    $display("%4t  | %b | %b | %b |%b",$time,a,b,sum,carry);

    //Test case 2: A = 1, B = 0
    a = 1;
    b = 0;
    #10;
    $display("%4t  | %b | %b | %b | %b",$time,a,b,sum,carry);

    //Test case 3: A = 0, B = 1
    a = 0;
    b = 1;
    #10;
    $display("%4t | %b | %b | %b | %b",$time,a,b,sum,carry);

    //Test case 4: A = 1, B = 1
    a = 1;
    b = 1;
    #10;
    $display("%4t | %b | %b | %b | %b",$time,a,b,sum,carry);

    $display("\nTest Complete!\n");
    $finish;
end

    initial begin
        $dumpfile("sim/half_adder.vcd");
        $dumpvars(0, half_adder_tb);
    end
endmodule




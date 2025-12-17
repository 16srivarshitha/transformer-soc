module full_adder_tb;
//declare signals

logic a, b, carry_in;
logic sum, carry_out;

//instantiate
full_adder dut(
    .a(a),
    .b(b),
    .carry_in(carry_in),
    .sum(sum),
    .carry_out(carry_out)
);

initial begin
        $display("---------------------------------------------------------");
        $display("Time |  A  |  B  | Cin | Sum | Cout | Check");
        $display("---------------------------------------------------------");

        // We can use a loop to generate all 8 combinations (000 to 111)
        for (int i = 0; i < 8; i++) begin
            {a, b, carry_in} = i[2:0]; // Assign bits of 'i' to inputs
            #10; // Wait for logic to settle
                        // The sum of inputs should equal {carry_out, sum}
            if ({carry_out, sum} !== (a + b + carry_in)) 
                $display("%4t |  %b  |  %b  |  %b  |  %b  |  %b   | FAIL", $time, a, b, carry_in, sum, carry_out);
            else
                $display("%4t |  %b  |  %b  |  %b  |  %b  |  %b   | PASS", $time, a, b, carry_in, sum, carry_out);
        end

        $display("---------------------------------------------------------");
        $finish;
    end

    // Waveform 
    initial begin
        $dumpfile("sim/full_adder.vcd");
        $dumpvars(0, full_adder_tb);
    end

endmodule
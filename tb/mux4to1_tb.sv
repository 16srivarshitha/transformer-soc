`timescale 1ns / 1ps

module mux4to1_tb;

    // 1. Parameters & Signals
    parameter WIDTH = 8;

    logic [WIDTH-1:0] in0, in1, in2, in3;
    logic [1:0]       sel;
    logic [WIDTH-1:0] out;

    // 2. Instantiate the DUT
    mux4to1 #(
        .WIDTH(WIDTH)
    ) dut (
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .sel(sel),
        .out(out)
    );

    // 3. Simulation Logic
    initial begin
        $dumpfile("sim/mux4to1.vcd");
        $dumpvars(0, mux4to1_tb);

        $display("-----------------------------------------");
        $display("Starting Simulation: Mux 4-to-1");
        $display("-----------------------------------------");

        // --- Test Case 1: Directed Test (Walk through all selects) ---
        in0 = 8'h11; in1 = 8'h22; in2 = 8'h33; in3 = 8'h44;
        
        sel = 2'b00; #5; check_output("Directed sel=00");
        sel = 2'b01; #5; check_output("Directed sel=01");
        sel = 2'b10; #5; check_output("Directed sel=10");
        sel = 2'b11; #5; check_output("Directed sel=11");

        // --- Test Case 2: Randomized Loop ---
        $display("Starting Randomized Tests...");
        for (int i = 0; i < 10; i++) begin
            in0 = 8'($random);
            in1 = 8'($random);
            in2 = 8'($random);
            in3 = 8'($random);
            sel = 2'($random); // Cast to 2 bits to avoid warnings
            #5;
            check_output($sformatf("Random Test %0d", i));
        end

        $display("-----------------------------------------");
        $display("Simulation Complete.");
        $display("-----------------------------------------");
        $finish;
    end

    // 4. Verification Task
    task check_output(input string test_name);
        logic [WIDTH-1:0] expected;
        case (sel)
            2'b00: expected = in0;
            2'b01: expected = in1;
            2'b10: expected = in2;
            2'b11: expected = in3;
            default: expected = 'x;
        endcase

        if (out === expected) begin
            $display("[PASS] %s | sel=%b out=%h (Expected %h)", 
                     test_name, sel, out, expected);
        end else begin
            $error("[FAIL] %s | sel=%b out=%h (Expected %h)", 
                   test_name, sel, out, expected);
        end
    endtask

endmodule
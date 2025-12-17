`timescale 1ns / 1ps

module mux2to1_tb;

    // declare signals
    parameter WIDTH = 8;

    logic [WIDTH-1:0] in0;
    logic [WIDTH-1:0] in1;
    logic             sel;
    logic [WIDTH-1:0] out;

    // Instantiate the DUT 
    mux2to1 #(
        .WIDTH(WIDTH)
    ) dut (
        .in0(in0),
        .in1(in1),
        .sel(sel),
        .out(out)
    );

    initial begin
        // Setup for GTKWave
        $dumpfile("sim/mux2to1.vcd");
        $dumpvars(0, mux2to1_tb);

        $display("-----------------------------------------");
        $display("Starting Simulation: Mux 2-to-1");
        $display("-----------------------------------------");

        // --- Test Case 1: Directed Test (Manual Values) ---
        in0 = 8'hAA; // 10101010
        in1 = 8'h55; // 01010101
        sel = 0;     // Should pick in0
        #5;          // Wait 5 time units
        check_output("Manual Test 1 (sel=0)");

        sel = 1;     // Should pick in1
        #5;
        check_output("Manual Test 2 (sel=1)");

        // --- Test Case 2: Randomized Loop ---
        $display("Starting Randomized Tests...");
        for (int i = 0; i < 10; i++) begin
            in0 = 8'($random);
            in1 = 8'($random);
            sel = 1'($random); 
            #5;
            check_output($sformatf("Random Test %0d", i));
        end

        $display("-----------------------------------------");
        $display("Simulation Complete. Waveforms generated.");
        $display("-----------------------------------------");
        $finish;
    end

    // 4. Automatic Verification Task
    // This task checks if the hardware output matches the expected behavior
    task check_output(input string test_name);
        logic [WIDTH-1:0] expected;
        
        // Behavioral Model 
        expected = (sel) ? in1 : in0;

        if (out === expected) begin
            $display("[PASS] %s | sel=%b in0=%h in1=%h -> out=%h", 
                     test_name, sel, in0, in1, out);
        end else begin
            $error("[FAIL] %s | sel=%b in0=%h in1=%h -> Output=%h (Expected %h)", 
                   test_name, sel, in0, in1, out, expected);
        end
    endtask

endmodule
`timescale 1ns / 1ps

module dff_tb;

    // 1. Signals
    logic clk;
    logic rst_n;
    logic d;
    logic q;

    // 2. Instantiate the DUT
    dff dut (
        .clk(clk),
        .rst_n(rst_n),
        .d(d),
        .q(q)
    );

    // 3. Clock Generation
    // Toggles every 5ns -> Period = 10ns -> Frequency = 100MHz
    always #5 clk = ~clk;

    // 4. Test Sequence
    initial begin
        $dumpfile("sim/dff.vcd");
        $dumpvars(0, dff_tb);

        $display("-----------------------------------------");
        $display("Starting Simulation: D Flip-Flop");
        $display("-----------------------------------------");

        // Initialize signals
        clk = 0;
        rst_n = 0; // Start in Reset
        d = 0;

        // --- Test 1: Reset Check ---
        #10; // Hold reset for a bit
        if (q !== 0) $error("[FAIL] Reset did not clear Q!");
        else $display("[PASS] Reset functionality confirmed (Q=0)");
        
        rst_n = 1; // Release Reset (Active Low)

        // --- Test 2: Randomized Data Loop ---
        $display("Starting Random Data Tests...");
        
        for (int i = 0; i < 10; i++) begin
            @(negedge clk);
            d = 1'($random); 

            @(posedge clk);

            // Wait a tiny bit for the output to update (propagation delay)
            #1; 

            // Verify
            check_output($sformatf("Random Test %0d", i));
        end

        // --- Test 3: Asynchronous Reset Check ---
        // We will assert reset while the clock is high and D is high
        // to prove it resets IMMEDIATELY without waiting for a clock edge.
        $display("Testing Asynchronous Reset...");
        @(negedge clk);
        d = 1;
        @(posedge clk); 
        #1; // Q should now be 1
        
        if (q !== 1) $error("Setup failed, Q should be 1");
        
        #2 rst_n = 0; // Assert Reset NOW (Asynchronous)
        #1;           // Wait tiny delay
        
        if (q === 0) $display("[PASS] Async Reset worked (Q dropped to 0 immediately)");
        else $error("[FAIL] Async Reset failed. Q=%b", q);


        $display("-----------------------------------------");
        $display("Simulation Complete.");
        $display("-----------------------------------------");
        $finish;
    end

    // Verification Task
    task check_output(input string test_name);
        if (q === d) begin
            $display("[PASS] %s | d=%b -> q=%b", test_name, d, q);
        end else begin
            $error("[FAIL] %s | d=%b -> q=%b (Expected %b)", test_name, d, q, d);
        end
    endtask

endmodule
`timescale 1ns / 1ps

module register_8bit_tb;

    // 1. Signals
    parameter WIDTH = 8;

    logic             clk;
    logic             rst_n;
    logic             en;
    logic [WIDTH-1:0] d;
    logic [WIDTH-1:0] q;

    // 2. Instantiate the DUT
    register_8bit #(
        .WIDTH(WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .d(d),
        .q(q)
    );

    // 3. Clock Generation (100MHz)
    always #5 clk = ~clk;

    // 4. Test Logic
    initial begin
        $dumpfile("sim/register_8bit.vcd");
        $dumpvars(0, register_8bit_tb);

        $display("-----------------------------------------");
        $display("Starting Simulation: 8-bit Register");
        $display("-----------------------------------------");

        // Initialize
        clk = 0;
        rst_n = 0; // Reset active
        en = 0;
        d = 0;

        // --- Test 1: Reset Behavior ---
        #10;
        rst_n = 1; // Release reset
        
        // --- Test 2: Enable = 1 (Writing Data) ---
        $display("Test 2: Writing Data (Enable = 1)...");
        for (int i = 0; i < 5; i++) begin
            @(negedge clk);
            en = 1;
            d = 8'($random); // Change data
            
            @(posedge clk);  // Wait for write
            #1;              // Prop delay
            
            check_output("Write Test");
        end

        // --- Test 3: Enable = 0 (Holding Data) ---
        $display("Test 3: Holding Data (Enable = 0)...");
        
        // First, write a known value (0xAA)
        @(negedge clk);
        en = 1; 
        d = 8'hAA; 
        @(posedge clk); 
        
        // Now DISABLE writing and change input 'd' to something else (0x55)
        @(negedge clk);
        en = 0;          // Turn off write!
        d = 8'h55;       // Change input data
        
        @(posedge clk);  // Clock ticks
        #1;
        
        // Q should still be 0xAA (the old value), NOT 0x55
        if (q === 8'hAA) 
            $display("[PASS] Hold Test | Input changed to %h, but Output held at %h", d, q);
        else 
            $error("[FAIL] Hold Test | Output changed to %h! Should have stayed %h", q, 8'hAA);


        // --- Test 4: Randomized Mix ---
        $display("Test 4: Randomized Write/Hold...");
        for (int i = 0; i < 10; i++) begin
            @(negedge clk);
            en = 1'($random); // Randomly enable or disable
            d = 8'($random);
        end
        
        #20;
        $display("-----------------------------------------");
        $display("Simulation Complete.");
        $display("-----------------------------------------");
        $finish;
    end

    // Verification Task (Only useful when En=1)
    task check_output(input string test_name);
        if (en && q === d) begin
            $display("[PASS] %s | en=%b d=%h -> q=%h", test_name, en, d, q);
        end else if (en && q !== d) begin
            $error("[FAIL] %s | en=%b d=%h -> q=%h (Expected %h)", test_name, en, d, q, d);
        end
    endtask

endmodule
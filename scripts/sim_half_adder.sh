#!/bin/bash

# 1. CLEANUP 
rm -rf obj_dir sim
mkdir -p sim

# 2. RUN VERILATOR
verilator --binary -j 4 --trace --timing \
    rtl/basics/half_adder.sv \
    tb/half_adder_tb.sv \
    --top-module half_adder_tb

# 3. RUN SIMULATION
./obj_dir/Vhalf_adder_tb

# 4. OPEN WAVEFORM
echo "Opening Waveform..."
gtkwave sim/half_adder.vcd &
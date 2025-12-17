rm -rf obj_dir
mkdir -p sim

verilator --binary -j 4 --trace --timing \
    rtl/basics/half_adder.sv \
    rtl/basics/full_adder.sv \
    tb/full_adder_tb.sv \
    --top-module full_adder_tb

./obj_dir/Vfull_adder_tb

echo "Opening Waveform..."
gtkwave sim/full_adder.vcd &
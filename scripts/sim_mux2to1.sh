rm -rf obj_dir
mkdir -p sim

verilator --binary -j 4  --trace --timing \
    rtl/basics/mux2to1.sv \
    tb/mux2to1_tb.sv \
    --top-module mux2to1_tb

./obj_dir/Vmux2to1_tb

echo "Opening waveform..."
gtkwave sim/mux2to1.vcd &
rm -rf obj_dir
mkdir -p sim

verilator --binary -j 4 --trace --timing \
    rtl/basics/mux4to1.sv \
    tb/mux4to1_tb.sv \
    --top-module mux4to1_tb

./obj_dir/Vmux4to1_tb

echo "Opening waveform..."
gtkwave sim/mux4to1.vcd &
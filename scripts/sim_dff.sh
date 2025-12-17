rm -rf obj_dir
mkdir -p sim

verilator --binary -j 4 --trace --timing \
    rtl/basics/dff.sv \
    tb/dff_tb.sv \
    --top-module dff_tb

./obj_dir/Vdff_tb

echo "Opening waveform..."
gtkwave sim/dff.vcd &
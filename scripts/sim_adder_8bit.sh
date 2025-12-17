rm -rf obj_dir
mkdir -p sim

verilator --binary -j 4 --trace --timing \
    rtl/basics/half_adder.sv \
    rtl/basics/full_adder.sv \
    rtl/basics/adder_8bit.sv \
    tb/adder_8bit_tb.sv \
    --top-module adder_8bit_tb

./obj_dir/Vadder_8bit_tb

echo "Opening Waveform ... "
gtkwave sim/adder_8bit.vcd &
rm -rf obj_dir
mkdir -p sim

verilator --binary -j 4 --trace --timing \
    rtl/basics/register_8bit.sv \
    tb/register_8bit_tb.sv \
    --top-module register_8bit_tb

./obj_dir/Vregister_8bit_tb
echo "Opening waveform..."
gtkwave sim/register_8bit.vcd &
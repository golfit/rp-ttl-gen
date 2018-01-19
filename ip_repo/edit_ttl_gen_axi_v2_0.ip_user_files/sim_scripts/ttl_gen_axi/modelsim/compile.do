vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../bd/ttl_gen_axi/sim/ttl_gen_axi.v" \


vlog -work xil_defaultlib \
"glbl.v"


vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/ttl_gen_axi/sim/ttl_gen_axi.v" \


vlog -work xil_defaultlib \
"glbl.v"


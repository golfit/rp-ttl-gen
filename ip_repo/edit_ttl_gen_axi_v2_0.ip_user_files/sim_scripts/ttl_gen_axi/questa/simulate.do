onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ttl_gen_axi_opt

do {wave.do}

view wave
view structure
view signals

do {ttl_gen_axi.udo}

run -all

quit -force

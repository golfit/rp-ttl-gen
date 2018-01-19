onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+ttl_gen_axi -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ttl_gen_axi xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {ttl_gen_axi.udo}

run -all

endsim

quit -force

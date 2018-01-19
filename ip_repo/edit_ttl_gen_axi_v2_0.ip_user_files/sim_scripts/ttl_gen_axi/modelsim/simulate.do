onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.ttl_gen_axi xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {ttl_gen_axi.udo}

run -all

quit -force

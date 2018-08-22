all: hardware.bin


hardware.blif: hardware.v spimemio.v simpleuart.v picosoc.v picorv32.v neopixel.v
	yosys -ql hardware.log -p 'synth_ice40 -top hardware -blif hardware.blif' $^

hardware.asc: hardware.pcf hardware.blif
	arachne-pnr -d 8k -P cm81 -o hardware.asc -p hardware.pcf hardware.blif

hardware.bin: hardware.asc
	icetime -d hx8k -c 12 -mtr hardware.rpt hardware.asc
	icepack hardware.asc hardware.bin


clean:
	rm -f hardware.blif hardware.log hardware.asc hardware.rpt hardware.bin





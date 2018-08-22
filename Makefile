
upload: hardware/hardware.bin firmware/firmware.bin
	make -C hardware
	tinyprog -p hardware/hardware.bin -u firmware/firmware.bin

hardware/hardware.bin::
	make -C hardware

firmware/firmware.bin::
	make -C firmware

clean:
	make -C firmware clean
	make -C hardware clean

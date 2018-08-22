all: firmware.elf
	riscv32-elf-objcopy -O binary firmware.elf /dev/stdout > firmware.bin

firmware.elf::
	gprbuild --target=riscv32-elf --RTS=zfp-picorv32 -O2 firmware \
		-o firmware.elf \
		-cargs -fdata-sections -ffunction-sections \
		-largs -Wl,-gc-section,--print-memory-usage

clean:
	rm -f *.o *.stdout *.stderr *.ali *.map b__* *.bin *.elf *.bexch

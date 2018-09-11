# Ada-PicoRV32-example
Example of Ada code running on the PicoRV32 RISC-V CPU for FPGA

You will find more information about this project in this [blog post](https://blog.adacore.com/ada-on-fpgas-with-picorv32).

## Hardware

This example uses a [TinyFPGA-BX](https://tinyfpga.com/) board and an AdaFruit [Neopixel strip](https://www.adafruit.com/product/1426).

## Compiler

You can get a RISC-V32 compiler from [adacore.com/download](adacore.com/download) (Linux64 host only).

## Run-time

To build and install the run-time, use the folowing commands:

```
$ git clone https://github.com/AdaCore/bb-runtimes
$ cd bb-runtimes
$ ./build_rts.py --output=temp picorv32
$ gprbuild -P temp/BSPs/zfp_picorv32.gpr
$ gprinstall -p -f -P temp/BSPs/zfp_picorv32.gpr
```
## Build and flash

To build and flash the project, just run `make` in the root directory.
Make sure that your TinyFPGA-BX board is in bootloader mode.

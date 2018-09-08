# ASP (Application Specific Processor)

## Description
Development of a tool for generating customized processors for specific applications.

## Build

Toolchain of RISCV RV32I Installation

For compile the RISC V RV32I there are some dependencies:

- **autoconf**
- **automake**
- **autotools-dev**
- **curl**
- **libmpc-dev**
- **libmpfr-dev**
- **libgmp-dev**
- **gawk**
- **build-essential**
- **bison**
- **flex**
- **texinfo**
- **gperf**
- **libtool**
- **patchutils**

Install dependecies:
```console
sudo apt-get install autoconf automake autotools-dev curl libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils
```

Download toolchain RISCV files:
```console
git clone https://github.com/riscv/riscv-gnu-toolchain riscv-gnu-toolchain-rv32i
```
Configuring tools:
```console
sudo ./configure --with-arch=rv32i
```

Any problem configuring tools (step before) it will fixed using:
```console
sudo ./configure --with-xlen=32 --with-arch=I
```

Installing toolchain (The installation need more or less than 4 hours):
```console
sudo make -j$(nproc)
```

Installing elf2hex:
```console
git clone https://github.com/riscv/riscv-fesvr riscv-fesvr
```

Configuring elf2hex:
```console
cd riscv-fesvr/ && sudo ./configure && sudo make install
```

At this point all the tools for the cross-compilation were installed.


## License

[GPLv2](./LICENSE).



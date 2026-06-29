# Vedic Multiplier in Verilog

A Verilog implementation of the **Vedic Multiplier** based on the **Urdhva-Tiryagbhyam (Vertical and Crosswise)** multiplication algorithm. This repository includes **two different RTL architectures** for implementing an 8×8 unsigned Vedic multiplier, enabling comparison between a classical hierarchical design and a scalable generate-based implementation.

## Features

* 8×8 unsigned Vedic multiplier
* Two RTL architectures

* Hierarchical recursive implementation
* Generate-based parameterized implementation
* Modular Verilog design
* Separate testbenches for each architecture
* Synthesizable RTL
* Functional verification using Icarus Verilog
* Waveform generation with GTKWave

---

# Architectures

## 1. Hierarchical Recursive Architecture

This implementation follows the conventional Vedic multiplier structure by recursively constructing larger multipliers from smaller ones.

```
8×8
├── 4×4
│   ├── 2×2
│   ├── 2×2
│   ├── 2×2
│   └── 2×2
├── 4×4
├── 4×4
└── 4×4
```

### Characteristics

* Classical Vedic multiplier implementation
* Highly modular design
* Easy to understand and verify
* Matches hardware architectures commonly presented in VLSI literature

Files used:

```
adder.v
vedic2x2.v
vedic_4x4.v
vedic_8x8.v
```

---

## 2. Generate-Based Architecture

This implementation uses Verilog **generate** constructs to automatically instantiate repeated hardware blocks. The design is parameterized and can be extended to larger operand widths with minimal modifications.

### Characteristics

* Parameterized RTL
* Reduced code duplication
* Easily scalable
* Suitable for reusable IP development
* Synthesizes to hardware comparable to manual instantiation

Files used:

```
adder.v
vedic-generate.v
vedic-top.v
```

---

# Repository Structure

```
vedic_multiplier/
│
├── adder.v                  # Adder modules
├── vedic2x2.v               # Base 2×2 Vedic multiplier
├── vedic_4x4.v              # Recursive 4×4 multiplier
├── vedic_8x8.v              # Recursive 8×8 multiplier
│
├── vedic-generate.v         # Generate-based implementation
├── vedic-top.v              # Top module for generate architecture
│
├── vedic_tb_rec.v           # Testbench for recursive architecture
├── vedic_tb_generate.v      # Testbench for generate-based architecture
│
├── dump.vcd                 # Generated waveform
├── sim                      # Simulation executable
└── README.md
```

---

# Simulation

## Recursive Architecture

Compile:

```bash
iverilog -g2012 -o sim \
vedic_8x8.v \
vedic_tb_rec.v
```

Run:

```bash
vvp sim
```

View waveform:

```bash
gtkwave dump.vcd
```

---

## Generate-Based Architecture

Compile:

```bash
iverilog -g2012 -o sim \
vedic-top.v \
vedic_tb_generate.v
```

Run:

```bash
vvp sim
```

View waveform:

```bash
gtkwave dump.vcd
```

---

# Verification

Both implementations have been functionally verified using dedicated Verilog testbenches. The RTL outputs are compared against the expected multiplication results, and simulation waveforms are generated for functional analysis using GTKWave.

---

# Future Improvements

* Signed multiplication support
* Support for configurable operand widths
* Pipelined implementation for higher operating frequencies
* FPGA synthesis and implementation
* Area, timing, and power comparison between both architectures
* Performance evaluation on Xilinx Artix-7 FPGA

---

# Tools Used

* Verilog HDL
* SystemVerilog
* Icarus Verilog
* GTKWave

---

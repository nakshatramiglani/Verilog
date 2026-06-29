# Asynchronous FIFO in Verilog

An RTL implementation of an **Asynchronous First-In-First-Out (FIFO)** memory in Verilog. The design enables reliable data transfer between two independent clock domains by maintaining separate read and write clocks, making it suitable for Clock Domain Crossing (CDC) applications.

## Features

* Independent read and write clock domains
* Parameterizable FIFO depth and data width
* Full and empty flag generation
* Circular buffer implementation
* Synthesizable RTL
* Functional verification using a dedicated testbench
* Waveform generation using GTKWave

---

# Architecture

The FIFO consists of the following major components:

* Memory array for data storage
* Independent write pointer
* Independent read pointer
* Full flag logic
* Empty flag logic
* Separate write and read clock domains

```
               +-------------------------+
 Write Clock -->|                         |
 Write Enable -->|     Asynchronous FIFO   |--> Read Data
 Write Data ---->|                         |
                |      Memory Array        |
 Read Enable --->|                         |
 Read Clock ---->|                         |
               +-------------------------+
                    ↑               ↑
               Write Pointer   Read Pointer
```

---

# Repository Structure

```
async_FIFO/
│
├── fifo.v                 # Asynchronous FIFO RTL
├── fifo_tb.v              # Testbench
├── dump.vcd               # Simulation waveform
├── a.out                  # Compiled simulation executable
├── asynchronous_fifo.md   # Project documentation
└── README.md
```

---

# Simulation

Compile:

```bash
iverilog -g2012 -o a.out \
fifo.v \
fifo_tb.v
```

Run:

```bash
vvp a.out
```

View waveform:

```bash
gtkwave dump.vcd
```

---

# Design Overview

The FIFO allows data transfer between two asynchronous clock domains by maintaining independent read and write operations.

### Write Operation

* Data is written on the rising edge of the write clock.
* The write pointer advances when `wr_en` is asserted and the FIFO is not full.
* Writes are blocked when the FIFO reaches capacity.

### Read Operation

* Data is read on the rising edge of the read clock.
* The read pointer advances when `rd_en` is asserted and the FIFO is not empty.
* Reads are blocked when no data is available.

### Status Flags

* **Full**: Indicates the FIFO cannot accept additional data.
* **Empty**: Indicates there is no data available for reading.

---

# Verification

The design is verified using a Verilog testbench that exercises:

* FIFO write operations
* FIFO read operations
* Simultaneous read/write conditions
* Full condition
* Empty condition
* Pointer wrap-around behavior

Simulation waveforms are generated using GTKWave for functional verification.

---

# Applications

Asynchronous FIFOs are commonly used in:

* Clock Domain Crossing (CDC)
* FPGA and ASIC designs
* High-speed communication interfaces
* DMA controllers
* AXI-Stream interfaces
* UART, SPI, and Ethernet buffering
* Video and image processing pipelines

---

# Future Improvements

* Gray code read/write pointers for robust CDC
* Pointer synchronization using two-stage synchronizers
* Almost Full and Almost Empty flags
* Configurable FIFO depth
* Dual-port RAM implementation
* FPGA synthesis and timing analysis
* SystemVerilog assertions for verification

---

# Tools Used

* Verilog HDL
* Icarus Verilog
* GTKWave


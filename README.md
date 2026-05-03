# FPGA-Accelerated Neural Network for Wildfire Pixel Classification

A compact fixed-point RGB multilayer perceptron (MLP) implemented in VHDL for low-latency wildfire pixel classification on FPGA devices.

This repository contains the software-to-hardware workflow used to train a small neural network in Python, quantize its parameters, export fixed-point coefficients, and verify a synthesizable VHDL inference core for Xilinx FPGA targets.

> **Research scope**  
> This project is a research prototype for early wildfire indication at the edge. It is not a certified safety-critical wildfire alarm system.

---

## Overview

Many image-based wildfire monitoring systems rely on cloud processing or GPU-based inference. This increases latency, energy consumption, and deployment complexity, especially in remote environments. This project explores a hardware-first alternative: a small neural network implemented directly on FPGA fabric for deterministic per-pixel classification from RGB video streams.

The implemented classifier uses:

- **Input:** RGB888 pixel stream, one pixel at a time
- **Model:** compact **3-7-2 MLP**
- **Task:** binary pixel classification: `fire` / `not fire`
- **Arithmetic:** fixed-point integer representation
- **Activation:** sigmoid lookup table (LUT/ROM)
- **Hardware language:** VHDL
- **Main FPGA target:** Zynq UltraScale+ MPSoC ZCU106
- **Additional targets:** Spartan-7 and Artix-7

The design priority is not maximum deep-learning accuracy, but **real-time deployability, low latency, deterministic timing, and portability across FPGA families**.

---

## Key Results

| Metric | Result |
|---|---:|
| Validation accuracy | 79.7% |
| Average precision (AP) | 0.781 |
| F1-score | 0.830 |
| ZCU106 clock frequency | 74.25 MHz |
| ZCU106 end-to-end latency | 121.2 ns |
| ZCU106 throughput | 1.782 Gbit/s |
| Best cross-device throughput | 2.256 Gbit/s on Artix-7 |

### Cross-device implementation summary

| Board / Target | Frequency (MHz) | LUTs | Throughput (Gbit/s) | Throughput / Area (Gbit/s/kLUT) |
|---|---:|---:|---:|---:|
| ZCU106 | 74.25 | 4850 | 1.782 | 0.367 |
| Spartan-7 | 90.00 | 5060 | 2.184 | 0.432 |
| Artix-7 | 94.00 | 5085 | 2.256 | 0.444 |

---

## System Architecture

The design follows an end-to-end software-to-hardware flow:

```mermaid
flowchart LR
    A[RGB images + segmentation masks] --> B[Python dataset preparation]
    B --> C[Train 3-7-2 MLP]
    C --> D[Evaluate floating-point model]
    D --> E[Quantize weights and biases]
    E --> F[Generate sigmoid LUT]
    F --> G[Export coefficients]
    G --> H[VHDL fixed-point inference core]
    H --> I[RTL simulation]
    I --> J[Vivado synthesis and implementation]
```

At hardware level, each RGB pixel is processed through a streaming datapath:

```mermaid
flowchart LR
    A[RGB888 input pixel] --> B[Pre-scale / clamp]
    B --> C[Layer 1: 3 to 7 neurons]
    C --> D[Sigmoid LUT ROM]
    D --> E[Layer 2: 7 to 2 neurons]
    E --> F[Fire / not-fire decision]
    F --> G[RGB overlay / output stream]
```

After the pipeline is filled, the design accepts **one pixel per clock cycle**.

---

## Neural Network Model

The classifier is a compact MLP:

```text
Input layer:   3 neurons   -> R, G, B
Hidden layer:  7 neurons   -> sigmoid activation
Output layer:  2 neurons   -> fire / not fire
```

The total number of exported fixed-point parameters is:

```text
Layer 1 weights: 3 x 7  = 21
Layer 1 biases:  7      = 7
Layer 2 weights: 7 x 2  = 14
Layer 2 biases:  2      = 2
Total parameters        = 44
```

The model is intentionally small so that it maps efficiently to FPGA multiply-accumulate datapaths.

---

## Fixed-Point Representation

The implementation avoids floating-point arithmetic in hardware.

| Component | Representation |
|---|---|
| RGB input | 8-bit per channel |
| Weights | signed fixed-point / integer coefficients |
| Biases | signed fixed-point / integer coefficients |
| Activation | sigmoid LUT |
| Sigmoid address | 12-bit |
| Sigmoid output | 8-bit |

The sigmoid activation is implemented as a ROM lookup table instead of computing the exponential function directly in RTL. This reduces hardware cost and gives predictable latency.

---

## Repository Structure

```text
FPGA_generate_spartan7/
├── VHDL/                 # Synthesizable VHDL source files and testbenches
├── coeffs/               # Exported fixed-point weights, biases, and activation LUT
├── data/wildfire/        # Dataset folder structure
├── docs/                 # Paper, presentation, bibliography, and supporting documents
├── python/               # Training, evaluation, quantization, and export scripts
├── sim/                  # ModelSim/Questa simulation files and image stimuli/responses
├── vivado_thesis/        # Vivado projects, reports, and target-specific implementations
├── rerun_vivado.tcl      # Vivado batch script
└── README.md             # Project documentation
```

---

## Main VHDL Modules

| File | Purpose |
|---|---|
| `VHDL/config.vhd` | Central configuration: widths, ranges, constants, and exported coefficients |
| `VHDL/multiplier.vhd` | Fixed-point multiplication block, typically mapped to FPGA DSP resources |
| `VHDL/neuron.vhd` | Multiply-accumulate neuron with bias addition and activation interface |
| `VHDL/sigmoid_IP.vhd` | ROM-based sigmoid activation wrapper |
| `VHDL/sigmoid_lut.vhd` | Sigmoid lookup table contents / ROM implementation |
| `VHDL/control.vhd` | Synchronization, valid-signal control, and pipeline alignment |
| `VHDL/nn_rgb.vhd` | Top-level RGB streaming neural-network inference core |
| `VHDL/tb_nn_rgb.vhd` | Image-based RTL simulation testbench |
| `VHDL/sim_nn_rgb.vhd` | Simulation support for the neural-network core |

---

## Python Workflow

The Python scripts are used to train the model and prepare hardware-compatible parameters.

| File | Purpose |
|---|---|
| `python/train_mlp.py` | Trains the 3-7-2 MLP using RGB pixel samples |
| `python/evaluate_and_plot.py` | Evaluates the trained model and generates validation plots |
| `python/export_fixedpoint.py` | Converts trained floating-point parameters to fixed-point values |
| `python/gen_sigmoid_lut.py` | Generates the sigmoid activation lookup table |
| `python/activation_txt_to_coe.py` | Converts activation LUT text data to Xilinx COE format |
| `python/export_to_xilinx.py` | Exports coefficients and LUT files for Xilinx/Vivado integration |
| `python/make_test_vectors.py` | Generates test vectors for software/RTL verification |
| `python/config.yaml` | Stores model and quantization configuration values |

---

## Coefficient Files

The `coeffs/` directory contains the fixed-point artifacts exported from Python and used by the VHDL design:

```text
coeffs/
├── activation_lut.coe
├── activation_lut.txt
├── bias_layer1.txt
├── bias_layer2.txt
├── weights_layer1.txt
└── weights_layer2.txt
```

These files allow the trained software model to be reproduced in the hardware implementation.

---

## Quick Start

### 1. Clone the repository

```bash
git clone https://github.com/kojos03/FPGA_generate_spartan7.git
cd FPGA_generate_spartan7
```

### 2. Create a Python environment

```bash
python -m venv .venv
```

Activate it:

```bash
# Windows
.venv\Scripts\activate

# Linux/macOS
source .venv/bin/activate
```

Install the common Python dependencies:

```bash
pip install numpy matplotlib scikit-learn pyyaml pillow
```

If a `requirements.txt` file is added later, use:

```bash
pip install -r requirements.txt
```

---

## Training and Export Flow

Run the software pipeline from the `python/` directory:

```bash
cd python
python train_mlp.py
python evaluate_and_plot.py
python export_fixedpoint.py
python gen_sigmoid_lut.py
python activation_txt_to_coe.py
python export_to_xilinx.py
```

Expected output artifacts include fixed-point weights, biases, activation LUT samples, and Xilinx-compatible coefficient files.

---

## RTL Simulation

The RTL simulation verifies that the VHDL datapath produces aligned image-level output.

The testbench reads:

```text
sim/image_stimuli.ppm
```

and writes output images such as:

```text
sim/image_response.ppm
sim/tb_nn_rgb_response.ppm
```

A typical ModelSim/Questa workflow is:

1. Open `sim/sim.mpf`.
2. Compile the VHDL sources in `VHDL/`.
3. Run the `tb_nn_rgb` testbench.
4. Inspect the generated PPM/PNG response image.

The simulation is used to check both the neural-network arithmetic and the alignment of video timing signals such as valid/data-enable and sync signals.

---

## Vivado Synthesis and Implementation

The repository includes Vivado project data and a TCL rerun script.

A typical batch run is:

```bash
vivado -mode batch -source rerun_vivado.tcl
```

The main synthesis top is:

```text
VHDL/nn_rgb.vhd
```

The project has been evaluated on:

- Zynq UltraScale+ MPSoC ZCU106
- Spartan-7
- Artix-7

The design is mostly vendor-neutral VHDL, but the sigmoid ROM wrapper may require device/tool-specific adaptation.

---

## Video Datapath Interface

The top-level design operates on an RGB video stream.

Typical input/output signals include:

```text
clk
rst
vs_in, hs_in, de_in
r_in[7:0], g_in[7:0], b_in[7:0]
vs_out, hs_out, de_out
r_out[7:0], g_out[7:0], b_out[7:0]
```

The controller delays the synchronization and valid/data-enable signals so that the output pixel remains aligned with the corresponding classified input pixel after the neural-network pipeline latency.

---

## Dataset Description

The dataset is organized as RGB wildfire and non-fire images with segmentation masks where available. The segmentation masks are used to derive pixel-level labels.

Summary:

- Fire images: **27,460**
- Non-fire images: **11,392**
- Split: **80% training / 20% validation**
- Features: raw RGB values
- Labels: fire / not fire

Balanced sampling is used to reduce class imbalance between fire and non-fire pixels.

---

## Limitations

This project intentionally uses a compact RGB-only per-pixel classifier. Therefore:

- It does not use spatial context such as neighboring pixels.
- It does not use temporal context such as flame motion over video frames.
- It may confuse fire-like colors, bright objects, reflections, or strong illumination with real fire pixels.
- It is best interpreted as an early-warning hardware baseline, not as a complete wildfire detection product.

---

## Future Work

Possible extensions include:

- adding temporal features for video-based fire dynamics;
- adding spatial features or lightweight convolutional layers;
- evaluating multispectral or hyperspectral inputs;
- improving threshold selection for application-specific false-positive/false-negative trade-offs;
- exploring partial on-device adaptation or training support;
- comparing the design against classical color-threshold baselines and larger CNN-based models.

---

## Related Paper

This repository supports the work:

**FPGA-accelerated neural network for wildfire pixel classification**  
C. Dionysiou, P. Antoniou, H. E. Michail, S. A. Chatzichristofis  
Twelfth International Conference on Remote Sensing and Geoinformation of the Environment, RSCy 2026, Paphos, Cyprus.

Suggested citation format, to be updated after official publication:

```bibtex
@inproceedings{dionysiou2026fpga_wildfire,
  title     = {FPGA-accelerated neural network for wildfire pixel classification},
  author    = {Dionysiou, C. and Antoniou, P. and Michail, H. E. and Chatzichristofis, S. A.},
  booktitle = {Twelfth International Conference on Remote Sensing and Geoinformation of the Environment},
  year      = {2026},
  address   = {Paphos, Cyprus},
  note      = {To be updated after official publication}
}
```

---

## Acknowledgements

This work was carried out at the Department of Electrical Engineering, Cyprus University of Technology. The author acknowledges the guidance and support received during the development of the thesis and conference paper, as well as the use of open-source tools and datasets that enabled this research.

This project was inspired by the open-source [NN_RGB_FPGA](https://github.com/Marco-Winzker/NN_RGB_FPGA) project by Marco Winzker, which provided useful direction for FPGA-based neural-network implementation in VHDL.

I would also like to thank the [Student New Technologies Group](https://www.instagram.com/omilos_newn_texnologiwn_cut?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==) at Cyprus University of Technology for making this research journey more enjoyable, collaborative, and motivating.

---

## Author

**Constantinos Dionysiou**  
Department of Electrical Engineering  
Cyprus University of Technology  
Email: `cs.dionysiou@edu.cut.ac.cy`

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

# 🔢 BCD Code Converter — Digital Circuit Implementation

**BCD-to-Gray Code and BCD-to-Excess-3 Converter**

A complete digital logic design project implementing two code conversion systems — **BCD to Gray Code** and **BCD to Excess-3** — through both real-time hardware implementation using standard logic gate ICs and VHDL-based digital design using Quartus with library-building techniques.

---


## 🔀 Two Implementations

This project covers the same combinational logic design realized in two distinct ways:

| Feature | Hardware (IC-Based) | VHDL (Quartus) |
|---------|---------------------|----------------|
| Platform | Breadboard + TTL ICs | Quartus Prime |
| Language | Physical Logic Gates | VHDL |
| Technique | IC wiring | Library building (package + components) |
| Verification | LED output observation | Waveform simulation |
| Scope | DLD Lab Project | Computer Architecture Lab Task |

---

## 🧠 What is Being Converted?

```
4-bit BCD Input (A3 A2 A1 A0)
           │
    ┌──────┴──────┐
    ▼             ▼
[BCD → Gray]  [BCD → Excess-3]
 Y3 Y2 Y1 Y0   Y3 Y2 Y1 Y0
```

### BCD to Gray Code
Gray Code is a binary system where only **one bit changes** between consecutive values — essential for encoders, ADCs, and error-reduction in digital systems.

```
Y3 = A3
Y2 = A3 ⊕ A2
Y1 = A2 ⊕ A1
Y0 = A1 ⊕ A0
```

### BCD to Excess-3
Excess-3 is formed by **adding binary 3 (0011)** to each BCD digit — used in decimal arithmetic and error detection.

```
Excess-3 = BCD + 0011
```

---

## 📐 Truth Tables

### BCD to Gray Code

| Decimal | A3 | A2 | A1 | A0 | Y3 | Y2 | Y1 | Y0 |
|---------|----|----|----|----|----|----|----|-----|
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 |
| 1 | 0 | 0 | 0 | 1 | 0 | 0 | 0 | 1 |
| 2 | 0 | 0 | 1 | 0 | 0 | 0 | 1 | 1 |
| 3 | 0 | 0 | 1 | 1 | 0 | 0 | 1 | 0 |
| 4 | 0 | 1 | 0 | 0 | 0 | 1 | 1 | 0 |
| 5 | 0 | 1 | 0 | 1 | 0 | 1 | 1 | 1 |
| 6 | 0 | 1 | 1 | 0 | 0 | 1 | 0 | 1 |
| 7 | 0 | 1 | 1 | 1 | 0 | 1 | 0 | 0 |
| 8 | 1 | 0 | 0 | 0 | 1 | 1 | 0 | 0 |
| 9 | 1 | 0 | 0 | 1 | 1 | 1 | 0 | 1 |
| 10–15 | — | — | — | — | X | X | X | X |

### BCD to Excess-3

| Decimal | A3 | A2 | A1 | A0 | Y3 | Y2 | Y1 | Y0 |
|---------|----|----|----|----|----|----|----|-----|
| 0 | 0 | 0 | 0 | 0 | 0 | 0 | 1 | 1 |
| 1 | 0 | 0 | 0 | 1 | 0 | 1 | 0 | 0 |
| 2 | 0 | 0 | 1 | 0 | 0 | 1 | 0 | 1 |
| 3 | 0 | 0 | 1 | 1 | 0 | 1 | 1 | 0 |
| 4 | 0 | 1 | 0 | 0 | 0 | 1 | 1 | 1 |
| 5 | 0 | 1 | 0 | 1 | 1 | 0 | 0 | 0 |
| 6 | 0 | 1 | 1 | 0 | 1 | 0 | 0 | 1 |
| 7 | 0 | 1 | 1 | 1 | 1 | 0 | 1 | 0 |
| 8 | 1 | 0 | 0 | 0 | 1 | 0 | 1 | 1 |
| 9 | 1 | 0 | 0 | 1 | 1 | 1 | 0 | 0 |
| 10–15 | — | — | — | — | X | X | X | X |

> X = Don't-care conditions (invalid BCD inputs used for K-Map optimization)

---

## 📁 Repository Structure

```
code-conversion-system
│
├── hardware/                          ← IC-based breadboard implementation
│   ├── photos/
│   │   └── breadboard_implementation.jpeg
│   ├── circuit-diagrams/
│   │   ├── block_diagram.jpeg
│   │   └── final_circuit_diagram.jpeg
│   └── truth-tables/
│       ├── truth_table_gray_code.jpeg
│       └── truth_table_excess3.jpeg
│
├── vhdl/                              ← Quartus VHDL implementation
│   ├── src/
│   │   ├── inverter.vhd
│   │   ├── and_2.vhd
│   │   ├── and_3.vhd
│   │   ├── or_2.vhd
│   │   ├── or_3.vhd
│   │   ├── my_pkg.vhd
│   │   ├── bcdtoex3.vhd
│   │   └── bcdtogray.vhd
│   └── simulation/
│       └── *(Add Quartus waveform screenshots here)*
│
├── docs/
│   └── project_report.pdf            ← Full DLD lab project report
│
├── README.md
├── TROUBLESHOOTING.md
└── LICENSE
```

---

## 🧰 Components Used (Hardware)

| IC / Component | Function |
|----------------|----------|
| IC 7408 (AND Gate) | 2-input AND operations |
| IC 7432 (OR Gate) | 2-input OR operations |
| IC 7404 (NOT Gate) | Logic inversion / complement |
| IC 7486 (XOR Gate) | XOR for Gray Code; Excess-3 |
| XNOR (XOR + NOT) | XNOR implemented from available ICs |
| Red LEDs | Output visualization (Gray + Excess-3) |
| Resistors (220Ω) | LED current limiting |
| Breadboard | Circuit assembly (no soldering) |
| Jumper Wires | Signal routing |

---

## 🚀 Getting Started

### Hardware Implementation
1. Refer to the circuit diagram in `hardware/circuit-diagrams/`
2. Wire ICs on breadboard as shown
3. Apply 4-bit BCD input via switches or logic levels
4. Observe Gray Code (4 LEDs) and Excess-3 (4 LEDs) outputs

### VHDL / Quartus Implementation
1. Open Quartus Prime
2. Create a new project
3. Add all `.vhd` files from `vhdl/src/` in this order:
   - First: component files (`inverter.vhd`, `and_2.vhd`, `and_3.vhd`, `or_2.vhd`, `or_3.vhd`)
   - Then: package file (`my_pkg.vhd`)
   - Finally: top-level entity (`bcdtoex3.vhd` or `bcdtogray.vhd`)
4. Compile and run functional simulation
5. Apply input vectors in waveform editor to verify truth table

---

## 📄 License

Licensed under **Creative Commons Attribution 4.0 International (CC BY 4.0)**.

See the [LICENSE](LICENSE) file for details.

---

## 👤 Authors

Muhammad Mamoon
Robotics Engineering Student

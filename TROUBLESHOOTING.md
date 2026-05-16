# 🔧 Troubleshooting Guide
## BCD Code Converter — Hardware & VHDL Implementations

---

## 📋 Table of Contents

1. [Hardware (IC-Based) Issues](#1-hardware-ic-based-issues)
2. [LED Output Issues](#2-led-output-issues)
3. [VHDL Compilation Issues](#3-vhdl-compilation-issues)
4. [VHDL Simulation Issues](#4-vhdl-simulation-issues)
5. [Logic/Output Correctness Issues](#5-logicoutput-correctness-issues)
6. [Quartus Project Issues](#6-quartus-project-issues)
7. [General Tips](#7-general-tips)

---

## 1. Hardware (IC-Based) Issues

### ❌ Circuit produces incorrect output for all inputs
**Cause:** IC power pins not connected.
**Fix:**
- Every IC must have VCC (pin 14 for 14-pin DIP) → 5V and GND (pin 7) → GND
- This is the most common mistake — always verify power to each IC first

---

### ❌ XOR (IC 7486) output always LOW
**Cause:** Input pins floating or IC not powered.
**Fix:**
- Confirm both inputs are driven to defined logic levels (not floating)
- Floating inputs on TTL ICs behave unpredictably — tie unused inputs to GND or VCC

---

### ❌ XNOR not working correctly
**Cause:** XNOR was implemented using XOR (7486) + NOT (7404) — a wire may be missing.
**Fix:**
- Trace: XOR output → NOT gate input → NOT gate output = XNOR result
- Verify the NOT gate output (not XOR output) connects to the next stage

---

### ❌ IC gets very hot
**Cause:** Short circuit or reverse VCC/GND connection.
**Fix:**
- Power off immediately
- Recheck IC orientation — pin 1 is marked by a notch/dot on the IC package
- Verify VCC and GND are not swapped

---

### ❌ Partial outputs correct, some wrong
**Cause:** One IC has a faulty gate or a loose wire on a specific pin.
**Fix:**
- Test each gate individually by applying known inputs and checking output with a multimeter
- Replace suspected ICs one at a time

---

## 2. LED Output Issues

### ❌ All LEDs OFF regardless of input
**Cause:** Common GND missing or LEDs in wrong orientation.
**Fix:**
- Check LED polarity: longer leg (anode) → signal, shorter leg (cathode) → GND
- Verify a 220Ω current-limiting resistor is in series with each LED
- Confirm the output pins of the final gates are actually HIGH when expected

---

### ❌ LEDs always ON
**Cause:** Output pins are stuck HIGH — IC output shorted to VCC.
**Fix:**
- Check for solder bridges or short jumper wires creating unintended connections
- Test the driving gate output with a multimeter

---

### ❌ Gray Code LEDs correct but Excess-3 LEDs wrong (or vice versa)
**Cause:** Wiring error in one of the two converter circuits.
**Fix:**
- Verify each circuit independently by checking outputs against the truth table one row at a time
- Start with decimal 0 input (0000) and confirm expected output

---

## 3. VHDL Compilation Issues

### ❌ "Library 'work' not found" error
**Fix:**
- Compile all component files BEFORE the package and top-level entity
- Correct compilation order:
  1. `inverter.vhd`
  2. `and_2.vhd`, `and_3.vhd`
  3. `or_2.vhd`, `or_3.vhd`
  4. `my_pkg.vhd`
  5. `bcdtoex3.vhd` or `bcdtogray.vhd`

---

### ❌ "Component not found in package" error
**Fix:**
- Ensure `use work.my_pkg.all;` is at the top of `bcdtoex3.vhd`
- Confirm each component name in `my_pkg.vhd` matches exactly the entity names in individual files

---

### ❌ "Port map mismatch" error
**Fix:**
- The `and_2` component takes `A : in std_logic_vector(1 downto 0)` — use `A(0)` and `A(1)` in PORT MAP
- Example correct syntax:
  ```vhdl
  U5: and_2 PORT MAP(A(0) => signal1, A(1) => signal2, B => output_signal);
  ```

---

### ❌ "Signal has multiple drivers" error
**Fix:**
- Each signal can only be driven by ONE source in a concurrent VHDL architecture
- Use unique intermediate signals (`s(0)`, `s(1)`, ...) for each gate output
- Never assign to the same signal from two different statements

---

### ❌ Syntax error on PORT MAP lines
**Fix:**
- VHDL is case-insensitive but spacing matters — ensure no missing semicolons
- Every component instantiation ends with `;`
- The last port mapping inside PORT MAP does NOT have a comma after it:
  ```vhdl
  U1: inverter PORT MAP(
      in1  => B(0),
      out1 => o(0)   -- No comma on last line
  );
  ```

---

## 4. VHDL Simulation Issues

### ❌ Simulation output always 'U' (uninitialized)
**Cause:** Input signals not driven in testbench.
**Fix:**
- In the Quartus waveform editor, make sure input `B` is assigned values before simulation
- Set initial value of all inputs at time 0

---

### ❌ Output doesn't match truth table
**Fix:**
- Check the Boolean equations used in the architecture match the minimized K-Map expressions
- Compare output waveform against the truth table row by row
- For Excess-3: verify that input `0000` gives output `0011`

---

### ❌ Simulation runs but waveform is empty
**Fix:**
- In Quartus: **Simulation → Run Functional Simulation**
- Ensure the simulation time is long enough (at least 160 ns for 10 input combinations at 16 ns each)

---

## 5. Logic/Output Correctness Issues

### ❌ BCD to Gray Code: Y0 is always wrong
**Cause:** XOR between A1 and A0 not implemented correctly.
**Fix:**
- Verify: `Y(0) <= A(1) xor A(0);` in VHDL
- On hardware: XOR gate pin 1 = A1, pin 2 = A0, pin 3 = Y0

---

### ❌ BCD to Excess-3: Output for decimal 5 is wrong
**Cause:** Threshold between lower and upper nibble logic is incorrect.
**Fix:**
- Decimal 5 (BCD: 0101) should give Excess-3: 1000
- Verify Y3 logic: `X(3) = (A0·A2) + (A1·A2) + A3`
- For input 0101: A1=0, A0=1, A2=1, A3=0 → (1·1)+(0·1)+0 = 1 ✓

---

### ❌ Don't-care inputs (10–15) produce unexpected outputs
**Note:** This is expected — don't-care outputs are undefined by design and may produce any value. The circuit is only guaranteed correct for BCD inputs 0–9.

---

## 6. Quartus Project Issues

### ❌ "Top-level entity not found"
**Fix:**
- Go to **Project → Set as Top-Level Entity** and select `bcdtoex3` or `bcdtogray`
- The entity name in the `.vhd` file must match the filename

---

### ❌ Files not being compiled in project
**Fix:**
- Go to **Project → Add/Remove Files** and ensure all `.vhd` files are listed
- Right-click each file → **Properties** → confirm it's set to VHDL type

---

### ❌ Quartus can't find `my_pkg`
**Fix:**
- The package must be compiled into the `work` library first
- Compile `my_pkg.vhd` before the top-level entity — Quartus compile order matters

---

## 7. General Tips

| Tip | Details |
|-----|---------|
| ⚡ Power ICs first | Always connect VCC/GND to every IC before connecting logic signals |
| 📋 Verify truth table row by row | Test decimal 0 first, then 1, 2 ... up to 9 systematically |
| 🔬 Use a multimeter | Measure gate outputs directly to isolate wiring vs. logic errors |
| 💾 Compile in order | VHDL components → package → top-level entity (always this sequence) |
| 🧪 Simulate before hardware | Confirm VHDL logic correct in simulation before wiring the breadboard |
| 🏷️ Label wires | Color-code or label jumper wires for A3/A2/A1/A0 inputs to avoid mix-ups |
| ❌ Don't leave inputs floating | Always tie unused IC inputs to VCC or GND on TTL logic families |

---

## 📬 Still Having Issues?

- [IC 7408 AND Gate Datasheet](https://www.ti.com/lit/ds/symlink/sn7408.pdf)
- [IC 7486 XOR Gate Datasheet](https://www.ti.com/lit/ds/symlink/sn7486.pdf)
- [Quartus VHDL Documentation](https://www.intel.com/content/www/us/en/docs/programmable/683091/current/vhdl-support.html)
- [VHDL Quick Reference](https://www.ics.uci.edu/~jmoorkan/vhdlref/)

---

*Troubleshooting Guide — BCD Code Converter Project*
*Authors: Muhammad Mamoon, Ali Ahmar Awan, Asad Ali*
*Course: DLD Lab & Computer Architecture — UCP Spring 2025*

# FPGA Dial  Rotator – Advent of Code Style

This project is my first implementation of a simple FPGA-style solution to a Advent of code problem 

I choosed the problem 1 that involves a rotating dial.

The design is written in syntheziable Verilog and simulated using Icarus Verilog on EDA Playground to test 


---
## 🧩 Problem Description

Focusing on the problem it has these 
- A dial has positions from **0 to 99**
- Initial position is **50**
- Each command specifies:
  - Direction: Left (L) or Right (R)
  - Distance: number of steps
- The dial moves **one step per clock**
- Each time the dial reaches position **0**, a counter is incremented

  and This corresponds to **Part 2** logic of the original Javascript solution,
  where zero corssings are counted step-by-step

  ---
## 🧱 Design Overview

### Module: `dial_rotator`

**Inputs**
- `clk` – system clock
- `reset` – asynchronous reset
- `start` – begin a rotation
- `direction` – `0 = Left`, `1 = Right`
- `distance` – number of steps (0–99)

**Outputs**
- `dial_pos` – current dial position (0–99)
- `zero_count` – number of times dial crossed zero
- `busy` – high while rotation is in progress


---

## ⏱️ Hardware Behavior

- One clock cycle = one dial movement
- Wraparound:
  - Left: `0 → 99`
  - Right: `99 → 0`
- Zero is counted **only when reached**
- `busy` goes low when rotation completes

---

## 🧪 Testbench

The testbench:
- Generates a 100 MHz clock
- Applies multiple rotations sequentially
- Waits for `busy` to deassert before issuing the next command
- Prints dial position and zero count at every step

Example commands:
- Right 10
- Left 60
- Right 100

---


This is my frist implementation on FPGA related work 
I used the help of AI on this into getting to know the concepts and how to desgin 
and recafecotred my code accoridingly I faced some horrible error though out but Im glad I did make a working solution finally :)) !

Had some work so it took sometime to write a README on this 

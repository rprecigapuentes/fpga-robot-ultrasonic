# fpga-robot-ultrasonic

This repository contains a Verilog-based control system for a mobile robot implemented on a Zybo Z7 FPGA.
The design integrates ultrasonic distance sensing and PWM motor control, coordinated by a finite state machine.

## Repository structure

- `rtl/`  
  Verilog source files (RTL design).

- `constraints/`  
  XDC constraints file for Zybo Z7 pin assignments.

- `docs/`  
  Optional documentation assets (block diagrams, images).

## Module hierarchy

Top-level module:
- `top.v` (`top`)
  - `maquinaestado.v` (`maquinaestado`)  
    Finite state machine that decides robot motion based on inputs.
  - `ultra.v` (`ultra`)  
    Ultrasonic sensor interface (trigger/echo timing and distance evaluation).
  - `pwm.v` (`pwm`)  
    PWM signal generation for motor control.

Ultrasonic subsystem:
- `ultra.v` (`ultra`)
  - `contador.v` (`contador`)  
    Cycle counter used for time measurement.
  - `temporizador.v` (`temporizador`)  
    Timing control for ultrasonic measurement windows.

## Functional overview

1. The ultrasonic module generates a trigger pulse and measures the echo return time to detect obstacles.
2. The finite state machine processes the distance information and control inputs to select the robot behavior.
3. The PWM module drives the motors according to the selected state.
4. The XDC file maps logical signals to physical pins on the Zybo Z7 board.

## Requirements

- Vivado Design Suite
- Zybo Z7 FPGA board
- Ultrasonic distance sensor (e.g., HC-SR04 or equivalent)

## Usage (Vivado)

1. Create a new RTL project in Vivado.
2. Add all Verilog files from the `rtl/` directory.
3. Add the XDC file from `constraints/`.
4. Set `top` as the top-level module.
5. Run synthesis, implementation, and generate the bitstream.

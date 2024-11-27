# ICS3203-CAT2-Assembly-Dante-148848# ICS3203 CAT 2 - Assembly Programming

## Overview
This repository contains solutions to the CAT 2 Assembly Programming tasks for ICS3203. Each task focuses on a key aspect of Assembly programming, including control flow, array manipulation, modularity with subroutines, and hardware simulation. The programs are written in x86 Assembly and demonstrate fundamental concepts like branching logic, stack management, and memory manipulation.

---

## Tasks and Features

### **Task 1: Control Flow and Conditional Logic**
- **Purpose:** Classify a user-input number as POSITIVE, NEGATIVE, or ZERO.
- **Features:**
  - Uses both conditional and unconditional jumps (`JE`, `JL`, `JG`, `JMP`).
  - Converts ASCII input to an integer for processing.
  - Outputs classification via system calls.

### **Task 2: Array Manipulation with Looping and Reversal**
- **Purpose:** Reverse an array of integers in place without using additional memory.
- **Features:**
  - Utilizes indexed registers (`ESI` and `EDI`) to access and swap array elements.
  - Implements a loop for efficient in-place reversal.
  - Outputs the reversed array using system calls.

### **Task 3: Modular Program with Subroutines for Factorial Calculation**
- **Purpose:** Calculate the factorial of a user-input number using a subroutine.
- **Features:**
  - Modular design with a `CALL` to a factorial subroutine.
  - Uses stack operations (`PUSH` and `POP`) to preserve registers.
  - Handles validation to ensure positive integer input.

### **Task 4: Data Monitoring and Control Using Port-Based Simulation**
- **Purpose:** Simulate a control program that responds to a water-level sensor.
- **Features:**
  - Reads a sensor value and performs actions such as:
    - Turning on a motor if the water level is low.
    - Triggering an alarm if the water level is too high.
    - Turning off the motor if the water level is moderate.
  - Simulates hardware control through memory manipulation.

---

## Compilation and Execution
All programs were written in x86 Assembly and can be compiled and executed using the following commands:

1. Save the program as `<filename>.asm`.
2. Open a terminal in the program's directory.
3. Compile the program:
   ```bash
   nasm -f elf <filename>.asm

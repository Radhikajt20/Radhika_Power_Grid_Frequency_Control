# Radhika_Power_Grid_Frequency_Control
MATLAB Simulink based Power Grid Frequency Control system using PID control to maintain grid stability during sudden load disturbances. The model reduces frequency deviations, improves settling response, and provides real-time monitoring through Simulink Dashboard components with future scope for fuzzy PID and AI-based control.
# Power Grid Frequency Control using PID Controller

## Project Overview

This project is developed using MATLAB Simulink to control and stabilize power grid frequency during sudden load disturbances using a PID controller. In electrical power systems, frequency deviations occur whenever there is an imbalance between power generation and load demand. If these deviations are not corrected quickly, they can affect the stability and reliability of the entire power grid. The main objective of this project is to maintain stable frequency by using a closed-loop PID control system.

## Features

* Closed loop feedback control
* Frequency stabilization during disturbances
* Disturbance rejection analysis
* Real-time dashboard monitoring
* Interactive visualization using:

  * Gauge
  * Scope
  * Slider
  * Numeric Display
  * Lamp Indicator

## Software Used

* MATLAB
* Simulink
* Simulink Dashboard

## Working Principle

1. A step input is applied as the system reference.
2. A disturbance signal is introduced to simulate sudden load changes.
3. The PID controller continuously calculates corrective control action based on system error.
4. The transfer function represents the dynamic behavior of the power system.
5. The feedback loop minimizes frequency deviation and stabilizes the system output.
6. Dashboard components display real-time system response and controller performance during simulation.

## Files Included

* Simulink model (.slx)
* MATLAB files (.m)
* Output screenshots
* Dashboard images
* Demo video
* Project documentation

## Output

The implemented PID controller successfully stabilizes frequency deviation after disturbances and improves system response with reduced oscillations and better settling performance. The dashboard interface provides real-time visualization of system behavior and controller operation.

## Future Improvements

* Adaptive fuzzy PID integration
* AI-based controller tuning
* Renewable energy disturbance analysis
* Real-time hardware implementation
* Smart grid monitoring enhancements

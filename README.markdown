# A Breathing Lamp Driver In Verilog
## Abstract
This is a Breathing Lamp Driver verilog module.

This module is designed to achieve hardware-independence. The `hardware-independence` means you can use this code in any FPGA, and it is paremeterized to adapt different clock inputs.

You can simpliy connect the output to a FPGA port that drives a LED.

## Solution

A breathing lamp sheds dimming light, when it can't get any darker, it turns getting brighter and brighter. And then it loops over and over.

We can see that a sine wave has a perfect curve that indicates the brightness curve. So we use a PWM to carry a sine wave to drive an LED to get a breathing lamp.

![pic](/doc/spwm_on_brl.png)

The simulation picture above shows how it works. The `wave` signal is the actual PWM output, and the `duty_cycle` signal represented in a sine plot shows the instant duty-cycle of PWM.

For the hardware implementation, we should set the period of the sine-duty-cycle wave to a few seconds, that's really slow. And the modules should be parameterized.

# DualSense Gamepad Assist

[中文说明](README_CN.md)

DualSense Gamepad Assist is an Assetto Corsa CSP `Gamepad FX` script for DualSense controllers. It combines controller steering assist, automatic clutch, optional automatic shifting, CSP native haptics, and adaptive triggers in one in-game control panel.

## Features

### DualSense Haptics

- CSP native DualSense semantic layers cover engine texture, road and bodywork impacts, curb detail, tire skid, gear shifts, rev limiter behavior, and collisions.
- A compatibility grip layer adds `vibrationLeft / vibrationRight` output alongside CSP native haptics for extra engine texture, road detail, and shift impact.
- Overall grip-vibration strength can be adjusted globally without changing L2 or R2 adaptive-trigger resistance.
- Diagnostic isolation tests can temporarily emphasize the Engine, Wheel, Bodywork, or Skid layer to help identify missing feedback.
- Live telemetry exposes curb activity, tire-slip values, Bodywork gain and pitch, and Skid gain and pitch.

### Adaptive Triggers

- L2 provides progressive braking resistance with an adjustable resistance curve.
- ABS intervention is represented by configurable L2 pulse depth and pulse speed.
- R2 provides progressive throttle resistance, wheelspin cues, rev-limiter pulses, upshift rebound, and a subtle downshift throttle-blip cue.
- Advanced trigger settings remain available for sensitivity, strength, timing, and pulse frequency tuning.

### Driving Assists And UI

- Controller steering assist includes simplified and detailed modes, calibration, steering presets, graphs, gamma, deadzone, self-steer response, damping, and countersteer controls.
- Automatic clutch helps with launches and stall prevention. Optional custom shifting modes add rev-matching and automatic shifting behavior where supported.
- The overview page provides core switches, three feedback presets, custom preset save and load actions, and common driving-assist controls.
- The advanced-settings window is independent, movable, resizable, and divided into Steering, Feedback, and Diagnostics tabs.
- No gyroscope or accelerometer data is read, and gyroscope steering is not modified.

## Downloads

- [English package](https://github.com/Adudumax/DualSense-Gamepad-Assist/releases/download/v0.6.2/DualSense-Gamepad-Assist-0.6.2-EN.zip)
- [Chinese package](https://github.com/Adudumax/DualSense-Gamepad-Assist/releases/download/v0.6.2/DualSense-Gamepad-Assist-0.6.2-CN.zip)
- [GitHub Releases](https://github.com/Adudumax/DualSense-Gamepad-Assist/releases)

## Installation

1. Install Content Manager and CSP `0.2.0` or newer.
2. Download the preferred package and open its `DualSense Gamepad Assist` folder.
3. Copy the `apps` and `extension` folders into the Assetto Corsa root folder, `assettocorsa`.
4. In Content Manager, open `Settings -> Custom Shaders Patch -> Gamepad FX`.
5. Enable Gamepad FX and select `DualSense Gamepad Assist`.
6. Enter a session and open the app from the in-game sidebar.

A USB connection is recommended. If dedicated feedback is missing, disable Steam Input for Assetto Corsa and enter the session again.

## Source

- [English source snapshot](source/EN/)
- [Chinese source snapshot](source/CN/)

The steering-assist implementation references AC Advanced Gamepad Assist. See [Third-Party Notices](THIRD_PARTY_NOTICES.md) for attribution and license details.

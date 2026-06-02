# DualSense Gamepad Assist

[中文说明](README_CN.md)

DualSense Gamepad Assist is an Assetto Corsa CSP `Gamepad FX` script for DualSense controllers. It combines controller steering assist, automatic clutch, optional automatic shifting, CSP native haptics, and adaptive triggers in one in-game control panel.

Version `0.6.2` keeps the verified `0.6.1` vibration behavior unchanged. This release reorganizes internal naming under DGA, adds separate English and Chinese packages, and prepares a clean public source snapshot.

## Features

- CSP native DualSense haptics for engine texture, curbs, bodywork, tire skid, gear shifts, and collisions.
- A `0.5.1` compatibility grip layer using `vibrationLeft / vibrationRight` alongside native haptics.
- Adaptive triggers with L2 braking resistance and ABS cues, plus R2 throttle resistance, wheelspin, limiter pulses, and shift rebound.
- A compact overview with feedback presets, custom preset save and load actions, and overall grip-vibration strength.
- An independent advanced-settings window that can be moved and resized freely.
- Controller steering assist, automatic clutch, optional automatic shifting, calibration, graphs, gamma, and deadzone controls.
- No gyroscope data is read, and gyroscope steering is not modified.

## Downloads

- [English package](releases/DualSense-Gamepad-Assist-0.6.2-EN.zip)
- [Chinese package](releases/DualSense-Gamepad-Assist-0.6.2-CN.zip)

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

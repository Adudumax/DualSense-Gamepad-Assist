# DualSense Gamepad Assist

[????](README_CN.md)

DualSense Gamepad Assist is an Assetto Corsa CSP `Gamepad FX` script for DualSense controllers. It combines controller steering assist, Gyrosteer-style precision gyro steering, automatic clutch, optional automatic shifting, CSP native haptics, compatibility vibration, and adaptive triggers in one in-game control panel.

## What's New In v1.0.0

- Adds Gyrosteer-style DualSense gyro steering with the original sensitivity curve and a direct steering feel.
- Refines DualSense haptics and adaptive triggers for stronger, clearer grip, curb, skid, redline, ABS, wheelspin, and shift feedback.
- Reworks the control panel around clear presets, a custom preset slot, and a separate advanced settings window.
- Keeps gyro steering independent from traditional gamepad steering assist so the two modes do not fight each other.
- Polishes the header and user-facing wording for a cleaner, more modern interface.

## Downloads

- [English package](https://github.com/Adudumax/DualSense-Gamepad-Assist/releases/download/v1.0.0/DualSense-Gamepad-Assist-v1.0.0-Windows-x64-EN.zip)
- [Chinese package](https://github.com/Adudumax/DualSense-Gamepad-Assist/releases/download/v1.0.0/DualSense-Gamepad-Assist-v1.0.0-Windows-x64-CN.zip)
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

The steering-assist implementation references AC Advanced Gamepad Assist. Gyro steering references the user-provided Gyrosteer script. See [Third-Party Notices](THIRD_PARTY_NOTICES.md) for attribution and license details.

# DualSense Gamepad Assist v1.0.0

Author: Adudumax

This package is based on the v1.0.0 stable build. It keeps the validated DualSense haptics and adaptive-trigger feedback while adding Gyrosteer-style precision gyro steering and a cleaner control panel.

## What's New

- Adds Gyrosteer-style DualSense gyro steering with the original sensitivity curve and direct steering response.
- Refines grip vibration, CSP native haptics, adaptive-trigger resistance, ABS pulses, wheelspin pulses, redline pulses, and shift rebound.
- Adds clearer feel presets, a custom preset slot, and a separate advanced settings window.
- Pauses traditional steering assist while gyro steering is active, while keeping vibration, triggers, and auto clutch available.
- Removes internal module wording from the UI and polishes the header layout.

## Recommended Use

1. Connect the DualSense controller over USB.
2. In Content Manager, open `Settings -> Custom Shaders Patch -> Gamepad FX` and select `DualSense Gamepad Assist`.
3. Enter a session and open `DualSense Gamepad Assist` from the in-game sidebar.
4. Enable `Precision gyro steering` if you want gyro control.
5. Drive directly; players familiar with Gyrosteer can fine-tune sensitivity in advanced settings.

## Mechanism Notes

The gyro steering core keeps the Gyrosteer-style response: sensor fusion feeds `math.tan(gamepadAngle * 4) / 4`, applies edge smoothing through `baseSteer`, adds a light `ffb * -0.06` correction, and maps to AC steering input with `500 / car.steerLock`.

## Limitations

Gyro steering depends on CSP exposing DualSense sensor data. If the current CSP environment does not provide DualSense gyro data, the UI will show it as unavailable and the script falls back to stick input without affecting vibration or adaptive-trigger feedback.

## Third-Party Notices

This project is released under a distinct name. See `THIRD_PARTY_NOTICES.md` and the `licenses` folder for third-party references and license texts.

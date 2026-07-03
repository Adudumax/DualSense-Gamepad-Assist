# DualSense Gamepad Assist v1.0.0

Author: Adudumax

DualSense Gamepad Assist is an Assetto Corsa / CSP Gamepad FX script for PlayStation 5 DualSense controllers. It combines controller steering assist, Gyrosteer-style precision gyro steering, automatic clutch support, CSP native haptics, compatibility vibration, and adaptive trigger feedback in one in-game control panel.

## Highlights

- DualSense haptics for grip, curbs, road texture, tire slip, collision impact, and shift impact.
- Adaptive triggers for brake resistance, throttle resistance, ABS pulses, wheelspin pulses, redline pulses, and shift rebound.
- Precision gyro steering with a Gyrosteer-style response.
- Controller steering assist for regular stick driving.
- Balanced, comfort, strong, and custom feel presets.

## Recommended Use

1. Connect the DualSense controller over USB.
2. In Content Manager, open `Settings -> Custom Shaders Patch -> Gamepad FX` and select `DualSense Gamepad Assist`.
3. Enter a session and open `DualSense Gamepad Assist` from the in-game sidebar.
4. Use the balanced preset first. Open advanced settings only if you want to fine-tune the behavior.

## Notes

Gyro steering depends on CSP exposing DualSense sensor data. If the current CSP environment does not provide DualSense gyro data, the UI will show it as unavailable and the script falls back to regular stick input without affecting vibration or adaptive-trigger feedback.

## Credits

Special thanks to the author of AC Advanced Gamepad Assist, Dmitrii Alekseev for Gyrosteer, and x4fab plus the Custom Shaders Patch contributors for CSP, Gamepad FX, and the controller feedback APIs.

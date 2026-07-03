# DualSense Gamepad Assist v1.0.0

作者：Adudumax

DualSense Gamepad Assist 是一个面向 Assetto Corsa / CSP 的 Gamepad FX 脚本，主要为 PlayStation 5 DualSense 手柄设计。它把手柄转向辅助、Gyrosteer 风格陀螺仪精准转向、自动离合、CSP 原生触觉、兼容震动和自适应扳机反馈整合到一个游戏内控制面板中。

## 功能亮点

- DualSense 触觉反馈：覆盖抓地、路肩、路面纹理、轮胎滑移、碰撞冲击和换挡冲击。
- 自适应扳机：支持刹车阻力、油门阻力、ABS 脉冲、打滑脉冲、红线脉冲和换挡回弹。
- Gyrosteer 风格陀螺仪精准转向。
- 面向普通摇杆驾驶的手柄转向辅助。
- 平衡、舒适、强劲和自定义手感预设。

## 推荐用法

1. 使用 USB 连接 DualSense 手柄。
2. 在 Content Manager 中打开 `设置 -> Custom Shaders Patch -> Gamepad FX`，并选择 `DualSense Gamepad Assist`。
3. 进入赛道后，从游戏内右侧应用栏打开 `DualSense Gamepad Assist`。
4. 先使用默认平衡预设。只有需要微调时，再打开高级设置。

## 说明

陀螺仪转向依赖 CSP 对 DualSense 传感器数据的读取。如果当前 CSP 环境没有提供 DualSense 陀螺仪数据，界面会显示不可用，脚本会回到普通摇杆输入，不会影响震动或自适应扳机反馈。

## 致谢

特别感谢 AC Advanced Gamepad Assist 的作者、Gyrosteer 作者 Dmitrii Alekseev，以及 x4fab 和 Custom Shaders Patch 贡献者提供的 CSP、Gamepad FX 与手柄反馈接口。

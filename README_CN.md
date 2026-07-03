![DualSense Gamepad Assist](assets/banner.png)

# DualSense Gamepad Assist

[English](README.md)

DualSense Gamepad Assist 是一个面向 Assetto Corsa / CSP 的手柄增强插件，主要为 PlayStation 5 DualSense 手柄设计。它把手柄转向辅助、Gyrosteer 风格陀螺仪精准转向、自动离合、CSP 原生触觉、兼容震动和自适应扳机反馈整合到一个游戏内控制面板中。

它的目标很简单：让 DualSense 在 Assetto Corsa 里拥有更强、更清晰、更自然的反馈，同时不要求普通玩家一上来就调整大量参数。

## 功能亮点

- **DualSense 触觉反馈**：覆盖抓地、路肩、路面纹理、轮胎滑移、碰撞冲击和换挡冲击。
- **自适应扳机**：支持刹车阻力、油门阻力、ABS 脉冲、打滑脉冲、红线脉冲和换挡回弹。
- **陀螺仪精准转向**：采用 Gyrosteer 风格响应，适合喜欢体感直接转向的玩家。
- **手柄转向辅助**：适合普通摇杆驾驶，并提供更简化的日常设置。
- **手感预设**：提供平衡、舒适、强劲和自定义方案。
- **游戏内控制面板**：通过 CSP Gamepad FX 运行，不需要额外启动外部伴随程序。

## 下载

- [GitHub Releases](https://github.com/Adudumax/DualSense-Gamepad-Assist/releases)

打开最新 Release，下载符合语言偏好的安装包。可用时会同时提供英文版和简体中文版。

## 安装

1. 安装 Content Manager 和 Custom Shaders Patch `0.2.0` 或更新版本。
2. 从 GitHub Releases 下载最新安装包。
3. 打开压缩包，进入 `DualSense Gamepad Assist` 文件夹。
4. 将其中的 `apps` 和 `extension` 文件夹复制到 Assetto Corsa 根目录，通常为 `assettocorsa`。
5. 在 Content Manager 中打开 `设置 -> Custom Shaders Patch -> Gamepad FX`。
6. 启用 Gamepad FX，并选择 `DualSense Gamepad Assist`。
7. 进入赛道后，从游戏内右侧应用栏打开本插件。

推荐使用 USB 连接 DualSense，以获得最稳定的触觉和扳机反馈。如果没有触觉或扳机反馈，请关闭 Assetto Corsa 的 Steam Input，然后重新进入赛道。

## 基本使用

大多数玩家可以直接从默认的平衡预设开始。主面板用于日常设置；只有在需要微调转向、触觉、扳机、诊断或恢复默认值时，再打开高级设置。

启用陀螺仪精准转向后，普通转向辅助会自动让位，避免两套转向逻辑互相抢方向。触觉反馈、自适应扳机和自动离合仍然可以继续使用。

## 致谢

特别感谢：

- **AC Advanced Gamepad Assist** 的作者，为手柄转向辅助提供了基础思路和参考。
- **Dmitrii Alekseev**，**Gyrosteer** 的作者，为陀螺仪转向提供了概念和参考行为。
- **x4fab 和 Custom Shaders Patch 贡献者**，提供了 CSP、Gamepad FX 以及游戏内手柄反馈所需的接口。

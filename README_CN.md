<p align="center">
  <img src="assets/banner.png" alt="DualSense Gamepad Assist" width="100%">
</p>

<h1 align="center">DualSense Gamepad Assist</h1>

<p align="center">
  面向 <strong>Assetto Corsa / CSP</strong> 的 DualSense 手柄增强插件。
</p>

<p align="center">
  <a href="README.md">English</a>
  ·
  <a href="https://github.com/Adudumax/DualSense-Gamepad-Assist/releases">下载</a>
</p>

<p align="center">
  <img alt="Assetto Corsa" src="https://img.shields.io/badge/Assetto%20Corsa-CSP-1f6feb?style=flat-square">
  <img alt="Gamepad FX" src="https://img.shields.io/badge/CSP-Gamepad%20FX-2ea043?style=flat-square">
  <img alt="DualSense" src="https://img.shields.io/badge/Controller-DualSense-8957e5?style=flat-square">
  <img alt="Version" src="https://img.shields.io/badge/latest-v1.0.0-0a7cff?style=flat-square">
</p>

---

## 概览

DualSense Gamepad Assist 为 Assetto Corsa 带来更强、更清晰的手柄体验。它把手柄转向辅助、Gyrosteer 风格陀螺仪精准转向、自动离合、CSP 原生触觉、兼容震动和自适应扳机反馈整合到一个游戏内控制面板中。

它优先面向普通玩家：安装、选择预设、直接驾驶。需要细调的玩家仍然可以进入高级设置。

## 功能

| 模块 | 内容 |
| --- | --- |
| 触觉反馈 | 抓地、路肩、路面纹理、轮胎滑移、碰撞冲击和换挡冲击 |
| 自适应扳机 | 刹车阻力、油门阻力、ABS 脉冲、打滑脉冲、红线脉冲和换挡回弹 |
| 转向 | 适合摇杆驾驶的手柄转向辅助，以及 Gyrosteer 风格陀螺仪精准转向 |
| 预设 | 平衡、舒适、强劲和自定义手感方案 |
| 集成 | 通过 CSP Gamepad FX 在游戏内运行，不需要额外外部伴随程序 |

## 下载

**从 [GitHub Releases](https://github.com/Adudumax/DualSense-Gamepad-Assist/releases) 获取最新安装包。**

可用时，每个 Release 会提供不同语言的安装包。选择英文版或简体中文版，然后按下面步骤安装。

## 安装

1. 安装 Content Manager 和 Custom Shaders Patch `0.2.0` 或更新版本。
2. 从 GitHub Releases 下载最新安装包。
3. 打开压缩包，进入 `DualSense Gamepad Assist` 文件夹。
4. 将其中的 `apps` 和 `extension` 文件夹复制到 Assetto Corsa 根目录，通常为 `assettocorsa`。
5. 在 Content Manager 中打开 `设置 -> Custom Shaders Patch -> Gamepad FX`。
6. 启用 Gamepad FX，并选择 `DualSense Gamepad Assist`。
7. 进入赛道后，从游戏内右侧应用栏打开本插件。

## 推荐设置

- 推荐使用 USB 连接，以获得最稳定的 DualSense 触觉和自适应扳机反馈。
- 如果没有专用触觉或扳机反馈，请关闭 Assetto Corsa 的 Steam Input。
- 首次使用建议从平衡预设开始。舒适适合更轻的反馈，强劲适合更主动的手感，自定义适合保存自己的调校。
- 只有在需要体感直接转向时才启用陀螺仪精准转向。启用后，普通转向辅助会自动让位，避免两套转向逻辑互相抢方向。

## 致谢

特别感谢：

- **AC Advanced Gamepad Assist** 的作者，为手柄转向辅助提供了基础思路和参考。
- **Dmitrii Alekseev**，**Gyrosteer** 的作者，为陀螺仪转向提供了概念和参考行为。
- **x4fab 和 Custom Shaders Patch 贡献者**，提供了 CSP、Gamepad FX 以及游戏内手柄反馈所需的接口。

# DualSense Gamepad Assist

[English README](README.md)

DualSense Gamepad Assist 是一个面向 Assetto Corsa CSP `Gamepad FX` 的 DualSense 脚本。它在一个游戏内控制面板中整合了游戏手柄转向辅助、自动离合、可选自动换挡、CSP 原生触觉和自适应扳机。

`0.6.2` 保持已经验证满意的 `0.6.1` 震动反馈不变。本次发布将内部命名整理为 DGA，提供独立的中文包和英文包，并准备了适合公开发布的源码快照。

## 特点

- CSP 原生 DualSense 触觉：发动机质感、路肩、车身冲击、轮胎侧滑、换挡和碰撞。
- `0.5.1` 兼容握把补充层：使用 `vibrationLeft / vibrationRight`，与原生触觉并行工作。
- 自适应扳机：L2 刹车阻力和 ABS 提示；R2 油门阻力、驱动轮空转、高转红线脉冲和换挡回弹。
- 首页总览：反馈预设、自定义预设保存与载入、握把震动总强度。
- 独立高级设置窗口：可以自由移动和调整大小。
- 转向辅助、自动离合、可选自动换挡、校准、图表、Gamma 和死区控制。
- 不读取陀螺仪数据，也不修改陀螺仪转向。

## 下载

- [中文版](releases/DualSense-Gamepad-Assist-0.6.2-CN.zip)
- [English package](releases/DualSense-Gamepad-Assist-0.6.2-EN.zip)

## 安装

1. 安装 Content Manager 与 CSP `0.2.0` 或更高版本。
2. 下载所需语言包，打开其中的 `DualSense Gamepad Assist` 文件夹。
3. 把 `apps` 和 `extension` 文件夹复制到 AC 游戏根目录 `assettocorsa`。
4. 在 Content Manager 中打开 `设置 -> Custom Shaders Patch -> Gamepad FX`。
5. 勾选启用，并选择 `DualSense Gamepad Assist`。
6. 进入赛道后，从右侧应用栏打开本项目。

推荐使用 USB 连接 DualSense。若没有专属反馈，请关闭 Assetto Corsa 的 Steam Input，再重新进入游戏测试。

## 源码

- [中文源码快照](source/CN/)
- [English source snapshot](source/EN/)

转向辅助部分参考了 AC Advanced Gamepad Assist。第三方归属和许可证详情请查看[第三方说明](THIRD_PARTY_NOTICES.md)。

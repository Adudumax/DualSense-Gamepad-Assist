# DualSense Gamepad Assist

[English README](README.md)

DualSense Gamepad Assist 是一个面向 Assetto Corsa CSP `Gamepad FX` 的 DualSense 脚本。它在一个游戏内控制面板中整合了游戏手柄转向辅助、自动离合、可选自动换挡、CSP 原生触觉和自适应扳机。

## 特点

### DualSense 触觉

- CSP 原生 DualSense 语义层覆盖发动机质感、车身与路面冲击、路肩细节、轮胎侧滑、换挡、高转红线和碰撞。
- 兼容握把补充层使用 `vibrationLeft / vibrationRight`，与 CSP 原生触觉并行工作，补充发动机细震、路面纹理和换挡冲击。
- 首页可以统一调节握把震动总强度，不会改变 L2 或 R2 自适应扳机阻力。
- 诊断页可以临时隔离强化 Engine、Wheel、Bodywork 或 Skid 层，方便确认缺失的反馈来源。
- 实时遥测会显示左右路肩、轮胎侧滑、Bodywork 增益和音调、Skid 增益和音调。

### 自适应扳机

- L2 提供渐进式刹车阻力，并支持调整阻力曲线。
- ABS 介入时，L2 会提供可调节深度和速度的脉冲提示。
- R2 提供渐进式油门阻力、驱动轮空转提示、高转红线脉冲、升挡回弹和轻微降挡补油提示。
- 高级设置中可以继续微调灵敏度、强度、持续时间和脉冲频率。

### 驾驶辅助与界面

- 手柄转向辅助提供简化和完整两种设置方式，包含校准、预设、图表、Gamma、死区、自动回正、阻尼和反打响应。
- 自动离合可以辅助起步并防止熄火；在车辆支持时，可选换挡模式还会提供补油和自动换挡逻辑。
- 首页总览集中显示核心开关、三组反馈预设、自定义预设保存与载入，以及常用驾驶辅助选项。
- 高级设置使用独立窗口，可以自由移动和调整大小，并分为转向、反馈和诊断三个页面。
- 不读取陀螺仪或加速度计数据，也不修改陀螺仪转向。

## 下载

- [中文版](https://github.com/Adudumax/DualSense-Gamepad-Assist/releases/download/v0.6.2/DualSense-Gamepad-Assist-0.6.2-CN.zip)
- [English package](https://github.com/Adudumax/DualSense-Gamepad-Assist/releases/download/v0.6.2/DualSense-Gamepad-Assist-0.6.2-EN.zip)
- [GitHub Releases](https://github.com/Adudumax/DualSense-Gamepad-Assist/releases)

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

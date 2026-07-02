# DualSense Gamepad Assist 1.0.10 UI 文案测试包

作者：Adudumax

本版基于 `1.0.9 Gyrosteer Exact`，只调整界面文案。陀螺仪转向核心、震动反馈和 DualSense 扳机反馈保持不变。

## 本版重点

- 设置界面中不再显示内部模块名称，统一使用用户能理解的 `转向辅助`。
- 优化陀螺仪提示语，说明启用后的模式切换和保留功能。
- 高级参数说明改为面向用户的微调说明，不再使用开发讨论式措辞。
- `gyro_input.lua` 保持 1.0.9 的 Gyrosteer Exact 核心不变。
- `dualsense_feedback.lua` 保持 1.0.5 稳定版核心反馈不变。

## 推荐用法

1. 使用 USB 连接 DualSense。
2. 进入 Content Manager：`设置 -> Custom Shaders Patch -> Gamepad FX`，选择 `DualSense Gamepad Assist`。
3. 进游戏后打开右侧应用栏里的 `DualSense Gamepad Assist`。
4. 打开 `陀螺仪精准转向`。
5. 直接驾驶；熟悉 Gyrosteer 的玩家可以在高级参数中微调灵敏度。

## 机制说明

本版仍保持 Gyrosteer 风格的驾驶核心：传感器融合后使用 `math.tan(gamepadAngle * 4) / 4` 响应曲线，通过 `baseSteer` 边缘平滑、`ffb * -0.06` 轻微回馈修正，再按 `500 / car.steerLock` 映射到 AC 转向输入。

## 限制

陀螺仪体验依赖 CSP 对 DualSense 传感器的读取。如果当前 CSP 环境没有提供 DualSense 陀螺仪数据，界面会显示未检测到，脚本会回退到摇杆输入，不会影响震动和扳机反馈。

## 第三方许可

本项目以独立名称发布。所使用的第三方开源组件、参考资料和许可文本见 `THIRD_PARTY_NOTICES.md` 与 `licenses` 目录。

local lib = require "../../../extension/lua/joypad-assist/DualSense Gamepad Assist/DGALib"
local _json = require "json"

local uiData = ac.connect{
    ac.StructItem.key("DSGAData"),
    _appCanRun               = ac.StructItem.boolean(),
    _rAxleHVelAngle          = ac.StructItem.double(),
    _selfSteerStrength       = ac.StructItem.double(),
    _frontNdSlip             = ac.StructItem.double(),
    _rearNdSlip              = ac.StructItem.double(),
    _maxLimitReduction       = ac.StructItem.double(),
    _limitReduction          = ac.StructItem.double(),
    _gameGamma               = ac.StructItem.double(),
    _gameDeadzone            = ac.StructItem.double(),
    _gameRumble              = ac.StructItem.double(),
    _rawSteer                = ac.StructItem.double(),
    _finalSteer              = ac.StructItem.double(),
    _dualSenseDetected       = ac.StructItem.boolean(),
    _dualSenseNativeHapticsAvailable = ac.StructItem.boolean(),
    _dualSenseNativeTestSeconds = ac.StructItem.double(),
    _dualSenseNativeTestMode  = ac.StructItem.int32(),
    _dualSenseSlipFL          = ac.StructItem.double(),
    _dualSenseSlipFR          = ac.StructItem.double(),
    _dualSenseSlipRL          = ac.StructItem.double(),
    _dualSenseSlipRR          = ac.StructItem.double(),
    _dualSenseNativeCurbLeft  = ac.StructItem.double(),
    _dualSenseNativeCurbRight = ac.StructItem.double(),
    _dualSenseNativeBodyworkGain = ac.StructItem.double(),
    _dualSenseNativeBodyworkPitch = ac.StructItem.double(),
    _dualSenseNativeSkidIntensity = ac.StructItem.double(),
    _dualSenseNativeSkidGain  = ac.StructItem.double(),
    _dualSenseNativeSkidPitch = ac.StructItem.double(),
    assistEnabled            = ac.StructItem.boolean(),
    graphSelection           = ac.StructItem.int32(), -- 1 = none, 2 = static, 3 = live
    keyboardMode             = ac.StructItem.int32(), -- 0 = disabled, 1 = enabled, 2 = enabled + brake assist, 3 = enabled + throttle and brake assist
    autoClutch               = ac.StructItem.boolean(),
    autoShiftingMode         = ac.StructItem.int32(), -- 0 = default, 1 = manual, 2 = automatic
    autoShiftingCruise       = ac.StructItem.boolean(),
    autoShiftingDownBias     = ac.StructItem.double(),
    dualSenseEnabled         = ac.StructItem.boolean(),
    dualSenseGlobalStrength  = ac.StructItem.double(),
    dualSenseLegacyBodyVibration = ac.StructItem.boolean(),
    dualSenseNativeHapticsEnabled = ac.StructItem.boolean(),
    dualSenseNativeBodyworkStrength = ac.StructItem.double(),
    dualSenseNativeEngineStrength = ac.StructItem.double(),
    dualSenseNativeGearStrength = ac.StructItem.double(),
    dualSenseNativeLimiterStrength = ac.StructItem.double(),
    dualSenseNativeSkidStrength = ac.StructItem.double(),
    dualSenseNativeWheelStrength = ac.StructItem.double(),
    dualSenseNativeCollisionStrength = ac.StructItem.double(),
    dualSenseNativeCurbBoost = ac.StructItem.double(),
    dualSenseNativeSidePitchSeparation = ac.StructItem.double(),
    dualSenseNativeCurbEngineDucking = ac.StructItem.double(),
    dualSenseNativeSkidDynamicBoost = ac.StructItem.double(),
    dualSenseNativeSkidThreshold = ac.StructItem.double(),
    dualSenseNativeSkidEngineDucking = ac.StructItem.double(),
    dualSenseNativeSkidAxlePitchSeparation = ac.StructItem.double(),
    dualSenseSlipThreshold   = ac.StructItem.double(),
    dualSenseShiftDuration   = ac.StructItem.double(),
    dualSenseTriggersEnabled = ac.StructItem.boolean(),
    dualSenseBrakeResistance = ac.StructItem.double(),
    dualSenseThrottleResistance = ac.StructItem.double(),
    dualSenseBrakeCurve      = ac.StructItem.double(),
    dualSenseThrottleCurve   = ac.StructItem.double(),
    dualSenseABSFeedback     = ac.StructItem.double(),
    dualSenseABSFrequency    = ac.StructItem.double(),
    dualSenseWheelspinFeedback = ac.StructItem.double(),
    dualSenseWheelspinThreshold = ac.StructItem.double(),
    dualSenseWheelspinFrequency = ac.StructItem.double(),
    dualSenseLimiterResistance = ac.StructItem.double(),
    dualSenseLimiterFrequency = ac.StructItem.double(),
    dualSenseShiftResistance = ac.StructItem.double(),
    dualSenseDownshiftThrottleKick = ac.StructItem.double(),
    useFilter                = ac.StructItem.boolean(),
    filterSetting            = ac.StructItem.double(),
    steeringRate             = ac.StructItem.double(),
    targetSlip               = ac.StructItem.double(),
    rateIncreaseWithSpeed    = ac.StructItem.double(),
    selfSteerResponse        = ac.StructItem.double(),
    dampingStrength          = ac.StructItem.double(),
    maxSelfSteerAngle        = ac.StructItem.double(),
    countersteerResponse     = ac.StructItem.double(),
    maxDynamicLimitReduction = ac.StructItem.double(), -- Stores 10x the value for legacy reasons
    photoMode                = ac.StructItem.boolean()
}

-- Keys that are stored in a preset
local presetKeys = {
    "useFilter",
    "filterSetting",
    "steeringRate",
    "rateIncreaseWithSpeed",
    "targetSlip",
    "selfSteerResponse",
    "dampingStrength",
    "maxSelfSteerAngle",
    "countersteerResponse",
    "maxDynamicLimitReduction",
}

local _factoryPresetsStr = '{"Loose":{"dampingStrength":0.3,"filterSetting":0.5,"useFilter":false,"selfSteerResponse":0.3,"maxSelfSteerAngle":4,"targetSlip":1,"countersteerResponse":0.3,"rateIncreaseWithSpeed":0.1,"maxDynamicLimitReduction":4.5,"steeringRate":0.5},"Default":{"dampingStrength":0.37,"filterSetting":0.5,"useFilter":true,"selfSteerResponse":0.37,"maxSelfSteerAngle":14,"targetSlip":0.95,"countersteerResponse":0.2,"rateIncreaseWithSpeed":0.1,"maxDynamicLimitReduction":5,"steeringRate":0.5},"Stable":{"dampingStrength":0.75,"filterSetting":0.5,"useFilter":false,"selfSteerResponse":0.65,"maxSelfSteerAngle":90,"targetSlip":0.93,"countersteerResponse":0.15,"rateIncreaseWithSpeed":0.0,"maxDynamicLimitReduction":6,"steeringRate":0.35},"Drift":{"dampingStrength":0.5,"filterSetting":0.5,"useFilter":false,"selfSteerResponse":0.35,"maxSelfSteerAngle":90,"targetSlip":1,"countersteerResponse":0.5,"rateIncreaseWithSpeed":0.1,"maxDynamicLimitReduction":4,"steeringRate":0.4},"Author\'s preference":{"dampingStrength":0.4,"filterSetting":0.5,"useFilter":false,"selfSteerResponse":0.35,"maxSelfSteerAngle":90,"targetSlip":0.95,"countersteerResponse":0.2,"rateIncreaseWithSpeed":-0.25,"maxDynamicLimitReduction":5,"steeringRate":0.5}}'
local factoryPresets     = _json.decode(_factoryPresetsStr)

local savedPresets = ac.storage({presets = "{}"}, "DSGA_PRESETS_")

local presets = _json.decode(savedPresets.presets)

-- Removing presets saved by previous versions that have the same names as the factory presets
for k, _ in pairs(presets) do
    if factoryPresets[k] ~= nil then
        presets[k] = nil
    end
end
savedPresets.presets = _json.encode(presets)

local tooltips = {
    factoryReset             = "将所有设置恢复为默认值，包括下方参数！\n请点击两次确认。",
    lockedNote               = "已锁定。取消勾选“简化转向设置”后可手动调整。",
    presets                  = "在这里保存或载入转向预设。\n\n以 * 开头的是内置预设，不能修改或删除。",
    calibration              = "车辆载入时会自动校准；如果感觉异常，也可以在这里重新校准。\n\n操作前必须停车。",
    graphs                   = "用图表显示转向辅助的工作状态。可以选择静态图表或实时更新。",
    assistEnabled            = "启用或停用完整转向辅助。\n\n停用后将直接使用 AC 内置输入处理。",
    useFilter                = "提供一个简化滑块，自动联动调整大部分转向参数。",
    autoClutch               = "起步或发动机可能熄火时自动控制离合。\n\n此设置不影响换挡；换挡逻辑由“换挡模式”控制。",
    autoShiftingMode         = "AC 默认 = 使用 AC 原生换挡逻辑。\n\n手动 = 使用自定义补油和离合逻辑，但仅手动换挡。\n\n自动 = 使用自定义补油、离合和自动换挡逻辑，仍可短暂手动覆盖挡位。\n\n自动模式也会参考发动机功率曲线选择换挡点。\n\n重要：使用“AC 默认”以外的模式时，请在 AC 辅助设置中关闭原生自动换挡。",
    autoShiftingCruise       = "根据油门输入在巡航与性能模式间自动切换。\n\n兼顾轻松驾驶和性能驾驶；比赛时可以关闭，尤其是动态起步。",
    autoShiftingDownBias     = "数值越高，自动模式下的降挡越积极。\n\n最大值会在入弯刹车时较快降挡，但重新给油时可能更接近当前挡位转速上限。\n\n多数情况下建议保持较高数值。",
    dualSenseBalancedPreset  = "恢复本版本推荐的默认手感。发动机底噪较轻，路肩、失抓、ABS 和换挡反馈更突出。",
    dualSenseDetailPreset    = "更克制的机身震动与更清晰的路面细节，适合长时间跑圈。",
    dualSenseStrongPreset    = "整体反馈更强，适合先确认每一种效果是否正常触发。",
    dualSenseSaveCustomPreset = "保存当前 DualSense 反馈参数。之后可以从首页一键恢复。",
    dualSenseLoadCustomPreset = "载入之前保存的 DualSense 反馈参数。",
    advancedSettings          = "打开独立的高级设置窗口。窗口可以自由移动和调整大小。",
    dualSenseGlobalStrength  = "统一缩放 CSP 原生握把触觉和 0.5.1 兼容握把补充层。不会改变 L2 / R2 自适应扳机阻力，也不会修改 AC 控制设置中的原生震动百分比。",
    dualSenseLegacyBodyVibration = "恢复 0.5.1 的 vibrationLeft / vibrationRight 兼容握把输出。它不会直接控制 L2 / R2，但会补充发动机细震、路面纹理和换挡时的机身冲击。",
    dualSenseTestNativeEngine = "将 CSP 原生 Engine 层临时强化 10 秒。停车怠速或空踩油门即可对比；它不是伪造震动事件。",
    dualSenseTestNativeWheel = "将其余主要原生层静音，仅把 Wheel 层放大到 800%，持续 15 秒。请立即实际压路肩。",
    dualSenseTestNativeBodywork = "将其余主要原生层静音，仅把 Bodywork 层放大到 500%，持续 15 秒。请立即实际压路肩或驶过明显颠簸。",
    dualSenseTestNativeSkid = "将其余主要原生层静音，仅把 Skid 层放大到 800%，持续 15 秒。请立即制造推头、甩尾或驱动轮空转。",
    dualSenseEnabled         = "DualSense 机身震动与自适应扳机总开关。\n\n本项目不会读取陀螺仪，也不会修改陀螺仪转向。",
    dualSenseNativeHapticsEnabled = "使用 CSP 的 DualSense USB 原生触觉层。",
    dualSenseNativeBodyworkStrength = "CSP 原生车身与路面冲击层强度。",
    dualSenseNativeEngineStrength = "CSP 原生发动机层强度。保持较低，避免盖过路肩与失抓。",
    dualSenseNativeGearStrength = "CSP 原生换挡层强度。",
    dualSenseNativeLimiterStrength = "CSP 原生红线层强度。",
    dualSenseNativeSkidStrength = "CSP 原生轮胎打滑层强度。",
    dualSenseNativeWheelStrength = "CSP 原生 Wheel 层强度。实测它不是压路肩和侧滑的主要来源，因此默认只保留较低强度。",
    dualSenseNativeCollisionStrength = "CSP 原生碰撞层强度。",
    dualSenseNativeCurbBoost = "检测到单侧路肩时，额外放大 CSP 原生 Bodywork 层。实测路肩主要由 Bodywork 层表达。",
    dualSenseNativeSidePitchSeparation = "根据左、右路肩改变 Bodywork 的音调：左侧略低、右侧略高。用于提高辨识度，不等同于直接控制左右执行器。",
    dualSenseNativeCurbEngineDucking = "压路肩时自动压低发动机底噪，为路肩细节留出空间。",
    dualSenseNativeSkidDynamicBoost = "轮胎越明显超过抓地极限，Skid 原生层额外放大越多。",
    dualSenseNativeSkidThreshold = "开始动态增强 Skid 层的原始 ndSlip 阈值。CSP 中 100% 表示轮胎到达抓地极限。",
    dualSenseNativeSkidEngineDucking = "侧滑时自动压低发动机底噪，为 Skid 层留出空间。",
    dualSenseNativeSkidAxlePitchSeparation = "根据前后轴失抓差异调整 Skid 音调：推头略高，甩尾略低。",
    dualSenseSlipThreshold   = "L2 判断前轮锁死趋势时使用的滑动阈值。数值越低越敏感。",
    dualSenseShiftDuration   = "R2 换挡回弹持续时间。",
    dualSenseTriggersEnabled = "启用 L2 与 R2 自适应扳机阻力。",
    dualSenseBrakeResistance = "L2 刹车基础阻力。",
    dualSenseThrottleResistance = "R2 油门基础阻力。",
    dualSenseBrakeCurve      = "L2 阻力曲线。数值越高，轻踩时越柔和，深踩时越明显。",
    dualSenseThrottleCurve   = "R2 阻力曲线。数值越高，轻踩时越柔和，深踩时越明显。",
    dualSenseABSFeedback     = "ABS 介入时 L2 阻力松放的幅度。",
    dualSenseABSFrequency    = "ABS 脉冲速度。",
    dualSenseWheelspinFeedback = "驱动轮打滑时 R2 阻力松放的幅度。",
    dualSenseWheelspinThreshold = "触发驱动轮打滑提示的阈值。数值越低越敏感。",
    dualSenseWheelspinFrequency = "驱动轮打滑时 R2 脉冲速度。",
    dualSenseLimiterResistance = "接近发动机红线时的 R2 脉冲强度。",
    dualSenseLimiterFrequency = "接近发动机红线时的 R2 脉冲速度。",
    dualSenseShiftResistance = "升挡时 R2 压紧、松放、回弹的强度。",
    dualSenseDownshiftThrottleKick = "降挡时 R2 的轻微补油提示。默认较轻，不会让 L2 误报 ABS。",
    keyboardMode             = "启用键盘油门、刹车和转向输入。\n\n在关闭 ABS 或 TCS 时，也可以启用刹车或油门辅助。它们不能替代 ABS 或 TCS，只是尽量弥补键盘没有模拟量输入的问题。\n\n漂移时不要使用油门辅助。\n\n如需换挡和手刹等车辆控制正常工作，还必须在 Content Manager 控制设置中启用“与键盘组合”。",
    filterSetting            = "整体转向辅助强度。\n\n0% 不代表关闭辅助，只是使用更轻的处理。",
    steeringRate             = "整体转向速度。\n\n较低数值会平滑转向输入并提高稳定性，但过低可能感觉迟钝。\n\n键盘转向通常适合比手柄更低的数值。",
    rateIncreaseWithSpeed    = "车速升高时转向变慢或变快的程度。\n\n即使设为 0%，实际转向速度在高速时也会自然降低。",
    selfSteerResponse        = "自动回正维持车辆直线的力度。\n\n较低 = 更松、更容易转向过度；较高 = 更稳定、更容易抑制转向过度。",
    dampingStrength          = "高级参数。多数情况下建议与“响应”保持接近。\n\n阻尼会增加抵消车身横摆的回正力，从而提高稳定性。\n\n如果车辆回正时摆动过多，可以提高阻尼。\n\n阻尼力不受“最大角度”限制。",
    maxSelfSteerAngle        = "限制自动回正力可作用的最大转向角度。\n\n它决定辅助可以帮助挽救多大幅度的侧滑。\n\n多数情况下推荐 90°；想要更松的感觉可以使用约 5°。",
    targetSlip               = "调整前轮目标侧滑角，也就是整体转向量。\n\n较高 = 转向更多；较低 = 转向更少。\n\n多数车辆在 90%-100% 间较自然，也可提高数值让前轮摩擦更多。",
    countersteerResponse     = "数值越高，反打越有效，但也更容易修正过度并向另一侧旋转。\n\n通常建议保持在 50% 以下。",
    maxDynamicLimitReduction = "车辆转向过度时，为保持前轮抓地而限制向弯内继续转向的程度。\n\n较低 = 允许更多向内转向；较高 = 车辆甩尾时更明显地收回转向。",
    builtInSettings          = "这里直接调整 AC 自身设置，与 Controller Tweaks 应用类似，仅为方便操作。",
    dualSenseEnableACRumble  = "将 AC 控制器设置中的原生震动强度设为 100%。自适应扳机不依赖该值，但握把震动输出可能被它缩放到零。",
    photoMode                = "停车时禁用自动回正，让车轮保持转向角度。\n适合截图。",
    _gameGamma               = "调整 AC 自身的“转向 Gamma”。\n\nGamma 越高，摇杆中心区域越不敏感。\n\n通常可按偏好设置在 120%-160% 左右。",
    _gameDeadzone            = "调整 AC 自身的“转向死区”。\n\n死区用于避免摇杆漂移造成误输入。\n\n建议在不产生误输入的前提下尽量设低。",
    _gameRumble              = "调整 AC 自身的原生震动强度。"
}

local sectionPadding = 10

local black              = rgbm(0.0, 0.0, 0.0, 1.0)
local white              = rgbm(1.0, 1.0, 1.0, 1.0)
local controlHoverColor  = rgbm(38/255, 87/255, 142/255, 0.92)
local controlAccentColor = rgbm(48/255, 143/255, 255/255, 1)
local controlActiveColor = rgbm(48/255, 143/255, 255/255, 0.48)
local lockIconColor      = controlAccentColor
local lockedSliderColor  = rgbm(0.0, 0.2, 0.5, 0.5)
local buttonColor        = rgbm(20/255, 37/255, 58/255, 0.88)
local childBgColor       = rgbm(5/255, 14/255, 26/255, 0.48)
local glassBgColor       = rgbm(4/255, 12/255, 23/255, 0.78)
local glassLineColor     = rgbm(48/255, 143/255, 255/255, 0.30)
local mutedTextColor     = rgbm(180/255, 198/255, 220/255, 0.88)
local successColor       = rgbm(95/255, 214/255, 152/255, 1.0)
local warningColor       = rgbm(255/255, 190/255, 92/255, 1.0)

local graphPadding       = 50
local graphDivColor      = rgbm(1.0, 1.0, 1.0, 0.1)
local graphPathColor     = controlAccentColor
local graphBgColor       = rgbm(0.0, 0.0, 0.0, 0.5)
local graphLiveColor     = rgbm(1.0, 1.0, 1.0, 0.5)
local graphBorderColor   = black

local barBgColor         = graphBgColor
local barPadding         = 25
local barLiveColor       = controlAccentColor
local barSecondaryColor  = rgbm(1.0, 0.5, 0.0, 1.0)
local barBorderColor     = black
local barCenterColor     = graphLiveColor
local barHighColor       = rgbm(1.0, 0.0, 0.0, 1.0)
local barLowColor        = rgbm(140/255, 156/255, 171/255, 1)

local zeroVec = vec2() -- Do not modify
local tmpVec1 = vec2()
local tmpVec2 = vec2()
local tmpVec3 = vec2()

local presetsWindowEnabled = false

local enableClicked = 0

local function getPresetList()
    local keys = {}
    for k, _ in pairs(factoryPresets) do
        keys[#keys + 1] = "*" .. k
    end
    for k, _ in pairs(presets) do
        if factoryPresets[k] == nil then keys[#keys + 1] = k end
    end
    table.sort(keys)
    return keys
end

local function addTooltipToLastItem(tooltipKey)
    if ui.itemHovered() and tooltipKey and tooltips[tooltipKey] then
        ui.setTooltip(tooltips[tooltipKey])
    end
end

local function showCheckbox(cfgKey, name, inverted, disabled, indent)
    indent = indent or sectionPadding
    local val = not uiData[cfgKey]
    if not inverted then val = not val end
    ui.offsetCursorX(indent)
    if disabled then ui.pushDisabled() end
    if ui.checkbox(name, val) and not disabled then
        uiData[cfgKey] = not uiData[cfgKey]
    end
    if disabled then ui.popDisabled() end
    addTooltipToLastItem(cfgKey)
end

local function showConfigSlider(cfgKey, name, format, minVal, maxVal, valueMult, locked, width, indent, disabled, onHover, hoverOnInteract)
    indent = indent or sectionPadding
    width = width or ui.availableSpaceX()
    local displayVal = uiData[cfgKey] * valueMult
    if locked then
        ui.offsetCursorX(indent)
        local cursorOld = ui.getCursor()
        ui.drawRectFilled(cursorOld, tmpVec1:set(cursorOld.x + width - indent, cursorOld.y + ui.frameHeight()), lockedSliderColor)
        ui.setCursorX(cursorOld.x)
        ui.textAligned(string.format(name .. ": " .. format, displayVal), tmpVec1:set(0.5, 0.5), tmpVec2:set(width - indent, ui.frameHeight()))
        ui.setCursor(cursorOld)
        ui.setItemAllowOverlap()
        ui.invisibleButton("##" .. cfgKey, tmpVec1:set(width - indent, ui.frameHeight()))
        addTooltipToLastItem(cfgKey)
        if onHover and ui.itemHovered() then onHover() end
        local preImageCursor = ui.getCursor()
        ui.setCursor(cursorOld)
        ui.offsetCursorX(-ui.frameHeight())
        ui.image("img/lock.png", tmpVec1:set(ui.frameHeight(), ui.frameHeight()), lockIconColor, true)
        addTooltipToLastItem("lockedNote")
        ui.setCursor(preImageCursor)
        local newValue = math.clamp(displayVal, minVal, maxVal) / valueMult
        if math.abs(newValue - displayVal) > (1e-5 * (maxVal - minVal)) then uiData[cfgKey] = newValue end
        return newValue
    else
        ui.offsetCursorX(indent)
        ui.setNextItemWidth(width - indent)
        if disabled then ui.pushDisabled() end
        local value, changed = ui.slider("##" .. cfgKey, displayVal, minVal, maxVal, name .. ": " .. format)
        if disabled then ui.popDisabled() end
        value = math.clamp(value, minVal, maxVal) / valueMult
        local changedFr = math.abs(value - displayVal) > (1e-5 * (maxVal - minVal))
        addTooltipToLastItem(cfgKey)
        if onHover and (ui.itemHovered() or (hoverOnInteract and ui.itemActive())) then onHover() end
        local newValue = changedFr and value or (math.clamp(displayVal, minVal, maxVal) / valueMult)
        if changedFr then uiData[cfgKey] = newValue end
        return newValue
    end
end

local function showDummyLine(lineHeightMult)
    lineHeightMult = lineHeightMult or 1.0
    ui.dummy(tmpVec1:set(ui.availableSpaceX(), ui.frameHeight() * lineHeightMult))
end

local function showHeader(text)
    showDummyLine(0.25)
    ui.alignTextToFramePadding()
    ui.header(text)
end

local function showButton(text, tooltipKey, callback, indent, textColor, disabled)
    indent = indent or sectionPadding
    ui.offsetCursorX(indent)
    if disabled then ui.pushDisabled() end
    if textColor then
        ui.pushStyleColor(ui.StyleColor.Text, textColor)
    end
    local clicked = ui.button(text, tmpVec1:set(ui.availableSpaceX() - indent, ui.frameHeight()))
    if textColor then
        ui.popStyleColor(1)
    end
    if disabled then ui.popDisabled() end
    addTooltipToLastItem(tooltipKey)
    if clicked and callback and not disabled then callback() end
    return clicked
end

local function showCompactDropdown(label, tooltipKey, values, selectedIndex, indent)
    indent = indent or sectionPadding
    ui.offsetCursorX(indent)
    ui.pushItemWidth(ui.availableSpaceX() * 0.5)
    local selection = ui.combo(string.format("%s - %s", label, values[selectedIndex]), selectedIndex, ui.ComboFlags.NoPreview, values)
    addTooltipToLastItem(tooltipKey)
    ui.popItemWidth()
    return selection + 0
end

local function sendRecalibrationEvent()
    ac.broadcastSharedEvent("DSGA_calibrateSteering")
end

local function testDualSenseNativeEngine()
    ac.broadcastSharedEvent("DSGA_testDualSenseNativeEngine")
end

local function testDualSenseNativeWheel()
    ac.broadcastSharedEvent("DSGA_testDualSenseNativeWheel")
end

local function testDualSenseNativeBodywork()
    ac.broadcastSharedEvent("DSGA_testDualSenseNativeBodywork")
end

local function testDualSenseNativeSkid()
    ac.broadcastSharedEvent("DSGA_testDualSenseNativeSkid")
end

local function nativeHapticTestModeLabel()
    if uiData._dualSenseNativeTestSeconds <= 0 then return "待机" end
    local labels = {"Engine", "Wheel", "Bodywork", "Skid"}
    return labels[uiData._dualSenseNativeTestMode] or "未知"
end

local function enableACRumbleForDualSense()
    uiData._gameRumble = 1.0
end

local function showBar(title, upperLeft, size, xMin, xMax, xDiv, lowColor, highColor, xHighlight, liveXValue, xHighlightColor)
    ui.toolWindow(title, upperLeft, size, true, function ()
        ui.pushFont(ui.Font.Small)

        ui.drawRectFilled(zeroVec, size, barBgColor)
        ui.drawRect(zeroVec, size, barBorderColor)
        ui.offsetCursorY(7)
        ui.textAligned(title, tmpVec1:set(0.5, 0.0), tmpVec2:set(size.x, 0.0))

        local xRange   = xMax - xMin
        local barWidth = size.x - 2 * barPadding
        local xPPU     = barWidth / xRange -- Pixels per unit

        ui.setCursorX(0)
        ui.setCursorY(0)

        for x = xMin, xMax, xDiv do
            ui.drawLine(tmpVec1:set(math.round(barPadding + xPPU * (x - xMin)) or 0, barPadding), tmpVec2:set(tmpVec1.x, size.y - barPadding), graphDivColor)
            ui.textAligned(
                string.format("%.f", x),
                tmpVec1:set(((x - xMin) / xRange) * ((size.x - 2 * barPadding + (barWidth * 0.018)) / size.x) + ((barPadding - (barWidth * 0.0053333)) / size.x), (size.y - barPadding + 15) / size.y),
                size
            )
            ui.setCursor(zeroVec)
        end

        if xHighlight then
            if xHighlightColor then
                ui.drawLine(tmpVec1:set(math.round(2 + barPadding + xPPU * (xHighlight - xMin) * (1.0 - (5 / barWidth))) or 0, barPadding), tmpVec2:set(tmpVec1.x, size.y - barPadding), xHighlightColor, 3)
            else
                ui.drawLine(tmpVec1:set(math.round(barPadding + xPPU * (xHighlight - xMin)) or 0, barPadding), tmpVec2:set(tmpVec1.x, size.y - barPadding), barCenterColor)
            end
        end

        if liveXValue then
            local liveLineXPos = math.round(barPadding + (liveXValue - xMin) / xRange * barWidth) or 0
            local tooLow = liveLineXPos < barPadding + 2
            local tooHigh = liveLineXPos > (size.x - barPadding - 3)
            local barColor = barLiveColor
            if tooHigh and highColor then
                liveLineXPos = size.x - barPadding - 3
                barColor = highColor
            end
            if tooLow and lowColor then
                liveLineXPos = barPadding + 2
                barColor = lowColor
            end
            if (tooLow or lowColor) and (tooHigh or highColor) then ui.drawLine(tmpVec1:set(liveLineXPos, barPadding + 1), tmpVec2:set(liveLineXPos, size.y - barPadding - 1), barColor, 3) end
        end

        ui.drawRect(tmpVec1:set(barPadding, barPadding), tmpVec2:set(size.x - barPadding, size.y - barPadding), white)

        ui.popFont()
        return 0
    end)
    ui.popStyleVar()
end

local function showGraph(title, upperLeft, size, xTitle, yTitle, xMin, xMax, yMin, yMax, xDiv, yDiv, graphCallback, liveXValue, screenSampleSize)
    ui.toolWindow(title, upperLeft, size, true, function ()
        ui.pushFont(ui.Font.Small)

        ui.drawRectFilled(zeroVec, size, graphBgColor)
        ui.drawRect(zeroVec, size, graphBorderColor)

        ui.offsetCursorY(10)
        ui.textAligned(title, tmpVec1:set(0.5, 0.0), tmpVec2:set(size.x, 0.0))

        ui.drawLine(tmpVec1:set(graphPadding, graphPadding), tmpVec2:set(graphPadding, size.y - graphPadding), white)
        ui.drawLine(tmpVec1:set(graphPadding, size.y - graphPadding), tmpVec2:set(size.x - graphPadding, size.y - graphPadding), white)

        local xRange = xMax - xMin
        local yRange = yMax - yMin

        local xPPU = (size.x - 2 * graphPadding) / xRange -- Pixels per unit
        local yPPU = (size.y - 2 * graphPadding) / yRange -- Pixels per unit

        ui.setCursorX(0)
        ui.setCursorY(0)

        local graphWidth  = size.x - graphPadding * 2.0
        local graphHeight = size.y - graphPadding * 2.0

        if graphCallback then
            for cx = graphPadding, size.x - graphPadding, screenSampleSize do
                local relativeX = math.clamp(cx - graphPadding, 0.0, graphWidth) / graphWidth
                ui.pathLineTo(tmpVec1:set(
                    graphPadding + relativeX * graphWidth,
                    ((1.0 - (graphCallback(xMin + relativeX * xRange) - yMin) / yRange)) * graphHeight + graphPadding
                ))
            end
            ui.pathStroke(graphPathColor, false, 2)
        end

        for x = xMin, xMax, xDiv do
            ui.drawLine(tmpVec1:set(math.round(graphPadding + xPPU * (x - xMin)) or 0, graphPadding), tmpVec2:set(tmpVec1.x, size.y - graphPadding), graphDivColor)
            ui.textAligned(
                string.format("%.f", x),
                tmpVec1:set(((x - xMin) / xRange) * ((size.x - 2 * graphPadding + (graphWidth * 0.018)) / size.x) + ((graphPadding - (graphWidth * 0.0053333)) / size.x), (size.y - graphPadding + 15) / size.y),
                size
            )
            ui.setCursor(zeroVec)
        end

        for y = yMin, yMax, yDiv do
            ui.drawLine(tmpVec1:set(graphPadding, math.round(graphPadding + yPPU * (y - yMin))), tmpVec2:set(size.x - graphPadding, math.round(graphPadding + yPPU * (y - xMin))), graphDivColor)
            ui.textAligned(
                string.format("%.f", y),
                tmpVec1:set((graphPadding - 15) / size.x, 1.0 - (((y - yMin) / yRange) * ((size.y - 2 * graphPadding + (graphHeight * 0.018)) / size.y) + ((graphPadding - (graphHeight * 0.0053333)) / size.y))),
                size
            )
            ui.setCursor(zeroVec)
        end

        if liveXValue and graphCallback then
            local liveLineXPos = math.round(graphPadding + (liveXValue - xMin) / xRange * graphWidth) or 0
            local liveLineYPos = math.round(graphPadding + (1.0 - (graphCallback(liveXValue) - yMin) / yRange) * graphHeight) or 0
            local xPosTooHigh = not (liveLineXPos < size.x - graphPadding)
            local yPosTooHigh = not (liveLineYPos > graphPadding)
            if liveLineXPos > graphPadding and not xPosTooHigh then
                ui.drawLine(tmpVec1:set(liveLineXPos, graphPadding), tmpVec2:set(liveLineXPos, size.y - graphPadding), graphLiveColor)
            end
            if liveLineYPos < size.y - graphPadding and not yPosTooHigh then
                ui.drawLine(tmpVec1:set(graphPadding, liveLineYPos), tmpVec2:set(size.x - graphPadding, liveLineYPos), graphLiveColor)
            end
            if not (xPosTooHigh or yPosTooHigh) then
                ui.drawCircleFilled(tmpVec1:set(liveLineXPos, liveLineYPos), 3, graphPathColor)
            end
        end

        ui.offsetCursorY(size.y - graphPadding + 30)
        ui.textAligned(xTitle, tmpVec1:set(0.5, 0.0), tmpVec2:set(size.x, 0.0))
        ui.setCursor(zeroVec)

        ui.beginRotation()
        ui.offsetCursorY(size.y * 0.5)
        ui.setCursorX(graphPadding)
        ui.textAligned(yTitle, tmpVec1:set(0.5, 0.0), tmpVec2:set(size.x - graphPadding * 2, 0.0))
        ui.endRotation(180.0, tmpVec1:set(-size.x * 0.5 + graphPadding - 30, 0.0))

        ui.popFont()
        return 0
    end)
    ui.popStyleVar()
end

local function selfSteerCurveCallback(x)
    local correctionExponent = 1.0 + (1.0 - math.log10(10.0 * (uiData.selfSteerResponse * 0.9 + 0.1)))
    local correctionBase     = lib.signedPow(math.clamp(x / 72.0, -1, 1), correctionExponent) * 72.0
    local selfSteerCapT      = math.min(1.0, 4.0 / (2 * uiData.maxSelfSteerAngle))
    return lib.clampEased(correctionBase, -uiData.maxSelfSteerAngle, uiData.maxSelfSteerAngle, selfSteerCapT) * ((uiData.graphSelection == 3) and uiData._selfSteerStrength or 1.0)
end

local function drawSelfSteerCurve()
    local liveAngle = (uiData.graphSelection == 3) and math.abs(uiData._rAxleHVelAngle) or nil
    showGraph("Self-steer force\n(damping force not included)", vec2(ui.windowPos().x + ui.windowWidth(), ui.windowPos().y), vec2(300, 226), "Rear axle travel angle (degrees)", "Self-steer (degrees)", 0.0, 60.0, 0.0, 60.0, 10.0, 10.0, uiData.assistEnabled and selfSteerCurveCallback or nil, uiData.assistEnabled and liveAngle or nil, 3)
end

local function drawInputBar()
    showBar("Input vs. final steering (%)", vec2(ui.windowPos().x + ui.windowWidth(), ui.windowPos().y + 225), vec2(300, 75), -100.0, 100.0, 25.0, barLiveColor, barLiveColor, uiData._rawSteer * 100.0, uiData._finalSteer * 100.0, barSecondaryColor) 
end

local function drawLimitReductionBar()
    showBar("Dynamic limit reduction (deg)", vec2(ui.windowPos().x + ui.windowWidth(), ui.windowPos().y + 299), vec2(300, 75), -10.0, 0.0, 1.0, barLiveColor, barLiveColor, -uiData._maxLimitReduction, uiData.assistEnabled and (-uiData._limitReduction) or nil)
end

local function drawFrontSlipBar()
    showBar("Relative front slip (%)", vec2(ui.windowPos().x + ui.windowWidth(), ui.windowPos().y + 373), vec2(300, 75), 50.0, 150.0, 10.0, barLowColor, barHighColor, 100.0, uiData._frontNdSlip * 100.0)
end

local function drawRearSlipBar()
    showBar("Relative rear slip (%)", vec2(ui.windowPos().x + ui.windowWidth(), ui.windowPos().y + 447), vec2(300, 75), 50.0, 150.0, 10.0, barLowColor, barHighColor, 100.0, uiData._rearNdSlip * 100.0)
end

local function enableScript()
    local gamepadFile     = "\\joypad_assist.ini"
    local gamepadSectionName = "BASIC"

    if ac.getPatchVersionCode() >= 2260 then
        gamepadFile = "\\gamepad_fx.ini"
        gamepadSectionName = "JOYPAD_ASSIST"
    end

    local gamepadIni  = ac.INIConfig.load(ac.getFolder(ac.FolderID.ExtCfgUser) .. gamepadFile)
    local controlsIni = ac.INIConfig.load(ac.getFolder(ac.FolderID.Cfg) .. "\\controls.ini")

    gamepadIni:set(gamepadSectionName, "ENABLED", 1)
    gamepadIni:set(gamepadSectionName, "IMPLEMENTATION", "DualSense Gamepad Assist")
    gamepadIni:save(ac.getFolder(ac.FolderID.ExtCfgUser) .. gamepadFile)

    controlsIni:set("HEADER", "INPUT_METHOD", "X360")
    controlsIni:save()

    enableClicked = os.clock()

    ac.reloadControlSettings()
end

local function togglePresetsWindow()
    presetsWindowEnabled = not presetsWindowEnabled
end

local function savePreset(name)
    if factoryPresets[name] ~= nil then return false end

    presets[name] = {}
    for _, pKey in ipairs(presetKeys) do
        if uiData[pKey] ~= nil then presets[name][pKey] = uiData[pKey] end
    end
    savedPresets.presets = _json.encode(presets)

    return true
end

local function loadPreset(name)
    if factoryPresets[name] ~= nil then
        for _, pKey in ipairs(presetKeys) do
            if uiData[pKey] ~= nil and factoryPresets[name][pKey] ~= nil then uiData[pKey] = factoryPresets[name][pKey] end
        end
        return true
    end

    if presets[name] ~= nil then
        for _, pKey in ipairs(presetKeys) do
            if uiData[pKey] ~= nil and presets[name][pKey] ~= nil then uiData[pKey] = presets[name][pKey] end
        end
        return true
    end

    return false
end

local function deletePreset(name)
    if presets[name] == nil then return false end
    presets[name] = nil
    savedPresets.presets = _json.encode(presets)
    return true
end

local function factoryReset()
    -- presets = _json.decode(_factoryPresetsStr)
    -- savedPresets.presets = _factoryPresetsStr

    -- uiData.assistEnabled           = true
    -- uiData.autoClutch              = false
    -- uiData.autoShiftingMode        = 0
    -- uiData.autoShiftingCruise      = true
    -- uiData.autoShiftingDownBias    = 0.9
    -- uiData.graphSelection          = 1
    -- uiData.keyboardMode            = 0

    loadPreset("Default")

    presetsWindowEnabled = false

    ac.broadcastSharedEvent("DSGA_factoryReset")
end

local function applyDualSensePreset(preset)
    for key, value in pairs(preset) do
        uiData[key] = value
    end
end

local dualSenseBalancedPreset = {
    dualSenseEnabled = true,
    dualSenseGlobalStrength = 1.00,
    dualSenseLegacyBodyVibration = true,
    dualSenseNativeHapticsEnabled = true,
    dualSenseNativeBodyworkStrength = 0.95,
    dualSenseNativeEngineStrength = 0.22,
    dualSenseNativeGearStrength = 1.30,
    dualSenseNativeLimiterStrength = 1.20,
    dualSenseNativeSkidStrength = 5.20,
    dualSenseNativeWheelStrength = 0.60,
    dualSenseNativeCollisionStrength = 3.00,
    dualSenseNativeCurbBoost = 1.35,
    dualSenseNativeSidePitchSeparation = 0.14,
    dualSenseNativeCurbEngineDucking = 0.82,
    dualSenseNativeSkidDynamicBoost = 0.75,
    dualSenseNativeSkidThreshold = 1.02,
    dualSenseNativeSkidEngineDucking = 0.82,
    dualSenseNativeSkidAxlePitchSeparation = 0.10,
    dualSenseSlipThreshold = 0.68,
    dualSenseShiftDuration = 0.115,
    dualSenseTriggersEnabled = true,
    dualSenseBrakeResistance = 0.48,
    dualSenseThrottleResistance = 0.12,
    dualSenseBrakeCurve = 1.35,
    dualSenseThrottleCurve = 1.45,
    dualSenseABSFeedback = 0.90,
    dualSenseABSFrequency = 14.0,
    dualSenseWheelspinFeedback = 0.88,
    dualSenseWheelspinThreshold = 1.02,
    dualSenseWheelspinFrequency = 18.0,
    dualSenseLimiterResistance = 0.30,
    dualSenseLimiterFrequency = 30.0,
    dualSenseShiftResistance = 0.78,
    dualSenseDownshiftThrottleKick = 0.18,
}

local dualSenseDetailOverrides = {
    dualSenseNativeBodyworkStrength = 0.68,
    dualSenseNativeEngineStrength = 0.18,
    dualSenseNativeGearStrength = 1.15,
    dualSenseNativeSkidStrength = 4.50,
    dualSenseNativeWheelStrength = 0.35,
    dualSenseNativeCurbBoost = 1.10,
    dualSenseNativeSidePitchSeparation = 0.10,
    dualSenseNativeSkidDynamicBoost = 0.62,
    dualSenseNativeSkidThreshold = 1.06,
    dualSenseNativeSkidEngineDucking = 0.76,
    dualSenseNativeSkidAxlePitchSeparation = 0.08,
    dualSenseSlipThreshold = 0.72,
    dualSenseBrakeResistance = 0.42,
    dualSenseShiftResistance = 0.72,
}

local dualSenseStrongOverrides = {
    dualSenseNativeBodyworkStrength = 1.10,
    dualSenseNativeEngineStrength = 0.30,
    dualSenseNativeGearStrength = 1.65,
    dualSenseNativeLimiterStrength = 1.55,
    dualSenseNativeSkidStrength = 7.00,
    dualSenseNativeWheelStrength = 0.80,
    dualSenseNativeCollisionStrength = 3.60,
    dualSenseNativeCurbBoost = 1.75,
    dualSenseNativeSidePitchSeparation = 0.20,
    dualSenseNativeCurbEngineDucking = 0.90,
    dualSenseNativeSkidDynamicBoost = 0.90,
    dualSenseNativeSkidThreshold = 1.00,
    dualSenseNativeSkidEngineDucking = 0.92,
    dualSenseNativeSkidAxlePitchSeparation = 0.14,
    dualSenseSlipThreshold = 0.58,
    dualSenseBrakeResistance = 0.62,
    dualSenseThrottleResistance = 0.18,
    dualSenseLimiterResistance = 0.42,
    dualSenseShiftResistance = 0.92,
    dualSenseDownshiftThrottleKick = 0.26,
}

local function loadDualSenseBalancedPreset()
    applyDualSensePreset(dualSenseBalancedPreset)
end

local function loadDualSenseDetailPreset()
    loadDualSenseBalancedPreset()
    applyDualSensePreset(dualSenseDetailOverrides)
end

local function loadDualSenseStrongPreset()
    loadDualSenseBalancedPreset()
    applyDualSensePreset(dualSenseStrongOverrides)
end

local function matchesDualSensePreset(overrides)
    for key, balancedValue in pairs(dualSenseBalancedPreset) do
        local expected = overrides and overrides[key] or balancedValue
        local actual = uiData[key]
        if type(expected) == "number" then
            if type(actual) ~= "number" or math.abs(actual - expected) > 1e-5 then return false end
        elseif actual ~= expected then
            return false
        end
    end
    return true
end

local function getDualSensePresetName()
    if matchesDualSensePreset(dualSenseDetailOverrides) then return "细腻赛道" end
    if matchesDualSensePreset(dualSenseStrongOverrides) then return "强烈反馈" end
    if matchesDualSensePreset(nil) then return "平衡推荐" end
    return "自定义"
end

local dualSensePresetKeys = {
    "dualSenseEnabled",
    "dualSenseGlobalStrength",
    "dualSenseLegacyBodyVibration",
    "dualSenseNativeHapticsEnabled",
    "dualSenseNativeBodyworkStrength",
    "dualSenseNativeEngineStrength",
    "dualSenseNativeGearStrength",
    "dualSenseNativeLimiterStrength",
    "dualSenseNativeSkidStrength",
    "dualSenseNativeWheelStrength",
    "dualSenseNativeCollisionStrength",
    "dualSenseNativeCurbBoost",
    "dualSenseNativeSidePitchSeparation",
    "dualSenseNativeCurbEngineDucking",
    "dualSenseNativeSkidDynamicBoost",
    "dualSenseNativeSkidThreshold",
    "dualSenseNativeSkidEngineDucking",
    "dualSenseNativeSkidAxlePitchSeparation",
    "dualSenseSlipThreshold",
    "dualSenseShiftDuration",
    "dualSenseTriggersEnabled",
    "dualSenseBrakeResistance",
    "dualSenseThrottleResistance",
    "dualSenseBrakeCurve",
    "dualSenseThrottleCurve",
    "dualSenseABSFeedback",
    "dualSenseABSFrequency",
    "dualSenseWheelspinFeedback",
    "dualSenseWheelspinThreshold",
    "dualSenseWheelspinFrequency",
    "dualSenseLimiterResistance",
    "dualSenseLimiterFrequency",
    "dualSenseShiftResistance",
    "dualSenseDownshiftThrottleKick",
}

local savedDualSenseCustomPreset = ac.storage({preset = "{}"}, "DSGA_061_CUSTOM_PRESET_")

local function decodeDualSenseCustomPreset()
    local ok, preset = pcall(_json.decode, savedDualSenseCustomPreset.preset)
    return ok and type(preset) == "table" and preset or nil
end

local function hasDualSenseCustomPreset()
    local preset = decodeDualSenseCustomPreset()
    return preset ~= nil and next(preset) ~= nil
end

local function saveDualSenseCustomPreset()
    local preset = {}
    for _, key in ipairs(dualSensePresetKeys) do
        preset[key] = uiData[key]
    end
    savedDualSenseCustomPreset.preset = _json.encode(preset)
end

local function loadDualSenseCustomPreset()
    local preset = decodeDualSenseCustomPreset()
    if preset ~= nil then applyDualSensePreset(preset) end
end

local function pushStyle()
    ui.pushFont(ui.Font.Small)
    ui.pushStyleColor(ui.StyleColor.Button, buttonColor)
    ui.pushStyleColor(ui.StyleColor.ButtonHovered, controlHoverColor)
    ui.pushStyleColor(ui.StyleColor.FrameBgHovered, controlHoverColor)
    ui.pushStyleColor(ui.StyleColor.CheckMark, controlAccentColor)
    ui.pushStyleColor(ui.StyleColor.ButtonActive, controlActiveColor)
    ui.pushStyleColor(ui.StyleColor.FrameBgActive, controlActiveColor)
    ui.pushStyleColor(ui.StyleColor.SliderGrab, buttonColor)
    ui.pushStyleColor(ui.StyleColor.SliderGrabActive, controlAccentColor)
    ui.pushStyleColor(ui.StyleColor.HeaderHovered, controlHoverColor)
    ui.pushStyleColor(ui.StyleColor.HeaderActive, controlActiveColor)
    ui.pushStyleColor(ui.StyleColor.TextSelectedBg, controlAccentColor)
    ui.pushStyleColor(ui.StyleColor.ChildBg, childBgColor)
end

local function popStyle()
    ui.popStyleColor(12)
    ui.popFont()
end

local currentPresetName   = ""
local saveFeedbackStart   = -1
local loadFeedbackStart   = -1
local deleteFeedbackStart = -1
local function drawPresetsWindow()
    ui.beginToolWindow("DSGA_presets", tmpVec1:set(ui.windowPos()):add(tmpVec2:set(0, -270)), tmpVec3:set(270, 270), false, true)

    ui.text("预设名称：")

    ui.setNextItemWidth(ui.availableSpaceX())
    currentPresetName = ui.inputText("", currentPresetName, ui.InputTextFlags.RetainSelection):gsub("%*", "")

    local loadText = "载入"
    local loadFlags = ui.ButtonFlags.None
    if loadFeedbackStart ~= -1 then
        if ui.time() - loadFeedbackStart > 1.0 then
            loadFeedbackStart = -1
        else
            ui.setNextTextBold()
            loadText = "已载入"
            loadFlags = ui.ButtonFlags.Disabled
        end
    end
    local loadClicked = ui.button(loadText, tmpVec1:set(ui.availableSpaceX() / 3.0, ui.frameHeight()), loadFlags)

    ui.sameLine()
    local saveText = "保存"
    local saveFlags = ui.ButtonFlags.None
    if saveFeedbackStart ~= -1 then
        if ui.time() - saveFeedbackStart > 1.0 then
            saveFeedbackStart = -1
        else
            ui.setNextTextBold()
            saveText = "已保存"
            saveFlags = ui.ButtonFlags.Disabled
        end
    end
    local saveClicked = ui.button(saveText, tmpVec1:set(ui.availableSpaceX() / 2.0, ui.frameHeight()), saveFlags)

    ui.sameLine()
    local deleteText = "删除"
    local deleteFlags = ui.ButtonFlags.None
    if deleteFeedbackStart ~= -1 then
        if ui.time() - deleteFeedbackStart > 1.0 then
            deleteFeedbackStart = -1
        else
            ui.setNextTextBold()
            deleteText = "已删除"
            deleteFlags = ui.ButtonFlags.Disabled
        end
    end
    local deleteClicked = ui.button(deleteText, tmpVec1:set(ui.availableSpaceX(), ui.frameHeight()), deleteFlags)

    if saveClicked and currentPresetName:len() > 0   then if savePreset(currentPresetName)   then saveFeedbackStart = ui.time() end end
    if loadClicked and currentPresetName:len() > 0   then if loadPreset(currentPresetName)   then loadFeedbackStart = ui.time() end end
    if deleteClicked and currentPresetName:len() > 0 then if deletePreset(currentPresetName) then deleteFeedbackStart = ui.time() end end

    ui.text("已保存预设：")

    local presetNames = getPresetList()

    ui.childWindow("presetList", tmpVec1:set(ui.availableSpaceX(), ui.windowHeight() - ui.getCursorY() - ui.StyleVar.WindowPadding), false, ui.WindowFlags.NoTitleBar + ui.WindowFlags.NoMove + ui.WindowFlags.NoResize, function ()
        -- ui.alignTextToFramePadding()
        showDummyLine(0.0)
        for _, preset in ipairs(presetNames) do
            local isSelected = (preset == currentPresetName or (string.startsWith(preset, "*") and string.sub(preset, 2) == currentPresetName))
            if isSelected then ui.setNextTextBold() end
            if ui.selectable(preset, isSelected) then
                currentPresetName = preset:gsub("%*", "")
            end
        end
        return 0
    end)

    popStyle()
    ui.setCursor(tmpVec1:set(270 - 20, 0))
    if ui.button("x", tmpVec1:set(20, 20)) then
        togglePresetsWindow()
    end
    pushStyle()

    ui.endToolWindow()
end

local settingsTab = 1
local steeringAdvancedExpanded = false
local telemetryExpanded = false
local resetClicked = 0
local latestFrameDt = 0.016
local advancedSettingsOpen = false
local openAdvancedSettings

local function drawGlassBackground()
    ui.drawRectFilled(zeroVec, tmpVec1:set(ui.windowWidth(), ui.windowHeight()), glassBgColor)
    ui.drawRectFilled(zeroVec, tmpVec1:set(ui.windowWidth(), 3), controlAccentColor)
    ui.drawRect(tmpVec1:set(0, 3), tmpVec2:set(ui.windowWidth(), ui.windowHeight()), glassLineColor)
end

local function drawBrandHeader()
    ui.image("img/icon.png", tmpVec1:set(52, 52), white, true)
    ui.sameLine()
    ui.text("DualSense Gamepad Assist")
    ui.pushStyleColor(ui.StyleColor.Text, mutedTextColor)
    ui.text("0.6.2 中文版")
    ui.text("Adudumax")
    ui.popStyleColor(1)
    ui.setCursorX(0)
    showDummyLine(0.20)
end

local function showStatusLine(label, value, ok)
    ui.pushStyleColor(ui.StyleColor.Text, ok and successColor or warningColor)
    ui.text(ok and "●" or "○")
    ui.popStyleColor(1)
    ui.sameLine()
    ui.text(string.format("%s：%s", label, value))
end

local function showDualSensePresetButtons()
    showButton("平衡推荐", "dualSenseBalancedPreset", loadDualSenseBalancedPreset, 0)
    showButton("细腻赛道", "dualSenseDetailPreset", loadDualSenseDetailPreset, 0)
    showButton("强烈反馈", "dualSenseStrongPreset", loadDualSenseStrongPreset, 0)
    showButton("保存当前为自定义预设", "dualSenseSaveCustomPreset", saveDualSenseCustomPreset, 0)
    showButton(hasDualSenseCustomPreset() and "载入自定义预设" or "载入自定义预设（尚未保存）",
        "dualSenseLoadCustomPreset", loadDualSenseCustomPreset, 0, nil, not hasDualSenseCustomPreset())
end

local function drawUnavailable()
    if ac.getPatchVersionCode() < 2651 then
        ui.pushStyleColor(ui.StyleColor.Text, warningColor)
        ui.textWrapped("请升级到 CSP 0.2.0 或更高版本。")
        ui.popStyleColor(1)
    elseif not lib.clampEased then
        ui.textWrapped("尚未正确安装 DualSense Gamepad Assist。")
    else
        ui.textWrapped("当前尚未启用 DualSense Gamepad Assist。")
        if (os.clock() - enableClicked) >= 3.0 then
            showDummyLine()
            showButton("启用脚本", nil, enableScript, 0)
        end
        showDummyLine()
        ui.textWrapped("如果无法启用，请确认 apps 与 extension 文件夹已经复制到 AC 根目录。")
    end
end

local function showTab(index, label, width)
    if settingsTab == index then ui.pushStyleColor(ui.StyleColor.Button, controlActiveColor) end
    local clicked = ui.button(label, tmpVec1:set(width, ui.frameHeight()))
    if settingsTab == index then ui.popStyleColor(1) end
    if clicked then settingsTab = index end
end

local function drawTabs()
    local width = (ui.availableSpaceX() - 6) / 3
    showTab(1, "转向", width)
    ui.sameLine()
    showTab(2, "反馈", width)
    ui.sameLine()
    showTab(3, "诊断", width)
    showDummyLine(0.20)
end

local function drawOverviewTab()
    ui.text("当前预设：" .. getDualSensePresetName())
    showDualSensePresetButtons()

    showHeader("整体震动")
    showConfigSlider("dualSenseGlobalStrength", "握把震动总强度", "%.f%%", 0.0, 200.0, 100.0, false, nil, 0, not uiData.dualSenseEnabled)

    showHeader("核心开关")
    showCheckbox("assistEnabled", "启用游戏手柄转向辅助", false, false, 0)
    showCheckbox("dualSenseEnabled", "启用 DualSense 反馈", false, false, 0)
    showCheckbox("dualSenseNativeHapticsEnabled", "启用 CSP 原生触觉调优", false, not uiData.dualSenseEnabled, 0)
    showCheckbox("dualSenseLegacyBodyVibration", "启用 0.5.1 兼容握把补充层", false, not uiData.dualSenseEnabled, 0)
    showCheckbox("dualSenseTriggersEnabled", "启用自适应扳机", false, not uiData.dualSenseEnabled, 0)

    showHeader("驾驶辅助")
    showCheckbox("autoClutch", "自动离合", false, false, 0)
    uiData.autoShiftingMode = showCompactDropdown("换挡模式", "autoShiftingMode", {"AC 默认", "手动", "自动"}, uiData.autoShiftingMode + 1, 0) - 1
    showCheckbox("autoShiftingCruise", "自动切换巡航模式", false, uiData.autoShiftingMode < 2, 20)
    showConfigSlider("autoShiftingDownBias", "降挡倾向", "%.f%%", 10.0, 90.0, 100.0, false, 240.0, 20, uiData.autoShiftingMode < 2)
end

function script.windowMain(dt)
    latestFrameDt = dt or latestFrameDt
    drawGlassBackground()
    pushStyle()
    drawBrandHeader()

    if not uiData._appCanRun then
        drawUnavailable()
        popStyle()
        return
    end

    showStatusLine("脚本", uiData.assistEnabled and "运行中" or "已暂停", uiData.assistEnabled)
    showStatusLine("DualSense", uiData._dualSenseDetected and "已连接" or "未识别", uiData._dualSenseDetected)
    showStatusLine("原生 Haptics API", uiData._dualSenseNativeHapticsAvailable and "可用" or "不可用", uiData._dualSenseNativeHapticsAvailable)
    showHeader("总览")
    drawOverviewTab()
    showHeader("更多")
    showButton(advancedSettingsOpen and "高级设置已打开" or "打开高级设置", "advancedSettings", openAdvancedSettings, 0, nil, advancedSettingsOpen)
    popStyle()
end

local function drawSteeringTab()
    showCheckbox("assistEnabled", "启用游戏手柄转向辅助", false, false, 0)
    showButton("重新校准转向", "calibration", sendRecalibrationEvent, 0)
    showButton(presetsWindowEnabled and "隐藏转向预设" or "显示转向预设", "presets", togglePresetsWindow, 0)
    showCheckbox("useFilter", "简化转向设置", false, false, 0)
    if uiData.useFilter then
        showConfigSlider("filterSetting", "转向辅助强度", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0)
    end

    showButton(steeringAdvancedExpanded and "收起完整转向参数" or "展开完整转向参数", nil, function ()
        steeringAdvancedExpanded = not steeringAdvancedExpanded
    end, 0)

    if steeringAdvancedExpanded then
        showHeader("转向输入")
        showConfigSlider("steeringRate", "转向速度", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0)
        showConfigSlider("rateIncreaseWithSpeed", "高速转向速度修正", "%+.f%%", -50.0, 50.0, 100.0, uiData.useFilter, nil, 0)
        showConfigSlider("targetSlip", "目标侧滑角", "%.1f%%", 90.0, 120.0, 100.0, uiData.useFilter, nil, 0)
        showConfigSlider("countersteerResponse", "反打响应", "%.f%%", 0.0, 100.0, 100.0, uiData.useFilter, nil, 0)
        showConfigSlider("maxDynamicLimitReduction", "动态转向限制", "%.f%%", 0.0, 100.0, 10.0, uiData.useFilter, nil, 0)
        showHeader("自动回正力")
        showConfigSlider("selfSteerResponse", "响应", "%.f%%", 0.0, 100.0, 100.0, uiData.useFilter, nil, 0)
        showConfigSlider("maxSelfSteerAngle", "最大角度", "%.1f°", 0.0, 90.0, 1.0, uiData.useFilter, nil, 0)
        showConfigSlider("dampingStrength", "阻尼", "%.f%%", 0.0, 100.0, 100.0, uiData.useFilter, nil, 0)
    end

    showHeader("转向工具")
    uiData.graphSelection = showCompactDropdown("辅助图表", "graphs", {"关闭", "静态", "实时"}, uiData.graphSelection, 0)
    showConfigSlider("_gameGamma", "转向 Gamma", "%.f%%", 100.0, 300.0, 100.0, false, nil, 0)
    showConfigSlider("_gameDeadzone", "摇杆死区", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0)
end

local function drawFeedbackTab()
    local nativeDisabled = not uiData.dualSenseEnabled or not uiData.dualSenseNativeHapticsEnabled
    local triggerDisabled = not uiData.dualSenseEnabled or not uiData.dualSenseTriggersEnabled

    ui.text("当前预设：" .. getDualSensePresetName())
    showCheckbox("dualSenseEnabled", "启用 DualSense 反馈", false, false, 0)
    showCheckbox("dualSenseNativeHapticsEnabled", "启用 CSP 原生触觉调优", false, not uiData.dualSenseEnabled, 0)
    showCheckbox("dualSenseTriggersEnabled", "启用自适应扳机", false, not uiData.dualSenseEnabled, 0)

    showHeader("原生触觉")
    showConfigSlider("dualSenseGlobalStrength", "握把震动总强度", "%.f%%", 0.0, 200.0, 100.0, false, nil, 0, not uiData.dualSenseEnabled)
    showConfigSlider("dualSenseNativeEngineStrength", "发动机质感", "%.f%%", 0.0, 200.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeBodyworkStrength", "车身 / 路肩反馈", "%.f%%", 0.0, 300.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeCurbBoost", "压路肩额外增强", "%.f%%", 0.0, 250.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSkidStrength", "轮胎侧滑反馈", "%.f%%", 0.0, 1000.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeGearStrength", "换挡反馈", "%.f%%", 0.0, 300.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeCollisionStrength", "碰撞冲击", "%.f%%", 0.0, 500.0, 100.0, false, nil, 0, nativeDisabled)

    showHeader("自适应扳机")
    showConfigSlider("dualSenseBrakeResistance", "L2 刹车阻力", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseThrottleResistance", "R2 油门阻力", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
end

local function drawResetButton(dt)
    local reset = showButton(resetClicked > 0 and "确认恢复出厂设置？" or "恢复全部默认设置", "factoryReset", nil, 0)
    if reset then
        if resetClicked > 0.2 then
            factoryReset()
            resetClicked = 0
        elseif resetClicked == 0 then
            resetClicked = resetClicked + dt
        end
    end
    if resetClicked > 3.0 then resetClicked = 0 end
    if resetClicked > 0 then resetClicked = resetClicked + dt end
end

local function drawTelemetry()
    ui.textWrapped(string.format("CSP 原始 ndSlip：FL %.0f%% / FR %.0f%% / RL %.0f%% / RR %.0f%%",
        uiData._dualSenseSlipFL * 100.0,
        uiData._dualSenseSlipFR * 100.0,
        uiData._dualSenseSlipRL * 100.0,
        uiData._dualSenseSlipRR * 100.0))
    ui.textWrapped(string.format("原生路肩：L %.0f%% / R %.0f%%，Bodywork 实时增益 %.0f%%，音调 %.2f",
        uiData._dualSenseNativeCurbLeft * 100.0,
        uiData._dualSenseNativeCurbRight * 100.0,
        uiData._dualSenseNativeBodyworkGain * 100.0,
        uiData._dualSenseNativeBodyworkPitch))
    ui.textWrapped(string.format("原生侧滑：动态强度 %.0f%%，Skid 实时增益 %.0f%%，音调 %.2f",
        uiData._dualSenseNativeSkidIntensity * 100.0,
        uiData._dualSenseNativeSkidGain * 100.0,
        uiData._dualSenseNativeSkidPitch))
end

local function drawDiagnosticsTab(dt)
    local nativeDisabled = not uiData.dualSenseEnabled or not uiData.dualSenseNativeHapticsEnabled
    local triggerDisabled = not uiData.dualSenseEnabled or not uiData.dualSenseTriggersEnabled

    showHeader("原生层隔离测试")
    ui.textWrapped(string.format("Haptics API：%s，测试层 %s，剩余 %.1f 秒",
        uiData._dualSenseNativeHapticsAvailable and "可用" or "不可用",
        nativeHapticTestModeLabel(),
        uiData._dualSenseNativeTestSeconds))
    showButton("测试：Engine 层强化 10 秒", "dualSenseTestNativeEngine", testDualSenseNativeEngine, 0)
    showButton("隔离：仅 Wheel 层 15 秒", "dualSenseTestNativeWheel", testDualSenseNativeWheel, 0)
    showButton("隔离：仅 Bodywork 层 15 秒", "dualSenseTestNativeBodywork", testDualSenseNativeBodywork, 0)
    showButton("隔离：仅 Skid 层 15 秒", "dualSenseTestNativeSkid", testDualSenseNativeSkid, 0)

    showButton(telemetryExpanded and "收起实时遥测" or "展开实时遥测", nil, function ()
        telemetryExpanded = not telemetryExpanded
    end, 0)
    if telemetryExpanded then drawTelemetry() end

    showHeader("原生触觉细项")
    showConfigSlider("dualSenseNativeBodyworkStrength", "原生车身 / 路面冲击", "%.f%%", 0.0, 300.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeEngineStrength", "原生发动机层", "%.f%%", 0.0, 200.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeGearStrength", "原生换挡层", "%.f%%", 0.0, 300.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeLimiterStrength", "原生红线层", "%.f%%", 0.0, 300.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSkidStrength", "原生轮胎打滑层", "%.f%%", 0.0, 1000.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeWheelStrength", "原生 Wheel 层", "%.f%%", 0.0, 500.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeCollisionStrength", "原生碰撞层", "%.f%%", 0.0, 500.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeCurbBoost", "路肩 Bodywork 额外增强", "%.f%%", 0.0, 250.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSidePitchSeparation", "左右路肩音调辨识", "%.f%%", 0.0, 35.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeCurbEngineDucking", "路肩时发动机降噪", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSkidDynamicBoost", "侧滑动态额外增强", "%.f%%", 0.0, 200.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSkidThreshold", "侧滑动态增强阈值", "%.f%%", 90.0, 170.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSkidEngineDucking", "侧滑时发动机降噪", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSkidAxlePitchSeparation", "推头 / 甩尾音调辨识", "%.f%%", 0.0, 30.0, 100.0, false, nil, 0, nativeDisabled)

    showHeader("自适应扳机细项")
    showConfigSlider("dualSenseShiftDuration", "换挡回弹持续时间", "%.f ms", 60.0, 180.0, 1000.0, false, nil, 0, not uiData.dualSenseEnabled)
    showConfigSlider("dualSenseSlipThreshold", "L2 前轮锁死判断阈值", "%.f%%", 45.0, 140.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseBrakeResistance", "L2 刹车基础阻力", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseBrakeCurve", "L2 刹车阻力曲线", "%.2f", 50.0, 250.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseABSFeedback", "L2 ABS 脉冲深度", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseABSFrequency", "ABS 脉冲速度", "%.f Hz", 6.0, 30.0, 1.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseThrottleResistance", "R2 油门基础阻力", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseThrottleCurve", "R2 油门阻力曲线", "%.2f", 50.0, 250.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseWheelspinFeedback", "R2 驱动轮打滑脉冲", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseWheelspinThreshold", "驱动轮打滑阈值", "%.f%%", 75.0, 175.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseWheelspinFrequency", "驱动轮打滑脉冲速度", "%.f Hz", 6.0, 35.0, 1.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseLimiterResistance", "R2 红线脉冲强度", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseLimiterFrequency", "R2 红线脉冲速度", "%.f Hz", 8.0, 45.0, 1.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseShiftResistance", "R2 升挡回弹强度", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseDownshiftThrottleKick", "R2 降挡补油提示", "%.f%%", 0.0, 60.0, 100.0, false, nil, 0, triggerDisabled)

    showHeader("其他工具")
    uiData.keyboardMode = showCompactDropdown("键盘模式", "keyboardMode", {"关闭", "开启", "开启（刹车辅助）", "开启（油门与刹车辅助）"}, uiData.keyboardMode + 1, 0) - 1
    showCheckbox("photoMode", "拍照模式", false, false, 0)
    showConfigSlider("_gameRumble", "AC 原生震动", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0)
    if uiData._gameRumble < 0.05 then
        ui.pushStyleColor(ui.StyleColor.Text, warningColor)
        ui.textWrapped("AC 原生震动接近 0%，握把触觉可能被缩放到静音。")
        ui.popStyleColor(1)
        showButton("将 AC 原生震动设为 100%", "dualSenseEnableACRumble", enableACRumbleForDualSense, 0)
    end
    drawResetButton(dt)
end

local function drawAdvancedSettings()
    drawGlassBackground()
    pushStyle()
    drawBrandHeader()
    if not uiData._appCanRun then
        drawUnavailable()
        popStyle()
        return
    end

    drawTabs()
    local scrollHeight = math.max(ui.windowHeight() - ui.getCursorY() - 4, 220)
    ui.childWindow("DGA_advanced_settings_scroll", tmpVec1:set(ui.availableSpaceX(), scrollHeight), false, ui.WindowFlags.NoTitleBar, function ()
        if settingsTab == 1 then
            drawSteeringTab()
        elseif settingsTab == 2 then
            drawFeedbackTab()
        else
            drawDiagnosticsTab(latestFrameDt)
        end
        return 0
    end)

    if uiData.graphSelection > 1 then
        drawSelfSteerCurve()
        if uiData.graphSelection == 3 then
            drawInputBar()
            drawLimitReductionBar()
            drawFrontSlipBar()
            drawRearSlipBar()
        end
    end
    if presetsWindowEnabled then drawPresetsWindow() end
    popStyle()
end

openAdvancedSettings = function ()
    if advancedSettingsOpen then return end
    advancedSettingsOpen = true
    ui.popup(drawAdvancedSettings, {
        title = "DualSense Gamepad Assist - 高级设置",
        size = {
            initial = vec2(620, 700),
            min = vec2(420, 420),
            max = vec2(980, 840),
        },
        backgroundColor = glassBgColor,
        parentless = true,
        onClose = function ()
            advancedSettingsOpen = false
        end,
    })
end

ac.onSharedEvent("DSGA_reloadControlSettings", function ()
    ac.reloadControlSettings()
end)

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
    _dualSenseCurbLeft       = ac.StructItem.double(),
    _dualSenseCurbRight      = ac.StructItem.double(),
    _dualSenseOutputLeft     = ac.StructItem.double(),
    _dualSenseOutputRight    = ac.StructItem.double(),
    _dualSenseDetected       = ac.StructItem.boolean(),
    _dualSenseTestActive     = ac.StructItem.boolean(),
    _dualSenseRumbleEffects  = ac.StructItem.double(),
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
    graphSelection           = ac.StructItem.int32(),
    keyboardMode             = ac.StructItem.int32(),
    autoClutch               = ac.StructItem.boolean(),
    autoShiftingMode         = ac.StructItem.int32(),
    autoShiftingCruise       = ac.StructItem.boolean(),
    autoShiftingDownBias     = ac.StructItem.double(),
    dualSenseEnabled         = ac.StructItem.boolean(),
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
    dualSenseNativeMasterStrength = ac.StructItem.double(),
    dualSenseBodyVibration   = ac.StructItem.boolean(),
    dualSenseBodyStrength    = ac.StructItem.double(),
    dualSenseBodyOutputBoost = ac.StructItem.double(),
    dualSenseBodyDetailStacking = ac.StructItem.double(),
    dualSenseBodyMinimumOutput = ac.StructItem.double(),
    dualSenseEngineStrength  = ac.StructItem.double(),
    dualSenseRoadStrength    = ac.StructItem.double(),
    dualSenseSlideStrength   = ac.StructItem.double(),
    dualSenseGripLossStrength = ac.StructItem.double(),
    dualSenseFrontSlipStrength = ac.StructItem.double(),
    dualSenseRearSlipStrength = ac.StructItem.double(),
    dualSenseSlipThreshold   = ac.StructItem.double(),
    dualSenseCurbStrength    = ac.StructItem.double(),
    dualSenseDirectionalCrossfeed = ac.StructItem.double(),
    dualSenseDirtStrength    = ac.StructItem.double(),
    dualSenseCollisionStrength = ac.StructItem.double(),
    dualSenseABSStrength     = ac.StructItem.double(),
    dualSenseShiftStrength   = ac.StructItem.double(),
    dualSenseDownshiftStrength = ac.StructItem.double(),
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
    dualSenseTriggerMasterStrength = ac.StructItem.double(),
    dualSenseBrakeDeadzone = ac.StructItem.double(),
    dualSenseThrottleDeadzone = ac.StructItem.double(),
    dualSenseBrakeForceFloor = ac.StructItem.double(),
    dualSenseThrottleForceFloor = ac.StructItem.double(),
    dualSenseBrakeWallAt = ac.StructItem.double(),
    dualSenseThrottleWallAt = ac.StructItem.double(),
    dualSenseBrakeWallForce = ac.StructItem.double(),
    dualSenseThrottleWallForce = ac.StructItem.double(),
    dualSensePulseReleaseDepth = ac.StructItem.double(),
    dualSensePulsePeakForce = ac.StructItem.double(),
    useFilter                = ac.StructItem.boolean(),
    filterSetting            = ac.StructItem.double(),
    steeringRate             = ac.StructItem.double(),
    targetSlip               = ac.StructItem.double(),
    rateIncreaseWithSpeed    = ac.StructItem.double(),
    selfSteerResponse        = ac.StructItem.double(),
    dampingStrength          = ac.StructItem.double(),
    maxSelfSteerAngle        = ac.StructItem.double(),
    countersteerResponse     = ac.StructItem.double(),
    maxDynamicLimitReduction = ac.StructItem.double(),
    gyroSteeringEnabled      = ac.StructItem.boolean(),
    gyroSteeringSensitivity  = ac.StructItem.double(),
    gyroSteeringDeadzone     = ac.StructItem.double(),
    gyroSteeringSmoothing    = ac.StructItem.double(),
    gyroSteeringCentering    = ac.StructItem.double(),
    gyroSteeringMaxAngle     = ac.StructItem.double(),
    gyroSteeringHighSpeedStability = ac.StructItem.double(),
    gyroSteeringStickBlend   = ac.StructItem.double(),
    gyroSteeringInvert       = ac.StructItem.boolean(),
    _gyroSteeringAvailable   = ac.StructItem.boolean(),
    _gyroSteeringRaw         = ac.StructItem.double(),
    _gyroSteeringOutput      = ac.StructItem.double(),
    photoMode                = ac.StructItem.boolean()
}

local white = rgbm(1, 1, 1, 1)
local muted = rgbm(0.66, 0.73, 0.84, 1)
local accent = rgbm(0.12, 0.53, 1.0, 1)
local success = rgbm(0.35, 0.88, 0.66, 1)
local warning = rgbm(1.0, 0.68, 0.24, 1)
local glassBg = rgbm(0.025, 0.055, 0.105, 0.82)
local cardBg = rgbm(0.08, 0.14, 0.23, 0.62)
local cardBorder = rgbm(0.32, 0.60, 0.96, 0.24)
local buttonBg = rgbm(0.12, 0.26, 0.43, 0.78)
local buttonHover = rgbm(0.12, 0.53, 1.0, 0.72)
local buttonActive = rgbm(0.10, 0.43, 0.88, 0.90)
local tmp1 = vec2()
local tmp2 = vec2()
local advancedSettingsOpen = false
local steeringPresetsOpen = false
local advancedTab = 1
local openAdvancedSettings
local resetArmedAt = 0
local enableClickedAt = 0
local customPresetSavedAt = 0
local customPresetLoadedAt = 0
local gyroAdvancedOpen = false

local balancedPreset = {
    dualSenseEnabled = true,
    dualSenseNativeHapticsEnabled = true,
    dualSenseNativeBodyworkStrength = 1.15,
    dualSenseNativeEngineStrength = 0.30,
    dualSenseNativeGearStrength = 1.55,
    dualSenseNativeLimiterStrength = 1.45,
    dualSenseNativeSkidStrength = 6.80,
    dualSenseNativeWheelStrength = 0.95,
    dualSenseNativeCollisionStrength = 3.80,
    dualSenseNativeCurbBoost = 1.55,
    dualSenseNativeSidePitchSeparation = 0.14,
    dualSenseNativeCurbEngineDucking = 0.64,
    dualSenseNativeSkidDynamicBoost = 0.95,
    dualSenseNativeSkidThreshold = 0.92,
    dualSenseNativeSkidEngineDucking = 0.58,
    dualSenseNativeSkidAxlePitchSeparation = 0.10,
    dualSenseNativeMasterStrength = 1.25,
    dualSenseBodyVibration = true,
    dualSenseBodyStrength = 1.00,
    dualSenseBodyOutputBoost = 1.35,
    dualSenseBodyDetailStacking = 0.42,
    dualSenseBodyMinimumOutput = 0.12,
    dualSenseEngineStrength = 0.06,
    dualSenseRoadStrength = 0.78,
    dualSenseSlideStrength = 0.82,
    dualSenseGripLossStrength = 1.12,
    dualSenseFrontSlipStrength = 1.08,
    dualSenseRearSlipStrength = 1.18,
    dualSenseSlipThreshold = 0.58,
    dualSenseCurbStrength = 1.25,
    dualSenseDirectionalCrossfeed = 0.10,
    dualSenseDirtStrength = 0.88,
    dualSenseCollisionStrength = 1.20,
    dualSenseABSStrength = 1.00,
    dualSenseShiftStrength = 0.92,
    dualSenseDownshiftStrength = 0.84,
    dualSenseShiftDuration = 0.130,
    dualSenseTriggersEnabled = true,
    dualSenseBrakeResistance = 0.40,
    dualSenseThrottleResistance = 0.14,
    dualSenseBrakeCurve = 1.05,
    dualSenseThrottleCurve = 1.15,
    dualSenseABSFeedback = 1.00,
    dualSenseABSFrequency = 16.0,
    dualSenseWheelspinFeedback = 1.00,
    dualSenseWheelspinThreshold = 0.88,
    dualSenseWheelspinFrequency = 20.0,
    dualSenseLimiterResistance = 0.78,
    dualSenseLimiterFrequency = 28.0,
    dualSenseShiftResistance = 0.95,
    dualSenseDownshiftThrottleKick = 0.28,
    dualSenseTriggerMasterStrength = 1.08,
    dualSenseBrakeDeadzone = 0.035,
    dualSenseThrottleDeadzone = 0.025,
    dualSenseBrakeForceFloor = 0.07,
    dualSenseThrottleForceFloor = 0.035,
    dualSenseBrakeWallAt = 0.88,
    dualSenseThrottleWallAt = 0.97,
    dualSenseBrakeWallForce = 0.72,
    dualSenseThrottleWallForce = 0.18,
    dualSensePulseReleaseDepth = 0.92,
    dualSensePulsePeakForce = 0.68,
}

local function clone(source)
    local result = {}
    for key, value in pairs(source) do result[key] = value end
    return result
end

local function override(target, values)
    for key, value in pairs(values) do target[key] = value end
    return target
end

local comfortPreset = override(clone(balancedPreset), {
    dualSenseBodyStrength = 0.72,
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
    dualSenseNativeMasterStrength = 1.08,
    dualSenseBodyOutputBoost = 1.12,
    dualSenseBodyDetailStacking = 0.30,
    dualSenseBodyMinimumOutput = 0.08,
    dualSenseEngineStrength = 0.025,
    dualSenseRoadStrength = 0.52,
    dualSenseGripLossStrength = 0.88,
    dualSenseFrontSlipStrength = 0.94,
    dualSenseRearSlipStrength = 0.96,
    dualSenseSlipThreshold = 0.72,
    dualSenseABSStrength = 0.68,
    dualSenseShiftStrength = 0.52,
    dualSenseBrakeResistance = 0.32,
    dualSenseShiftResistance = 0.72,
    dualSenseTriggerMasterStrength = 0.96,
    dualSenseBrakeForceFloor = 0.05,
    dualSenseThrottleForceFloor = 0.025,
    dualSensePulseReleaseDepth = 0.88,
    dualSensePulsePeakForce = 0.56,
})

local strongPreset = override(clone(balancedPreset), {
    dualSenseNativeBodyworkStrength = 1.35,
    dualSenseNativeGearStrength = 1.80,
    dualSenseNativeLimiterStrength = 1.70,
    dualSenseNativeSkidStrength = 7.20,
    dualSenseNativeWheelStrength = 1.20,
    dualSenseNativeCollisionStrength = 4.40,
    dualSenseNativeCurbBoost = 1.85,
    dualSenseNativeSkidDynamicBoost = 1.08,
    dualSenseNativeMasterStrength = 1.40,
    dualSenseBodyStrength = 1.12,
    dualSenseBodyOutputBoost = 1.55,
    dualSenseBodyDetailStacking = 0.50,
    dualSenseBodyMinimumOutput = 0.16,
    dualSenseRoadStrength = 0.92,
    dualSenseSlideStrength = 0.92,
    dualSenseGripLossStrength = 1.24,
    dualSenseFrontSlipStrength = 1.18,
    dualSenseRearSlipStrength = 1.30,
    dualSenseSlipThreshold = 0.55,
    dualSenseCurbStrength = 1.45,
    dualSenseCollisionStrength = 1.35,
    dualSenseABSStrength = 1.12,
    dualSenseShiftStrength = 1.08,
    dualSenseDownshiftStrength = 1.00,
    dualSenseWheelspinFeedback = 1.08,
    dualSenseLimiterResistance = 0.88,
    dualSenseShiftResistance = 1.08,
    dualSenseTriggerMasterStrength = 1.28,
    dualSensePulsePeakForce = 0.76,
})

local presets = {
    {name = "平衡", values = balancedPreset},
    {name = "舒适", values = comfortPreset},
    {name = "强劲", values = strongPreset},
}

local function applyPreset(values)
    for key, value in pairs(values) do uiData[key] = value end
end

local function matchesPreset(values)
    for key, value in pairs(values) do
        local current = uiData[key]
        if type(value) == "boolean" then
            if current ~= value then return false end
        elseif math.abs(current - value) > 1e-4 then
            return false
        end
    end
    return true
end

local function currentPresetName()
    for _, preset in ipairs(presets) do
        if matchesPreset(preset.values) then return preset.name end
    end
    return "自定义"
end

local feedbackPresetKeys = {
    "dualSenseEnabled",
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
    "dualSenseNativeMasterStrength",
    "dualSenseBodyVibration",
    "dualSenseBodyStrength",
    "dualSenseBodyOutputBoost",
    "dualSenseBodyDetailStacking",
    "dualSenseBodyMinimumOutput",
    "dualSenseEngineStrength",
    "dualSenseRoadStrength",
    "dualSenseSlideStrength",
    "dualSenseGripLossStrength",
    "dualSenseFrontSlipStrength",
    "dualSenseRearSlipStrength",
    "dualSenseSlipThreshold",
    "dualSenseCurbStrength",
    "dualSenseDirectionalCrossfeed",
    "dualSenseDirtStrength",
    "dualSenseCollisionStrength",
    "dualSenseABSStrength",
    "dualSenseShiftStrength",
    "dualSenseDownshiftStrength",
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
    "dualSenseTriggerMasterStrength",
    "dualSenseBrakeDeadzone",
    "dualSenseThrottleDeadzone",
    "dualSenseBrakeForceFloor",
    "dualSenseThrottleForceFloor",
    "dualSenseBrakeWallAt",
    "dualSenseThrottleWallAt",
    "dualSenseBrakeWallForce",
    "dualSenseThrottleWallForce",
    "dualSensePulseReleaseDepth",
    "dualSensePulsePeakForce",
}

local customPresetStorage = ac.storage({preset = "{}"}, "DSGA_UI_105_CUSTOM_PRESET_")

local function decodeCustomPreset()
    local ok, preset = pcall(_json.decode, customPresetStorage.preset)
    return ok and type(preset) == "table" and preset or nil
end

local function hasCustomPreset()
    local preset = decodeCustomPreset()
    return preset ~= nil and next(preset) ~= nil
end

local function saveCustomPreset()
    local preset = {}
    for _, key in ipairs(feedbackPresetKeys) do preset[key] = uiData[key] end
    customPresetStorage.preset = _json.encode(preset)
    customPresetSavedAt = os.clock()
end

local function loadCustomPreset()
    local preset = decodeCustomPreset()
    if preset == nil then return end
    for _, key in ipairs(feedbackPresetKeys) do
        if preset[key] ~= nil then uiData[key] = preset[key] end
    end
    customPresetLoadedAt = os.clock()
end

local function pushStyle()
    ui.pushFont(ui.Font.Small)
    ui.pushStyleColor(ui.StyleColor.Button, buttonBg)
    ui.pushStyleColor(ui.StyleColor.ButtonHovered, buttonHover)
    ui.pushStyleColor(ui.StyleColor.ButtonActive, buttonActive)
    ui.pushStyleColor(ui.StyleColor.FrameBg, rgbm(0.08, 0.15, 0.24, 0.84))
    ui.pushStyleColor(ui.StyleColor.FrameBgHovered, rgbm(0.12, 0.28, 0.44, 0.92))
    ui.pushStyleColor(ui.StyleColor.FrameBgActive, buttonActive)
    ui.pushStyleColor(ui.StyleColor.CheckMark, accent)
    ui.pushStyleColor(ui.StyleColor.SliderGrab, rgbm(0.46, 0.73, 1.0, 0.95))
    ui.pushStyleColor(ui.StyleColor.SliderGrabActive, accent)
    ui.pushStyleColor(ui.StyleColor.ChildBg, rgbm(0.02, 0.05, 0.10, 0.40))
end

local function popStyle()
    ui.popStyleColor(10)
    ui.popFont()
end

local function drawBackground()
    ui.drawRectFilled(tmp1:set(0, 0), tmp2:set(ui.windowWidth(), ui.windowHeight()), glassBg)
end

local function colorText(text, color)
    ui.pushStyleColor(ui.StyleColor.Text, color)
    ui.text(text)
    ui.popStyleColor(1)
end

local function wrappedColorText(text, color)
    ui.pushStyleColor(ui.StyleColor.Text, color)
    ui.textWrapped(text)
    ui.popStyleColor(1)
end

local function beginCard(height)
    local start = ui.getCursor()
    local cardStart = vec2(start.x, start.y)
    ui.drawRectFilled(cardStart, tmp1:set(cardStart.x + ui.availableSpaceX(), cardStart.y + height), cardBg)
    ui.drawRect(cardStart, tmp1:set(cardStart.x + ui.availableSpaceX(), cardStart.y + height), cardBorder)
    ui.setCursor(tmp1:set(cardStart.x + 12, cardStart.y + 9))
    return cardStart
end

local function endCard(start, height)
    ui.setCursor(tmp1:set(start.x, start.y + height + 8))
end

local function checkbox(key, label, disabled)
    if disabled then ui.pushDisabled() end
    local value = uiData[key]
    if ui.checkbox(label, value) and not disabled then uiData[key] = not value end
    if disabled then ui.popDisabled() end
end

local function slider(key, label, minValue, maxValue, mult, format, disabled)
    mult = mult or 100
    format = format or "%.0f%%"
    ui.setNextItemWidth(math.max(80, ui.availableSpaceX() - 12))
    if disabled then ui.pushDisabled() end
    local value, changed = ui.slider("##" .. key, uiData[key] * mult, minValue, maxValue, label .. ": " .. format)
    if disabled then ui.popDisabled() end
    if changed and not disabled then uiData[key] = value / mult end
end

local function scaleSlider(id, label, mappings, maxValue)
    local anchor = mappings[1]
    local display = anchor.base > 0 and uiData[anchor.key] / anchor.base * 100 or 0
    ui.setNextItemWidth(math.max(80, ui.availableSpaceX() - 12))
    local value, changed = ui.slider("##scale_" .. id, display, 0, maxValue or 180, label .. ": %.0f%%")
    if changed then
        local scale = value / 100
        for _, mapping in ipairs(mappings) do
            uiData[mapping.key] = mapping.base * scale
        end
    end
end

local function fullButton(label, callback)
    if ui.button(label, tmp1:set(ui.availableSpaceX() - 12, ui.frameHeight())) then callback() end
end

local function rowButtons(items)
    local width = (ui.availableSpaceX() - 20) / #items
    for index, item in ipairs(items) do
        if item.disabled then ui.pushDisabled() end
        if ui.button(item.label, tmp1:set(width, ui.frameHeight())) and not item.disabled then item.callback() end
        if item.disabled then ui.popDisabled() end
        if index < #items then ui.sameLine() end
    end
end

local function section(title)
    ui.dummy(tmp1:set(1, 4))
    colorText(title, accent)
end

local function nativeTestLabel()
    if uiData._dualSenseNativeTestSeconds <= 0 then return "待机" end
    local labels = {"Engine", "Wheel", "Bodywork", "Skid"}
    return labels[uiData._dualSenseNativeTestMode] or "未知"
end

local function enableScript()
    local file = "\\gamepad_fx.ini"
    local sectionName = "JOYPAD_ASSIST"
    if ac.getPatchVersionCode() < 2260 then
        file = "\\joypad_assist.ini"
        sectionName = "BASIC"
    end
    local gamepadIni = ac.INIConfig.load(ac.getFolder(ac.FolderID.ExtCfgUser) .. file)
    local controlsIni = ac.INIConfig.load(ac.getFolder(ac.FolderID.Cfg) .. "\\controls.ini")
    gamepadIni:set(sectionName, "ENABLED", 1)
    gamepadIni:set(sectionName, "IMPLEMENTATION", "DualSense Gamepad Assist")
    gamepadIni:save(ac.getFolder(ac.FolderID.ExtCfgUser) .. file)
    controlsIni:set("HEADER", "INPUT_METHOD", "X360")
    controlsIni:save()
    enableClickedAt = os.clock()
    ac.reloadControlSettings()
end

local function renderUnavailable()
    drawBackground()
    ui.image("img/icon.png", tmp1:set(58, 58), white, true)
    ui.sameLine()
    ui.setNextTextBold()
    ui.text("DualSense Gamepad Assist")
    ui.dummy(tmp1:set(1, 8))
    if ac.getPatchVersionCode() < 2651 then
        wrappedColorText("需要 CSP 0.2.0 或更高版本。建议使用 CSP 0.3.0 Preview 361 或更新版本。", warning)
        return
    end
    wrappedColorText("当前尚未启用本脚本。点击下方按钮后，CSP 会选择 DualSense Gamepad Assist 作为 Gamepad FX 实现。", muted)
    ui.dummy(tmp1:set(1, 8))
    if os.clock() - enableClickedAt > 2 then
        fullButton("启用 DualSense Gamepad Assist", enableScript)
    else
        colorText("正在重新加载控制器设置...", success)
    end
end

local function renderHeader()
    local start = ui.getCursor()
    ui.image("img/icon.png", tmp1:set(48, 48), white, true)
    ui.setCursor(tmp1:set(start.x + 58, start.y + 5))
    ui.setNextTextBold()
    ui.text("DualSense Gamepad Assist")
    ui.setCursor(tmp1:set(start.x + 58, start.y + 30))
    colorText("当前预设  " .. currentPresetName(), accent)
    ui.setCursor(tmp1:set(start.x, start.y + 56))
end

local function renderPresetCard()
    local card = beginCard(108)
    colorText("手感预设", accent)
    rowButtons({
        {label = "平衡", callback = function() applyPreset(balancedPreset) end},
        {label = "舒适", callback = function() applyPreset(comfortPreset) end},
        {label = "强劲", callback = function() applyPreset(strongPreset) end},
    })
    ui.dummy(tmp1:set(1, 4))
    rowButtons({
        {label = "保存自定义", callback = saveCustomPreset},
        {label = hasCustomPreset() and "载入自定义" or "载入自定义", callback = loadCustomPreset, disabled = not hasCustomPreset()},
    })
    if os.clock() - customPresetSavedAt < 1.5 then
        colorText("已保存当前手感为自定义预设", success)
    elseif os.clock() - customPresetLoadedAt < 1.5 then
        colorText("已载入自定义预设", success)
    elseif not hasCustomPreset() then
        colorText("自定义预设尚未保存", muted)
    end
    endCard(card, 108)
end

local function renderStatusCard()
    local card = beginCard(116)
    colorText("运行状态", accent)
    checkbox("assistEnabled", "启用游戏手柄转向辅助", uiData.gyroSteeringEnabled)
    checkbox("gyroSteeringEnabled", "陀螺仪精准转向")
    checkbox("dualSenseEnabled", "启用 DualSense 触觉反馈")
    checkbox("dualSenseNativeHapticsEnabled", "启用 CSP 原生 USB 触觉层", not uiData.dualSenseEnabled)
    endCard(card, 116)
end

local function renderMainControls()
    local card = beginCard(176)
    colorText("握把反馈", accent)
    scaleSlider("engine", "发动机质感", {
        {key = "dualSenseNativeEngineStrength", base = 0.30},
        {key = "dualSenseEngineStrength", base = 0.06},
    }, 180)
    scaleSlider("curb", "路肩纹理", {
        {key = "dualSenseNativeCurbBoost", base = 1.55},
        {key = "dualSenseCurbStrength", base = 1.25},
    }, 180)
    scaleSlider("road", "路面细节", {
        {key = "dualSenseNativeBodyworkStrength", base = 1.15},
        {key = "dualSenseRoadStrength", base = 0.78},
        {key = "dualSenseDirtStrength", base = 0.88},
    }, 180)
    scaleSlider("skid", "轮胎侧滑", {
        {key = "dualSenseNativeSkidStrength", base = 6.80},
        {key = "dualSenseNativeSkidDynamicBoost", base = 0.95},
        {key = "dualSenseSlideStrength", base = 0.82},
        {key = "dualSenseGripLossStrength", base = 1.12},
        {key = "dualSenseFrontSlipStrength", base = 1.08},
        {key = "dualSenseRearSlipStrength", base = 1.18},
    }, 180)
    scaleSlider("collision", "碰撞冲击", {
        {key = "dualSenseNativeCollisionStrength", base = 3.80},
        {key = "dualSenseCollisionStrength", base = 1.20},
    }, 180)
    scaleSlider("shift", "换挡冲击", {
        {key = "dualSenseNativeGearStrength", base = 1.55},
        {key = "dualSenseShiftStrength", base = 0.92},
        {key = "dualSenseDownshiftStrength", base = 0.84},
    }, 180)
    endCard(card, 176)
end

local function renderTriggerCard()
    local card = beginCard(145)
    colorText("自适应扳机", accent)
    checkbox("dualSenseTriggersEnabled", "启用 L2 / R2 动态阻力", not uiData.dualSenseEnabled)
    slider("dualSenseBrakeResistance", "L2 刹车阻力", 0, 100, 100, "%.0f%%", not uiData.dualSenseTriggersEnabled)
    slider("dualSenseThrottleResistance", "R2 油门阻力", 0, 100, 100, "%.0f%%", not uiData.dualSenseTriggersEnabled)
    slider("dualSenseABSFeedback", "ABS 踏板脉冲", 0, 100, 100, "%.0f%%", not uiData.dualSenseTriggersEnabled)
    slider("dualSenseWheelspinFeedback", "驱动轮空转脉冲", 0, 100, 100, "%.0f%%", not uiData.dualSenseTriggersEnabled)
    endCard(card, 145)
end

local function renderMain()
    renderHeader()
    renderStatusCard()
    renderPresetCard()
    renderMainControls()
    renderTriggerCard()
    if uiData._gameRumble < 0.05 then
        wrappedColorText("AC 原生震动接近 0%，握把反馈可能被静音。请在高级设置中恢复为 100%。", warning)
    end
    fullButton("高级设置", openAdvancedSettings)
end

local steeringPresets = {
    {
        name = "默认转向",
        hint = "通用手柄驾驶，保留简化转向设置。",
        values = {
            useFilter = true,
            filterSetting = 0.50,
            steeringRate = 0.50,
            rateIncreaseWithSpeed = 0.10,
            targetSlip = 0.95,
            countersteerResponse = 0.20,
            maxDynamicLimitReduction = 5.0,
            selfSteerResponse = 0.37,
            maxSelfSteerAngle = 14.0,
            dampingStrength = 0.37,
        },
    },
    {
        name = "稳定转向",
        hint = "更强回正和阻尼，适合高速稳定与新手。",
        values = {
            useFilter = false,
            filterSetting = 0.50,
            steeringRate = 0.35,
            rateIncreaseWithSpeed = 0.00,
            targetSlip = 0.93,
            countersteerResponse = 0.15,
            maxDynamicLimitReduction = 6.0,
            selfSteerResponse = 0.65,
            maxSelfSteerAngle = 90.0,
            dampingStrength = 0.75,
        },
    },
    {
        name = "灵活转向",
        hint = "响应更快、限制更少，适合熟悉手柄后微调。",
        values = {
            useFilter = false,
            filterSetting = 0.45,
            steeringRate = 0.55,
            rateIncreaseWithSpeed = 0.05,
            targetSlip = 0.98,
            countersteerResponse = 0.30,
            maxDynamicLimitReduction = 4.5,
            selfSteerResponse = 0.32,
            maxSelfSteerAngle = 70.0,
            dampingStrength = 0.35,
        },
    },
    {
        name = "漂移转向",
        hint = "更容易反打和维持大角度，日常跑圈不建议默认使用。",
        values = {
            useFilter = false,
            filterSetting = 0.50,
            steeringRate = 0.40,
            rateIncreaseWithSpeed = 0.10,
            targetSlip = 1.00,
            countersteerResponse = 0.50,
            maxDynamicLimitReduction = 4.0,
            selfSteerResponse = 0.35,
            maxSelfSteerAngle = 90.0,
            dampingStrength = 0.50,
        },
    },
}

local function applySteeringPreset(preset)
    for key, value in pairs(preset.values) do uiData[key] = value end
end

local function renderSteeringPresetsPopup(dt)
    pushStyle()
    drawBackground()
    colorText("转向辅助预设", accent)
    wrappedColorText("这些只调整手柄转向辅助参数，不改变 DualSense 震动和扳机反馈。", muted)
    ui.dummy(tmp1:set(1, 6))
    for _, preset in ipairs(steeringPresets) do
        fullButton(preset.name, function() applySteeringPreset(preset) end)
        wrappedColorText(preset.hint, muted)
        ui.dummy(tmp1:set(1, 4))
    end
    popStyle()
end

local function openSteeringPresets()
    if steeringPresetsOpen then return end
    steeringPresetsOpen = true
    ui.popup(renderSteeringPresetsPopup, {
        title = "DualSense Gamepad Assist - 转向辅助预设",
        size = {
            initial = vec2(460, 420),
            min = vec2(360, 300),
            max = vec2(640, 620),
        },
        backgroundColor = glassBg,
        parentless = true,
        onClose = function() steeringPresetsOpen = false end,
    })
end

local function renderNativeDetails()
    section("CSP 原生触觉层")
    checkbox("dualSenseNativeHapticsEnabled", "启用原生 USB 触觉优化", not uiData.dualSenseEnabled)
    local disabled = not uiData.dualSenseEnabled or not uiData.dualSenseNativeHapticsEnabled
    slider("dualSenseNativeMasterStrength", "原生层总增益", 50, 200, 100, "%.0f%%", disabled)
    slider("dualSenseNativeBodyworkStrength", "Bodywork 车身 / 路面", 0, 300, 100, "%.0f%%", disabled)
    slider("dualSenseNativeEngineStrength", "Engine 发动机", 0, 200, 100, "%.0f%%", disabled)
    slider("dualSenseNativeGearStrength", "Gear 换挡", 0, 300, 100, "%.0f%%", disabled)
    slider("dualSenseNativeLimiterStrength", "Limiter 红线", 0, 300, 100, "%.0f%%", disabled)
    slider("dualSenseNativeSkidStrength", "Skid 轮胎侧滑", 0, 900, 100, "%.0f%%", disabled)
    slider("dualSenseNativeWheelStrength", "Wheel 车轮层", 0, 500, 100, "%.0f%%", disabled)
    slider("dualSenseNativeCollisionStrength", "Collision 碰撞", 0, 500, 100, "%.0f%%", disabled)
    slider("dualSenseNativeCurbBoost", "路肩 Bodywork 额外增强", 0, 250, 100, "%.0f%%", disabled)
    slider("dualSenseNativeSidePitchSeparation", "左右路肩音调辨识", 0, 35, 100, "%.0f%%", disabled)
    slider("dualSenseNativeCurbEngineDucking", "压路肩时发动机降噪", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseNativeSkidDynamicBoost", "侧滑 Skid 动态增强", 0, 200, 100, "%.0f%%", disabled)
    slider("dualSenseNativeSkidThreshold", "侧滑增强阈值", 90, 170, 100, "%.0f%%", disabled)
    slider("dualSenseNativeSkidEngineDucking", "侧滑时发动机降噪", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseNativeSkidAxlePitchSeparation", "推头 / 甩尾音调辨识", 0, 30, 100, "%.0f%%", disabled)
end

local function renderDrivingDetails()
    section("驾驶辅助")
    checkbox("gyroSteeringEnabled", "陀螺仪精准转向")
    if uiData.gyroSteeringEnabled then
        wrappedColorText("建议保持预设参数。启用陀螺仪后，传统转向辅助会暂停，震动、扳机和自动离合仍会保留。", warning)
    else
        wrappedColorText("陀螺仪关闭时使用常规转向辅助；打开后会切换到更直接的精准转向模式。", muted)
    end
    fullButton("校准陀螺仪中位", function() ac.broadcastSharedEvent("DSGA_resetGyroCenter") end)
    ui.textWrapped(string.format("陀螺仪状态：%s | 原始 %.0f%% | 输出 %.0f%%",
        uiData._gyroSteeringAvailable and "可用" or "未检测到",
        uiData._gyroSteeringRaw * 100,
        uiData._gyroSteeringOutput * 100))
    fullButton(gyroAdvancedOpen and "收起陀螺仪高级参数" or "陀螺仪高级参数", function() gyroAdvancedOpen = not gyroAdvancedOpen end)
    if gyroAdvancedOpen then
        wrappedColorText("这里保留 Gyrosteer 原版灵敏度入口，用于熟悉该脚本的玩家微调手感。", muted)
        slider("gyroSteeringSensitivity", "Gyrosteer 灵敏度", 10, 150, 100, "%.0f%%", not uiData.gyroSteeringEnabled)
        checkbox("gyroSteeringInvert", "反向陀螺仪", not uiData.gyroSteeringEnabled)
    end

    section("转向辅助")
    local gyroMode = uiData.gyroSteeringEnabled
    checkbox("assistEnabled", "启用游戏手柄转向辅助", gyroMode)
    rowButtons({
        {label = "重新校准转向", callback = function() ac.broadcastSharedEvent("DSGA_calibrateSteering") end, disabled = gyroMode or not uiData.assistEnabled},
        {label = steeringPresetsOpen and "转向辅助预设已打开" or "转向辅助预设", callback = openSteeringPresets, disabled = gyroMode or steeringPresetsOpen},
    })
    checkbox("useFilter", "简化转向设置", gyroMode or not uiData.assistEnabled)
    if uiData.useFilter then
        slider("filterSetting", "转向辅助强度", 0, 100, 100, "%.0f%%", gyroMode or not uiData.assistEnabled)
        wrappedColorText("开启简化时，完整转向参数会由这个强度滑块自动联动。", muted)
    else
        section("完整转向参数")
        slider("steeringRate", "转向速度", 0, 100, 100, "%.0f%%", gyroMode or not uiData.assistEnabled)
        slider("rateIncreaseWithSpeed", "高速转向速度修正", -50, 50, 100, "%+.0f%%", gyroMode or not uiData.assistEnabled)
        slider("targetSlip", "目标侧滑角", 90, 120, 100, "%.1f%%", gyroMode or not uiData.assistEnabled)
        slider("countersteerResponse", "反打响应", 0, 100, 100, "%.0f%%", gyroMode or not uiData.assistEnabled)
        slider("maxDynamicLimitReduction", "动态转向限制", 0, 100, 10, "%.0f%%", gyroMode or not uiData.assistEnabled)
        section("自动回正")
        slider("selfSteerResponse", "自动回正响应", 0, 100, 100, "%.0f%%", gyroMode or not uiData.assistEnabled)
        slider("maxSelfSteerAngle", "最大回正角度", 0, 90, 1, "%.0f°", gyroMode or not uiData.assistEnabled)
        slider("dampingStrength", "回正阻尼", 0, 100, 100, "%.0f%%", gyroMode or not uiData.assistEnabled)
    end
    checkbox("autoClutch", "启用自动离合")
end

local function renderCompatibilityDetails()
    section("兼容通道细节")
    checkbox("dualSenseBodyVibration", "启用遥测驱动的兼容震动", not uiData.dualSenseEnabled)
    local disabled = not uiData.dualSenseEnabled or not uiData.dualSenseBodyVibration
    slider("dualSenseBodyStrength", "兼容通道总强度", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseBodyOutputBoost", "兼容输出增益", 60, 220, 100, "%.0f%%", disabled)
    slider("dualSenseBodyDetailStacking", "多层细节软叠加", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseBodyMinimumOutput", "最低可感输出", 0, 30, 100, "%.0f%%", disabled)
    slider("dualSenseEngineStrength", "兼容发动机底噪", 0, 40, 100, "%.0f%%", disabled)
    slider("dualSenseRoadStrength", "普通路面 / 悬挂细节", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseSlideStrength", "轮胎摩擦 / 轻微侧滑", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseGripLossStrength", "明显失抓提示", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseFrontSlipStrength", "前轮失抓 / 推头", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseRearSlipStrength", "后轮失抓 / 甩尾", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseSlipThreshold", "失抓触发阈值", 45, 140, 100, "%.0f%%", disabled)
    slider("dualSenseCurbStrength", "路肩震动", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseDirectionalCrossfeed", "单侧路肩串扰", 0, 50, 100, "%.0f%%", disabled)
    slider("dualSenseDirtStrength", "草地 / 泥地震动", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseCollisionStrength", "碰撞冲击", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseABSStrength", "ABS 握把脉冲", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseShiftStrength", "升挡握把冲击", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseDownshiftStrength", "降挡握把冲击", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseShiftDuration", "换挡回弹持续时间", 60, 180, 1000, "%.0f ms", disabled)
end

local function renderTriggerDetails()
    section("自适应扳机细节")
    checkbox("dualSenseTriggersEnabled", "启用自适应扳机", not uiData.dualSenseEnabled)
    local disabled = not uiData.dualSenseEnabled or not uiData.dualSenseTriggersEnabled
    slider("dualSenseTriggerMasterStrength", "扳机总增益", 50, 180, 100, "%.0f%%", disabled)
    slider("dualSenseBrakeResistance", "L2 刹车基础阻力", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseBrakeCurve", "L2 刹车阻力曲线", 50, 250, 100, "%.2f", disabled)
    slider("dualSenseBrakeDeadzone", "L2 清空死区", 0, 15, 100, "%.1f%%", disabled)
    slider("dualSenseBrakeForceFloor", "L2 初段力度地板", 0, 35, 100, "%.0f%%", disabled)
    slider("dualSenseBrakeWallAt", "L2 硬墙触发位置", 55, 98, 100, "%.0f%%", disabled)
    slider("dualSenseBrakeWallForce", "L2 硬墙力度", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseThrottleResistance", "R2 油门基础阻力", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseThrottleCurve", "R2 油门阻力曲线", 50, 250, 100, "%.2f", disabled)
    slider("dualSenseThrottleDeadzone", "R2 清空死区", 0, 15, 100, "%.1f%%", disabled)
    slider("dualSenseThrottleForceFloor", "R2 初段力度地板", 0, 30, 100, "%.0f%%", disabled)
    slider("dualSenseThrottleWallAt", "R2 末段压紧位置", 55, 98, 100, "%.0f%%", disabled)
    slider("dualSenseThrottleWallForce", "R2 末段压紧力度", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseABSFeedback", "L2 ABS 脉冲深度", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseABSFrequency", "ABS 脉冲速度", 6, 30, 1, "%.0f Hz", disabled)
    slider("dualSensePulseReleaseDepth", "脉冲释放深度", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSensePulsePeakForce", "脉冲回压峰值", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseWheelspinFeedback", "R2 驱动轮空转脉冲", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseWheelspinThreshold", "驱动轮空转阈值", 75, 175, 100, "%.0f%%", disabled)
    slider("dualSenseWheelspinFrequency", "驱动轮空转脉冲速度", 6, 35, 1, "%.0f Hz", disabled)
    slider("dualSenseLimiterResistance", "R2 红线脉冲强度", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseLimiterFrequency", "R2 红线脉冲速度", 8, 45, 1, "%.0f Hz", disabled)
    slider("dualSenseShiftResistance", "R2 升挡回弹强度", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseDownshiftThrottleKick", "R2 降挡补油提示", 0, 60, 100, "%.0f%%", disabled)
end

local function renderDiagnostics()
    section("实时诊断")
    ui.textWrapped(string.format("原生 Haptics API：%s | 测试层：%s | 剩余：%.1f 秒",
        uiData._dualSenseNativeHapticsAvailable and "可用" or "不可用",
        nativeTestLabel(),
        uiData._dualSenseNativeTestSeconds))
    ui.textWrapped(string.format("轮胎 ndSlip：FL %.0f%% / FR %.0f%% / RL %.0f%% / RR %.0f%%",
        uiData._dualSenseSlipFL * 100,
        uiData._dualSenseSlipFR * 100,
        uiData._dualSenseSlipRL * 100,
        uiData._dualSenseSlipRR * 100))
    ui.textWrapped(string.format("路肩：L %.0f%% / R %.0f%% | Bodywork %.0f%% | 音调 %.2f",
        uiData._dualSenseNativeCurbLeft * 100,
        uiData._dualSenseNativeCurbRight * 100,
        uiData._dualSenseNativeBodyworkGain * 100,
        uiData._dualSenseNativeBodyworkPitch))
    ui.textWrapped(string.format("侧滑：动态 %.0f%% | Skid %.0f%% | 音调 %.2f",
        uiData._dualSenseNativeSkidIntensity * 100,
        uiData._dualSenseNativeSkidGain * 100,
        uiData._dualSenseNativeSkidPitch))
    ui.textWrapped(string.format("AC 原生震动 %.0f%% | 兼容输出 L %.0f%% / R %.0f%%",
        uiData._gameRumble * 100,
        uiData._dualSenseOutputLeft * 100,
        uiData._dualSenseOutputRight * 100))

    section("原生层测试")
    fullButton("测试：Engine 发动机层强化 10 秒", function() ac.broadcastSharedEvent("DSGA_testDualSenseNativeEngine") end)
    fullButton("测试：仅 Wheel 层 15 秒", function() ac.broadcastSharedEvent("DSGA_testDualSenseNativeWheel") end)
    fullButton("测试：仅 Bodywork 层 15 秒", function() ac.broadcastSharedEvent("DSGA_testDualSenseNativeBodywork") end)
    fullButton("测试：仅 Skid 层 15 秒", function() ac.broadcastSharedEvent("DSGA_testDualSenseNativeSkid") end)

    section("兼容通道测试")
    wrappedColorText("部分 DualSense USB 驱动只输出 CSP 原生层。以下按钮主要用于兼容性诊断。", muted)
    fullButton("模拟：路肩", function() ac.broadcastSharedEvent("DSGA_testDualSenseCurb") end)
    fullButton("模拟：前轮推头", function() ac.broadcastSharedEvent("DSGA_testDualSenseFrontSlip") end)
    fullButton("模拟：后轮甩尾", function() ac.broadcastSharedEvent("DSGA_testDualSenseRearSlip") end)
end

local function renderSystemDetails()
    section("系统与恢复")
    slider("_gameRumble", "AC 原生震动", 0, 100, 100, "%.0f%%")
    fullButton("将 AC 原生震动恢复为 100%", function() uiData._gameRumble = 1 end)
    if resetArmedAt > 0 and os.clock() - resetArmedAt < 3 then
        fullButton("确认恢复平衡推荐默认设置", function()
            ac.broadcastSharedEvent("DSGA_factoryReset")
            resetArmedAt = 0
        end)
    else
        fullButton("恢复默认设置", function() resetArmedAt = os.clock() end)
    end
end

local advancedTabs = {
    {label = "驾驶辅助"},
    {label = "握把反馈"},
    {label = "自适应扳机"},
    {label = "诊断与恢复"},
}

local function renderAdvancedTabs()
    local items = {}
    for index, tab in ipairs(advancedTabs) do
        local label = tab.label
        if advancedTab == index then label = "[" .. label .. "]" end
        items[#items + 1] = {
            label = label,
            callback = function() advancedTab = index end,
        }
    end
    rowButtons(items)
    ui.dummy(tmp1:set(1, 6))
end

local function renderAdvanced(includeBack)
    if includeBack then
        rowButtons({
            {label = "载入平衡推荐", callback = function() applyPreset(balancedPreset) end},
        })
        ui.dummy(tmp1:set(1, 4))
    end
    colorText("高级设置", accent)
    wrappedColorText("这里保留逐层参数、运行诊断和测试入口。常用驾驶只需要主界面的预设和几组滑块。", muted)
    renderAdvancedTabs()
    ui.childWindow("advanced_scroll", tmp1:set(ui.availableSpaceX(), math.max(120, ui.windowHeight() - ui.getCursorY() - 4)), false, ui.WindowFlags.NoTitleBar, function()
        if advancedTab == 1 then
            renderDrivingDetails()
        elseif advancedTab == 2 then
            renderNativeDetails()
            renderCompatibilityDetails()
        elseif advancedTab == 3 then
            renderTriggerDetails()
        else
            renderDiagnostics()
            renderSystemDetails()
        end
    end)
end

local function renderAdvancedPopup(dt)
    pushStyle()
    drawBackground()
    renderAdvanced(false)
    popStyle()
end

openAdvancedSettings = function()
    if advancedSettingsOpen then return end
    advancedSettingsOpen = true
    ui.popup(renderAdvancedPopup, {
        title = "DualSense Gamepad Assist - 高级设置",
        size = {
            initial = vec2(620, 700),
            min = vec2(420, 420),
            max = vec2(980, 840),
        },
        backgroundColor = glassBg,
        parentless = true,
        onClose = function() advancedSettingsOpen = false end,
    })
end

function script.windowMain(dt)
    pushStyle()
    drawBackground()
    if not uiData._appCanRun then
        renderUnavailable()
    else
        renderMain()
    end
    popStyle()
end

function script.windowSettings(dt)
    if not uiData._appCanRun then return end
    pushStyle()
    drawBackground()
    renderAdvanced(false)
    popStyle()
end

ac.onSharedEvent("DSGA_reloadControlSettings", function()
    ac.reloadControlSettings()
end)

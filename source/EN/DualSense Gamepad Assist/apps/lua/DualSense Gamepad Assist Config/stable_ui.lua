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
    {name = "Balanced", values = balancedPreset},
    {name = "Comfort", values = comfortPreset},
    {name = "Strong", values = strongPreset},
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
    return "Custom"
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
    if uiData._dualSenseNativeTestSeconds <= 0 then return "Idle" end
    local labels = {"Engine", "Wheel", "Bodywork", "Skid"}
    return labels[uiData._dualSenseNativeTestMode] or "Unknown"
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
        wrappedColorText("CSP 0.2.0 or newer is required. CSP 0.3.0 Preview 361 or newer is recommended.", warning)
        return
    end
    wrappedColorText("This script is not enabled yet. Use the button below and CSP will select DualSense Gamepad Assist as the Gamepad FX implementation.", muted)
    ui.dummy(tmp1:set(1, 8))
    if os.clock() - enableClickedAt > 2 then
        fullButton("Enable DualSense Gamepad Assist", enableScript)
    else
        colorText("Reloading controller settings...", success)
    end
end

local function renderHeader()
    local start = ui.getCursor()
    ui.image("img/icon.png", tmp1:set(48, 48), white, true)
    ui.setCursor(tmp1:set(start.x + 58, start.y + 5))
    ui.setNextTextBold()
    ui.text("DualSense Gamepad Assist")
    ui.setCursor(tmp1:set(start.x + 58, start.y + 30))
    colorText("Current preset  " .. currentPresetName(), accent)
    ui.setCursor(tmp1:set(start.x, start.y + 56))
end

local function renderPresetCard()
    local card = beginCard(108)
    colorText("Feel presets", accent)
    rowButtons({
        {label = "Balanced", callback = function() applyPreset(balancedPreset) end},
        {label = "Comfort", callback = function() applyPreset(comfortPreset) end},
        {label = "Strong", callback = function() applyPreset(strongPreset) end},
    })
    ui.dummy(tmp1:set(1, 4))
    rowButtons({
        {label = "Save custom", callback = saveCustomPreset},
        {label = hasCustomPreset() and "Load custom" or "Load custom", callback = loadCustomPreset, disabled = not hasCustomPreset()},
    })
    if os.clock() - customPresetSavedAt < 1.5 then
        colorText("Saved current feel as a custom preset", success)
    elseif os.clock() - customPresetLoadedAt < 1.5 then
        colorText("Loaded custom preset", success)
    elseif not hasCustomPreset() then
        colorText("No custom preset has been saved yet", muted)
    end
    endCard(card, 108)
end

local function renderStatusCard()
    local card = beginCard(116)
    colorText("Status", accent)
    checkbox("assistEnabled", "Enable gamepad steering assist", uiData.gyroSteeringEnabled)
    checkbox("gyroSteeringEnabled", "Precision gyro steering")
    checkbox("dualSenseEnabled", "Enable DualSense haptic feedback")
    checkbox("dualSenseNativeHapticsEnabled", "Enable CSP native USB haptic layer", not uiData.dualSenseEnabled)
    endCard(card, 116)
end

local function renderMainControls()
    local card = beginCard(176)
    colorText("Grip feedback", accent)
    scaleSlider("engine", "Engine texture", {
        {key = "dualSenseNativeEngineStrength", base = 0.30},
        {key = "dualSenseEngineStrength", base = 0.06},
    }, 180)
    scaleSlider("curb", "Curb texture", {
        {key = "dualSenseNativeCurbBoost", base = 1.55},
        {key = "dualSenseCurbStrength", base = 1.25},
    }, 180)
    scaleSlider("road", "Road detail", {
        {key = "dualSenseNativeBodyworkStrength", base = 1.15},
        {key = "dualSenseRoadStrength", base = 0.78},
        {key = "dualSenseDirtStrength", base = 0.88},
    }, 180)
    scaleSlider("skid", "Tire skid", {
        {key = "dualSenseNativeSkidStrength", base = 6.80},
        {key = "dualSenseNativeSkidDynamicBoost", base = 0.95},
        {key = "dualSenseSlideStrength", base = 0.82},
        {key = "dualSenseGripLossStrength", base = 1.12},
        {key = "dualSenseFrontSlipStrength", base = 1.08},
        {key = "dualSenseRearSlipStrength", base = 1.18},
    }, 180)
    scaleSlider("collision", "Collision impact", {
        {key = "dualSenseNativeCollisionStrength", base = 3.80},
        {key = "dualSenseCollisionStrength", base = 1.20},
    }, 180)
    scaleSlider("shift", "Shift impact", {
        {key = "dualSenseNativeGearStrength", base = 1.55},
        {key = "dualSenseShiftStrength", base = 0.92},
        {key = "dualSenseDownshiftStrength", base = 0.84},
    }, 180)
    endCard(card, 176)
end

local function renderTriggerCard()
    local card = beginCard(145)
    colorText("Adaptive triggers", accent)
    checkbox("dualSenseTriggersEnabled", "Enable L2 / R2 dynamic resistance", not uiData.dualSenseEnabled)
    slider("dualSenseBrakeResistance", "L2 brake resistance", 0, 100, 100, "%.0f%%", not uiData.dualSenseTriggersEnabled)
    slider("dualSenseThrottleResistance", "R2 throttle resistance", 0, 100, 100, "%.0f%%", not uiData.dualSenseTriggersEnabled)
    slider("dualSenseABSFeedback", "ABS pedal pulse", 0, 100, 100, "%.0f%%", not uiData.dualSenseTriggersEnabled)
    slider("dualSenseWheelspinFeedback", "Drive-wheel slip pulse", 0, 100, 100, "%.0f%%", not uiData.dualSenseTriggersEnabled)
    endCard(card, 145)
end

local function renderMain()
    renderHeader()
    renderStatusCard()
    renderPresetCard()
    renderMainControls()
    renderTriggerCard()
    if uiData._gameRumble < 0.05 then
        wrappedColorText("AC native rumble is close to 0%, so grip feedback might be muted. Restore it to 100% in advanced settings.", warning)
    end
    fullButton("Advanced settings", openAdvancedSettings)
end

local steeringPresets = {
    {
        name = "Default steering",
        hint = "General gamepad driving with simplified steering settings.",
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
        name = "Stable steering",
        hint = "Stronger centering and damping for high-speed stability and new players.",
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
        name = "Agile steering",
        hint = "Quicker response with fewer limits for experienced gamepad tuning.",
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
        name = "Drift steering",
        hint = "Easier countersteer and large-angle control; not recommended as a default grip-driving preset.",
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
    colorText("Steering assist presets", accent)
    wrappedColorText("These only adjust gamepad steering-assist parameters. DualSense vibration and trigger feedback are unchanged.", muted)
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
        title = "DualSense Gamepad Assist - Steering assist presets",
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
    section("CSP native haptic layer")
    checkbox("dualSenseNativeHapticsEnabled", "Enable native USB haptic optimization", not uiData.dualSenseEnabled)
    local disabled = not uiData.dualSenseEnabled or not uiData.dualSenseNativeHapticsEnabled
    slider("dualSenseNativeMasterStrength", "Native layer master gain", 50, 200, 100, "%.0f%%", disabled)
    slider("dualSenseNativeBodyworkStrength", "Bodywork chassis / road", 0, 300, 100, "%.0f%%", disabled)
    slider("dualSenseNativeEngineStrength", "Engine", 0, 200, 100, "%.0f%%", disabled)
    slider("dualSenseNativeGearStrength", "Gear shift", 0, 300, 100, "%.0f%%", disabled)
    slider("dualSenseNativeLimiterStrength", "Rev limiter", 0, 300, 100, "%.0f%%", disabled)
    slider("dualSenseNativeSkidStrength", "Skid tire slip", 0, 900, 100, "%.0f%%", disabled)
    slider("dualSenseNativeWheelStrength", "Wheel layer", 0, 500, 100, "%.0f%%", disabled)
    slider("dualSenseNativeCollisionStrength", "Collision", 0, 500, 100, "%.0f%%", disabled)
    slider("dualSenseNativeCurbBoost", "Extra curb Bodywork boost", 0, 250, 100, "%.0f%%", disabled)
    slider("dualSenseNativeSidePitchSeparation", "Left/right curb pitch separation", 0, 35, 100, "%.0f%%", disabled)
    slider("dualSenseNativeCurbEngineDucking", "Engine ducking on curbs", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseNativeSkidDynamicBoost", "Dynamic Skid boost on slip", 0, 200, 100, "%.0f%%", disabled)
    slider("dualSenseNativeSkidThreshold", "Slip boost threshold", 90, 170, 100, "%.0f%%", disabled)
    slider("dualSenseNativeSkidEngineDucking", "Engine ducking on slip", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseNativeSkidAxlePitchSeparation", "Understeer / oversteer pitch separation", 0, 30, 100, "%.0f%%", disabled)
end

local function renderDrivingDetails()
    section("Driving assist")
    checkbox("gyroSteeringEnabled", "Precision gyro steering")
    if uiData.gyroSteeringEnabled then
        wrappedColorText("Preset values are recommended. When gyro steering is enabled, traditional steering assist is paused while vibration, triggers, and auto clutch stay active.", warning)
    else
        wrappedColorText("With gyro off, regular steering assist is used. With gyro on, steering switches to a more direct precision mode.", muted)
    end
    fullButton("Calibrate gyro center", function() ac.broadcastSharedEvent("DSGA_resetGyroCenter") end)
    ui.textWrapped(string.format("Gyro status: %s | Raw %.0f%% | Output %.0f%%",
        uiData._gyroSteeringAvailable and "Available" or "Not detected",
        uiData._gyroSteeringRaw * 100,
        uiData._gyroSteeringOutput * 100))
    fullButton(gyroAdvancedOpen and "Collapse gyro advanced settings" or "Gyro advanced settings", function() gyroAdvancedOpen = not gyroAdvancedOpen end)
    if gyroAdvancedOpen then
        wrappedColorText("This keeps the original Gyrosteer sensitivity entry for players familiar with that script.", muted)
        slider("gyroSteeringSensitivity", "Gyrosteer sensitivity", 10, 150, 100, "%.0f%%", not uiData.gyroSteeringEnabled)
        checkbox("gyroSteeringInvert", "Invert gyro", not uiData.gyroSteeringEnabled)
    end

    section("Steering assist")
    local gyroMode = uiData.gyroSteeringEnabled
    checkbox("assistEnabled", "Enable gamepad steering assist", gyroMode)
    rowButtons({
        {label = "Recalibrate steering", callback = function() ac.broadcastSharedEvent("DSGA_calibrateSteering") end, disabled = gyroMode or not uiData.assistEnabled},
        {label = steeringPresetsOpen and "Steering presets already open" or "Steering assist presets", callback = openSteeringPresets, disabled = gyroMode or steeringPresetsOpen},
    })
    checkbox("useFilter", "Simplified steering settings", gyroMode or not uiData.assistEnabled)
    if uiData.useFilter then
        slider("filterSetting", "Steering assist strength", 0, 100, 100, "%.0f%%", gyroMode or not uiData.assistEnabled)
        wrappedColorText("When simplified mode is enabled, the detailed steering parameters are linked to this strength slider.", muted)
    else
        section("Detailed steering parameters")
        slider("steeringRate", "Steering speed", 0, 100, 100, "%.0f%%", gyroMode or not uiData.assistEnabled)
        slider("rateIncreaseWithSpeed", "High-speed steering-rate adjustment", -50, 50, 100, "%+.0f%%", gyroMode or not uiData.assistEnabled)
        slider("targetSlip", "Target slip angle", 90, 120, 100, "%.1f%%", gyroMode or not uiData.assistEnabled)
        slider("countersteerResponse", "Countersteer response", 0, 100, 100, "%.0f%%", gyroMode or not uiData.assistEnabled)
        slider("maxDynamicLimitReduction", "Dynamic steering limit", 0, 100, 10, "%.0f%%", gyroMode or not uiData.assistEnabled)
        section("Self centering")
        slider("selfSteerResponse", "Self-centering response", 0, 100, 100, "%.0f%%", gyroMode or not uiData.assistEnabled)
        slider("maxSelfSteerAngle", "Maximum self-centering angle", 0, 90, 1, "%.0f°", gyroMode or not uiData.assistEnabled)
        slider("dampingStrength", "Self-centering damping", 0, 100, 100, "%.0f%%", gyroMode or not uiData.assistEnabled)
    end
    checkbox("autoClutch", "Enable auto clutch")
end

local function renderCompatibilityDetails()
    section("Compatibility channel details")
    checkbox("dualSenseBodyVibration", "Enable telemetry-driven compatibility vibration", not uiData.dualSenseEnabled)
    local disabled = not uiData.dualSenseEnabled or not uiData.dualSenseBodyVibration
    slider("dualSenseBodyStrength", "Compatibility channel master strength", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseBodyOutputBoost", "Compatibility output gain", 60, 220, 100, "%.0f%%", disabled)
    slider("dualSenseBodyDetailStacking", "Soft stacking for detail layers", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseBodyMinimumOutput", "Minimum perceptible output", 0, 30, 100, "%.0f%%", disabled)
    slider("dualSenseEngineStrength", "Compatibility engine texture", 0, 40, 100, "%.0f%%", disabled)
    slider("dualSenseRoadStrength", "Road / suspension detail", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseSlideStrength", "Tire scrub / light slip", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseGripLossStrength", "Grip-loss cue", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseFrontSlipStrength", "Front slip / understeer", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseRearSlipStrength", "Rear slip / oversteer", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseSlipThreshold", "Grip-loss trigger threshold", 45, 140, 100, "%.0f%%", disabled)
    slider("dualSenseCurbStrength", "Curb vibration", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseDirectionalCrossfeed", "Single-side curb crossfeed", 0, 50, 100, "%.0f%%", disabled)
    slider("dualSenseDirtStrength", "Grass / dirt vibration", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseCollisionStrength", "Collision impact", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseABSStrength", "ABS grip pulse", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseShiftStrength", "Upshift grip impact", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseDownshiftStrength", "Downshift grip impact", 0, 150, 100, "%.0f%%", disabled)
    slider("dualSenseShiftDuration", "Shift rebound duration", 60, 180, 1000, "%.0f ms", disabled)
end

local function renderTriggerDetails()
    section("Adaptive trigger details")
    checkbox("dualSenseTriggersEnabled", "Enable adaptive triggers", not uiData.dualSenseEnabled)
    local disabled = not uiData.dualSenseEnabled or not uiData.dualSenseTriggersEnabled
    slider("dualSenseTriggerMasterStrength", "Trigger master gain", 50, 180, 100, "%.0f%%", disabled)
    slider("dualSenseBrakeResistance", "L2 brake base resistance", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseBrakeCurve", "L2 brake resistance curve", 50, 250, 100, "%.2f", disabled)
    slider("dualSenseBrakeDeadzone", "L2 release deadzone", 0, 15, 100, "%.1f%%", disabled)
    slider("dualSenseBrakeForceFloor", "L2 initial force floor", 0, 35, 100, "%.0f%%", disabled)
    slider("dualSenseBrakeWallAt", "L2 wall trigger position", 55, 98, 100, "%.0f%%", disabled)
    slider("dualSenseBrakeWallForce", "L2 wall force", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseThrottleResistance", "R2 throttle base resistance", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseThrottleCurve", "R2 throttle resistance curve", 50, 250, 100, "%.2f", disabled)
    slider("dualSenseThrottleDeadzone", "R2 release deadzone", 0, 15, 100, "%.1f%%", disabled)
    slider("dualSenseThrottleForceFloor", "R2 initial force floor", 0, 30, 100, "%.0f%%", disabled)
    slider("dualSenseThrottleWallAt", "R2 end-travel tightening point", 55, 98, 100, "%.0f%%", disabled)
    slider("dualSenseThrottleWallForce", "R2 end-travel tightening force", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseABSFeedback", "L2 ABS pulse depth", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseABSFrequency", "ABS pulse speed", 6, 30, 1, "%.0f Hz", disabled)
    slider("dualSensePulseReleaseDepth", "Pulse release depth", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSensePulsePeakForce", "Pulse peak return force", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseWheelspinFeedback", "R2 drive-wheel slip pulse", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseWheelspinThreshold", "Drive-wheel slip threshold", 75, 175, 100, "%.0f%%", disabled)
    slider("dualSenseWheelspinFrequency", "Drive-wheel slip pulse speed", 6, 35, 1, "%.0f Hz", disabled)
    slider("dualSenseLimiterResistance", "R2 rev-limiter pulse strength", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseLimiterFrequency", "R2 rev-limiter pulse speed", 8, 45, 1, "%.0f Hz", disabled)
    slider("dualSenseShiftResistance", "R2 upshift rebound strength", 0, 100, 100, "%.0f%%", disabled)
    slider("dualSenseDownshiftThrottleKick", "R2 downshift throttle-blip cue", 0, 60, 100, "%.0f%%", disabled)
end

local function renderDiagnostics()
    section("Live diagnostics")
    ui.textWrapped(string.format("Native Haptics API: %s | Test layer: %s | Remaining: %.1f s",
        uiData._dualSenseNativeHapticsAvailable and "Available" or "Unavailable",
        nativeTestLabel(),
        uiData._dualSenseNativeTestSeconds))
    ui.textWrapped(string.format("Tire ndSlip: FL %.0f%% / FR %.0f%% / RL %.0f%% / RR %.0f%%",
        uiData._dualSenseSlipFL * 100,
        uiData._dualSenseSlipFR * 100,
        uiData._dualSenseSlipRL * 100,
        uiData._dualSenseSlipRR * 100))
    ui.textWrapped(string.format("Curb: L %.0f%% / R %.0f%% | Bodywork %.0f%% | Pitch %.2f",
        uiData._dualSenseNativeCurbLeft * 100,
        uiData._dualSenseNativeCurbRight * 100,
        uiData._dualSenseNativeBodyworkGain * 100,
        uiData._dualSenseNativeBodyworkPitch))
    ui.textWrapped(string.format("Slip: Dynamic %.0f%% | Skid %.0f%% | Pitch %.2f",
        uiData._dualSenseNativeSkidIntensity * 100,
        uiData._dualSenseNativeSkidGain * 100,
        uiData._dualSenseNativeSkidPitch))
    ui.textWrapped(string.format("AC native rumble %.0f%% | Compatibility output L %.0f%% / R %.0f%%",
        uiData._gameRumble * 100,
        uiData._dualSenseOutputLeft * 100,
        uiData._dualSenseOutputRight * 100))

    section("Native layer tests")
    fullButton("Test: boost Engine layer for 10 s", function() ac.broadcastSharedEvent("DSGA_testDualSenseNativeEngine") end)
    fullButton("Test: Wheel layer only for 15 s", function() ac.broadcastSharedEvent("DSGA_testDualSenseNativeWheel") end)
    fullButton("Test: Bodywork layer only for 15 s", function() ac.broadcastSharedEvent("DSGA_testDualSenseNativeBodywork") end)
    fullButton("Test: Skid layer only for 15 s", function() ac.broadcastSharedEvent("DSGA_testDualSenseNativeSkid") end)

    section("Compatibility channel tests")
    wrappedColorText("Some DualSense USB paths only output CSP native layers. These buttons are mainly for compatibility diagnostics.", muted)
    fullButton("Simulate: curb", function() ac.broadcastSharedEvent("DSGA_testDualSenseCurb") end)
    fullButton("Simulate: front understeer", function() ac.broadcastSharedEvent("DSGA_testDualSenseFrontSlip") end)
    fullButton("Simulate: rear oversteer", function() ac.broadcastSharedEvent("DSGA_testDualSenseRearSlip") end)
end

local function renderSystemDetails()
    section("System and restore")
    slider("_gameRumble", "AC native rumble", 0, 100, 100, "%.0f%%")
    fullButton("Restore AC native rumble to 100%", function() uiData._gameRumble = 1 end)
    if resetArmedAt > 0 and os.clock() - resetArmedAt < 3 then
        fullButton("Confirm restoring balanced defaults", function()
            ac.broadcastSharedEvent("DSGA_factoryReset")
            resetArmedAt = 0
        end)
    else
        fullButton("Restore defaults", function() resetArmedAt = os.clock() end)
    end
end

local advancedTabs = {
    {label = "Driving assist"},
    {label = "Grip feedback"},
    {label = "Adaptive triggers"},
    {label = "Diagnostics and restore"},
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
            {label = "Load balanced recommendation", callback = function() applyPreset(balancedPreset) end},
        })
        ui.dummy(tmp1:set(1, 4))
    end
    colorText("Advanced settings", accent)
    wrappedColorText("This keeps per-layer parameters, diagnostics, and test entries. Normal driving only needs the main-page presets and sliders.", muted)
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
        title = "DualSense Gamepad Assist - Advanced settings",
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

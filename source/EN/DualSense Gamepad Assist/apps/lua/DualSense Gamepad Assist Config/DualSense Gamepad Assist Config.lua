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
    factoryReset             = "RESETS EVERY SETTING TO ITS DEFAULT VALUE, INCLUDING THE ONES BELOW!\nClick twice to confirm!",
    lockedNote               = "Locked. Uncheck 'Simplified settings' to adjust manually!",
    presets                  = "This is where you can save or load presets!\n\nPresets starting with a * character are factory presets that cannot be changed or deleted.",
    calibration              = "Not necessary since calibration happens automatically when the car spawns, but you can do it again from here just in case something isn't right.\n\nYou must stop the car before doing this!",
    graphs                   = "Shows graphs to visualize what the steering assist is doing.\nThey can either be static or updated with live values.",
    assistEnabled            = "Enables or disables the entire assist.\n\nIf unchecked, AC's built-in input processing is used without any change.",
    useFilter                = "Provides a single slider that will adjust most settings automatically for you.",
    autoClutch               = "Automatically controls the clutch if the engine would otherwise stall, or when setting off from a standstill.\n\nThis setting doesn't affect gear changes, that part is controlled by the 'Shifting mode' setting.",
    autoShiftingMode         = "Default = AC's own gear shifting, no change.\n\nManual = custom rev-matching and clutch logic (if the car allows it), but manual shifting only.\n\nAutomatic = custom rev-matching and clutch logic (if the car allows it), as well as automatic gear shifting. You can still shift manually to override a gear for a short time though.\n\nThe 'Automatic' mode uses a custom algorithm which also takes the engine's power curve into account for optimal shifting points.\n\nIMPORTANT: Options other than 'Default' only work properly if 'Automatic shifting' is DISABLED in AC's assist settings!",
    autoShiftingCruise       = "Allows the automatic shifting to go between cruise mode and performance mode depending on your throttle input.\n\nUseful if you want to do both performance driving and casual cruising, but you can disable it for racing (especially for rolling starts).",
    autoShiftingDownBias     = "Higher = more aggressive downshifting when using automatic mode.\n\nFor example at the maximum setting the car will downshift almost immediately when you brake for a turn, however, this might leave you very close to the top of a gear when going back on the throttle again.\n\nIn most cases I recommend leaving this at maximum.",
    dualSenseBalancedPreset  = "Restores the recommended default feel. Engine texture stays light while curbs, grip loss, ABS, and shifts stand out.",
    dualSenseDetailPreset    = "Restrained chassis vibration and clearer road detail for longer sessions.",
    dualSenseStrongPreset    = "Stronger overall feedback, useful for confirming that each effect is triggering correctly.",
    dualSenseSaveCustomPreset = "Saves the current DualSense feedback parameters for one-click restore from the overview.",
    dualSenseLoadCustomPreset = "Loads the previously saved DualSense feedback parameters.",
    advancedSettings          = "Opens the independent advanced settings window. It can be moved and resized freely.",
    dualSenseGlobalStrength  = "Scales CSP native grip haptics and the 0.5.1 compatibility grip layer together. It does not change L2 / R2 adaptive-trigger resistance or AC's native rumble percentage.",
    dualSenseLegacyBodyVibration = "Restores the 0.5.1 vibrationLeft / vibrationRight compatibility grip output. It does not directly control L2 / R2, but adds engine texture, road detail, and shift impact.",
    dualSenseTestNativeEngine = "Temporarily boosts the CSP native Engine layer for 10 seconds. Compare while idling or revving; this does not create fake vibration events.",
    dualSenseTestNativeWheel = "Mutes the other main native layers and boosts only Wheel to 800% for 15 seconds. Drive over an actual curb now.",
    dualSenseTestNativeBodywork = "Mutes the other main native layers and boosts only Bodywork to 500% for 15 seconds. Drive over an actual curb or a clear bump now.",
    dualSenseTestNativeSkid = "Mutes the other main native layers and boosts only Skid to 800% for 15 seconds. Induce understeer, oversteer, or wheelspin now.",
    dualSenseEnabled         = "Master switch for DualSense grip vibration and adaptive triggers.\n\nThis project does not read gyroscope data or modify gyroscope steering.",
    dualSenseNativeHapticsEnabled = "Uses CSP's native DualSense USB haptic layers.",
    dualSenseNativeBodyworkStrength = "Strength of the CSP native bodywork and road-impact layer.",
    dualSenseNativeEngineStrength = "Strength of the CSP native engine layer. Keep it modest so it does not mask curb and grip-loss detail.",
    dualSenseNativeGearStrength = "Strength of the CSP native gear-shift layer.",
    dualSenseNativeLimiterStrength = "Strength of the CSP native rev-limiter layer.",
    dualSenseNativeSkidStrength = "Strength of the CSP native tire-skid layer.",
    dualSenseNativeWheelStrength = "Strength of the CSP native Wheel layer. Testing shows that it is not the main source of curb and skid detail, so its default remains low.",
    dualSenseNativeCollisionStrength = "Strength of the CSP native collision layer.",
    dualSenseNativeCurbBoost = "Adds extra CSP native Bodywork gain when a one-sided curb is detected. Testing shows that curbs are mainly expressed by Bodywork.",
    dualSenseNativeSidePitchSeparation = "Changes Bodywork pitch for left and right curbs: slightly lower on the left and higher on the right. This improves clarity, but is not direct left and right actuator control.",
    dualSenseNativeCurbEngineDucking = "Reduces engine texture over curbs so road detail has more space.",
    dualSenseNativeSkidDynamicBoost = "Adds more native Skid gain as the tires exceed their grip limit more clearly.",
    dualSenseNativeSkidThreshold = "Raw ndSlip threshold where dynamic Skid gain begins. In CSP, 100% means the tire has reached its grip limit.",
    dualSenseNativeSkidEngineDucking = "Reduces engine texture during tire slip so the Skid layer has more space.",
    dualSenseNativeSkidAxlePitchSeparation = "Adjusts Skid pitch using front and rear grip-loss difference: understeer slightly higher, oversteer slightly lower.",
    dualSenseSlipThreshold   = "Slip threshold used by L2 to detect front-wheel lock tendency. Lower values are more sensitive.",
    dualSenseShiftDuration   = "Duration of the R2 shift rebound.",
    dualSenseTriggersEnabled = "Enables L2 and R2 adaptive-trigger resistance.",
    dualSenseBrakeResistance = "Base L2 brake resistance.",
    dualSenseThrottleResistance = "Base R2 throttle resistance.",
    dualSenseBrakeCurve      = "L2 resistance curve. Higher values feel softer at light input and stronger at deep input.",
    dualSenseThrottleCurve   = "R2 resistance curve. Higher values feel softer at light input and stronger at deep input.",
    dualSenseABSFeedback     = "Amount of L2 resistance release while ABS is active.",
    dualSenseABSFrequency    = "ABS pulse speed.",
    dualSenseWheelspinFeedback = "Amount of R2 resistance release during driven-wheel slip.",
    dualSenseWheelspinThreshold = "Threshold for driven-wheel slip cues. Lower values are more sensitive.",
    dualSenseWheelspinFrequency = "R2 pulse speed during driven-wheel slip.",
    dualSenseLimiterResistance = "R2 pulse strength near the engine limiter.",
    dualSenseLimiterFrequency = "R2 pulse speed near the engine limiter.",
    dualSenseShiftResistance = "R2 press, release, and rebound strength during upshifts.",
    dualSenseDownshiftThrottleKick = "Subtle R2 throttle blip cue during downshifts. The default stays light and does not create false L2 ABS cues.",
    keyboardMode             = "Enables gas, brake and steering input on keyboard.\n\nYou can also choose to have brake or gas assistance when ABS or TCS are off. These aren't as good as ABS or TCS, they just try to compensate for not having analog input.\n\nDon't use gas assistance for drifting!\n\nFor every vehicle control to work (like shifting or handbrake), you also have to enable the 'Combine with keyboard' option in the control settings in Content Manager!",
    filterSetting            = "How much steering assistance you want in general.\n\nNote that 0% does not mean the assist is off, it's just a lower level of processing.",
    steeringRate             = "How fast the steering is in general.\n\nA Lower rate will smooth out your steering input more which can help with stability, but going too low can feel unresponsive.\n\nKeyboard steering is generally nicer at a lower rate compared to controller input.",
    rateIncreaseWithSpeed    = "How much slower or faster the steering gets as you speed up.\n\nNote that the actual steering speed will already be slower at high speed even with this at 0%.",
    selfSteerResponse        = "How aggressive the self-steer force will fight to keep the car straight.\n\nLow = looser feel and easier to oversteer, high = more assistance to prevent oversteer and keep the car stable.",
    dampingStrength          = "This is an advanced setting, and in most cases it's best to leave it at a similar value to 'Response'.\n\nDamping adds some additional self-steer that counteracts the car's yaw rotation which results in more stability.\n\nIf the car wobbles too much when returning to the center (especially with a high 'Response' setting), you can increase damping to counteract that.\n\nThe damping force is not limited by the 'Max angle' setting.",
    maxSelfSteerAngle        = "Caps the self-steer force to a certain steering angle.\n\nBasically this limits how big of a slide the self-steer can help to recover from.\n\nI'd recommend 90° in most cases, or a small value like 5° for a looser feel.",
    targetSlip               = "Changes the slip angle that the front wheels will target, which is simply how much you're steering.\n\nHigher = more steering, lower = less steering.\n\nMost cars feel best between 90%-100%, but you can set it higher to scrub the front tires more (to generate more heat for example).",
    countersteerResponse     = "Higher = more effective countersteering, but also easier to overcorrect a slide and spin the other way if you're not careful.\n\nI would generally recommend to keep it under 50%.",
    maxDynamicLimitReduction = "How much should inward steering be restricted when the car oversteers, in order to maintain front grip.\n\nLow = being able to steer inward more when the car oversteers, meaning the front tires will scrub more if you steer into a slide.\n\nHigh = the steering backing off more when the car steps out.",
    builtInSettings          = "These directly adjust AC's own settings (just like the Controller Tweaks app), they are just here for convenience.",
    dualSenseEnableACRumble  = "Sets AC's native controller rumble to 100%. Adaptive triggers do not depend on this value, but grip vibration can be scaled down to zero by it.",
    photoMode                = "Allows you to leave the wheels turned when the car is parked by disabling re-centering.\nUseful for taking screenshots for example.",
    _gameGamma               = "Controls AC's own 'Steering gamma' setting.\n\nHigher gamma will make your analog stick less sensitive near the center.\n\nI would recommend around 120-160% depending on preference.",
    _gameDeadzone            = "Controls AC's own 'Steering deadzone' setting.\n\nDeadzone is used to avoid unintended inputs caused by stick-drift.\n\nShould be as low as you can go without causing unintended inputs when not touching the analog stick.",
    _gameRumble              = "Controls AC's own 'Rumble effects' setting."
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
    if uiData._dualSenseNativeTestSeconds <= 0 then return "Idle" end
    local labels = {"Engine", "Wheel", "Bodywork", "Skid"}
    return labels[uiData._dualSenseNativeTestMode] or "Unknown"
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
    if matchesDualSensePreset(dualSenseDetailOverrides) then return "Track Detail" end
    if matchesDualSensePreset(dualSenseStrongOverrides) then return "Strong Feedback" end
    if matchesDualSensePreset(nil) then return "Balanced" end
    return "Custom"
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

    ui.text("Preset name:")

    ui.setNextItemWidth(ui.availableSpaceX())
    currentPresetName = ui.inputText("", currentPresetName, ui.InputTextFlags.RetainSelection):gsub("%*", "")

    local loadText = "Load"
    local loadFlags = ui.ButtonFlags.None
    if loadFeedbackStart ~= -1 then
        if ui.time() - loadFeedbackStart > 1.0 then
            loadFeedbackStart = -1
        else
            ui.setNextTextBold()
            loadText = "Loaded"
            loadFlags = ui.ButtonFlags.Disabled
        end
    end
    local loadClicked = ui.button(loadText, tmpVec1:set(ui.availableSpaceX() / 3.0, ui.frameHeight()), loadFlags)

    ui.sameLine()
    local saveText = "Save"
    local saveFlags = ui.ButtonFlags.None
    if saveFeedbackStart ~= -1 then
        if ui.time() - saveFeedbackStart > 1.0 then
            saveFeedbackStart = -1
        else
            ui.setNextTextBold()
            saveText = "Saved"
            saveFlags = ui.ButtonFlags.Disabled
        end
    end
    local saveClicked = ui.button(saveText, tmpVec1:set(ui.availableSpaceX() / 2.0, ui.frameHeight()), saveFlags)

    ui.sameLine()
    local deleteText = "Delete"
    local deleteFlags = ui.ButtonFlags.None
    if deleteFeedbackStart ~= -1 then
        if ui.time() - deleteFeedbackStart > 1.0 then
            deleteFeedbackStart = -1
        else
            ui.setNextTextBold()
            deleteText = "Deleted"
            deleteFlags = ui.ButtonFlags.Disabled
        end
    end
    local deleteClicked = ui.button(deleteText, tmpVec1:set(ui.availableSpaceX(), ui.frameHeight()), deleteFlags)

    if saveClicked and currentPresetName:len() > 0   then if savePreset(currentPresetName)   then saveFeedbackStart = ui.time() end end
    if loadClicked and currentPresetName:len() > 0   then if loadPreset(currentPresetName)   then loadFeedbackStart = ui.time() end end
    if deleteClicked and currentPresetName:len() > 0 then if deletePreset(currentPresetName) then deleteFeedbackStart = ui.time() end end

    ui.text("Saved presets:")

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
    ui.text("0.6.2 English")
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
    ui.text(string.format("%s: %s", label, value))
end

local function showDualSensePresetButtons()
    showButton("Balanced", "dualSenseBalancedPreset", loadDualSenseBalancedPreset, 0)
    showButton("Track Detail", "dualSenseDetailPreset", loadDualSenseDetailPreset, 0)
    showButton("Strong Feedback", "dualSenseStrongPreset", loadDualSenseStrongPreset, 0)
    showButton("Save current custom preset", "dualSenseSaveCustomPreset", saveDualSenseCustomPreset, 0)
    showButton(hasDualSenseCustomPreset() and "Load custom preset" or "Load custom preset (not saved yet)",
        "dualSenseLoadCustomPreset", loadDualSenseCustomPreset, 0, nil, not hasDualSenseCustomPreset())
end

local function drawUnavailable()
    if ac.getPatchVersionCode() < 2651 then
        ui.pushStyleColor(ui.StyleColor.Text, warningColor)
        ui.textWrapped("Please update to CSP 0.2.0 or newer.")
        ui.popStyleColor(1)
    elseif not lib.clampEased then
        ui.textWrapped("DualSense Gamepad Assist is not installed correctly.")
    else
        ui.textWrapped("DualSense Gamepad Assist is not enabled.")
        if (os.clock() - enableClicked) >= 3.0 then
            showDummyLine()
            showButton("Enable script", nil, enableScript, 0)
        end
        showDummyLine()
        ui.textWrapped("If it cannot be enabled, confirm that the apps and extension folders were copied into the AC root folder.")
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
    showTab(1, "Steering", width)
    ui.sameLine()
    showTab(2, "Feedback", width)
    ui.sameLine()
    showTab(3, "Diagnostics", width)
    showDummyLine(0.20)
end

local function drawOverviewTab()
    ui.text("Current preset: " .. getDualSensePresetName())
    showDualSensePresetButtons()

    showHeader("Overall Vibration")
    showConfigSlider("dualSenseGlobalStrength", "Grip vibration strength", "%.f%%", 0.0, 200.0, 100.0, false, nil, 0, not uiData.dualSenseEnabled)

    showHeader("Core Switches")
    showCheckbox("assistEnabled", "Enable controller steering assist", false, false, 0)
    showCheckbox("dualSenseEnabled", "Enable DualSense feedback", false, false, 0)
    showCheckbox("dualSenseNativeHapticsEnabled", "Enable CSP native haptic tuning", false, not uiData.dualSenseEnabled, 0)
    showCheckbox("dualSenseLegacyBodyVibration", "Enable 0.5.1 compatibility grip layer", false, not uiData.dualSenseEnabled, 0)
    showCheckbox("dualSenseTriggersEnabled", "Enable adaptive triggers", false, not uiData.dualSenseEnabled, 0)

    showHeader("Driving Assists")
    showCheckbox("autoClutch", "Automatic clutch", false, false, 0)
    uiData.autoShiftingMode = showCompactDropdown("Shifting mode", "autoShiftingMode", {"AC Default", "Manual", "Automatic"}, uiData.autoShiftingMode + 1, 0) - 1
    showCheckbox("autoShiftingCruise", "Automatic cruise mode switching", false, uiData.autoShiftingMode < 2, 20)
    showConfigSlider("autoShiftingDownBias", "Downshift bias", "%.f%%", 10.0, 90.0, 100.0, false, 240.0, 20, uiData.autoShiftingMode < 2)
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

    showStatusLine("Script", uiData.assistEnabled and "Running" or "Paused", uiData.assistEnabled)
    showStatusLine("DualSense", uiData._dualSenseDetected and "Connected" or "Not detected", uiData._dualSenseDetected)
    showStatusLine("Native Haptics API", uiData._dualSenseNativeHapticsAvailable and "Available" or "Unavailable", uiData._dualSenseNativeHapticsAvailable)
    showHeader("Overview")
    drawOverviewTab()
    showHeader("More")
    showButton(advancedSettingsOpen and "Advanced settings are open" or "Open advanced settings", "advancedSettings", openAdvancedSettings, 0, nil, advancedSettingsOpen)
    popStyle()
end

local function drawSteeringTab()
    showCheckbox("assistEnabled", "Enable controller steering assist", false, false, 0)
    showButton("Recalibrate steering", "calibration", sendRecalibrationEvent, 0)
    showButton(presetsWindowEnabled and "Hide steering presets" or "Show steering presets", "presets", togglePresetsWindow, 0)
    showCheckbox("useFilter", "Simplified steering settings", false, false, 0)
    if uiData.useFilter then
        showConfigSlider("filterSetting", "Steering assist strength", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0)
    end

    showButton(steeringAdvancedExpanded and "Collapse detailed steering controls" or "Expand detailed steering controls", nil, function ()
        steeringAdvancedExpanded = not steeringAdvancedExpanded
    end, 0)

    if steeringAdvancedExpanded then
        showHeader("Steering Input")
        showConfigSlider("steeringRate", "Steering rate", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0)
        showConfigSlider("rateIncreaseWithSpeed", "High-speed steering-rate correction", "%+.f%%", -50.0, 50.0, 100.0, uiData.useFilter, nil, 0)
        showConfigSlider("targetSlip", "Target slip angle", "%.1f%%", 90.0, 120.0, 100.0, uiData.useFilter, nil, 0)
        showConfigSlider("countersteerResponse", "Countersteer response", "%.f%%", 0.0, 100.0, 100.0, uiData.useFilter, nil, 0)
        showConfigSlider("maxDynamicLimitReduction", "Dynamic steering limit", "%.f%%", 0.0, 100.0, 10.0, uiData.useFilter, nil, 0)
        showHeader("Self-Steer")
        showConfigSlider("selfSteerResponse", "Response", "%.f%%", 0.0, 100.0, 100.0, uiData.useFilter, nil, 0)
        showConfigSlider("maxSelfSteerAngle", "Maximum angle", "%.1f°", 0.0, 90.0, 1.0, uiData.useFilter, nil, 0)
        showConfigSlider("dampingStrength", "Damping", "%.f%%", 0.0, 100.0, 100.0, uiData.useFilter, nil, 0)
    end

    showHeader("Steering Tools")
    uiData.graphSelection = showCompactDropdown("Assist graphs", "graphs", {"Off", "Static", "Live"}, uiData.graphSelection, 0)
    showConfigSlider("_gameGamma", "Steering gamma", "%.f%%", 100.0, 300.0, 100.0, false, nil, 0)
    showConfigSlider("_gameDeadzone", "Stick deadzone", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0)
end

local function drawFeedbackTab()
    local nativeDisabled = not uiData.dualSenseEnabled or not uiData.dualSenseNativeHapticsEnabled
    local triggerDisabled = not uiData.dualSenseEnabled or not uiData.dualSenseTriggersEnabled

    ui.text("Current preset: " .. getDualSensePresetName())
    showCheckbox("dualSenseEnabled", "Enable DualSense feedback", false, false, 0)
    showCheckbox("dualSenseNativeHapticsEnabled", "Enable CSP native haptic tuning", false, not uiData.dualSenseEnabled, 0)
    showCheckbox("dualSenseTriggersEnabled", "Enable adaptive triggers", false, not uiData.dualSenseEnabled, 0)

    showHeader("Native Haptics")
    showConfigSlider("dualSenseGlobalStrength", "Grip vibration strength", "%.f%%", 0.0, 200.0, 100.0, false, nil, 0, not uiData.dualSenseEnabled)
    showConfigSlider("dualSenseNativeEngineStrength", "Engine texture", "%.f%%", 0.0, 200.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeBodyworkStrength", "Bodywork / curb feedback", "%.f%%", 0.0, 300.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeCurbBoost", "Extra curb boost", "%.f%%", 0.0, 250.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSkidStrength", "Tire-skid feedback", "%.f%%", 0.0, 1000.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeGearStrength", "Shift feedback", "%.f%%", 0.0, 300.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeCollisionStrength", "Collision impact", "%.f%%", 0.0, 500.0, 100.0, false, nil, 0, nativeDisabled)

    showHeader("Adaptive Triggers")
    showConfigSlider("dualSenseBrakeResistance", "L2 brake resistance", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseThrottleResistance", "R2 throttle resistance", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
end

local function drawResetButton(dt)
    local reset = showButton(resetClicked > 0 and "Confirm factory reset?" or "Restore all defaults", "factoryReset", nil, 0)
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
    ui.textWrapped(string.format("CSP raw ndSlip: FL %.0f%% / FR %.0f%% / RL %.0f%% / RR %.0f%%",
        uiData._dualSenseSlipFL * 100.0,
        uiData._dualSenseSlipFR * 100.0,
        uiData._dualSenseSlipRL * 100.0,
        uiData._dualSenseSlipRR * 100.0))
    ui.textWrapped(string.format("Native curbs: L %.0f%% / R %.0f%%, live Bodywork gain %.0f%%, pitch %.2f",
        uiData._dualSenseNativeCurbLeft * 100.0,
        uiData._dualSenseNativeCurbRight * 100.0,
        uiData._dualSenseNativeBodyworkGain * 100.0,
        uiData._dualSenseNativeBodyworkPitch))
    ui.textWrapped(string.format("Native skid: dynamic intensity %.0f%%, live Skid gain %.0f%%, pitch %.2f",
        uiData._dualSenseNativeSkidIntensity * 100.0,
        uiData._dualSenseNativeSkidGain * 100.0,
        uiData._dualSenseNativeSkidPitch))
end

local function drawDiagnosticsTab(dt)
    local nativeDisabled = not uiData.dualSenseEnabled or not uiData.dualSenseNativeHapticsEnabled
    local triggerDisabled = not uiData.dualSenseEnabled or not uiData.dualSenseTriggersEnabled

    showHeader("Native Layer Isolation Tests")
    ui.textWrapped(string.format("Haptics API: %s, test layer %s, %.1f seconds remaining",
        uiData._dualSenseNativeHapticsAvailable and "Available" or "Unavailable",
        nativeHapticTestModeLabel(),
        uiData._dualSenseNativeTestSeconds))
    showButton("Test: boost Engine layer for 10 seconds", "dualSenseTestNativeEngine", testDualSenseNativeEngine, 0)
    showButton("Isolate: Wheel layer only for 15 seconds", "dualSenseTestNativeWheel", testDualSenseNativeWheel, 0)
    showButton("Isolate: Bodywork layer only for 15 seconds", "dualSenseTestNativeBodywork", testDualSenseNativeBodywork, 0)
    showButton("Isolate: Skid layer only for 15 seconds", "dualSenseTestNativeSkid", testDualSenseNativeSkid, 0)

    showButton(telemetryExpanded and "Collapse live telemetry" or "Expand live telemetry", nil, function ()
        telemetryExpanded = not telemetryExpanded
    end, 0)
    if telemetryExpanded then drawTelemetry() end

    showHeader("Native Haptic Details")
    showConfigSlider("dualSenseNativeBodyworkStrength", "Native bodywork / road impacts", "%.f%%", 0.0, 300.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeEngineStrength", "Native engine layer", "%.f%%", 0.0, 200.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeGearStrength", "Native gear-shift layer", "%.f%%", 0.0, 300.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeLimiterStrength", "Native rev-limiter layer", "%.f%%", 0.0, 300.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSkidStrength", "Native tire-skid layer", "%.f%%", 0.0, 1000.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeWheelStrength", "Native Wheel layer", "%.f%%", 0.0, 500.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeCollisionStrength", "Native collision layer", "%.f%%", 0.0, 500.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeCurbBoost", "Extra curb Bodywork boost", "%.f%%", 0.0, 250.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSidePitchSeparation", "Left / right curb pitch separation", "%.f%%", 0.0, 35.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeCurbEngineDucking", "Engine ducking over curbs", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSkidDynamicBoost", "Extra dynamic skid boost", "%.f%%", 0.0, 200.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSkidThreshold", "Dynamic skid-boost threshold", "%.f%%", 90.0, 170.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSkidEngineDucking", "Engine ducking during skid", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, nativeDisabled)
    showConfigSlider("dualSenseNativeSkidAxlePitchSeparation", "Understeer / oversteer pitch separation", "%.f%%", 0.0, 30.0, 100.0, false, nil, 0, nativeDisabled)

    showHeader("Adaptive Trigger Details")
    showConfigSlider("dualSenseShiftDuration", "Shift rebound duration", "%.f ms", 60.0, 180.0, 1000.0, false, nil, 0, not uiData.dualSenseEnabled)
    showConfigSlider("dualSenseSlipThreshold", "L2 front-wheel lock threshold", "%.f%%", 45.0, 140.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseBrakeResistance", "L2 base brake resistance", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseBrakeCurve", "L2 brake-resistance curve", "%.2f", 50.0, 250.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseABSFeedback", "L2 ABS pulse depth", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseABSFrequency", "ABS pulse speed", "%.f Hz", 6.0, 30.0, 1.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseThrottleResistance", "R2 base throttle resistance", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseThrottleCurve", "R2 throttle-resistance curve", "%.2f", 50.0, 250.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseWheelspinFeedback", "R2 driven-wheel slip pulse", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseWheelspinThreshold", "Driven-wheel slip threshold", "%.f%%", 75.0, 175.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseWheelspinFrequency", "Driven-wheel slip pulse speed", "%.f Hz", 6.0, 35.0, 1.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseLimiterResistance", "R2 limiter pulse strength", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseLimiterFrequency", "R2 limiter pulse speed", "%.f Hz", 8.0, 45.0, 1.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseShiftResistance", "R2 upshift rebound strength", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0, triggerDisabled)
    showConfigSlider("dualSenseDownshiftThrottleKick", "R2 downshift throttle-blip cue", "%.f%%", 0.0, 60.0, 100.0, false, nil, 0, triggerDisabled)

    showHeader("Other Tools")
    uiData.keyboardMode = showCompactDropdown("Keyboard mode", "keyboardMode", {"Off", "On", "On (brake assist)", "On (gas and brake assist)"}, uiData.keyboardMode + 1, 0) - 1
    showCheckbox("photoMode", "Photo mode", false, false, 0)
    showConfigSlider("_gameRumble", "AC native rumble", "%.f%%", 0.0, 100.0, 100.0, false, nil, 0)
    if uiData._gameRumble < 0.05 then
        ui.pushStyleColor(ui.StyleColor.Text, warningColor)
        ui.textWrapped("AC native rumble is close to 0%, so grip haptics might be scaled down to silence.")
        ui.popStyleColor(1)
        showButton("Set AC native rumble to 100%", "dualSenseEnableACRumble", enableACRumbleForDualSense, 0)
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
        title = "DualSense Gamepad Assist - Advanced Settings",
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

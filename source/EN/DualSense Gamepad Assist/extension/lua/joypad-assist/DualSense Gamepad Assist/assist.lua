if ac.getPatchVersionCode() < 2651 then
    ac.onCarJumped(car.index, function ()
        ac.setMessage("DualSense Gamepad Assist", "Error - Only CSP 0.2.0 and higher are supported!")
    end)
    return
end

if car.isAIControlled then return end

local lib                = require "AssistCore"
local extras             = require "extras"
local dualSenseFeedback  = require "dualsense_feedback"
local gyroInput          = require('gyro_input')
local CarPerformanceData = require "CarPerformanceData"

local function runDualSenseTest(effect, message)
    dualSenseFeedback.test(effect)
    ac.setMessage("DualSense Gamepad Assist 1.0.0", message)
end

local function runDualSenseNativeTest(effect, message)
    dualSenseFeedback.testNative(effect)
    ac.setMessage("DualSense Gamepad Assist 1.0.0", message)
end

ac.onSharedEvent("DSGA_testDualSenseCurb", function()
    runDualSenseTest("curb", "Received test event: simulated curb")
end)

ac.onSharedEvent("DSGA_testDualSenseFrontSlip", function()
    runDualSenseTest("frontSlip", "Received test event: simulated front understeer")
end)

ac.onSharedEvent("DSGA_testDualSenseRearSlip", function()
    runDualSenseTest("rearSlip", "Received test event: simulated rear oversteer")
end)

ac.onSharedEvent("DSGA_testDualSenseNativeEngine", function()
    runDualSenseNativeTest("engine", "Native Engine layer boosted for 10 seconds: compare while idling or revving in neutral")
end)

ac.onSharedEvent("DSGA_testDualSenseNativeWheel", function()
    runDualSenseNativeTest("wheel", "Native Wheel layer only for 15 seconds: drive over a curb now")
end)

ac.onSharedEvent("DSGA_testDualSenseNativeBodywork", function()
    runDualSenseNativeTest("bodywork", "Native Bodywork layer only for 15 seconds: drive over a curb now")
end)

ac.onSharedEvent("DSGA_testDualSenseNativeSkid", function()
    runDualSenseNativeTest("skid", "Native Skid layer only for 15 seconds: create tire slip now")
end)

-- CONFIG =====================================================================================

-- Data shared with the UI app
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
    graphSelection           = ac.StructItem.int32(), -- 1 = none, 2 = static, 3 = live
    keyboardMode             = ac.StructItem.int32(), -- 0 = disabled, 1 = enabled, 2 = enabled + brake assist, 3 = enabled + throttle and brake assist
    autoClutch               = ac.StructItem.boolean(),
    autoShiftingMode         = ac.StructItem.int32(), -- 0 = default, 1 = manual, 2 = automatic
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
    maxDynamicLimitReduction = ac.StructItem.double(), -- Stores 10x the value for legacy reasons
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

local firstInstall = false -- Set to true on the very first boot after installing the assist

if table.nkeys(ac.INIConfig.load(ac.findFile(ac.getFolder(ac.FolderID.ScriptConfig) .. ".ini")).sections) == 0 then
    firstInstall = true
end

-- Config saved to disk
local savedCfg = ac.storage({
    assistEnabled            = true,
    graphSelection           = 1,
    keyboardMode             = 0,
    autoClutch               = true,
    autoShiftingMode         = 0,
    autoShiftingCruise       = true,
    autoShiftingDownBias     = 0.9,
    dualSenseEnabled         = true,
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
    dualSenseBodyVibration   = true,
    dualSenseBodyStrength    = 1.0,
    dualSenseBodyOutputBoost = 1.35,
    dualSenseBodyDetailStacking = 0.42,
    dualSenseBodyMinimumOutput = 0.12,
    dualSenseEngineStrength  = 0.06,
    dualSenseRoadStrength    = 0.78,
    dualSenseSlideStrength   = 0.82,
    dualSenseGripLossStrength = 1.12,
    dualSenseFrontSlipStrength = 1.08,
    dualSenseRearSlipStrength = 1.18,
    dualSenseSlipThreshold   = 0.58,
    dualSenseCurbStrength    = 1.25,
    dualSenseDirectionalCrossfeed = 0.10,
    dualSenseDirtStrength    = 0.88,
    dualSenseCollisionStrength = 1.20,
    dualSenseABSStrength     = 1.0,
    dualSenseShiftStrength   = 0.92,
    dualSenseDownshiftStrength = 0.84,
    dualSenseShiftDuration   = 0.13,
    dualSenseTriggersEnabled = true,
    dualSenseBrakeResistance = 0.40,
    dualSenseThrottleResistance = 0.14,
    dualSenseBrakeCurve      = 1.05,
    dualSenseThrottleCurve   = 1.15,
    dualSenseABSFeedback     = 1.0,
    dualSenseABSFrequency    = 16.0,
    dualSenseWheelspinFeedback = 1.0,
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
    useFilter                = true,
    filterSetting            = 0.5,
    steeringRate             = 0.5,
    targetSlip               = 0.95,
    rateIncreaseWithSpeed    = 0.0,
    selfSteerResponse        = 0.37,
    dampingStrength          = 0.37,
    maxSelfSteerAngle        = 90.0,
    countersteerResponse     = 0.2,
    maxDynamicLimitReduction = 5.0,
    gyroSteeringEnabled      = false,
    gyroSteeringSensitivity  = 0.50,
    gyroSteeringDeadzone     = 0.0,
    gyroSteeringSmoothing    = 0.0,
    gyroSteeringCentering    = 0.55,
    gyroSteeringMaxAngle     = 90.0,
    gyroSteeringHighSpeedStability = 0.0,
    gyroSteeringStickBlend   = 0.0,
    gyroSteeringInvert       = false,
    gyroSteeringProfileVersion = 108,
    photoMode                = false
}, "DSGA_REFINE_103_")

-- controls.ini stuff

local gameCfg                  = ac.INIConfig.load(ac.getFolder(ac.FolderID.Cfg) .. "\\controls.ini")
local kbThrottleBind           = ac.KeyIndex.Up
local kbBrakeBind              = ac.KeyIndex.Down
local kbSteerLBind             = ac.KeyIndex.Left
local kbSteerRBind             = ac.KeyIndex.Right

local lastGameGamma            = 0
local lastGameDeadzone         = 0
local lastGameRumble           = 0
local lastGameCfgSave          = 0

local function onFirstInstall()
    uiData._gameGamma    = 1.4
    uiData._gameDeadzone = 0.12
    -- uiData._gameRumble   = 0.0

    gameCfg:set("X360", "STEER_GAMMA",      1.4)
    gameCfg:set("X360", "STEER_DEADZONE",   0.12)
    -- gameCfg:set("X360", "RUMBLE_INTENSITY", 0.0)

    gameCfg:save()
end

local function readGameControls()
    gameCfg = ac.INIConfig.load(ac.getFolder(ac.FolderID.Cfg) .. "\\controls.ini")

    if gameCfg then
        kbThrottleBind = gameCfg:get("KEYBOARD", "GAS",   kbThrottleBind)
        kbBrakeBind    = gameCfg:get("KEYBOARD", "BRAKE", kbBrakeBind)
        kbSteerLBind   = gameCfg:get("KEYBOARD", "LEFT",  kbSteerLBind)
        kbSteerRBind   = gameCfg:get("KEYBOARD", "RIGHT", kbSteerRBind)

        lastGameGamma    = gameCfg:get("X360", "STEER_GAMMA",      lastGameGamma)
        lastGameDeadzone = gameCfg:get("X360", "STEER_DEADZONE",   lastGameDeadzone)
        lastGameRumble   = gameCfg:get("X360", "RUMBLE_INTENSITY", lastGameRumble)
    end

    if firstInstall then
        firstInstall = false
        onFirstInstall()
    else
        uiData._gameGamma    = lastGameGamma
        uiData._gameDeadzone = lastGameDeadzone
        uiData._gameRumble   = lastGameRumble
    end
end

ac.onSharedEvent("DSGA_factoryReset", function()
    uiData.assistEnabled            = true
    uiData.graphSelection           = 1
    uiData.keyboardMode             = 0
    uiData.autoClutch               = true
    uiData.autoShiftingMode         = 0
    uiData.autoShiftingCruise       = true
    uiData.autoShiftingDownBias     = 0.9
    uiData.dualSenseEnabled         = true
    uiData.dualSenseNativeHapticsEnabled = true
    uiData.dualSenseNativeBodyworkStrength = 1.15
    uiData.dualSenseNativeEngineStrength = 0.30
    uiData.dualSenseNativeGearStrength = 1.55
    uiData.dualSenseNativeLimiterStrength = 1.45
    uiData.dualSenseNativeSkidStrength = 6.80
    uiData.dualSenseNativeWheelStrength = 0.95
    uiData.dualSenseNativeCollisionStrength = 3.80
    uiData.dualSenseNativeCurbBoost = 1.55
    uiData.dualSenseNativeSidePitchSeparation = 0.14
    uiData.dualSenseNativeCurbEngineDucking = 0.64
    uiData.dualSenseNativeSkidDynamicBoost = 0.95
    uiData.dualSenseNativeSkidThreshold = 0.92
    uiData.dualSenseNativeSkidEngineDucking = 0.58
    uiData.dualSenseNativeSkidAxlePitchSeparation = 0.10
    uiData.dualSenseNativeMasterStrength = 1.25
    uiData.dualSenseBodyVibration   = true
    uiData.dualSenseBodyStrength    = 1.0
    uiData.dualSenseBodyOutputBoost = 1.35
    uiData.dualSenseBodyDetailStacking = 0.42
    uiData.dualSenseBodyMinimumOutput = 0.12
    uiData.dualSenseEngineStrength  = 0.06
    uiData.dualSenseRoadStrength    = 0.78
    uiData.dualSenseSlideStrength   = 0.82
    uiData.dualSenseGripLossStrength = 1.12
    uiData.dualSenseFrontSlipStrength = 1.08
    uiData.dualSenseRearSlipStrength = 1.18
    uiData.dualSenseSlipThreshold   = 0.58
    uiData.dualSenseCurbStrength    = 1.25
    uiData.dualSenseDirectionalCrossfeed = 0.10
    uiData.dualSenseDirtStrength    = 0.88
    uiData.dualSenseCollisionStrength = 1.20
    uiData.dualSenseABSStrength     = 1.0
    uiData.dualSenseShiftStrength   = 0.92
    uiData.dualSenseDownshiftStrength = 0.84
    uiData.dualSenseShiftDuration   = 0.13
    uiData.dualSenseTriggersEnabled = true
    uiData.dualSenseBrakeResistance = 0.40
    uiData.dualSenseThrottleResistance = 0.14
    uiData.dualSenseBrakeCurve      = 1.05
    uiData.dualSenseThrottleCurve   = 1.15
    uiData.dualSenseABSFeedback     = 1.0
    uiData.dualSenseABSFrequency    = 16.0
    uiData.dualSenseWheelspinFeedback = 1.0
    uiData.dualSenseWheelspinThreshold = 0.88
    uiData.dualSenseWheelspinFrequency = 20.0
    uiData.dualSenseLimiterResistance = 0.78
    uiData.dualSenseLimiterFrequency = 28.0
    uiData.dualSenseShiftResistance = 0.95
    uiData.dualSenseDownshiftThrottleKick = 0.28
    uiData.dualSenseTriggerMasterStrength = 1.08
    uiData.dualSenseBrakeDeadzone = 0.035
    uiData.dualSenseThrottleDeadzone = 0.025
    uiData.dualSenseBrakeForceFloor = 0.07
    uiData.dualSenseThrottleForceFloor = 0.035
    uiData.dualSenseBrakeWallAt = 0.88
    uiData.dualSenseThrottleWallAt = 0.97
    uiData.dualSenseBrakeWallForce = 0.72
    uiData.dualSenseThrottleWallForce = 0.18
    uiData.dualSensePulseReleaseDepth = 0.92
    uiData.dualSensePulsePeakForce = 0.68
    uiData.useFilter                = true
    uiData.filterSetting            = 0.5
    uiData.steeringRate             = 0.5
    uiData.targetSlip               = 0.95
    uiData.rateIncreaseWithSpeed    = 0.0
    uiData.selfSteerResponse        = 0.37
    uiData.dampingStrength          = 0.37
    uiData.maxSelfSteerAngle        = 90.0
    uiData.countersteerResponse     = 0.2
    uiData.maxDynamicLimitReduction = 5.0
    uiData.gyroSteeringEnabled      = false
    uiData.gyroSteeringSensitivity  = 0.50
    uiData.gyroSteeringDeadzone     = 0.0
    uiData.gyroSteeringSmoothing    = 0.0
    uiData.gyroSteeringCentering    = 0.55
    uiData.gyroSteeringMaxAngle     = 90.0
    uiData.gyroSteeringHighSpeedStability = 0.0
    uiData.gyroSteeringStickBlend   = 0.0
    uiData.gyroSteeringInvert       = false
    uiData.photoMode                = false

    onFirstInstall()
    ac.broadcastSharedEvent("DSGA_reloadControlSettings")
end)

ac.onSharedEvent("DSGA_resetGyroCenter", function()
    gyroInput.resetCenter()
end)


readGameControls()


local function setGameCfgValue(section, key, value)
    local currentTime = os.clock()
    if (currentTime - lastGameCfgSave) > 0.25 then
        if gameCfg:setAndSave(section, key, value) then
            lastGameCfgSave = currentTime
            ac.broadcastSharedEvent("DSGA_reloadControlSettings")
            return true
        end
    end
    return false
end

-- Initializing shared cfg
uiData._appCanRun               = false
uiData.assistEnabled            = savedCfg.assistEnabled
uiData.keyboardMode             = savedCfg.keyboardMode
uiData.graphSelection           = savedCfg.graphSelection
uiData.useFilter                = savedCfg.useFilter
uiData.autoClutch               = savedCfg.autoClutch
uiData.autoShiftingMode         = savedCfg.autoShiftingMode
uiData.autoShiftingCruise       = savedCfg.autoShiftingCruise
uiData.autoShiftingDownBias     = savedCfg.autoShiftingDownBias
uiData.dualSenseEnabled         = savedCfg.dualSenseEnabled
uiData.dualSenseNativeHapticsEnabled = savedCfg.dualSenseNativeHapticsEnabled
uiData.dualSenseNativeBodyworkStrength = savedCfg.dualSenseNativeBodyworkStrength
uiData.dualSenseNativeEngineStrength = savedCfg.dualSenseNativeEngineStrength
uiData.dualSenseNativeGearStrength = savedCfg.dualSenseNativeGearStrength
uiData.dualSenseNativeLimiterStrength = savedCfg.dualSenseNativeLimiterStrength
uiData.dualSenseNativeSkidStrength = savedCfg.dualSenseNativeSkidStrength
uiData.dualSenseNativeWheelStrength = savedCfg.dualSenseNativeWheelStrength
uiData.dualSenseNativeCollisionStrength = savedCfg.dualSenseNativeCollisionStrength
uiData.dualSenseNativeCurbBoost = savedCfg.dualSenseNativeCurbBoost
uiData.dualSenseNativeSidePitchSeparation = savedCfg.dualSenseNativeSidePitchSeparation
uiData.dualSenseNativeCurbEngineDucking = savedCfg.dualSenseNativeCurbEngineDucking
uiData.dualSenseNativeSkidDynamicBoost = savedCfg.dualSenseNativeSkidDynamicBoost
uiData.dualSenseNativeSkidThreshold = savedCfg.dualSenseNativeSkidThreshold
uiData.dualSenseNativeSkidEngineDucking = savedCfg.dualSenseNativeSkidEngineDucking
uiData.dualSenseNativeSkidAxlePitchSeparation = savedCfg.dualSenseNativeSkidAxlePitchSeparation
uiData.dualSenseNativeMasterStrength = savedCfg.dualSenseNativeMasterStrength
uiData.dualSenseBodyVibration   = savedCfg.dualSenseBodyVibration
uiData.dualSenseBodyStrength    = savedCfg.dualSenseBodyStrength
uiData.dualSenseBodyOutputBoost = savedCfg.dualSenseBodyOutputBoost
uiData.dualSenseBodyDetailStacking = savedCfg.dualSenseBodyDetailStacking
uiData.dualSenseBodyMinimumOutput = savedCfg.dualSenseBodyMinimumOutput
uiData.dualSenseEngineStrength  = savedCfg.dualSenseEngineStrength
uiData.dualSenseRoadStrength    = savedCfg.dualSenseRoadStrength
uiData.dualSenseSlideStrength   = savedCfg.dualSenseSlideStrength
uiData.dualSenseGripLossStrength = savedCfg.dualSenseGripLossStrength
uiData.dualSenseFrontSlipStrength = savedCfg.dualSenseFrontSlipStrength
uiData.dualSenseRearSlipStrength = savedCfg.dualSenseRearSlipStrength
uiData.dualSenseSlipThreshold   = savedCfg.dualSenseSlipThreshold
uiData.dualSenseCurbStrength    = savedCfg.dualSenseCurbStrength
uiData.dualSenseDirectionalCrossfeed = savedCfg.dualSenseDirectionalCrossfeed
uiData.dualSenseDirtStrength    = savedCfg.dualSenseDirtStrength
uiData.dualSenseCollisionStrength = savedCfg.dualSenseCollisionStrength
uiData.dualSenseABSStrength     = savedCfg.dualSenseABSStrength
uiData.dualSenseShiftStrength   = savedCfg.dualSenseShiftStrength
uiData.dualSenseDownshiftStrength = savedCfg.dualSenseDownshiftStrength
uiData.dualSenseShiftDuration   = savedCfg.dualSenseShiftDuration
uiData.dualSenseTriggersEnabled = savedCfg.dualSenseTriggersEnabled
uiData.dualSenseBrakeResistance = savedCfg.dualSenseBrakeResistance
uiData.dualSenseThrottleResistance = savedCfg.dualSenseThrottleResistance
uiData.dualSenseBrakeCurve      = savedCfg.dualSenseBrakeCurve
uiData.dualSenseThrottleCurve   = savedCfg.dualSenseThrottleCurve
uiData.dualSenseABSFeedback     = savedCfg.dualSenseABSFeedback
uiData.dualSenseABSFrequency    = savedCfg.dualSenseABSFrequency
uiData.dualSenseWheelspinFeedback = savedCfg.dualSenseWheelspinFeedback
uiData.dualSenseWheelspinThreshold = savedCfg.dualSenseWheelspinThreshold
uiData.dualSenseWheelspinFrequency = savedCfg.dualSenseWheelspinFrequency
uiData.dualSenseLimiterResistance = savedCfg.dualSenseLimiterResistance
uiData.dualSenseLimiterFrequency = savedCfg.dualSenseLimiterFrequency
uiData.dualSenseShiftResistance = savedCfg.dualSenseShiftResistance
uiData.dualSenseDownshiftThrottleKick = savedCfg.dualSenseDownshiftThrottleKick
uiData.dualSenseTriggerMasterStrength = savedCfg.dualSenseTriggerMasterStrength
uiData.dualSenseBrakeDeadzone = savedCfg.dualSenseBrakeDeadzone
uiData.dualSenseThrottleDeadzone = savedCfg.dualSenseThrottleDeadzone
uiData.dualSenseBrakeForceFloor = savedCfg.dualSenseBrakeForceFloor
uiData.dualSenseThrottleForceFloor = savedCfg.dualSenseThrottleForceFloor
uiData.dualSenseBrakeWallAt = savedCfg.dualSenseBrakeWallAt
uiData.dualSenseThrottleWallAt = savedCfg.dualSenseThrottleWallAt
uiData.dualSenseBrakeWallForce = savedCfg.dualSenseBrakeWallForce
uiData.dualSenseThrottleWallForce = savedCfg.dualSenseThrottleWallForce
uiData.dualSensePulseReleaseDepth = savedCfg.dualSensePulseReleaseDepth
uiData.dualSensePulsePeakForce = savedCfg.dualSensePulsePeakForce
uiData.filterSetting            = savedCfg.filterSetting
uiData.steeringRate             = savedCfg.steeringRate
uiData.targetSlip               = savedCfg.targetSlip
uiData.rateIncreaseWithSpeed    = savedCfg.rateIncreaseWithSpeed
uiData.selfSteerResponse        = savedCfg.selfSteerResponse
uiData.dampingStrength          = savedCfg.dampingStrength
uiData.maxSelfSteerAngle        = savedCfg.maxSelfSteerAngle
uiData.countersteerResponse     = savedCfg.countersteerResponse
uiData.maxDynamicLimitReduction = savedCfg.maxDynamicLimitReduction
uiData.gyroSteeringEnabled      = savedCfg.gyroSteeringEnabled
uiData.gyroSteeringSensitivity  = savedCfg.gyroSteeringSensitivity
uiData.gyroSteeringDeadzone     = savedCfg.gyroSteeringDeadzone
uiData.gyroSteeringSmoothing    = savedCfg.gyroSteeringSmoothing
uiData.gyroSteeringCentering    = savedCfg.gyroSteeringCentering
uiData.gyroSteeringMaxAngle     = savedCfg.gyroSteeringMaxAngle
uiData.gyroSteeringHighSpeedStability = savedCfg.gyroSteeringHighSpeedStability
uiData.gyroSteeringStickBlend   = savedCfg.gyroSteeringStickBlend
uiData.gyroSteeringInvert       = savedCfg.gyroSteeringInvert
if savedCfg.gyroSteeringProfileVersion ~= 108 then
    uiData.gyroSteeringSensitivity = 0.50
    uiData.gyroSteeringDeadzone = 0.0
    uiData.gyroSteeringSmoothing = 0.0
    uiData.gyroSteeringCentering = 0.55
    uiData.gyroSteeringMaxAngle = 90.0
    uiData.gyroSteeringHighSpeedStability = 0.0
    uiData.gyroSteeringStickBlend = 0.0
    savedCfg.gyroSteeringProfileVersion = 108
end
uiData.photoMode                = savedCfg.photoMode

-- MAIN LOGIC =================================================================================

local steeringSmoother         = lib.SmoothTowards:new( 7.0,  0.13, -1.0,  1.0,  0.0) -- Smooths the initial steering input
local absSteeringSmoother      = lib.SmoothTowards:new( 7.0,  0.13, -1.0,  1.0,  0.0) -- Smooths the absolute value of the initial steering input
local kbThrottleSmoother       = lib.SmoothTowards:new(12.0,  1.0,   0.0,  1.0,  0.0)
local kbBrakeSmoother          = lib.SmoothTowards:new(12.0,  1.0,   0.0,  1.0,  0.0)
local kbSteerSmoother          = lib.SmoothTowards:new( 7.0,  1.0,  -1.0,  1.0,  0.0)
local selfSteerSmoother        = lib.SmoothTowards:new( 7.0,  0.13, -1.0,  1.0,  0.0) -- Smooths out the self-steer force
local limitSmoother            = lib.SmoothTowards:new(11.0,  0.01,  0.0, 32.0, 32.0) -- Smooths out changes in the steering limit -- tricky to get the rate right, too slow and it causes oscillations on turn-in, too fast and it lets noise through into the steering
local groundedSmoother         = lib.SmoothTowards:new( 4.0,  1.0,   0.0,  1.0,  1.0) -- Smooths the value that indicates if any of the front wheels are grounded
local frontSlipDisplaySmoother = lib.SmoothTowards:new(10.0,  0.05,  0.0,  1.0,  0.0) -- Smooths the relative front slip value sent to the UI app for visualization
local rearSlipDisplaySmoother  = lib.SmoothTowards:new(10.0,  0.05,  0.0,  1.0,  0.0) -- Smooths the relative rear slip value sent to the UI app for visualization
local counterIndicatorSmoother = lib.SmoothTowards:new(12.0,  1.0,   0.0,  1.0,  0.0) -- Smooths out the value that indicates if the player is countersteering
local vehicleSteeringLock      = math.NaN -- Degrees
local slowLog                  = false

local storedCarPerformanceData = nil

-- Calibration stuff

local calibrationPreDelay      = 0
local calibrationDelay         = 0
local calibrationLockDelay     = 0
local calibrationStage         = 0
local calibrationSmoother      = lib.SmoothTowards:new(1.2, 1.0, -1.0, 1.0, 0.0)
local calibrationSavedWheels   = false
local calibrationSuccess       = false
local calibrationTries         = 0
local calibrationMaxTries      = 2
local calibrationRateMult      = math.NaN

local localWheelPositions      = {[0] = vec3(0.7, -0.2, 1.3), vec3(-0.7, -0.2, 1.3), vec3(0.7, -0.2, -1.3), vec3(-0.7, -0.2, -1.3)} -- Local positions of all 4 wheels (0-based index). Only set once, not updated dynamically.
local fAxlePos                 = vec3(0.0, -0.2,  1.3)
local rAxlePos                 = vec3(0.0, -0.2, -1.3)
local avgWheelPos              = vec3(0.0, -0.2, 0.0)
local steeringCurveSamples     = {}
local steeringExponent         = 0.95

-- Updates the config values based on the settings in the UI app
local function updateConfig()
    if uiData.useFilter then
        uiData.rateIncreaseWithSpeed    = (1.0 - uiData.filterSetting) * 0.2 - 0.1
        uiData.selfSteerResponse        = uiData.filterSetting * 0.5 + 0.12
        uiData.dampingStrength          = uiData.selfSteerResponse -- * 0.8
        uiData.maxSelfSteerAngle        = 90.0 --28.0 * uiData.filterSetting
        uiData.maxDynamicLimitReduction = 3 * uiData.filterSetting + 3.5
        uiData.countersteerResponse     = (1.0 - uiData.filterSetting) * 0.2 + 0.1
        uiData.targetSlip               = 0.95 - ((uiData.filterSetting - 0.5) * 0.04)
    end

    savedCfg.assistEnabled            = uiData.assistEnabled
    savedCfg.keyboardMode             = uiData.keyboardMode
    savedCfg.graphSelection           = uiData.graphSelection
    savedCfg.useFilter                = uiData.useFilter
    savedCfg.autoClutch               = uiData.autoClutch
    savedCfg.autoShiftingMode         = uiData.autoShiftingMode
    savedCfg.autoShiftingCruise       = uiData.autoShiftingCruise
    savedCfg.autoShiftingDownBias     = uiData.autoShiftingDownBias
    savedCfg.dualSenseEnabled         = uiData.dualSenseEnabled
    savedCfg.dualSenseNativeHapticsEnabled = uiData.dualSenseNativeHapticsEnabled
    savedCfg.dualSenseNativeBodyworkStrength = uiData.dualSenseNativeBodyworkStrength
    savedCfg.dualSenseNativeEngineStrength = uiData.dualSenseNativeEngineStrength
    savedCfg.dualSenseNativeGearStrength = uiData.dualSenseNativeGearStrength
    savedCfg.dualSenseNativeLimiterStrength = uiData.dualSenseNativeLimiterStrength
    savedCfg.dualSenseNativeSkidStrength = uiData.dualSenseNativeSkidStrength
    savedCfg.dualSenseNativeWheelStrength = uiData.dualSenseNativeWheelStrength
    savedCfg.dualSenseNativeCollisionStrength = uiData.dualSenseNativeCollisionStrength
    savedCfg.dualSenseNativeCurbBoost = uiData.dualSenseNativeCurbBoost
    savedCfg.dualSenseNativeSidePitchSeparation = uiData.dualSenseNativeSidePitchSeparation
    savedCfg.dualSenseNativeCurbEngineDucking = uiData.dualSenseNativeCurbEngineDucking
    savedCfg.dualSenseNativeSkidDynamicBoost = uiData.dualSenseNativeSkidDynamicBoost
    savedCfg.dualSenseNativeSkidThreshold = uiData.dualSenseNativeSkidThreshold
    savedCfg.dualSenseNativeSkidEngineDucking = uiData.dualSenseNativeSkidEngineDucking
    savedCfg.dualSenseNativeSkidAxlePitchSeparation = uiData.dualSenseNativeSkidAxlePitchSeparation
    savedCfg.dualSenseNativeMasterStrength = uiData.dualSenseNativeMasterStrength
    savedCfg.dualSenseBodyVibration   = uiData.dualSenseBodyVibration
    savedCfg.dualSenseBodyStrength    = uiData.dualSenseBodyStrength
    savedCfg.dualSenseBodyOutputBoost = uiData.dualSenseBodyOutputBoost
    savedCfg.dualSenseBodyDetailStacking = uiData.dualSenseBodyDetailStacking
    savedCfg.dualSenseBodyMinimumOutput = uiData.dualSenseBodyMinimumOutput
    savedCfg.dualSenseEngineStrength  = uiData.dualSenseEngineStrength
    savedCfg.dualSenseRoadStrength    = uiData.dualSenseRoadStrength
    savedCfg.dualSenseSlideStrength   = uiData.dualSenseSlideStrength
    savedCfg.dualSenseGripLossStrength = uiData.dualSenseGripLossStrength
    savedCfg.dualSenseFrontSlipStrength = uiData.dualSenseFrontSlipStrength
    savedCfg.dualSenseRearSlipStrength = uiData.dualSenseRearSlipStrength
    savedCfg.dualSenseSlipThreshold   = uiData.dualSenseSlipThreshold
    savedCfg.dualSenseCurbStrength    = uiData.dualSenseCurbStrength
    savedCfg.dualSenseDirectionalCrossfeed = uiData.dualSenseDirectionalCrossfeed
    savedCfg.dualSenseDirtStrength    = uiData.dualSenseDirtStrength
    savedCfg.dualSenseCollisionStrength = uiData.dualSenseCollisionStrength
    savedCfg.dualSenseABSStrength     = uiData.dualSenseABSStrength
    savedCfg.dualSenseShiftStrength   = uiData.dualSenseShiftStrength
    savedCfg.dualSenseDownshiftStrength = uiData.dualSenseDownshiftStrength
    savedCfg.dualSenseShiftDuration   = uiData.dualSenseShiftDuration
    savedCfg.dualSenseTriggersEnabled = uiData.dualSenseTriggersEnabled
    savedCfg.dualSenseBrakeResistance = uiData.dualSenseBrakeResistance
    savedCfg.dualSenseThrottleResistance = uiData.dualSenseThrottleResistance
    savedCfg.dualSenseBrakeCurve      = uiData.dualSenseBrakeCurve
    savedCfg.dualSenseThrottleCurve   = uiData.dualSenseThrottleCurve
    savedCfg.dualSenseABSFeedback     = uiData.dualSenseABSFeedback
    savedCfg.dualSenseABSFrequency    = uiData.dualSenseABSFrequency
    savedCfg.dualSenseWheelspinFeedback = uiData.dualSenseWheelspinFeedback
    savedCfg.dualSenseWheelspinThreshold = uiData.dualSenseWheelspinThreshold
    savedCfg.dualSenseWheelspinFrequency = uiData.dualSenseWheelspinFrequency
    savedCfg.dualSenseLimiterResistance = uiData.dualSenseLimiterResistance
    savedCfg.dualSenseLimiterFrequency = uiData.dualSenseLimiterFrequency
    savedCfg.dualSenseShiftResistance = uiData.dualSenseShiftResistance
    savedCfg.dualSenseDownshiftThrottleKick = uiData.dualSenseDownshiftThrottleKick
    savedCfg.dualSenseTriggerMasterStrength = uiData.dualSenseTriggerMasterStrength
    savedCfg.dualSenseBrakeDeadzone = uiData.dualSenseBrakeDeadzone
    savedCfg.dualSenseThrottleDeadzone = uiData.dualSenseThrottleDeadzone
    savedCfg.dualSenseBrakeForceFloor = uiData.dualSenseBrakeForceFloor
    savedCfg.dualSenseThrottleForceFloor = uiData.dualSenseThrottleForceFloor
    savedCfg.dualSenseBrakeWallAt = uiData.dualSenseBrakeWallAt
    savedCfg.dualSenseThrottleWallAt = uiData.dualSenseThrottleWallAt
    savedCfg.dualSenseBrakeWallForce = uiData.dualSenseBrakeWallForce
    savedCfg.dualSenseThrottleWallForce = uiData.dualSenseThrottleWallForce
    savedCfg.dualSensePulseReleaseDepth = uiData.dualSensePulseReleaseDepth
    savedCfg.dualSensePulsePeakForce = uiData.dualSensePulsePeakForce
    savedCfg.filterSetting            = uiData.filterSetting
    savedCfg.steeringRate             = uiData.steeringRate
    savedCfg.targetSlip               = uiData.targetSlip
    savedCfg.rateIncreaseWithSpeed    = uiData.rateIncreaseWithSpeed
    savedCfg.selfSteerResponse        = uiData.selfSteerResponse
    savedCfg.dampingStrength          = uiData.dampingStrength
    savedCfg.maxSelfSteerAngle        = uiData.maxSelfSteerAngle
    savedCfg.countersteerResponse     = uiData.countersteerResponse
    savedCfg.maxDynamicLimitReduction = uiData.maxDynamicLimitReduction
    savedCfg.gyroSteeringEnabled      = uiData.gyroSteeringEnabled
    savedCfg.gyroSteeringSensitivity  = uiData.gyroSteeringSensitivity
    savedCfg.gyroSteeringDeadzone     = uiData.gyroSteeringDeadzone
    savedCfg.gyroSteeringSmoothing    = uiData.gyroSteeringSmoothing
    savedCfg.gyroSteeringCentering    = uiData.gyroSteeringCentering
    savedCfg.gyroSteeringMaxAngle     = uiData.gyroSteeringMaxAngle
    savedCfg.gyroSteeringHighSpeedStability = uiData.gyroSteeringHighSpeedStability
    savedCfg.gyroSteeringStickBlend   = uiData.gyroSteeringStickBlend
    savedCfg.gyroSteeringInvert       = uiData.gyroSteeringInvert
    savedCfg.gyroSteeringProfileVersion = 108
    savedCfg.photoMode                = uiData.photoMode

    if math.abs(lastGameGamma - uiData._gameGamma) > 1e-6 then
        if setGameCfgValue("X360", "STEER_GAMMA", uiData._gameGamma) then
            lastGameGamma = uiData._gameGamma
        end
    end

    if math.abs(lastGameDeadzone - uiData._gameDeadzone) > 1e-6 then
        if setGameCfgValue("X360", "STEER_DEADZONE", uiData._gameDeadzone) then
            lastGameDeadzone = uiData._gameDeadzone
        end
    end

    if math.abs(lastGameRumble - uiData._gameRumble) > 1e-6 then
        if setGameCfgValue("X360", "RUMBLE_INTENSITY", uiData._gameRumble) then
            lastGameRumble = uiData._gameRumble
        end
    end

    -- uiData._appCanRun = true
end

local function sanitizeSteeringInput(value)
    return lib.numberGuard(math.clamp(value, -1, 1))
end

local function sanitize01Input(value)
    return lib.numberGuard(math.clamp(value, 0, 1))
end

local function calcSteeringCurveExponent(Vx, Vy)
    Vy = math.clamp(Vy, 0.001, 0.999) -- Otherwise the function might do dumb shit
    return math.log(1.0 - Vy, 10) / math.log(1.0 - Vx, 10)
end

local function inputToNormalizedSteering(input, steeringCurveExp)
    return math.sign(input) * (1.0 - math.pow(1.0 - math.abs(input), steeringCurveExp))
end

local function normalizedSteeringToInput(steeringAngleNormalized, steeringCurveExp)
    return math.sign(steeringAngleNormalized) * (1.0 - math.pow(1.0 - math.abs(steeringAngleNormalized), 1.0 / steeringCurveExp))
end

local _tmpVec0 = vec3()
local _tmpVec1 = vec3()
-- Returns the current steering angle of the car in degrees. It's an average of the angle of both front wheels.
local function getCurrentSteeringAngleDeg(vehicle, inverseBodyTransform)
    inverseBodyTransform:transformVectorTo(_tmpVec0, vehicle.wheels[0].look)
    inverseBodyTransform:transformVectorTo(_tmpVec1, vehicle.wheels[1].look)
    return -math.deg(lib.numberGuard(math.atan2(_tmpVec0.x + _tmpVec1.x, _tmpVec0.z + _tmpVec1.z)))
end

-- Analyzes the samples collected during the steering calibration and returns the steering curve exponent that should be used with `inputToNormalizedSteering()` and `normalizedSteeringToInput()`.
local function evaluateSteeringCurve(samples, steeringLock)
    local sampleCount      = 0
    local acc              = 0
    local sampleWindowLow  = math.clamp( 3.5 / vehicleSteeringLock, 0.10, 0.25) -- These adjust the window of valid samples based on the car's steering lock, hopefully making the calibration more accurate for typical steering angles
    local sampleWindowHigh = math.clamp(10.0 / vehicleSteeringLock, 0.45, 0.60)
    for _, value in ipairs(samples) do
        if value[1] >= sampleWindowLow and value[1] <= sampleWindowHigh then
            local valueToAdd = calcSteeringCurveExponent(value[1], value[2] / steeringLock)
            if valueToAdd and not math.isNaN(valueToAdd) then
                acc = acc + valueToAdd
                sampleCount = sampleCount + 1
            end
        end
    end
    return acc / sampleCount
end

local function retryCalibration(silent)
    if not silent then ac.setMessage("DualSense Gamepad Assist", "Error - Steering calibration failed. Retrying ...") end
    -- cfg._appCanRun = false
    calibrationSuccess = false
    calibrationSavedWheels = false
    calibrationStage = 0
    calibrationDelay = 0
    calibrationLockDelay = 0
    steeringExponent = 0.95
    calibrationRateMult = math.NaN
    table.clear(steeringCurveSamples)
    vehicleSteeringLock = math.NaN

    storedCarPerformanceData = nil
end

-- Hijacks the throttle / brake / handbrake/ steering inputs to perform calibration. Returns `true` if the calibration is over or aborted, `false` if it's in progress.
local function performCalibration(inputData, vehicle, inverseBodyTransform, dt)
    if vehicle.velocity:length() > 0.5 and calibrationStage == 0 then
        if not (vehicle.wheels[0].loadK == 0.0 or vehicle.wheels[1].loadK == 0.0) then
            calibrationPreDelay = calibrationPreDelay + dt
        end
        if calibrationPreDelay > 1.5 then
            calibrationStage = 2
            return true
        else
            inputData.gas       = 0.0
            inputData.handbrake = 1.0
            inputData.brake     = 1.0
            inputData.clutch    = 0.0
            return false
        end
    end

    if calibrationStage < 2 then

        if math.isNaN(calibrationRateMult) then
            calibrationRateMult = math.clamp((ac.getSim().fps - 6.0) / 60.0, 0.6, 1.3)
        end

        inputData.gas       = 0.0
        inputData.handbrake = 1.0
        inputData.brake     = 1.0
        inputData.clutch    = 0.0
        inputData.steer     = calibrationSmoother.state

        local currentAbsAngle = lib.numberGuard(math.abs(getCurrentSteeringAngleDeg(vehicle, inverseBodyTransform)))

        if calibrationDelay < 0.7 or currentAbsAngle < 0.2 then
            calibrationDelay = calibrationDelay + dt
            inputData.steer = sanitizeSteeringInput(calibrationSmoother:getWithRateMult(0.05, dt, 5.0))
            return false
        end

        if not calibrationSavedWheels then
            calibrationSavedWheels = true
            inverseBodyTransform:transformPoint(vehicle.wheels[0].position):copyTo(localWheelPositions[0])
            inverseBodyTransform:transformPoint(vehicle.wheels[1].position):copyTo(localWheelPositions[1])
            inverseBodyTransform:transformPoint(vehicle.wheels[2].position):copyTo(localWheelPositions[2])
            inverseBodyTransform:transformPoint(vehicle.wheels[3].position):copyTo(localWheelPositions[3])
            fAxlePos:set(localWheelPositions[0]):add(localWheelPositions[1]):scale(0.5)
            rAxlePos:set(localWheelPositions[2]):add(localWheelPositions[3]):scale(0.5)
            avgWheelPos:set(localWheelPositions[0]):add(localWheelPositions[1]):add(localWheelPositions[2]):add(localWheelPositions[3]):scale(0.25)
            avgWheelPos.x = math.round(avgWheelPos.x * 1000.0) / 1000.0
            avgWheelPos.y = math.round(avgWheelPos.y * 1000.0) / 1000.0
            avgWheelPos.z = math.round(avgWheelPos.z * 1000.0) / 1000.0
            if math.abs(rAxlePos.x) > 0.01 or math.abs(fAxlePos.x) > 0.01 then
                ac.setMessage("DualSense Gamepad Assist", "Warning - The average wheel position seems off-center.")
            end
        end

        if calibrationStage == 0 then
            if #steeringCurveSamples == 0 or math.abs(currentAbsAngle - steeringCurveSamples[#steeringCurveSamples][2]) > 1e-6 then
                table.insert(steeringCurveSamples, {calibrationSmoother.state, currentAbsAngle})
            end
            inputData.steer = sanitizeSteeringInput(calibrationSmoother:getWithRateMult(1, dt, calibrationRateMult))
            if (1.0 - inputData.steer) < 1e-10 then
                calibrationLockDelay = calibrationLockDelay + dt
                if calibrationLockDelay > 0.2 then
                    calibrationStage = calibrationStage + 1
                end
            end
        elseif calibrationStage == 1 then
            if math.isNaN(vehicleSteeringLock) then
                vehicleSteeringLock = currentAbsAngle
                if not (vehicleSteeringLock > 3.0 and vehicleSteeringLock < 90.0) then
                    if calibrationTries < (calibrationMaxTries - 1) then
                        calibrationTries = calibrationTries + 1
                        retryCalibration()
                        return false
                    end
                    ac.setMessage("DualSense Gamepad Assist", "Error - Failed to determine steering lock. Using a fallback value.")
                    vehicleSteeringLock = -1
                end
                steeringExponent = lib.numberGuard(evaluateSteeringCurve(steeringCurveSamples, vehicleSteeringLock))
                if not (steeringExponent > 0.5 and steeringExponent < 2.0) then
                    if calibrationTries < (calibrationMaxTries - 1) then
                        calibrationTries = calibrationTries + 1
                        retryCalibration()
                        return false
                    end
                    ac.setMessage("DualSense Gamepad Assist", "Error - Failed to determine steering curve. Using a fallback value.")
                    steeringExponent = 0.95
                end
            end
            inputData.steer = sanitizeSteeringInput(calibrationSmoother:getWithRateMult(0, dt, 5.0))
            if inputData.steer < 1e-6 then
                calibrationStage = calibrationStage + 1
                calibrationSuccess = true
                if vehicleSteeringLock == -1 then vehicleSteeringLock = math.NaN end
            end
        end

        return false
    end

    return true
end

-- local function worldVecToLocal(objForward, objUp, worldVector)
--     local objRight = math.cross(objForward, objUp):scale(-1.0)
--     local localX   = worldVector:dot(objRight)
--     local localY   = worldVector:dot(objUp)
--     local localZ   = worldVector:dot(objForward)
--     objRight:set(localX, localY, localZ)
--     return objRight
-- end

local prevGearSetHash = 0
-- Returns `true` if the gear set hash had to be updated
---@param vehicle ac.StateCar
---@param cPhys ac.StateCarPhysics
local function updateGearSetHash(vehicle, cPhys)

    if vehicle.gearCount < 1 or not cPhys.gearRatios or #cPhys.gearRatios == 0 then return false end

    local currentGearSetHash = 0

    for gear = 1, vehicle.gearCount, 1 do
        currentGearSetHash = currentGearSetHash + (cPhys.gearRatios[gear + 1] * gear * 16)
    end

    currentGearSetHash = currentGearSetHash + cPhys.finalRatio * 1024
    currentGearSetHash = currentGearSetHash + vehicle.rpmLimiter

    local ret = (currentGearSetHash ~= prevGearSetHash)

    prevGearSetHash = currentGearSetHash

    return ret
end

local storedLocalWheelVel      = {[0] = vec3(), vec3(), vec3(), vec3()} -- Stores local wheel velocities to avoid creating new vectors on every update
-- local storedWeightedFLocalVel  = vec3()
local storedFAxleLocalVel      = vec3()
local storedRAxleLocalVel      = vec3()
local storedMiddleVel          = vec3()
local storedVData              = {}
local tmpTable2                = {}
local tmpTable4                = {}

-- Returns all relevant measurements and data related to the vehicle, or `nil` if the steering clibration has not finished yet
local function getVehicleData(dt, skipCalibration)
    local inputData            = ac.getJoypadState()
    local vehicle              = ac.getCar(0) or car
    local inverseBodyTransform = vehicle.transform:inverse()

    if not skipCalibration then
        if not performCalibration(inputData, vehicle, inverseBodyTransform, dt) then return nil end
    end

    local fWheelWeights   = {lib.zeroGuard(vehicle.wheels[0].load), lib.zeroGuard(vehicle.wheels[1].load)}
    local rWheelWeights   = {lib.zeroGuard(vehicle.wheels[2].load), lib.zeroGuard(vehicle.wheels[3].load)}
    local allWheelWeights = {fWheelWeights[1], fWheelWeights[2], rWheelWeights[1], rWheelWeights[2]}

    tmpTable2[1]       = vehicle.wheels[0].slipAngle
    tmpTable2[2]       = vehicle.wheels[1].slipAngle
    local frontSlipDeg = lib.numberGuard(lib.weightedAverage(tmpTable2, fWheelWeights))
    tmpTable2[1]       = vehicle.wheels[2].slipAngle
    tmpTable2[2]       = vehicle.wheels[3].slipAngle
    local rearSlipDeg  = lib.numberGuard(lib.weightedAverage(tmpTable2, rWheelWeights))
    tmpTable2[1]       = vehicle.wheels[0].ndSlip
    tmpTable2[2]       = vehicle.wheels[1].ndSlip
    local frontNdSlip  = lib.numberGuard(lib.weightedAverage(tmpTable2, fWheelWeights))
    tmpTable2[1]       = vehicle.wheels[2].ndSlip
    tmpTable2[2]       = vehicle.wheels[3].ndSlip
    local rearNdSlip   = lib.numberGuard(lib.weightedAverage(tmpTable2, rWheelWeights))
    tmpTable4[1]       = vehicle.wheels[0].ndSlip
    tmpTable4[2]       = vehicle.wheels[1].ndSlip
    tmpTable4[3]       = vehicle.wheels[2].ndSlip
    tmpTable4[4]       = vehicle.wheels[3].ndSlip
    local totalNdSlip  = lib.numberGuard(lib.weightedAverage(tmpTable4, allWheelWeights))


    local wheelbase       = math.abs(fAxlePos.z - rAxlePos.z)
    -- local trackWidth      = math.max(math.abs(localWheelPositions[0].x - localWheelPositions[1].x), math.abs(localWheelPositions[2].x - localWheelPositions[3].x))

    -- Updating local wheel velocities
    for i = 0, 3 do
        lib.getPointVelocity(localWheelPositions[i], vehicle.localAngularVelocity, vehicle.localVelocity, storedLocalWheelVel[i])
    end

    -- lib.weightedVecAverage({storedLocalWheelVel[0], storedLocalWheelVel[1]}, fWheelWeights, storedWeightedFLocalVel)
    lib.getPointVelocity(fAxlePos, vehicle.localAngularVelocity, vehicle.localVelocity, storedFAxleLocalVel)
    lib.getPointVelocity(rAxlePos, vehicle.localAngularVelocity, vehicle.localVelocity, storedRAxleLocalVel)
    lib.getPointVelocity(avgWheelPos, vehicle.localAngularVelocity, vehicle.localVelocity, storedMiddleVel)

    local cPhys = ac.getCarPhysics(vehicle.index)

    if not storedCarPerformanceData or updateGearSetHash(vehicle, cPhys) then
        storedCarPerformanceData = CarPerformanceData:new(vehicle)
        extras.clearGearData()
    end

    storedVData.inputData             = inputData -- ac.getJoypadState()
    storedVData.vehicle               = vehicle -- ac.getCar(0)
    storedVData.wheelbase             = wheelbase
    storedVData.wheelbaseFactor       = wheelbase / 2.5
    storedVData.inverseBodyTransform  = inverseBodyTransform -- Used for converting points or vectors from global space to local space
    storedVData.localVel              = storedMiddleVel -- Local velocity vector of the vehicle at the average position of all 4 wheels
    storedVData.localHVelLen          = math.sqrt(storedMiddleVel.x * storedMiddleVel.x + storedMiddleVel.z * storedMiddleVel.z) -- Velocity magnitude of the vehicle on the local horizontal plane (m/s)
    storedVData.localAngularVel       = vehicle.localAngularVelocity
    storedVData.localWheelVelocities  = storedLocalWheelVel -- Wheel velocities in local space, 0-based indexing
    storedVData.fWheelWeights         = fWheelWeights -- Front wheel loads, for using a weighted average
    storedVData.rWheelWeights         = rWheelWeights -- Rear wheel loads, for using a weighted average
    storedVData.travelDirection       = lib.numberGuard(math.deg(math.atan2(storedMiddleVel.x, storedMiddleVel.z))) -- The angle of the vehicle's velocity vector on the local horizontal plane (deg), at the average position of all wheels
    storedVData.frontSlipDeg          = frontSlipDeg -- Average front wheel slip angle, weighted by wheel load (deg)
    storedVData.rearSlipDeg           = rearSlipDeg -- Average rear wheel slip angle, weighted by wheel load (deg)
    storedVData.frontNdSlip           = frontNdSlip -- Average normalized front slip, weighted by wheel load
    storedVData.rearNdSlip            = rearNdSlip -- Average normalized rear slip, weighted by wheel load
    storedVData.totalNdSlip           = totalNdSlip
    storedVData.fwdVelClamped         = math.max(0.0, storedMiddleVel.z) -- Velocity along the local forwrad axis, positive only (m/s)
    storedVData.steeringLockDeg       = lib.numberGuard(vehicleSteeringLock, math.abs(inputData.steerLock / inputData.steerRatio))
    storedVData.fAxleLocalVel         = storedFAxleLocalVel -- Local velocity of the front axle (same as the average of the front wheels)
    storedVData.rAxleLocalVel         = storedRAxleLocalVel -- Local velocity of the rear axle (same as the average of the rear wheels)
    storedVData.fAxleHVelLen          = math.sqrt(storedFAxleLocalVel.x * storedFAxleLocalVel.x + storedFAxleLocalVel.z * storedFAxleLocalVel.z)
    storedVData.steeringCurveExponent = steeringExponent -- Used with normalizedSteeringToInput() and inputToNormalizedSteering()
    storedVData.frontGrounded         = groundedSmoother:get((vehicle.wheels[0].loadK == 0.0 and vehicle.wheels[1].loadK == 0.0) and 0.0 or 1.0, dt) -- Smoothed 0-1 value to indicate if the steered wheels are grounded
    storedVData.cPhys                 = cPhys
    storedVData.currentSteeringAngle  = getCurrentSteeringAngleDeg(vehicle, inverseBodyTransform)
    storedVData.perfData              = storedCarPerformanceData

    return storedVData
end

-- VERY crude estimation, only based on power and nothing else
local function getTopSpeedEstimate(vData)
    return (math.sqrt(vData.perfData.maxEnginePower * 80.0) + 75) / 3.6
end

-- Returns the rate multiplier that should be used for the steering filter
local function calcSteeringRateMult(fwdVelClamped, steeringLockDeg)
    local speedAdjustedRate = steeringLockDeg / math.min(65.0 / (math.max(fwdVelClamped, 8.0) - 7.3) + 3.5, steeringLockDeg)
    return math.pow(speedAdjustedRate, uiData.rateIncreaseWithSpeed) * uiData.steeringRate
end

-- Returns the corrected sterering angle with the steering limit and self-steer force applied, normalized to the car's steering lock
local function calcCorrectedSteering(vData, targetFrontSlipDeg, initialSteering, absInitialSteering, assistFadeIn, dt)
    -- Calculating baseline data

    local fAxleHVelAngle       = lib.numberGuard(math.deg(math.atan2(vData.fAxleLocalVel.x, math.abs(vData.fAxleLocalVel.z)))) -- Angle of the front axle velocity on the local horizontal plane, corrected for reverse (deg)
    local rAxleHVelAngle       = lib.numberGuard(math.deg(math.atan2(vData.rAxleLocalVel.x, math.abs(vData.rAxleLocalVel.z)))) -- Angle of the rear axle velocity on the local horizontal plane, corrected for reverse (deg)
    local inputSign            = math.sign(initialSteering) -- Sign of the initial steering input by the player (after smoothing)
    local midSpeedFade         = math.lerpInvSat(vData.localHVelLen, 10.0 * vData.wheelbaseFactor, 20.0 * vData.wheelbaseFactor) -- Used for fading some effects at medium speed

    -- Self-steer force

    local correctionExponent  = 1.0 + (1.0 - math.log10(10.0 * (uiData.selfSteerResponse * 0.9 + 0.1))) -- This is just to make `cfg.selfSteerResponse` scale in a better way
    local correctionBase      = lib.signedPow(math.clamp(-rAxleHVelAngle / 72.0, -1, 1), correctionExponent) * 72.0 / vData.steeringLockDeg -- Base self-steer force
    local selfSteerCap        = lib.clamp01(uiData.maxSelfSteerAngle / vData.steeringLockDeg) -- Max self-steer amount
    local selfSteerStrength   = math.max(1.0, vData.frontGrounded) * assistFadeIn -- Multiplier that can fade the self-steer force in and out
    local dampingForce        = vData.localAngularVel.y * uiData.dampingStrength * 0.15 * (30.0 / vData.steeringLockDeg) -- 0.2125 * 0.6 = 0.1275 -- 0.159375
    local selfSteerCapT       = math.min(1.0, 4.0 / (2.0 * selfSteerCap)) -- Easing window
    local rawSelfSteer        = lib.clampEased(correctionBase, -selfSteerCap, selfSteerCap, selfSteerCapT) + dampingForce
    local selfSteerForce      = math.clamp(selfSteerSmoother:get(rawSelfSteer, dt), -2.0, 2.0) * selfSteerStrength
    uiData._selfSteerStrength = selfSteerStrength * (1.0 - absInitialSteering)

    -- Steering limit

    local finalTargetSlip      = targetFrontSlipDeg * uiData.targetSlip
    -- finalTargetSlip            = finalTargetSlip * math.lerp(1.0, 0.5, math.lerpInvSat(inputSign * fAxleHVelAngle, -finalTargetSlip * 0.1, finalTargetSlip * 0.5))
    uiData._maxLimitReduction  = math.lerp(finalTargetSlip * 0.4, finalTargetSlip * 0.75, lib.clamp01(uiData.maxDynamicLimitReduction / 10.0)) -- math.lerp(0.8, 1.2, lib.clamp01(vData.localHVelLen / getTopSpeedEstimate(vData)))
    local angleSubLimit        = math.lerp(uiData._maxLimitReduction, uiData._maxLimitReduction * 0.9, vData.inputData.brake) -- How many degrees the steering limit is allowed to reduce when the car oversteers, in the process of trying to maintain the desired front slip angle -- + math.max(0.0, -inputSign * selfSteerForce * vData.steeringLockDeg)
    local clampedFAxleVelAngle = lib.clampEased(inputSign * fAxleHVelAngle, -vData.steeringLockDeg - 15.0, angleSubLimit, (angleSubLimit * 0.4) / (vData.steeringLockDeg + 15.0 + angleSubLimit)) -- Limiting how much the front velocity angle can affect the steering limit
    if vData.localHVelLen > 1e-15 then
        uiData._rAxleHVelAngle = rAxleHVelAngle
        uiData._limitReduction = math.max(clampedFAxleVelAngle, 0.0)
    end

    local isCountersteering   = (inputSign ~= math.sign(lib.zeroGuard(vData.rAxleLocalVel.x)) and math.abs(initialSteering) > 1e-6) -- Boolean to indicate if the player is countersteering
    local rawCounterIndicator = isCountersteering and lib.inverseLerpClampedEased(4.5, 10.0, math.abs(rAxleHVelAngle), 0.0, 1.0, 0.6) or 0.0 -- Countersteer factor before smoothing
    local returnRate          = math.lerp(0.8, 0.3, math.lerpInvSat(math.abs(fAxleHVelAngle - rAxleHVelAngle), 2.0, 10.0))
    local counterIndicator    = counterIndicatorSmoother:getWithRateMult(rawCounterIndicator, dt, rawCounterIndicator < counterIndicatorSmoother.state and returnRate or 1.0) * midSpeedFade -- Final 0-1 multiplier to indicate if the player is countersteering

    local antiSelfSteer       = absInitialSteering * -selfSteerForce -- This prevents the self-steer force from affecting the steering limit
    local targetInward        = finalTargetSlip - clampedFAxleVelAngle -- Steering limit when turning inward
    local counterMult         = math.lerp(math.lerpInvSat(-inputSign * rAxleHVelAngle, 0.0, 30.0) * (1.0 / 3.0) + (2.0 / 3.0), 1.0, uiData.countersteerResponse) -- Makes manual countersteering a bit less sensitive near the center
    local targetCounter       = (finalTargetSlip * (uiData.countersteerResponse * counterMult * 0.7 + 0.1)) - (inputSign * rAxleHVelAngle) -- Steering limit when countersteering

    local targetSteeringAngle = math.lerp(math.clamp(targetInward, 0, vData.steeringLockDeg), math.clamp(targetCounter, 0, vData.steeringLockDeg), counterIndicator) -- The steering angle that would result in the targeted slip angle
    local notForward          = math.sin(math.clamp(math.rad(vData.travelDirection * 2.0 / 3.0), -math.pi * 0.5, math.pi * 0.5)) ^ 16 -- Gets rid of the steering limit when going backwards
    local smoothLimit         = limitSmoother:get(targetSteeringAngle, dt)
    local limit               = math.lerp(smoothLimit / vData.steeringLockDeg, 1.0, notForward) -- The final steering limit (absolute)

    return math.clamp((initialSteering * limit) + selfSteerForce + antiSelfSteer, -1.0, 1.0)
end

-- Updates the graphs in the UI app
local function updateDisplayValues(vData, assistFadeIn, assistEnabled, dt)
    if assistFadeIn < 1e-15 and assistEnabled then
        uiData._rAxleHVelAngle    = 0
        uiData._selfSteerStrength = 0
        uiData._limitReduction    = 0
        uiData._frontNdSlip       = 0
        uiData._rearNdSlip        = 0
    else
        if not assistEnabled then
            uiData._rAxleHVelAngle    = 0
            uiData._selfSteerStrength = 0
            uiData._limitReduction    = 0
            uiData._rawSteer          = vData.inputData.steerStickX
        end
        uiData._frontNdSlip = frontSlipDisplaySmoother:get(vData.frontNdSlip, dt)
        uiData._rearNdSlip  = rearSlipDisplaySmoother:get(vData.rearNdSlip, dt)
    end

    uiData._finalSteer = vData.inputData.steer
end

local function updateGyroDisplayValues(available, raw, output)
    uiData._gyroSteeringAvailable = available
    uiData._gyroSteeringRaw = raw or 0
    uiData._gyroSteeringOutput = output or 0
    if available then
        uiData._rawSteer = raw or 0
        uiData._finalSteer = output or 0
    end
end

ac.onSharedEvent("DSGA_calibrateSteering", function()
    if not uiData.assistEnabled then
        ac.setMessage("DualSense Gamepad Assist", "You have to enable the assist to re-calibrating the steering!")
        return
    end
    if ac.getCar(0).velocity:length() > 0.5 then
        ac.setMessage("DualSense Gamepad Assist", "You must stop the car before re-calibrating the steering!")
        return
    end
    retryCalibration(true)
end)

local brakeTarget    = 1.0
local throttleTarget = 1.0
local prevBrakeNd    = 0.0
local prevThrottleNd = 0.0

local function syncControllerPedalsForExtras(vData)
    extras.rawThrottle = lib.clamp01(vData.inputData.gas)
    extras.controllerThrottle = vData.inputData.gas
    extras.controllerBrake = vData.inputData.brake
end

local function processGyroSteeringInput(vData, dt)
    local speedKmh = vData.vehicle.speedKmh or car.speedKmh or (vData.localHVelLen * 3.6)
    local gyroSteer, available, raw = gyroInput.update(vData.inputData, uiData, speedKmh, dt)
    if not available then
        gyroSteer = sanitizeSteeringInput(vData.inputData.steerStickX)
        raw = gyroSteer
    end
    gyroSteer = sanitizeSteeringInput(gyroSteer)
    updateGyroDisplayValues(available, raw, gyroSteer)
    return gyroSteer, available
end

-- Reads controller and keyboard input (if enabled), and performs the initial smoothing and processing
local function processInitialInput(vData, kbMode, steeringRateMult, extrasObj, dt)
    local kbSteer = 0

    if kbMode > 0 then
        -- Applying an extra layer of smoothing to keyboard steering input that works better for key tapping
        local kbRawSteer = (ac.isKeyDown(kbSteerRBind) and 1.0 or 0.0) + (ac.isKeyDown(kbSteerLBind) and -1.0 or 0.0)
        local kbRateMult = (math.abs(kbSteerSmoother.state) - math.sign(kbSteerSmoother.state) * kbRawSteer) > 0.0 and 1.5 or 1.0 -- 2.0 or 1.0 ?
        kbSteer          = kbSteerSmoother:getWithRateMult(kbRawSteer, dt, steeringRateMult * kbRateMult)
    else
        kbSteerSmoother.state = 0.0
    end

    local rawSteer           = sanitizeSteeringInput(vData.inputData.steerStickX + kbSteer)
    local centeringRate      = 1.0 -- Faster centering rate when the steering rate is under 50%
    if steeringRateMult > 0.0 and steeringRateMult < 0.5 then
        if (math.abs(rawSteer) < math.abs(steeringSmoother.state) and math.sign(rawSteer) == math.sign(steeringSmoother.state)) or (math.sign(rawSteer) ~= math.sign(steeringSmoother.state)) then
            centeringRate = (steeringRateMult * 0.5 + 0.25) / steeringRateMult
        end
    end

    if vData.localHVelLen < 0.5 and uiData.photoMode then
        rawSteer = (math.abs(rawSteer) > math.abs(steeringSmoother.state) or math.sign(rawSteer) ~= math.sign(steeringSmoother.state)) and sanitizeSteeringInput(steeringSmoother.state + rawSteer * dt * 100.0) or steeringSmoother.state
    end

    uiData._rawSteer         = rawSteer
    local initialSteering    = steeringSmoother:getWithRateMult(rawSteer, dt, steeringRateMult * centeringRate) -- Steering input with no processing (except smoothing)
    local absInitialSteering = absSteeringSmoother:getWithRateMult(math.abs(rawSteer), dt, steeringRateMult * centeringRate) -- Absolute steering input with no processing (except smoothing)

    local kbThrottle = 0.0
    local kbBrake    = 0.0

    if kbMode > 0 then
        kbThrottle = kbThrottleSmoother:get(ac.isKeyDown(kbThrottleBind) and 1.0 or 0.0, dt)
        kbBrake    = kbBrakeSmoother:get(ac.isKeyDown(kbBrakeBind) and 1.0 or 0.0, dt)
    else
        kbThrottleSmoother.state = 0.0
        kbBrakeSmoother.state    = 0.0
    end

    extrasObj.rawThrottle        = lib.clamp01(vData.inputData.gas + kbThrottle)
    extrasObj.controllerThrottle = vData.inputData.gas
    extrasObj.controllerBrake    = vData.inputData.brake

    -- // TODO detect these in a better way
    local brakeNdUsed        = vData.totalNdSlip
    local slipSub            = math.lerp(0.25, 0.35, lib.clamp01(lib.inverseLerp(40.0, 160.0, vData.localHVelLen * 3.6)))
    local throttleNdUsed     = ((vData.vehicle.tractionType == 1) and vData.frontNdSlip or vData.rearNdSlip) - slipSub
    extrasObj.brakeNdUsed    = brakeNdUsed + 0.15
    extrasObj.throttleNdUsed = throttleNdUsed

    if kbMode > 0 then

        local finalBrakeTarget = 1.0
        local finalThrottleTarget = 1.0

        if kbMode > 1 then
            if vData.vehicle.absMode == 0 then
                -- Applying brake assistance to keyboard input
                local brakNdUsed2     = brakeNdUsed + 0.15
                local extBrakeNd      = math.clamp(brakNdUsed2 + dt * 5000.0 * (brakNdUsed2 - prevBrakeNd), 0, 2.0)
                brakeTarget           = sanitize01Input(math.max(0.3, brakeTarget + dt * 10.0 * (extBrakeNd < 1 and (-1.0 * extBrakeNd + 1.0) or (-3.0 * extBrakeNd + 3.0))))
                finalBrakeTarget      = brakeTarget
                prevBrakeNd           = brakNdUsed2
            end
        end

        if kbMode > 2 then
            if vData.vehicle.tractionControlMode == 0 then
                -- Applying throttle assistance to keyboard input
                local extThrottleNd     = math.clamp(throttleNdUsed + dt * 5000.0 * (throttleNdUsed - prevThrottleNd), 0, 2.0)
                local tMin              = math.lerp(0.6, 0.8, lib.clamp01(lib.inverseLerp(40.0, 160.0, vData.localHVelLen * 3.6)))
                throttleTarget          = sanitize01Input(math.max(tMin, throttleTarget + dt * 10.0 * (extThrottleNd < 1 and (-1.0 * extThrottleNd + 1.0) or (-3.0 * extThrottleNd + 3.0))))
                finalThrottleTarget     = throttleTarget
                prevThrottleNd          = throttleNdUsed
            end
        end

        vData.inputData.brake = sanitize01Input(vData.inputData.brake + kbBrake * finalBrakeTarget)
        vData.inputData.gas   = sanitize01Input(vData.inputData.gas + kbThrottle * finalThrottleTarget)
    end

    return initialSteering, absInitialSteering
end

local logTimer = 0.0

function script.update(dt)
    if car.isAIControlled or not car.physicsAvailable then return end

    uiData._appCanRun = true

    local vData = getVehicleData(dt, not uiData.assistEnabled or uiData.gyroSteeringEnabled) -- Vehicle data such as velocities, slip angles etc.

    if not vData then return end

    if uiData.assistEnabled and not calibrationSuccess then
        ac.setMessage("DualSense Gamepad Assist", "Error - Failed to calibrate steering. Stop the vehicle and try again. Using fallback values.")
        calibrationSuccess = true
    end

    if uiData.assistEnabled and calibrationSuccess and calibrationTries > 0 then
        ac.setMessage("DualSense Gamepad Assist", "Calibration successful!")
        calibrationTries = 0
    end

    updateConfig() -- Updates the config values based on the settings in the UI app

    local desiredSteering = 0 -- The desired steering angle normalized to the car's steering lock
    local assistFadeIn    = 0 -- Controls how the steering processing is faded in and out at low speeds

    if uiData.gyroSteeringEnabled then
        local gyroSteer = processGyroSteeringInput(vData, dt)

        desiredSteering       = gyroSteer
        vData.inputData.steer = gyroSteer

        syncControllerPedalsForExtras(vData)
        extras.update(vData, uiData, math.abs(gyroSteer), dt)

        if vData.inputData.rumbleEffects == 0.0 then
            vData.inputData.vibrationLeft  = 0.0
            vData.inputData.vibrationRight = 0.0
        end
    elseif uiData.assistEnabled then
        local steeringRateMult                    = calcSteeringRateMult(vData.localHVelLen, vData.steeringLockDeg)
        local initialSteering, absInitialSteering = processInitialInput(vData, uiData.keyboardMode, steeringRateMult, extras, dt)

        vData.perfData:updateTargetFrontSlipAngle(vData, initialSteering, dt)

        assistFadeIn            = math.lerpInvSat(vData.fAxleHVelLen, 2.0 * vData.wheelbaseFactor, 6.0 * vData.wheelbaseFactor)
        local processedSteering = calcCorrectedSteering(vData, vData.perfData:getTargetFrontSlipAngle(), initialSteering, absInitialSteering, assistFadeIn, dt)

        desiredSteering         = math.lerp(initialSteering, processedSteering, assistFadeIn)
        vData.inputData.steer   = sanitizeSteeringInput(normalizedSteeringToInput(desiredSteering, vData.steeringCurveExponent)) -- Final steering input sent to the car

        extras.update(vData, uiData, absInitialSteering, dt) -- Updating extra functionality like auto clutch etc.

        -- vData.inputData.vibrationLeft  = sanitize01Input(vData.inputData.vibrationLeft  - 0.01)
        -- vData.inputData.vibrationRight = sanitize01Input(vData.inputData.vibrationRight - 0.01)

        if vData.inputData.rumbleEffects == 0.0 then
            vData.inputData.vibrationLeft  = 0.0
            vData.inputData.vibrationRight = 0.0
        end
    end

    dualSenseFeedback.update(vData, uiData, dt)

    updateDisplayValues(vData, assistFadeIn, uiData.assistEnabled and not uiData.gyroSteeringEnabled, dt) -- Updating graphs

    -- Logging data

    if slowLog then
        logTimer = logTimer + dt

        if logTimer < 0.0125 then
            return
        end

        logTimer = 0
    end

    local steeringAngleGraphLimit = math.ceil(vehicleSteeringLock / 10.0) * 10.0
    local powerGraphLimit = math.ceil(vData.perfData.maxEnginePower * 1.05 * ((vData.vehicle.mgukDeliveryCount > 0) and 3.0 or 1.0) / 100.0) * 100.0

    ac.debug("A) Relative front slip [%]",            math.round(vData.frontNdSlip * 100.0, 1), 0.0, 200.0)
    ac.debug("B) Relative rear slip [%]",             math.round(vData.rearNdSlip * 100.0, 1), 0.0, 200.0)
    ac.debug("C) Target front slip angle [deg]",      math.round(vData.perfData:getTargetFrontSlipAngle(), 2), 0.0, 15.0)
    ac.debug("D) Front slip angle [deg]",             math.round(vData.frontSlipDeg, 2), -45.0, 45.0)
    ac.debug("E) Rear slip angle [deg]",              math.round(vData.rearSlipDeg, 2), -45.0, 45.0)
    ac.debug("F) Measured steering lock [deg]",       math.round(vData.steeringLockDeg, 2), -90.0, 90.0)
    ac.debug("G) Steering angle [deg]",               math.round(vData.currentSteeringAngle, 2), -steeringAngleGraphLimit, steeringAngleGraphLimit)
    ac.debug("H) Intended steering angle [deg]",      math.round(desiredSteering * vData.steeringLockDeg, 2), -steeringAngleGraphLimit, steeringAngleGraphLimit)
    ac.debug("I) Steering curve exponent (measured)", math.round(vData.steeringCurveExponent, 3))
    ac.debug("J) RPM",                                vData.vehicle.rpm, 0.0, vData.perfData.maxRPM)
    ac.debug("K) Engine limiter active",              vData.vehicle.isEngineLimiterOn)
    ac.debug("L) Drivertrain power [HP]",             vData.vehicle.drivetrainPower, 0.0, powerGraphLimit)
    ac.debug("M) Extended physics",                   vData.vehicle.extendedPhysics)

    -- ac.debug("Z) FFB",   vData.vehicle.ffbFinal, -1, 1)
    -- ac.debug("Z) W1 MZ", vData.vehicle.wheels[1].mz, -200.0, 200.0)
    -- ac.debug("Z) W1 FX", vData.vehicle.wheels[1].fy, -10000.0, 10000.0)
    -- ac.debug("Z) W1 FY", vData.vehicle.wheels[1].fx, -10000.0, 10000.0)
end

ac.onControlSettingsChanged(function ()
    readGameControls()
end)

ac.onRelease(function()
    uiData._appCanRun = false
    dualSenseFeedback.release()
end)

ac.onCarJumped(car.index, function ()
    storedCarPerformanceData = nil
end)

if type(ac.onTyresSetChange) == "function" then -- Only in CSP 0.2.1+
    ac.onTyresSetChange(car.index, function ()
        storedCarPerformanceData = nil
    end)
end

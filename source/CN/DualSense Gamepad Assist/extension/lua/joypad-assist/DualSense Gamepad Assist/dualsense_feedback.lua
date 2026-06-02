-- Native DualSense haptics and adaptive triggers for Assetto Corsa.

local M = {}

local clock = 0
local collisionTimer = 0
local shiftTimer = 0
local shiftDirection = 0
local previousGear = nil
local triggersWereActive = false
local nativeHapticTestEffect = nil
local nativeHapticTestTimer = 0
local nativeHapticGamepadIndex = nil
local nativeHapticApplyTimer = 0
local appliedNativeHapticParams = {}
local bodyYVelocitySmooth = 0
local bodyVelocityInitialized = false
local previousLoadK = {[0] = 0, 0, 0, 0}
local loadsInitialized = false

-- Keep this compatibility layer deliberately fixed to the validated 0.5.1
-- defaults. The UI only exposes an on/off switch and the shared grip multiplier.
local legacyBody = {
    bodyStrength = 0.85,
    engineStrength = 0.045,
    roadStrength = 0.62,
    slideStrength = 0.58,
    gripLossStrength = 0.92,
    frontSlipStrength = 0.92,
    rearSlipStrength = 1.0,
    curbStrength = 1.0,
    directionalCrossfeed = 0.08,
    dirtStrength = 0.68,
    collisionStrength = 1.0,
    absStrength = 0.75,
    shiftStrength = 0.62,
    downshiftStrength = 0.58,
}

local nativeHapticDefaults = {
    Bodywork        = {0.5, 1.0, 0.0, 0.0},
    Engine          = {1.0, 1.0, 0.0, 0.9},
    Gear            = {1.0, 1.0, 0.0, 0.0},
    GearGrind       = {1.0, 1.0, 0.0, 0.0},
    Limiter         = {1.0, 1.0, 0.0, 0.0},
    Skid            = {2.0, 1.0, 0.0, 0.0},
    Wheel           = {2.0, 1.0, 0.0, 0.0},
    CollisionCar    = {3.0, 1.0, 0.0, 0.0},
    CollisionObject = {3.0, 1.0, 0.0, 0.0},
    CollisionTrack  = {3.0, 1.0, 0.0, 0.0},
    ScrapeCar       = {3.0, 1.0, 0.0, 0.0},
    ScrapeTrack     = {3.0, 1.0, 0.0, 0.0},
}

local nativeHapticFallbackKeys = {
    Bodywork        = 0,
    Engine          = 1,
    Gear            = 2,
    GearGrind       = 3,
    Limiter         = 4,
    Skid            = 5,
    Wheel           = 6,
    CollisionCar    = 7,
    CollisionObject = 8,
    CollisionTrack  = 9,
    ScrapeCar       = 10,
    ScrapeTrack     = 11,
}

local function numberOrZero(value)
    return type(value) == "number" and value == value and value or 0
end

local function clamp01(value)
    return math.clamp(numberOrZero(value), 0, 1)
end

local function pulse(frequency, duty, phaseOffset)
    local phase = (clock * math.max(1, numberOrZero(frequency)) + (phaseOffset or 0)) % 1
    return phase < (duty or 0.5) and 1 or 0
end

local function addDetail(base, detail)
    detail = clamp01(detail)
    return clamp01(detail + base * (1 - detail))
end

local function clearTriggers()
    if type(ac.setDualSenseTriggerNoEffect) ~= "function" then return end

    ac.setDualSenseTriggerNoEffect(0)
    ac.setDualSenseTriggerNoEffect(1)
    triggersWereActive = false
end

local function setTriggerResistance(triggerIndex, force)
    force = clamp01(force)
    if force < 0.002 and type(ac.setDualSenseTriggerNoEffect) == "function" then
        ac.setDualSenseTriggerNoEffect(triggerIndex)
    else
        ac.setDualSenseTriggerContinuousResitanceEffect(triggerIndex, 0, force)
    end
end

local function dualSenseConnected(state)
    if type(ac.getDualSense) ~= "function" then return false end
    return ac.getDualSense(state.gamepadIndex) ~= nil
end

local function nativeHapticAPIAvailable()
    return type(ac.setDualSenseHapticParams) == "function"
end

local function globalHapticStrength(uiData)
    return math.max(0, numberOrZero(uiData.dualSenseGlobalStrength))
end

local function nativeHapticValue(gain, pitch, normalizationTarget, normalizationLag)
    return {
        numberOrZero(gain),
        numberOrZero(pitch) ~= 0 and numberOrZero(pitch) or 1,
        numberOrZero(normalizationTarget),
        numberOrZero(normalizationLag),
    }
end

local function nativeHapticSignature(value)
    return string.format("%.4f:%.4f:%.4f:%.4f", value[1], value[2], value[3], value[4])
end

local function setNativeHapticParam(gamepadIndex, name, value)
    if not nativeHapticAPIAvailable() then return end
    if nativeHapticGamepadIndex ~= gamepadIndex then
        nativeHapticGamepadIndex = gamepadIndex
        appliedNativeHapticParams = {}
    end

    local signature = nativeHapticSignature(value)
    if appliedNativeHapticParams[name] == signature then return end

    local enum = ac.DualSenseHapticParam
    local key = enum and enum[name] or nativeHapticFallbackKeys[name]
    ac.setDualSenseHapticParams(gamepadIndex, key, vec4(value[1], value[2], value[3], value[4]))
    appliedNativeHapticParams[name] = signature
end

local function applyNativeHapticProfile(gamepadIndex, profile)
    for name, value in pairs(profile) do
        setNativeHapticParam(gamepadIndex, name, value)
    end
end

local function getNativeCurbSignals(state)
    return clamp01(numberOrZero(state.surfaceVibrationGainLeft) * 6.0),
        clamp01(numberOrZero(state.surfaceVibrationGainRight) * 6.0)
end

local function getConfiguredNativeHapticProfile(state, uiData)
    local globalStrength = globalHapticStrength(uiData)
    local curbLeft, curbRight = getNativeCurbSignals(state)
    local curb = math.max(curbLeft, curbRight)
    local sideBalance = curbRight - curbLeft
    local slipFL = math.abs(numberOrZero(state.ndSlipL))
    local slipFR = math.abs(numberOrZero(state.ndSlipR))
    local slipRL = math.abs(numberOrZero(state.ndSlipRL))
    local slipRR = math.abs(numberOrZero(state.ndSlipRR))
    local frontSlip = math.max(slipFL, slipFR)
    local rearSlip = math.max(slipRL, slipRR)
    local skidIntensity = math.lerpInvSat(
        math.max(frontSlip, rearSlip),
        uiData.dualSenseNativeSkidThreshold,
        uiData.dualSenseNativeSkidThreshold + 0.65
    )
    local bodyworkGain = globalStrength * uiData.dualSenseNativeBodyworkStrength
        * (1 + curb * uiData.dualSenseNativeCurbBoost)
    local bodyworkPitch = math.clamp(
        1 + sideBalance * uiData.dualSenseNativeSidePitchSeparation,
        0.55,
        1.45
    )
    local engineGain = globalStrength * uiData.dualSenseNativeEngineStrength
        * (1 - curb * uiData.dualSenseNativeCurbEngineDucking)
        * (1 - skidIntensity * uiData.dualSenseNativeSkidEngineDucking)
    engineGain = math.max(0, engineGain)
    local skidGain = globalStrength * uiData.dualSenseNativeSkidStrength
        * (1 + skidIntensity * uiData.dualSenseNativeSkidDynamicBoost)
    local skidPitch = math.clamp(
        1 + (frontSlip - rearSlip) * uiData.dualSenseNativeSkidAxlePitchSeparation,
        0.65,
        1.35
    )
    local collision = nativeHapticValue(globalStrength * uiData.dualSenseNativeCollisionStrength, 1, 0, 0)
    uiData._dualSenseNativeCurbLeft = curbLeft
    uiData._dualSenseNativeCurbRight = curbRight
    uiData._dualSenseNativeBodyworkGain = bodyworkGain
    uiData._dualSenseNativeBodyworkPitch = bodyworkPitch
    uiData._dualSenseNativeSkidIntensity = skidIntensity
    uiData._dualSenseNativeSkidGain = skidGain
    uiData._dualSenseNativeSkidPitch = skidPitch
    return {
        Bodywork        = nativeHapticValue(bodyworkGain, bodyworkPitch, 0, 0),
        Engine          = nativeHapticValue(engineGain, 1, 0, 0.9),
        Gear            = nativeHapticValue(globalStrength * uiData.dualSenseNativeGearStrength, 1, 0, 0),
        GearGrind       = nativeHapticValue(globalStrength, 1, 0, 0),
        Limiter         = nativeHapticValue(globalStrength * uiData.dualSenseNativeLimiterStrength, 1, 0, 0),
        Skid            = nativeHapticValue(skidGain, skidPitch, 0, 0),
        Wheel           = nativeHapticValue(globalStrength * uiData.dualSenseNativeWheelStrength, 1, 0, 0),
        CollisionCar    = collision,
        CollisionObject = collision,
        CollisionTrack  = collision,
        ScrapeCar       = nativeHapticValue(globalStrength * 3.0, 1, 0, 0),
        ScrapeTrack     = nativeHapticValue(globalStrength * 3.0, 1, 0, 0),
    }
end

local function isolateNativeHapticProfile(profile)
    profile.Bodywork = nativeHapticValue(0, 1, 0, 0)
    profile.Engine = nativeHapticValue(0, 1, 0, 0.9)
    profile.Gear = nativeHapticValue(0, 1, 0, 0)
    profile.GearGrind = nativeHapticValue(0, 1, 0, 0)
    profile.Limiter = nativeHapticValue(0, 1, 0, 0)
    profile.Skid = nativeHapticValue(0, 1, 0, 0)
    profile.Wheel = nativeHapticValue(0, 1, 0, 0)
    profile.ScrapeCar = nativeHapticValue(0, 1, 0, 0)
    profile.ScrapeTrack = nativeHapticValue(0, 1, 0, 0)
end

local function updateNativeHaptics(state, uiData, dt)
    if not nativeHapticAPIAvailable() then return end
    nativeHapticApplyTimer = nativeHapticApplyTimer - dt

    if nativeHapticApplyTimer <= 0 then
        local profile = nativeHapticDefaults
        if uiData.dualSenseEnabled and uiData.dualSenseNativeHapticsEnabled then
            local globalStrength = globalHapticStrength(uiData)
            profile = getConfiguredNativeHapticProfile(state, uiData)
            if nativeHapticTestTimer > 0 then
                if nativeHapticTestEffect == "engine" then
                    profile.Engine = nativeHapticValue(globalStrength * 2.0, 1, 0, 0.9)
                elseif nativeHapticTestEffect == "wheel" then
                    isolateNativeHapticProfile(profile)
                    profile.Wheel = nativeHapticValue(globalStrength * 8.0, 1, 0, 0)
                elseif nativeHapticTestEffect == "bodywork" then
                    isolateNativeHapticProfile(profile)
                    profile.Bodywork = nativeHapticValue(globalStrength * 5.0, profile.Bodywork[2], 0, 0)
                elseif nativeHapticTestEffect == "skid" then
                    isolateNativeHapticProfile(profile)
                    profile.Skid = nativeHapticValue(globalStrength * 8.0, 1, 0, 0)
                end
            end
        end

        applyNativeHapticProfile(state.gamepadIndex, profile)
        nativeHapticApplyTimer = 0.1
    end

    if nativeHapticTestTimer > 0 then
        nativeHapticTestTimer = math.max(0, nativeHapticTestTimer - dt)
    end
end

local function getWheelSlip(wheel, threshold)
    local ndSlip = math.abs(numberOrZero(wheel.ndSlip))
    local slipRatio = math.abs(numberOrZero(wheel.slipRatio))
    local ndSlipSignal = math.lerpInvSat(ndSlip, threshold, threshold + 0.48)
    local longitudinalSignal = math.lerpInvSat(slipRatio, 0.07, 0.34) * 0.82
    local loadMultiplier = math.lerp(0.52, 1.0, clamp01(wheel.loadK))
    return math.max(ndSlipSignal, longitudinalSignal) * loadMultiplier
end

local function getSurfaceAndSuspension(vehicle, state, speedFade, dt)
    local surfaceLeft = clamp01(numberOrZero(state.surfaceVibrationGainLeft) * 6.0)
    local surfaceRight = clamp01(numberOrZero(state.surfaceVibrationGainRight) * 6.0)
    local dirtLeft, dirtRight = 0, 0
    local loadShockLeft, loadShockRight = 0, 0
    local loadAlpha = math.clamp(dt * 36, 0, 1)

    for i = 0, 3 do
        local wheel = vehicle.wheels[i]
        local loadK = clamp01(wheel.loadK)
        local dirt = clamp01(wheel.surfaceDirt) * loadK
        local loadDelta = loadsInitialized and math.abs(loadK - previousLoadK[i]) or 0
        local loadShock = math.lerpInvSat(loadDelta, 0.018, 0.20)
        previousLoadK[i] = math.lerp(previousLoadK[i], loadK, loadAlpha)

        if i == 0 or i == 2 then
            dirtLeft = math.max(dirtLeft, dirt)
            loadShockLeft = math.max(loadShockLeft, loadShock)
        else
            dirtRight = math.max(dirtRight, dirt)
            loadShockRight = math.max(loadShockRight, loadShock)
        end
    end
    loadsInitialized = true

    local groundNormal = vehicle.groundNormal
    local bodyYVelocity = groundNormal and math.dot(vehicle.velocity, groundNormal) or numberOrZero(vehicle.velocity.y)
    if not bodyVelocityInitialized then
        bodyYVelocitySmooth = bodyYVelocity
        bodyVelocityInitialized = true
    end
    local bodyYDelta = math.abs(bodyYVelocity - bodyYVelocitySmooth)
    bodyYVelocitySmooth = math.lerp(bodyYVelocitySmooth, bodyYVelocity, math.clamp(dt * 26, 0, 1))

    local roadShock = math.lerpInvSat(bodyYDelta, 0.018, 0.28) * speedFade
    local curbShock = math.lerpInvSat(bodyYDelta, 0.10, 0.62) * speedFade
    local curbLeft = math.max(surfaceLeft, loadShockLeft * 0.92) * speedFade
    local curbRight = math.max(surfaceRight, loadShockRight * 0.92) * speedFade
    local bodyCurbFallback = curbShock * 0.68 * speedFade
    if math.max(curbLeft, curbRight) > 0.025 then
        if curbLeft > curbRight then
            curbLeft = math.max(curbLeft, bodyCurbFallback)
        elseif curbRight > curbLeft then
            curbRight = math.max(curbRight, bodyCurbFallback)
        end
    else
        local centeredFallback = bodyCurbFallback * 0.56
        curbLeft = centeredFallback
        curbRight = centeredFallback
    end

    return curbLeft, curbRight, dirtLeft * speedFade, dirtRight * speedFade, roadShock
end

local function updateLegacyBodyVibration(vData, uiData, dt)
    if not uiData.dualSenseLegacyBodyVibration then return end

    local state = vData.inputData
    local vehicle = vData.vehicle
    local speedKmh = numberOrZero(vehicle.speedKmh)
    local speedFade = math.lerpInvSat(speedKmh, 3, 32)
    local rpmMax = math.max(numberOrZero(vehicle.rpmLimiter), 1000)
    local rpmRatio = clamp01(numberOrZero(vehicle.rpm) / rpmMax)
    local engine = pulse(math.lerp(18, 58, rpmRatio), 0.50)
        * math.lerp(0.20, 1.0, rpmRatio)
        * legacyBody.engineStrength

    local curbLeft, curbRight, dirtLeft, dirtRight, roadShock =
        getSurfaceAndSuspension(vehicle, state, speedFade, dt)
    local threshold = math.max(0.1, uiData.dualSenseSlipThreshold)
    local slipFL = getWheelSlip(vehicle.wheels[0], threshold)
    local slipFR = getWheelSlip(vehicle.wheels[1], threshold)
    local slipRL = getWheelSlip(vehicle.wheels[2], threshold)
    local slipRR = getWheelSlip(vehicle.wheels[3], threshold)
    local frontSlip = math.max(slipFL, slipFR)
    local rearSlip = math.max(slipRL, slipRR)

    local roadWave = 0.30 + pulse(43, 0.54) * 0.70
    local curbWave = 0.42 + pulse(31, 0.62) * 0.58
    local dirtWave = 0.28 + pulse(25, 0.66, 0.30) * 0.72
    local frontSlipWave = 0.30 + pulse(86, 0.48) * 0.70
    local rearSlipWave = 0.38 + pulse(57, 0.54, 0.20) * 0.62
    local curbMotorLeft = math.max(curbLeft, curbRight * legacyBody.directionalCrossfeed)
        * curbWave * legacyBody.curbStrength
    local curbMotorRight = math.max(curbRight, curbLeft * legacyBody.directionalCrossfeed)
        * curbWave * legacyBody.curbStrength
    local roadMotorLeft = roadShock * roadWave * legacyBody.roadStrength * 0.78
    local roadMotorRight = roadShock * roadWave * legacyBody.roadStrength
    local dirtCrossfeed = math.max(0.12, legacyBody.directionalCrossfeed)
    local dirtMotorLeft = math.max(dirtLeft, dirtRight * dirtCrossfeed) * dirtWave * legacyBody.dirtStrength
    local dirtMotorRight = math.max(dirtRight, dirtLeft * dirtCrossfeed) * dirtWave * legacyBody.dirtStrength
    local frontScale = legacyBody.gripLossStrength * legacyBody.frontSlipStrength
    local rearScale = legacyBody.gripLossStrength * legacyBody.rearSlipStrength
    local frontMotorLeft = math.max(frontSlip * 0.48, slipFL * 0.68, slipFR * 0.54) * frontSlipWave * frontScale
    local frontMotorRight = math.max(frontSlip * 0.82, slipFL * 0.90, slipFR) * frontSlipWave * frontScale
    local rearMotorLeft = math.max(rearSlip * 0.86, slipRL, slipRR * 0.88) * rearSlipWave * rearScale
    local rearMotorRight = math.max(rearSlip * 0.58, slipRL * 0.64, slipRR * 0.76) * rearSlipWave * rearScale
    local scrub = math.max(frontSlip, rearSlip) * legacyBody.slideStrength
    local detailLeft = math.max(curbMotorLeft, roadMotorLeft, dirtMotorLeft, frontMotorLeft, rearMotorLeft, scrub * frontSlipWave * 0.34)
    local detailRight = math.max(curbMotorRight, roadMotorRight, dirtMotorRight, frontMotorRight, rearMotorRight, scrub * frontSlipWave * 0.52)

    if vehicle.absInAction and pulse(uiData.dualSenseABSFrequency, 0.52) > 0 then
        local absPulse = clamp01(vehicle.brake) * legacyBody.absStrength
        detailLeft = math.max(detailLeft, absPulse * 0.70)
        detailRight = math.max(detailRight, absPulse)
    end
    if shiftTimer > 0 then
        local duration = math.max(0.001, uiData.dualSenseShiftDuration)
        local progress = clamp01(1 - shiftTimer / duration)
        local envelope = progress < 0.24 and 1 or (1 - math.lerpInvSat(progress, 0.24, 1))
        local strength = shiftDirection < 0 and legacyBody.downshiftStrength or legacyBody.shiftStrength
        local shiftPulse = envelope * strength
        detailLeft = math.max(detailLeft, shiftPulse)
        detailRight = math.max(detailRight, shiftPulse * (shiftDirection < 0 and 0.74 or 0.88))
    end
    if vehicle.collisionDepth > 0 and speedKmh > 8 then collisionTimer = 0.16 end
    if collisionTimer > 0 then
        local impact = clamp01(collisionTimer / 0.16) * legacyBody.collisionStrength
        detailLeft = math.max(detailLeft, impact)
        detailRight = math.max(detailRight, impact)
        collisionTimer = math.max(0, collisionTimer - dt)
    end

    local strength = legacyBody.bodyStrength * globalHapticStrength(uiData)
    state.vibrationLeft = clamp01(addDetail(engine, detailLeft) * strength)
    state.vibrationRight = clamp01(addDetail(engine, detailRight) * strength)
end

local function getDrivenWheelspin(vehicle, threshold)
    local startIndex = vehicle.tractionType == 1 and 0 or 2
    return math.max(
        getWheelSlip(vehicle.wheels[startIndex], threshold),
        getWheelSlip(vehicle.wheels[startIndex + 1], threshold)
    )
end

local function updateTriggers(vData, uiData)
    if not uiData.dualSenseTriggersEnabled
        or type(ac.setDualSenseTriggerContinuousResitanceEffect) ~= "function" then
        if triggersWereActive then clearTriggers() end
        return
    end

    local vehicle = vData.vehicle
    local gas = clamp01(vData.inputData.gas)
    local brake = clamp01(vData.inputData.brake)
    local brakeForce = math.pow(brake, uiData.dualSenseBrakeCurve) * uiData.dualSenseBrakeResistance
    local frontSlip = math.max(
        getWheelSlip(vehicle.wheels[0], uiData.dualSenseSlipThreshold),
        getWheelSlip(vehicle.wheels[1], uiData.dualSenseSlipThreshold)
    )

    if vehicle.absInAction or (brake > 0.28 and frontSlip > 0.18) then
        local absRelease = pulse(uiData.dualSenseABSFrequency, 0.48) * uiData.dualSenseABSFeedback
        brakeForce = brakeForce * (1 - absRelease)
    end

    local throttleBase = math.pow(gas, uiData.dualSenseThrottleCurve) * uiData.dualSenseThrottleResistance
    local throttleForce = throttleBase
    local wheelspinIntensity = getDrivenWheelspin(vehicle, uiData.dualSenseWheelspinThreshold)
    local wheelspin = gas > 0.18 and vData.localHVelLen > 1 and wheelspinIntensity > 0

    -- Upshift: strong R2 interruption. Downshift: subtle R2 blip, never an L2 kick.
    if shiftTimer > 0 and gas > 0.08 then
        local duration = math.max(0.001, uiData.dualSenseShiftDuration)
        local progress = clamp01(1 - shiftTimer / duration)
        local kick = shiftDirection < 0 and uiData.dualSenseDownshiftThrottleKick or uiData.dualSenseShiftResistance
        if progress < 0.18 then
            throttleForce = math.max(throttleBase, kick)
        elseif progress < 0.46 then
            throttleForce = throttleBase * (1 - kick * 0.96)
        elseif progress < 0.78 then
            throttleForce = math.max(throttleBase, kick * 0.62)
        else
            throttleForce = throttleBase * (1 - kick * 0.30)
        end
    elseif wheelspin then
        local release = pulse(uiData.dualSenseWheelspinFrequency, 0.50)
            * uiData.dualSenseWheelspinFeedback
            * wheelspinIntensity
        if release > 0 then
            throttleForce = throttleBase * (1 - release)
        else
            throttleForce = math.max(throttleBase, 0.12 * uiData.dualSenseWheelspinFeedback * wheelspinIntensity)
        end
    else
        local limiterIntensity = vehicle.rpmLimiter > 0
            and math.lerpInvSat(vehicle.rpm, vehicle.rpmLimiter - 180, vehicle.rpmLimiter - 35)
            or 0
        if limiterIntensity > 0 then
            if pulse(uiData.dualSenseLimiterFrequency, 0.50) > 0 then
                throttleForce = math.max(throttleBase, limiterIntensity * uiData.dualSenseLimiterResistance)
            else
                throttleForce = throttleBase * (1 - limiterIntensity * 0.72)
            end
        end
    end

    setTriggerResistance(0, brakeForce)
    setTriggerResistance(1, throttleForce)
    triggersWereActive = true
end

function M.update(vData, uiData, dt)
    local state = vData.inputData
    clock = clock + dt
    uiData._dualSenseDetected = dualSenseConnected(state)
    uiData._dualSenseNativeHapticsAvailable = nativeHapticAPIAvailable()
    uiData._dualSenseNativeTestSeconds = nativeHapticTestTimer
    uiData._dualSenseNativeTestMode = nativeHapticTestEffect == "engine" and 1
        or nativeHapticTestEffect == "wheel" and 2
        or nativeHapticTestEffect == "bodywork" and 3
        or nativeHapticTestEffect == "skid" and 4
        or 0
    uiData._dualSenseSlipFL = math.abs(numberOrZero(state.ndSlipL))
    uiData._dualSenseSlipFR = math.abs(numberOrZero(state.ndSlipR))
    uiData._dualSenseSlipRL = math.abs(numberOrZero(state.ndSlipRL))
    uiData._dualSenseSlipRR = math.abs(numberOrZero(state.ndSlipRR))

    if previousGear ~= nil and previousGear ~= vData.vehicle.gear and vData.localHVelLen > 1 then
        shiftDirection = vData.vehicle.gear > previousGear and 1 or -1
        shiftTimer = math.max(0.06, uiData.dualSenseShiftDuration)
    end
    previousGear = vData.vehicle.gear

    updateNativeHaptics(state, uiData, dt)

    if not uiData.dualSenseEnabled then
        if triggersWereActive then clearTriggers() end
        return
    end

    updateLegacyBodyVibration(vData, uiData, dt)
    updateTriggers(vData, uiData)
    shiftTimer = math.max(0, shiftTimer - dt)
end

function M.release()
    clearTriggers()
    if nativeHapticGamepadIndex ~= nil then
        applyNativeHapticProfile(nativeHapticGamepadIndex, nativeHapticDefaults)
    end
end

function M.testNative(effect)
    nativeHapticTestEffect = effect
    nativeHapticTestTimer = effect == "engine" and 10 or 15
    nativeHapticApplyTimer = 0
end

return M

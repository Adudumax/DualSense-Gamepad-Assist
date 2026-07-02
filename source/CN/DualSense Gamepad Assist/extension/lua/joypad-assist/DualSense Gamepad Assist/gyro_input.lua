local M = {}

local gamepadAngle = 0
local baseSteer = 0
local ffbSmooth = 0

local function clampN(value)
    return math.clamp(value or 0, -1, 1)
end

function M.resetCenter()
    gamepadAngle = 0
    baseSteer = 0
    ffbSmooth = 0
end

local function getDualSense(state)
    if type(ac.getDualSense) ~= "function" then return nil end

    local ok, ds = pcall(ac.getDualSense, state.gamepadIndex or 0)
    if ok and ds ~= nil then return ds end

    ok, ds = pcall(ac.getDualSense)
    if ok then return ds end
    return nil
end

function M.update(state, uiData, speedKmh, dt)
    local ds = getDualSense(state)
    if ds == nil or ds.gyroscope == nil or ds.accelerometer == nil then
        return clampN(state.steerStickX), false, 0
    end

    local accDir = ds.gyroscope:clone():normalize()
    local accAngle = -math.atan2(accDir.x, #vec2(accDir.y, accDir.z)) * 0.2
    local fastTurning = math.pow(math.saturateN(math.abs(ds.accelerometer.z * 1000 / 3.1415 * 0.03) - 0.1), 3)
    local fastTurningLag = math.lerp(0.95, 0.5, fastTurning)
    gamepadAngle = gamepadAngle - ds.accelerometer.z * 1400 * dt * 0.0037
    gamepadAngle = math.applyLag(gamepadAngle, accAngle, fastTurningLag, dt)

    local gammed = math.tan(gamepadAngle * 4) / 4
    local edgeLag = 0.9 * math.saturateN(math.abs(baseSteer) * 4)
    baseSteer = math.applyLag(baseSteer, gammed, edgeLag, dt)

    local sensitivity = math.max(0.1, uiData.gyroSteeringSensitivity or 0.5)
    local finalSteer = baseSteer * sensitivity * 2

    ffbSmooth = math.applyLag(ffbSmooth, state.ffb or 0, 0.9, dt)
    local ffbSteer = finalSteer + ffbSmooth * -0.06
    local target = math.clampN((state.steer + ffbSteer) * 500 / car.steerLock, -1, 1)

    return target, true, clampN(gamepadAngle / 0.32)
end

return M

local move = {}
local config = require("config")
local waitFrames = 15  -- ajuste esse valor se quiser esperar mais/menos
pos = nil
lastPos = nil

function move.up(steps)
    steps = steps or 1
    for i = 1, steps*waitFrames do
        joypad.set(1, {up = true })
        emu.frameadvance()
    end
    joypad.set(1, {up = false })
    emu.frameadvance()
end

function move.down(steps)
    steps = steps or 1
    for i = 1, steps*waitFrames do
        joypad.set(1, {down = true })
        emu.frameadvance()
    end
    joypad.set(1, {down = false })
    emu.frameadvance()
end

function move.left(steps)
    steps = steps or 1
    for i = 1, steps*waitFrames do
        joypad.set(1, {left = true })
        emu.frameadvance()
    end
    joypad.set(1, {left = false })
    emu.frameadvance()
end

function move.right(steps)
    steps = steps or 1
    for i = 1, steps*waitFrames do
        joypad.set(1, {right = true })
        emu.frameadvance()
    end
    joypad.set(1, {right = false })
    emu.frameadvance()
end

function move.random(maxSteps)
    local steps = math.random(1, maxSteps or 1)  -- se maxSteps não for passado, usa 1
    local directions = { "up", "down", "left", "right" }
    local direction = directions[math.random(#directions)]
    print("Movendo aleatoriamente para " .. direction .. " por " .. steps .. " passos")
    move[direction](steps)
end

function pressA()
    for i = 1, 15 do
        joypad.set(1, {A = true })
        emu.frameadvance()
    end
    joypad.set(1, {A = false })
    emu.frameadvance()
end

function pressB()
    for i = 1, 15 do
        joypad.set(1, {B = true })
        emu.frameadvance()
    end
    joypad.set(1, {B = false })
    emu.frameadvance()
end

function move.walkToX(gotoX)
    local atualMap = map()
    while x() ~= gotoX and onMap() and atualMap == map() do
        posRecord()
        if x() < gotoX then
            if position() == lastPos then
                move.random(4)
            else
                move.right()
            end
        elseif position() == lastPos then
            move.random(4)
        else
            move.left()
        end
    end
end

function move.walkToY(gotoY)
    local atualMap = map()
    while y() ~= gotoY and onMap() and atualMap == map() do
        posRecord()
        if y() < gotoY then
            if position() == lastPos then
                move.random(4)
            else
                move.down()
            end
        elseif position() == lastPos then
            move.random(4)
        else
            move.up()
        end
    end
end

function posRecord()
    if pos == nil then
        pos = position()
        print("Criada variavel de pos: " .. string.format("0x%08X", pos))
    else
        lastPos = pos
        pos = position()
        print("Ultimo pos atualizado: " .. string.format("0x%08X", lastPos))
    end
end

function justtalk()
end

return move
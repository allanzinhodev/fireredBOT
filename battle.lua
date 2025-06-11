local battle = {}
local config = require("config")
local move = require("move")

function onAttackMenu()
    return battleAttackCursor() ~= 0x00
end

function onPokemonChange()
    
    return onChangePokeCursor() == 0x01
end

function notOnChange()
    return onChangePokeCursor() == 0x04
end

function simpleBattle()
    print("simpleBattle")
    tryAttack()
end

function tryAttack()
    print("tryAttack")
    if getState() == "battleMenu" then
        print("onBattleMenu")
        move.left()
        move.up()
        if battleMenuCursor() == 0x00 then
            print("Attack press A")
            pressA()
        end
    elseif getState() == "attackMenu" then
        print("onAttackMenu")
        move.random(2)
        emu.frameadvance()
        move.random(2)
        emu.frameadvance()
        if skillHavePP() then
            pressA()
        end
    elseif getState() == "battleDiePokeChange" then
        print("onPokemonChange")
        move.down()
        pressA()
        emu.frameadvance()
        pressA()
    elseif getState() == "blackScreen" then
        print("blackScreen")
        pressA()
    elseif getState() == "battleTalk" then
        print("battleTalk")
        pressA()
    elseif getState() == "battlePack" then
        print("battlePack")
        if onCaptureStatus == 0 then
            pressB()
        elseif onCaptureStatus == 1 then
            capturar()
        end
    elseif getState() == "levelUP" then
        print("LevelUP")
        pressA()
    elseif getState() == "namePoke" then
        print("namePoke")
        move.down()
        if cursorNamePoke() == 1 then
            pressA()
            onCaptureStatus = 0
        end
    elseif getState() == "nextPoke" then
        print("nextPoke")
        pressA()
    elseif getState() == "capturedPokeScreen" then
        print("capturedPokeScreen")
        pressA()
    elseif getState() == "deadPokeText" then
        print("deadPoke")
        pressA()
    elseif getState() == "battleWin" then
        print("battleWin")
        pressA()
    elseif getState() == "changeSkillScreen" then
        print("changeSkill")
        skillN = isLowPriorityMove()
        local Cursor = moveChangeCursor() + 1
        if skillN == nil then
            move.random(5)
            move.random(5)
            pressA()
        elseif skillN == Cursor then
            pressA()
        else
            move.down()
        end
    else
        print("else")
    end
end

function capturar()
    print("capturar")
    if notHavePokemon() and battleTurn() > 2 and havePokeball() then
        onCaptureStatus = 1
        if getState() == "battleMenu" then
            move.right()
            move.up()
            if battleMenuCursor() == 0x01 then
                pressA()
            end
        elseif getState() == "battlePack" then
            if packMenuPos() == 2 then
                print("chegou aq")
                pressA()
                pressA()
                onCaptureStatus = 1
            else
                move.right(2)
            end
        elseif getState() == "usePokeball" then
            pressA()
        end
    elseif notHavePokeball() then
        onCaptureStatus = 0
    end
end

return battle
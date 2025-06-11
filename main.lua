local config = require("config")
local move = require("move")
local battle = require("battle")
local mapActions = require ("mapActions")
local mapRoutes = require ("mapRoutes")
local twitch = require ("twitch")
local walkmode = "random"

function handleBattleState()
    print("?")
    if onMap() then
        print("no mapa")
        mapTalk()
        smartRoutes()
        posRecord()
        walkCommand = walkMod()
       -- print(walkCommand)  -- apenas para ver o resultado, opcional    
        twitchMove()
    elseif onWildBattle() then
        capturar()
        tryAttack()
    elseif onTrainerBattle() then
        tryAttack()
    else
        print("nao ta funcionando")
    end
    emu.frameadvance()
end

while true do
    handleBattleState()
    emu.frameadvance()
end

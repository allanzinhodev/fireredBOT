mapRoutes = {}
local config = require("config")
local move = require("move")

function smartRoutes()
    -- mapa multiplayer
    if map() == 0x0407 or map() == 0x0505 or map() == 0x0606 or map() == 0x0108 or map() == 0x0209 or map() == 0x0D0A or map() == 0x060B or map() == 0x060C or map() == 0x0C01 or map() == 0x070F then
        move.walkToX(0x08)
    -- mapa cerulean
    elseif map() == 0x0303 then
        if onThisArea(25,30,2,0,9) and getCheckpoint() ~= "Cerulean CP" then
            print("fiumff")
            move.walkToY(0x1D)
            move.walkToX(0x1D)
            move.walkToY(0x1A)
        end
    end
end

return mapRoutes
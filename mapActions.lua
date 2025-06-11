local mapActions = {}
local config = require("config")
local move = require("move")
    function mapTalk()
        if getState() == "mapTalk" then
            pressA()
        elseif getState() == "pcOption01" or  getState() == "pcOption02" or  getState() == "pcOption03" or  getState() == "pcOption04" then
            pressB()
        elseif getState() == "mapGrass" then
            pressA()
        elseif getState() == "profileNPCYES" then
            move.down()
        elseif getState() == "profileNPCNO" then
            pressA()
        elseif getState() == "mapScreen" then
            pressB()
        else
            pressA()
        end
    end

    function onThisArea(baseX, baseY, squareSize, horizontalSize, verticalSize)
        print("ffuncionou")
        local px = x()
        local py = y()
        -- Verifica se está dentro do quadrado central
        if px >= baseX - squareSize and px <= baseX + squareSize and
        py >= baseY - squareSize and py <= baseY + squareSize then
            return true
        end
        -- Verifica a parte horizontal da cruz (linha horizontal)
        if px >= baseX - horizontalSize and px <= baseX + horizontalSize and py == baseY then
            return true
        end
        -- Verifica a parte vertical da cruz (linha vertical)
        if py >= baseY - verticalSize and py <= baseY + verticalSize and px == baseX then
            return true
        end
        return false
    end

return mapActions
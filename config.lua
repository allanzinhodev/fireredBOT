local config = {}
    -- Player States
    x  = function() return memory.readbyte(0x02036E4C) end -- X pos
    y = function() return memory.readbyte(0x02036E4E) end -- Y pos
    position = function() return memory.readdword(0x02036E4C) end -- pos dWord
    dir = function() return memory.readbyte(0x02036E50) end -- Direção
    map = function() return memory.readword(0x02031DBC) end -- map + mapbank
    previousMap = function() return memory.readword(0x02031DB4) end -- previous map + mapbank
    onMoving = function() return memory.readbyte(0x02036E50) == 0x01 end -- em movimento? 01 Em batalha selvagem 02 (??)
    onWildBattle = function() return memory.readbyte(0x02022B4C) ~= 0x0C and memory.readbyte(0x03003529) == 0x02 end -- em movimento? 01 Em batalha selvagem 02 (??)
    onTrainerBattle = function() return memory.readbyte(0x02022B4C) == 0x0C and memory.readbyte(0x03003529) == 0x02  end -- em movimento? 01 Em batalha selvagem 02 (??)
    onMap = function() return memory.readbyte(0x03003529) == 0x00 end
    onBattleHP = function() return memory.readwordunsigned(0x02023C0C) end
    battleTurn = function() return memory.readbyteunsigned(0x03004FA3) end
    havePokeball = function() return memory.readbyteunsigned(0x02023BFE) > 0 end
    notHavePokeball = function() return memory.readbyteunsigned(0x02023BFE) == 0 end

    -- Screen
    cursorNamePoke = function() return memory.readbyteunsigned(0x02023E83) end
    cursorPos = function() return memory.readbyte(0x0203ADE6) end -- start e sim ou nao cursor
    battleMenuCursor = function() return memory.readbyte(0x02023FF8) end -- 0 fight 1 pack 2 poke 3 run
    battleAttackCursor = function() return memory.readbyteunsigned(0x02023FFC) end
    martCursorPos = function() return memory.readbyte(0x02039940) end
    onChangePokeCursor = function() return memory.readbyte(0x02039940) end
    onPokeMenuCursor = function() return memory.readbyte(0x0203B0A9) end
    moveChangeCursor = function() return memory.readbyte(0x0203B16D) end
    packMenuPos = function() return memory.readbyteunsigned(0x020206AA) end
    -- Function 
    skillHavePP = function() return memory.readbyte(0x02023C08 + battleAttackCursor()) ~= 0x00 end
    onBattlemMenu = function() return memory.readbyte(0x02023FF8) ~= 0x00 end
    onCaptureStatus = 0

    function getState()
        state = memory.readdword(0x02020014)
        if state == 0x01000200 then
            return "journal"
        elseif state == 0x01000206 then
            return "deadPokeText"
        elseif state == 0x01000400 then
            return "mapTalk"
        elseif state == 0x01000500 then
            return "mapTalk"
        elseif state == 0x02000008 then
            return "attackMenu"
        elseif state == 0x02000201 or state == 0x02000202 then
            return "pcOption01"
        elseif state == 0x12000201 or state == 0x12000202 then
            return "pcOption02"
        elseif state == 0x22000201 or state == 0x22000202 then
            return "pcOption03"
        elseif state == 0x32000201 or state == 0x32000202 then
            return "pcOption04"
        elseif state == 0x02000119 then
            return "blackScreen"
        elseif state == 0x02000204 then
            return "usePokeball"
        elseif state == 0x0200020E and onCaptureStatus == 1 then
            return "namePoke"
        elseif state == 0x0200020E then
            return "nextPoke"
        elseif state == 0x02020200 then
            return "battleTalk"
        elseif state == 0x02020201 then
            return "battleMenu"
        elseif state == 0x02000208 then
            return "battleDiePokeChange"
        elseif state == 0x02020400 then
            return "battleWin"
        elseif state == 0x02000500 then
            return "battleWin"
        elseif state == 0x03000201 then
            return "battlePack"
        elseif state == 0x05020202 then
            return "afterPokeChange"
        elseif state == 0x10000200 then
            return "mapGrass"
        elseif state == 0x10000201 then
            return "profileNPCYES"
        elseif state == 0x1E000201 then
            return "profileNPCNO"
        elseif state == 0x2A070204 and onMap() then
            return "profileNPCNO"
        elseif state == 0x02D00001 then
            return "capturedPokeScreen"
        elseif state == 0x4B44020C or state == 0x02690202 or state == 0x2A070204 then
            return "changeSkillScreen"
        elseif state == 0x00000004 then
            return "mapScreen"
        end
    end

    function isLowPriorityMove()
        local lowPriorityList = { 43, 54, 74, 81, 104, 108, 111, 106, 150, 204, 336 }
        local moveSlots = {
            memory.readwordunsigned(0x0201198C), -- slot 1
            memory.readwordunsigned(0x0201198E), -- slot 2
            memory.readwordunsigned(0x02011990), -- slot 3
            memory.readwordunsigned(0x02011992),  -- slot 4
            memory.readwordunsigned(0x02011994)  -- new MOVE
        }

        for slotIndex, move in ipairs(moveSlots) do
            for _, lowPriority in ipairs(lowPriorityList) do
                if move == lowPriority then
                    print(string.format("Movimento de baixa prioridade encontrado no slot %d: ID %d", slotIndex, move))
                    return slotIndex  -- retorna o número do slot (1 a 5)
                end
            end
        end

        print("Nenhum movimento de baixa prioridade encontrado.")
        return nil
    end

    function getCheckpoint()
        local map = memory.readbyte(0x020370B2)
        local mapBank = memory.readbyte(0x020370B4)
        if map == 0x05 and mapBank == 0x04 then
            return "Viridian CP"
        elseif map == 0x06 and mapBank == 0x05 then
            return "Pewter CP"
        elseif map == 0x03 and mapBank == 0x03 then
            return "Cerulean CP"
        end
    end

    function getBattlePackState()
        state = memory.readdword(0x02020018)
        if state == 0x00021F8C then
            return "item"
        elseif state == 0x00021F48 then
            return "keyItem"
        elseif state == 0x00021F9C then
            return "pokeball"
        end
    end

    -- Função para contar os bits 1 de um byte
    local function countBits(byte)
        local count = 0
        local resto = 0
        local byte = memory.readbyteunsigned(byte)
        while byte >= 1 do
            print(byte)
            resto = byte % 2
            count = count + resto
            byte = ( byte - resto ) / 2
        end
        return count
    end

    -- Função para calcular quantos pokemons tem numa cadeia de 256 switches binarios
    local function count51Hex(hexStart)
        local total_own = 0
        for i = 0, 51, 1 do
        total_own = total_own + countBits(hexStart + i)
        end
            return total_own
    end

    function onThisArea(baseX, baseY, squareSize, horizontalSize, verticalSize)
        print("ffuncionou")
        local px = memory.readbyteunsigned(0x02036E4C)
        local py = memory.readbyteunsigned(0x02036E4E)
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

return config
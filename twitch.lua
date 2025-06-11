local twitch = {}
local move = require("move")
local caminho_arquivo = "walkmode.txt"
-- Abre o arquivo para leitura
local arquivo = io.open(caminho_arquivo, "r")

function walkMod()
    if not arquivo then
      print("Erro: não foi possível abrir o arquivo.")
      return
    end

    local file = io.open("walkmode.txt", "r")  -- abre o arquivo em modo de leitura
    local comando = file:read("*l")          -- lê todo o conteúdo do arquivo
    file:close()                              -- fecha o arquivo
    return comando
end

function notHavePokemon()
    if not arquivo then
      print("Erro: não foi possível abrir o arquivo.")
      return
    end

    local file = io.open("captured.txt", "r")  -- abre o arquivo em modo de leitura
    local comando = file:read("*l")          -- lê todo o conteúdo do arquivo
    file:close()                              -- fecha o arquivo
    return comando == "not captured"
end

function twitchMove()
        if walkCommand == "random" then
            move.random(5)
        elseif walkCommand == "left" then
            if position() == lastPos then
                move.random(4)
            else
                move.left()
            end
        elseif walkCommand == "right" then
            if position() == lastPos then
                move.random(4)
            else
                move.right()
            end
        elseif walkCommand == "up" then
            if position() == lastPos then
                move.random(4)
            else
                move.up()
            end
        elseif walkCommand == "down" then
            if position() == lastPos then
                move.random(4)
            else
                move.down()
            end
        else
            move.random(5)
        end
end

function seen()
    if not arquivo then
      print("Erro: não foi possível abrir o arquivo.")
      return
    end

    local file = io.open("seen.txt", "r")  -- abre o arquivo em modo de leitura
    local comando = file:read("*l")          -- lê todo o conteúdo do arquivo
    file:close()                              -- fecha o arquivo
    return comando
end

function seen()
    local file = io.open("seen.txt", "w")
    local data = seenPokemons()
    if file then

      file:write(data)
      file:close()
      print("seen.txt atualizado com sucesso.")
    else
      print("Erro ao abrir own.txt para escrita.")
    end
end

function own()
    local file = io.open("own.txt", "w")
    local dataa = ownPokemons()
    if file then
      file:write(dataa)
      file:close()
      print("own.txt atualizado com sucesso.")
    else
      print("Erro ao abrir own.txt para escrita.")
    end
end
return twitch
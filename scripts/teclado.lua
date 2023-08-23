local Teclado = {} -- armazena todos os dados do script

-- a funcao é associada ao (player) por que a interaçao sera com ele
function Teclado.novo (player)

local function verificarTecla (event)
    -- se a fase de evento for down (tecla pressionada) entao
    if event.phase == "down" then
        -- se a tecla pressionada for o d entao
        if event.keyName == "d" then
            player.direcao = "direita"
            player:setSequence ("correndo")
            player:play()
            player.xScale = 1
        elseif event.keyName == "a" then
            player.direcao = "esquerda"
            player:setSequence ("correndo")
            player:play()
            player.xScale = -1
        elseif event.keyName == "space" then
            player.numeroPulo = player.numeroPulo +1
            -- se o numero de pulo for igual a 1 entao
                if player.numeroPulo == 1 then
                   -- é aplicado impulso linear no player (y)
                    player:applyLinearImpulse (0, -0.4, player.x, player.y)
                -- se o numero de pulos for igual a 2 entao
                elseif player.numeroPulo == 2 then
                    -- transicao para que o player gire 360 graus em torno do proprio eixo
                    transition.to (player, {rotation = player.rotation+360, time = 400})
                    player:applyLinearImpulse(0,-0.4, player.x, player.y)
                end
        end
    -- quando a fase de evento for up (soltar a tecla) entao
    elseif event.phase == "up" then
        if event.keyName == "d" then
            player.direcao = "parado"
            player:setSequence ("parado")
            player:play ()
        elseif event.keyName == "a" then
            player.direcao = "parado"
            player:setSequence("parado")
            player:play()
        end
    end
end
    -- runtime -> a funcao continua rodando enquanto o processador estiver ativo
    Runtime:addEventListener("key", verificarTecla)
    local function verificarDirecao()
        -- retorna os valores de velocidade linear X e Y e armazena nas variaveis velocidadeX, velocidadeY respectivamente
        local velocidadeX, velocidadeY = player:getLinearVelocity ()
        -- se a direcao do player for direita e a velocidade X for menor ou igual a 200 entao
        if player.direcao == "direita" and velocidadeX <= 200 then
            -- aplicado impulso linear para movimentacao X direita.
            player:applyLinearImpulse(0.2,0, player.x, player.y)
        elseif player.direcao == "esquerda" and velocidadeX >= -200 then 
            player:applyLinearImpulse(-0.2, 0, player.x, player.y)
        end
    end
    -- "enterFrame" executa a funcao o numero de fps/s 
    Runtime:addEventListener ("enterFrame", verificarDirecao)
end

return Teclado -- return do teclado para fechar a variavel


        
-- chamamos o script do teclado
local scriptTeclado = require ("Teclado")

local Player = {}
-- hud esta ligado a variavel criada no main que executa a funcao .novo no script HUD
function Player.novo (x, y, hud)
    local spritePlayer = graphics.newImageSheet("imagens/player.png", {width = 90, height = 95, numFrames = 12})

    local playerAnimacao = 
    {
        {name = "parado", start = 1, count = 3, time = 300, loopCount = 0},
        {name = "correndo", start = 5, count = 8, time = 1000, loopCount = 0},
    }
    local player = display.newSprite (spritePlayer, playerAnimacao)
    player.x = x
    player.y = y
    player.id = "player"
    player.direcao = "parado"
    player:setSequence ("parado")
    player:play ()
    player.numeroPulo = 0
    physics.addBody (player, "dynamic", {friction = 2, box = {x=0, y=0, halfWidth=30, halfHeight=40, angle=0}})
    player.isFixedRotation = true -- utilizada para que o player nao tombe ao descer do pulo

-- ativando a funcao .novo do script do teclado.
    scriptTeclado.novo (player)

-- essa colisao e usada para colisao do player com outros objetos (de um objeto para muitos)
local function verificarColisao (self, event)
    if event.phase == "began" then
    -- quando o id do outro corpo for "chao"
        if event.other.id == "chao" then
        -- zeramos a variavel numeroPulo do player para impedir o pulo duplo no chao
        self.numeroPulo = 0
        elseif event.other.id == "inimigo" then
        -- criamos a variavel topoInimigo para definir a localizacao do topo do inimigo
        local topoInimigo = event.other.y - (event.other.height/2)
        -- se a localizacao y do player for a mesma do topo do inimigo entao
            if self.y <= topoInimigo then
                --remove o inmigo
                display.remove (event.other)
                -- aplicamos velocidade linear ao player para que ele suba
                self:setLinearVelocity (0,-300)
            end
        elseif event.other.id == "moeda" then
            display.remove (event.other)
            hud.somar()
        end
    end
end
player.collision = verificarColisao
player:addEventListener ("collision")

return player --  personagem
end
return Player -- script
-- chamar a biblioteca de fisica
local physics = require ("physics")
-- iniciar o motor de fisica
physics.start()
-- definir a gravidade
physics.setGravity (0, 0)
-- definir o modo de renderizaçao, normal, hybrid, debug
physics.setDrawMode ("normal")

-- remover a barra de notificações.
display.setStatusBar (display.HiddenStatusBar)

-- criar os grupos de exibição
local grupoBg = display.newGroup() -- objetos decorativos, cenario (nao tem interaçao)
local grupoMain = display.newGroup() -- bloco principal (tudo que precisa interagir com o player fica nesse grupo)
local grupoUI = display.newGroup() -- interface do usuario (placares, botoes, poderes, etc...) 

-- criar variaveis de pontos e vidas para atribuiçao de valor
local pontos = 0
local vidas = 5

--adicionar background
--                    (grupo, "pasta/nome.extensao", largura, altura)
local bg = display.newImageRect (grupoBg, "imagens/bg.png", 1090*0.4,900*0.6)
--localização das imagens
bg.x = display.contentCenterX -- localizaçao horizontal
bg.y = display.contentCenterY -- localizaçao vertical

local bgAudio = audio.loadStream ("audio/bg.mp3")  
audio.reserveChannels (1)
audio.setVolume (0.6, {channel = 1})
audio.play (bgAudio, {channel = 1, loops = 0})

local audioTiro = audio.loadSound("audio/feitico.mp3")
local parametros = {time = 2000, fadein = 200}


-- adicionar placar na tela.
-- (grupo, "escreve o que ira aparecer na tela", concatenação + variavel, localizaçao X, localização Y, tipo de fonte, tamanho da fonte)
local pontosText = display.newText (grupoUI, "Pontos: " .. pontos, 100, 30, native.systemFont, 20)
-- cor do texto (variavelText:comando (cor R,G,B))
pontosText:setFillColor (0,0,0)

-- adicionar vidas na tela.

local vidasText = display.newText (grupoUI, "Vidas: " .. vidas, 200, 30, native.systemFont, 20)
vidasText: setFillColor (0, 0, 0)

-- Adicionar herói
local player = display.newImageRect (grupoMain, "imagens/braum.png", 777*0.1, 1028*0.1)
player.x = 50
player.y = display.contentCenterY 
player.myName = "braum"
-- adicionar corpo fisico a imagem
physics.addBody (player, "kinematic") -- colide apenas com dinamico, nao tem interferencia da gravidade. mas se adicionar um movimento, ele ira se movimentar.

-- Criar botoes
local moverCima = display.newImageRect(grupoUI,"imagens/button.png", 1280/30, 1279/30)
moverCima.x = 70
moverCima.y = 460
moverCima.rotation = 270

local function cima(event)
    player.y = player.y - 70
end

moverCima:addEventListener ("tap", cima)

local moverBaixo = display.newImageRect(grupoUI, "imagens/button.png", 1280/30, 1279/30)
moverBaixo.x = 250
moverBaixo.y = 460
moverBaixo.rotation = 90 -- faz a rotaçao da imagem em graus

local function baixo(event)
    player.y = player.y + 70
    return true
end

moverBaixo:addEventListener ("tap", baixo)

-- adicionar botao de tiro:
local botaoTiro = display.newImageRect (grupoMain, "imagens/tiro.png", 960*0.1, 480*0.1)
botaoTiro.x = display.contentCenterX
botaoTiro.y = 460

-- funcao para atirar:
local function atirar ()
    -- toda vez que a funcao for executada, cria-se um novo "tiro"
    local projetil = display.newImageRect (grupoMain, "imagens/projetil.png", 965*0.04, 500*0.04)
    -- a localizaçao é a mesma do player.
    projetil.x = player.x + 55
    projetil.y = player.y 
    physics.addBody(projetil, "dynamic", {isSensor = true}) -- determinamos que o projetil é um sensor, o que ativa a detecçao continua de colisao.
    -- transiçao do projetil para linha x = 500 em 900 milisegundos
    transition.to (projetil, {x = 500, time = 1400, 
    -- quando a transicao for completada
                    onComplete = function () 
    -- removemos o projétil do display
                        display.remove (projetil)
                    end})    
    projetil.myName = "projetil"
    projetil:toBack() -- faz o elemento ir pra tras dentro do grupo de exibicao dele.
end

botaoTiro:addEventListener("tap", atirar)

-- Adicionar inimigo
local inimigo = display.newImageRect (grupoMain,"imagens/yasuo.png", 512*0.2, 512*0.2)
inimigo.x = 280
inimigo.y = display.contentCenterY
inimigo.myName = "yasuo"
physics.addBody (inimigo, "kinematic")
local direcaoInimigo = "cima"

-- funcao para inimigo atirar:
local function inimigoAtirar ()
    local tiroInimigo = display.newImageRect(grupoMain, "imagens/projetil.png", 965*0.04, 500*0.04)
    tiroInimigo.x = inimigo.x - 50 
    tiroInimigo.y = inimigo.y
    tiroInimigo.rotation = 180
    physics.addBody(tiroInimigo, "dynamic", {isSensor = true})
    transition.to (tiroInimigo, {x = -200, time = 1400,})
                    onComplete = function ()
                        display.remove(tiroInimigo)
                    end
    tiroInimigo.myName = "projetilInimigo"
end

-- criando timer do disparo inimigo:
-- comandos timer (tempo repetição, função, quantidade de repetiçoes (0 = infinito))
inimigo.timer = timer.performWithDelay (math.random (1000, 1500), inimigoAtirar, 0)

-- movimentação do inimigo
local function movimentarInimigo ()
-- se a localizacao x nao for igual a nulo entao
    if not (inimigo.x == nil) then
        --quando a direçao do inimigo for cima entao
        if(direcaoInimigo == "cima") then
            inimigo.y = inimigo.y - 1
                -- se a localizaçao y do inimigo for <= 50 entao
                if(inimigo.y <=50) then
                    -- altera a variavel pra "baixo"
                    direcaoInimigo = "baixo"
                end
            -- se a direçao do inimigo for igual a baixo entao
            elseif (direcaoInimigo == "baixo") then
                inimigo.y = inimigo.y + 1
                -- se a localizaçao y do inimigo for >= 400 entao
                if (inimigo.y >=400) then
                        direcaoInimigo = "cima"
                end
            end
    -- se nao     
    else
        print ("inimigo morreu!")
        -- Runtime: representa todo o jogo (evento é executado para todos), enterFrame: esta ligado ao valor de FPS do jogo (frames por segundo), no caso, a funcao vai ser executada 60 vezes por segundo.
        Runtime:removeEventListener ("enterFrame", movimentarInimigo)
    end
end

Runtime:addEventListener("enterFrame", movimentarInimigo)

-- funcao de colisao:
local function onCollision (event)
    if (event.phase == "began") then
        local obj1 = event.object1
        local obj2 = event.object2
        
        
        if ((obj1.myName == "projetil" and obj2.myName == "yasuo") or (obj1.myName == "yasuo" and obj2.myName == "projetil"))
        then
            audio.play (audioTiro,parametros)
            if (obj1.myName == "projetil") then
            display.remove (obj1)
            else
            display.remove (obj2)
            end
    
        
        pontos = pontos + 1
        pontosText.text = "Pontos: " .. pontos

        elseif ((obj1.myName == "braum" and obj2.myName == "projetilInimigo") or (obj1.myName == "projetilInimigo" and obj2.myName == "braum")) then        
            audio.play (audioTiro,parametros)
            if (obj1.myName == "projetilInimigo") then
                display.remove (obj1)
            else
                display.remove (obj2)
            end
        -- reduz a vida do player a cada colisao
        vidas = vidas - 1
        vidasText.text = "Vidas: " .. vidas
        -- Game over
            if (vidas <= 0 ) then
                Runtime:removeEventListener("collision", onCollision)
                Runtime:removeEventListener("enterFrame", movimentarInimigo)
                --colocar sempre o nome que foi criado o timerWithDelay
                timer.pause(inimigo.timer) 
                moverBaixo:removeEventListener("tap", baixo)
                moverCima:removeEventListener("tap", cima)
                botaoTiro:removeEventListener("tap", atirar)

                local gameOver = display.newImageRect (grupoUI, "imagens/gameOver.png", 500*0.8, 505*0.8 )
                gameOver.x = display.contentCenterX
                gameOver.y = display.contentCenterY
            end
        end
    end
end

Runtime:addEventListener ("collision", onCollision)
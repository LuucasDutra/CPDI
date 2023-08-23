local physics = require ("physics")
physics.start ()
physics.setGravity (0, 0)
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

--Grupos

local grupoBg = display.newGroup()
local grupoMain = display.newGroup()
local grupoUI = display.newGroup()

-- Background - Beach

local bg = display.newImageRect (grupoBg, "imagens/beach.png", 1301*0.5, 1300*0.5)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local castle = display.newImageRect (grupoBg, "imagens/castle2.png", 500*0.25, 500*0.25)
castle.x = display.contentCenterX
castle.y = display.contentCenterY - 50
physics.addBody (castle, "static")

-- Placar

local pontos = 0
local vidas = 5

local fundo = display.newRoundedRect (grupoUI, 0, 10, 350, 20, 30)
fundo:setFillColor (30/255, 156/255, 26/255)
local pontosText = display.newText (grupoUI, "Pontos: " .. pontos, 25, 10, native.systemFont, 20)
pontosText:setFillColor (3/255, 247/255, 44/255)
local vidasText  = display.newText (grupoUI, "Vidas: " .. vidas, 125, 10, native.systemFont, 20)
vidasText:setFillColor (3/255, 247/255, 44/255)

--Player - Turtle

local player = display.newImageRect (grupoMain, "imagens/turtle2.png", 255*0.25, 265*0.25)
player.x = display.contentCenterX
player.y = 450
player.myName = "Turtle"
physics.addBody (player, "static")

-- Barreiras - Lixo

local barreira = display.newImageRect (grupoMain, "imagens/can2.png", 171*0.25, 143*0.25)
barreira.x = 0
barreira.y = 50
physics.addBody (barreira, "dynamic")
barreira.myName = "Lixo"
local direcaoBarreira = "direita"
barreira:applyTorque (math.random (1, 2))

local barreira2 = display.newImageRect (grupoMain, "imagens/can2.png", 171*0.30, 143*0.30)
barreira2.x = 350
barreira2.y = 290
physics.addBody (barreira2, "dynamic")
barreira2.myName = "Lixo"
local direcaoBarreira2 = "direita"
barreira2:applyTorque (math.random (-2, -1))

local barreira3 = display.newImageRect (grupoMain, "imagens/can2.png", 171*0.25, 143*0.25)
barreira3.x = 0
barreira3.y = 360
physics.addBody (barreira3, "dynamic")
barreira3.myName = "Lixo"
local direcaoBarreira3 = "direita"
barreira3:applyTorque (math.random (1, 2))

-- Movimentação da Barreira:

local function movimentarBarreira ()

    if not (barreira.x == nil ) then
        
        if (direcaoBarreira == "direita" ) then
            barreira.x = barreira.x + (math.random(1, 5))
            barreira.xScale = 1

            if (barreira.x >= 350 ) then
                direcaoBarreira = "esquerda"
                barreira.xScale = -1
            end

        elseif (direcaoBarreira == "esquerda" ) then
            barreira.x = barreira.x - (math.random(1, 5))
            
            if (barreira.x <= 10 ) then
                direcaoBarreira = "direita"
            end
        end
    end
end

Runtime:addEventListener ("enterFrame", movimentarBarreira)

-- Movimentação da Barreira 2:

local function movimentarBarreira2 ()

    if not (barreira2.x == nil ) then

        if (direcaoBarreira2 == "direita" ) then
            barreira2.x = barreira2.x + (math.random(1, 5))
            barreira2.xScale = 1

            if (barreira2.x >= 350 ) then
                direcaoBarreira2 = "esquerda"
                barreira2.xScale = -1
            end

        elseif (direcaoBarreira2 == "esquerda" ) then
            barreira2.x = barreira2.x - (math.random(1, 5))

            if (barreira2.x <= 10 ) then
                direcaoBarreira2 = "direita"
            end
        end
    end
end

Runtime:addEventListener ("enterFrame", movimentarBarreira2)

-- Movimentação da Barreira 3:

local function movimentarBarreira3 ()

    if not (barreira3.x == nil ) then

        if (direcaoBarreira3 == "direita" ) then
            barreira3.x = barreira3.x + (math.random(1, 5))
            barreira3.xScale = 1

            if (barreira3.x >= 350 ) then
                direcaoBarreira3 = "esquerda"
                barreira3.xScale = -1
            end

        elseif (direcaoBarreira3 == "esquerda" ) then
            barreira3.x = barreira3.x - (math.random(1, 5))

            if (barreira3.x <= 10 ) then
                direcaoBarreira3 = "direita"
            end
        end
    end
end

Runtime:addEventListener ("enterFrame", movimentarBarreira3)

-- Mover Tartaruga

local function moverPlayer (event)

    local player = event.target
    local phase = event.phase

    if ("began" == phase) then

        display.currentStage:setFocus (player)
        player.touchOffsetX = event.x - player.x 
        player.touchOffsetY = event.y - player.y 
    elseif ("moved" == phase) then
        player.x = event.x - player.touchOffsetX
        player.y = event.y - player.touchOffsetY
    elseif ("ended" == phase or "cancelled" == phase) then
        display.currentStage:setFocus (nil)
    end
    return true
end

player:addEventListener ("touch", moverPlayer)

-- Colisões 

local function onCollision (event)

    if (event.phase == "began" ) then

        local obj1 = event.object1
        local obj2 = event.object2

        if ((obj1.myName == "Lixo" and obj2.myName == "Turtle") or (obj1.myName == "Turtle" and obj2.myName == "Lixo"))
        then
            vidas = vidas -1
            vidasText.text = "Vidas: " .. vidas
        end
    end
end

Runtime:addEventListener ("collision", onCollision)


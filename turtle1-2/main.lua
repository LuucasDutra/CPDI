--Physics
local physics = require ("physics")
physics.start ()
physics.setGravity (0, 0)
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

-- Perspectiva
local perspective = require ("perspective")
local camera = perspective.createView()
camera:prependLayer () -- prepara os layers da camera.

--Grupos e Scripts

local grupoBg = display.newGroup()
local grupoMain = display.newGroup()
local scriptPlayer = require ("Player")
local scriptPlacar = require ("Placar")
local placar = scriptPlacar.novo ()

-- Background - Beach
local bg = display.newImageRect (grupoBg, "imagens/beach.png", 1301*2, 1300*2)
bg.x = display.contentCenterX
bg.y = display.contentCenterY
camera:add (bg, 8)

-- Castelos

for i = -5,5 do
    local castle = display.newImageRect (grupoBg, "imagens/castle2.png", 500*0.25, 500*0.25)
    castle.x = i * (math.random(-50,200))
    castle.y = i*250
    castle.myName = "Castelo"
    physics.addBody (castle, "static")
    camera:add (castle, 7)
end

-- Saída

local Exit = display.newImageRect (grupoBg, "imagens/Exit2.png", 578*0.25, 432*0.25)
Exit.x = display.contentCenterX + 50
Exit.y = -1000
Exit.myName = "Exit"
physics.addBody (Exit, "static")
camera:add (Exit, 7)

--Player - Turtle

local player = scriptPlayer.novo (grupoMain, display.contentCenterX, 500, placar)
camera:add (player, 1)

camera.damping = 10 -- Controla a fluidez da camêra ao seguir o player.
camera:setFocus (player)
camera:track() -- inicia a perseguição da camera

-- Barreiras - Lixo

for i = -5,5 do

    local barreira = display.newImageRect (grupoMain, "imagens/can2.png", 171*0.25, 143*0.25)
    barreira.x =-250
    barreira.y = (i*250)-70
    physics.addBody (barreira, "dynamic")
    barreira.myName = "Lixo"
    local direcaoBarreira = "direita"
    
    camera:add (barreira, 2)


    local function movimentarBarreira ()

        if not (barreira.x == nil ) then
            
            if (direcaoBarreira == "direita" ) then
                barreira.x = barreira.x + (math.random(1, 5))
                barreira.xScale = 1

                if (barreira.x >= 550 ) then
                    direcaoBarreira = "esquerda"
                    barreira.xScale = -1
                end

            elseif (direcaoBarreira == "esquerda" ) then
                barreira.x = barreira.x - (math.random(1, 5))
                
                if (barreira.x <= -250 ) then
                    direcaoBarreira = "direita"
                end
            end
        end
    end

    Runtime:addEventListener ("enterFrame", movimentarBarreira)
end

-- Babies
for i = -6,6 do
    local babyBlue = display.newImageRect ( "imagens/turtle2.png", 255*0.15, 265*0.15)
    babyBlue.x = i*(math.random(-50,200))
    babyBlue.y = i*150
    babyBlue.myName = "BB"
    physics.addBody (babyBlue, "dynamic")
    babyBlue.isFixedRotation = true
    --babyBlue:setFillColor (61/255, 72/255, 245/255)
    camera:add (babyBlue, 2)
end
-- local babyRed = display.newImageRect ( "imagens/turtle2.png", 255*0.15, 265*0.15)
-- babyRed.x = 400
-- babyRed.y = 200
-- babyRed.myName = "BR"
-- physics.addBody (babyRed, "dynamic")
-- babyRed.isFixedRotation = true
-- babyRed:setFillColor (240/255, 47/255, 10/255)
-- camera:add (babyRed, 2)

-- local babyGreen = display.newImageRect ( "imagens/turtle2.png", 255*0.15, 265*0.15)
-- babyGreen.x = 400
-- babyGreen.y = 300
-- babyGreen.myName = "BG"
-- physics.addBody (babyGreen, "dynamic")
-- babyGreen.isFixedRotation = true
-- babyGreen:setFillColor (18/255, 242/255, 42/255)
-- camera:add (babyGreen, 2)

-- local babyYellow = display.newImageRect ( "imagens/turtle2.png", 255*0.15, 265*0.15)
-- babyYellow.x = 400
-- babyYellow.y = 400
-- babyYellow.myName = "BY"
-- physics.addBody (babyYellow, "dynamic")
-- babyYellow.isFixedRotation = true
-- babyYellow:setFillColor (242/255, 252/255, 5/255)
-- camera:add (babyYellow, 2)

-- Colisões 


local function onCollision (event)

    if (event.phase == "began" ) then

        local obj1 = event.object1
        local obj2 = event.object2

        if ((obj1.myName == "Lixo" and obj2.myName == "Turtle") or (obj1.myName == "Turtle" and obj2.myName == "Lixo"))
        then
            placar.somarVidas()
        end
        if ((obj1.myName == "BB" and obj2.myName == "Turtle") or (obj1.myName == "Turtle" and obj2.myName == "BB"))
        then
            placar.somarPontos()
            if (obj1.myName=="BB") then
                display.remove (obj1)
            else
                display.remove (obj2)
            end
        end
        if ((obj1.myName == "Exit" and obj2.myName == "Turtle") or (obj1.myName == "Turtle" and obj2.myName == "Exit"))
        then

            placar.comparar ()
            -- if (pontos >= 30) then
            --     print ("Finalizou")
            -- else
            --     print ("Falta pontos")
            -- end
        end
    end
end

Runtime:addEventListener ("collision", onCollision)



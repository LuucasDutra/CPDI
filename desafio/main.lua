local physics = require ("physics")
physics.start()
physics.setGravity (0, 9.8)
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

-- myName serve pra nomear o objeto na funçao de colisao

local cima = display.newRect(display.contentCenterX, 0,500,50)
physics.addBody (cima,"static")
cima.myName = "teto"

local baixo = display.newRect(display.contentCenterX,480, 500, 50)
physics.addBody(baixo,"static")
baixo.myName = "chao"

local esquerda = display.newRect (-15, display.contentCenterY, 50, 500)
physics.addBody (esquerda, "static")
esquerda.myName = "parede esquerda"

local direita = display.newRect (330, display.contentCenterY, 50, 500)
physics.addBody (direita, "static")
direita.myName = "parede direita"

local bola1 = display.newImageRect ("imagens/bola1.png", 481*0.2, 518*0.2)
bola1.x = display.contentCenterX
bola1.y = 50
physics.addBody (bola1, {bounce = 0.8, radius = 48})
bola1.myName = "bola um"

local quadrado = display.newRect(display.contentCenterX, 414, 80, 80)
physics.addBody (quadrado)

local function trocaCor (event)
    if (event.phase == "began") then
        quadrado:setFillColor(0.3, 0.1,0.9)
    else
        quadrado:setFillColor(0.4, 0.3,0.2)
    end
end

Runtime:addEventListener("collision", trocaCor)


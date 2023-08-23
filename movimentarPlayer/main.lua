local backGroup = display.newGroup()
local mainGroup = display.newGroup() 
local uiGroup = display.newGroup() 

local sky = display.newImageRect("imagens/sky.png", 960, 240*2)
sky.x = display.contentCenterX
sky.y = display.contentCenterY
backGroup:insert(sky)

local ground = display.newImageRect("imagens/ground.png", 1028/2, 256/1.7)
ground.x = display.contentCenterX
ground.y = 410
mainGroup:insert(ground)

local player = display.newImageRect("imagens/player.png", 532/5, 469/5)
player.x = 40
player.y = 300
mainGroup:insert(player)

local moverDireita = display.newImageRect("imagens/button.png", 1280/30, 1279/30)
moverDireita.x = 300
moverDireita.y = 400
mainGroup:insert(player)

local function direita(event)
    player.x = player.x + 5
    return true
end

moverDireita:addEventListener("tap", direita)


local moverEsquerda = display.newImageRect("imagens/button.png", 1280/30, 1279/30)
moverEsquerda.x = 220
moverEsquerda.y = 400
moverEsquerda.rotation = 180

local function esquerda(event)
    player.x = player.x - 5
    return true
end

moverEsquerda:addEventListener ("tap", esquerda)

local moverCima = display.newImageRect("imagens/button.png", 1280/30, 1279/30)
moverCima.x = 260
moverCima.y = 360
moverCima.rotation = 270

local function cima(event)
    player.y = player.y - 70
end

moverCima:addEventListener ("tap", cima)

local moverBaixo = display.newImageRect("imagens/button.png", 1280/30, 1279/30)
moverBaixo.x = 260
moverBaixo.y = 440
moverBaixo.rotation = 90

local function baixo(event)
    player.y = player.y + 70
    return true
end

moverBaixo:addEventListener ("tap", baixo)

local function nordeste (event)
    player.x = player.x + 10
    player.y = player.y - 55
end    return true
end

moverCima:addEventListener ("tap", cima)

local moverBaixo = display.newImageRect("imagens/button.png", 1280/30, 1279/30)
moverBaixo.x = 260
moverBaixo.y = 440
moverBaixo.rotation = 90

local function baixo(event)
    player.y = player.y + 70
    return true
end

moverBaixo:addEventListener ("tap", baixo)

local function nordeste (event)
    player.x = player.x + 10
    player.y = player.y - 55
end

local moverNordeste = display.newImageRect("imagens/button.png", 1280/30, 1279/30)
moverNordeste.x = 300
moverNordeste.y = 360
moverNordeste.rotation = 320
moverNordeste:addEventListener("tap", nordeste)

local function sudeste (event)
    player.x = player.x + 10
    player.y = player.y + 55
end

local moverSudeste = display.newImageRect("imagens/button.png", 1280/30, 1279/30)
moverSudeste.x = 300
moverSudeste.y = 440
moverSudeste.rotation = 45
moverSudeste:addEventListener("tap", sudeste)

local function sudoeste (event)
    player.x = player.x - 10
    player.y = player.y + 55
end

local moverSudoeste = display.newImageRect("imagens/button.png", 1280/30, 1279/30)
moverSudoeste.x = 220
moverSudoeste.y = 440
moverSudoeste.rotation = 130
moverSudoeste:addEventListener("tap", sudoeste)

local function noroeste (event)
    player.x = player.x - 10
    player.y = player.y - 55
end

local moverNoroeste = display.newImageRect("imagens/button.png", 1280/30, 1279/30)
moverNoroeste.x = 220
moverNoroeste.y = 360
moverNoroeste.rotation = 225
moverNoroeste:addEventListener("tap", noroeste)
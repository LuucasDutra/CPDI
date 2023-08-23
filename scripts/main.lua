-- chamando os scripts criados para o projeto
local scriptPlayer = require ("Player")
local scriptInimigo = require ("Inimigo")
local scriptHUD = require ("HUD")
local scriptColetavel = require ("Coletavel")
--chamando a fisica
local physics = require ("physics")
physics.start()
physics.setGravity (0, 9.8)
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect ("imagens/bg.png", 800*0.5, 600)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local hud = scriptHUD.novo()

local chao = display.newImageRect("imagens/chao.png", 1503, 150)
chao.x = display.contentCenterX
chao.y = display.contentHeight + 10
chao.id = "chao"
-- parametros para criar a box {x referente imagem=, y referente imagem=, metade da largura da box=, metade da altura da box=, angulo da box}
physics.addBody (chao, "static", {friction = 1, box = {x = 0, y = 0, halfWidth = 750, halfHeight = 55, angle = 0}})

local inimigo = scriptInimigo.novo (250, 400)

local player = scriptPlayer.novo (40, 200, hud)

-- apos 1 segundo, cria-se a moeda 1 = chama a funcao novamoeda [script coletavel] (x=math.random, y = -100, quantidade de repeticoes [0 é infinito], "nome do timer")
timer.performWithDelay (1000, function()
    local moeda = scriptColetavel.novaMoeda(math.random(0,480), -100)
    end,0, "timerMoeda")
local scriptPlayer = require ("Player")
local perspective = require ("perspective")
local physics = require ("physics")

physics.start ()
physics.setGravity (0, 9.8)
physics.setDrawMode ("normal")

--cria a camera
local camera = perspective.createView()
camera:prependLayer () -- prepara os layers da camera

display.setStatusBar (display.HiddenStatusBar)

local bg = display.newImageRect("imagens/fundo.png", 2551*0.15, 3437*0.15)ad
bg.x, bg.y = display.contentCenterX, display.contentCenterY
camera:add(bg, 8) -- adiciona a imagem ao layer determinado, no caso - 8, quanto maior mais distante

local sol = display.newImageRect ("imagens/sun.png",96, 96)
sol.x = 400
sol.y = 20
camera:add (sol, 7)

for i = 0, 4 do
   local nuvens = display.newImageRect ("imagens/cloud.png", 920*0.2, 384*0.2)
   nuvens.x = 128*i
   nuvens.y = math.random (-20, 100)
   nuvens.alpha = 0.8
   camera:add (nuvens,7)
end

for i = 0, 3 do
   local nuvem = display.newImageRect ("imagens/cloud.png", 920*0.2, 384*0.2)
   nuvem.x = 128*i
   nuvem.y = math.random (-160, 160)
   nuvem.alpha = 0.7
   camera:add(nuvem, 6)
end

for i = 0, 4 do
   local chaoFundo = display.newImageRect("imagens/chao.png", 4503*0.15, 613*0.15)
   chaoFundo.x = -256 + (chaoFundo.width*i)
   chaoFundo.y = 210
   camera:add(chaoFundo, 6)
end

for i = 0, 6 do
   local arvoreFundo = display.newImageRect("imagens/tree.png", 96, 96)
   arvoreFundo.x = -256 +(120*i)
   arvoreFundo.y = 140
   camera:add (arvoreFundo,6)
end

for i = 0,4 do
   local chaoMeio = display.newImageRect("imagens/chao.png", 4503*0.15, 613*0.15)
   chaoMeio.x = -256 + (chaoMeio.width*i)
   chaoMeio.y = 250
   camera:add(chaoMeio,4)
end

for i = 0, 6 do
   local arvoreMeio = display.newImageRect("imagens/tree.png", 96, 96)
   arvoreMeio.x = -266 + (128*i)
   arvoreMeio.y = 180
   camera:add (arvoreMeio,4)
end

for i = 0, 4 do
   local chao = display.newImageRect("imagens/chao.png", 4503*0.15, 613*0.15)
   chao.x = -256 + (chao.width*i)
   chao.y = 290
   chao.id = "chao"
   physics.addBody (chao, "static", {friction = 1, box = {x = 0, y = 0, halfWidth = chao.width/2, halfHeight = chao.height/5}})
   camera:add(chao, 1)
end

for i = 0, 6 do
   local arvore = display.newImageRect("imagens/tree.png", 96, 96)
   arvore.x = -234 + (128*i)
   arvore.y = 220
   camera:add (arvore, 1)
end

local player = scriptPlayer.novo (240, 0)
camera:add (player, 1)


-- efeitos parallar tras a ilusao de profundidade ao jogo
-- as posicoes das virgulas representam os numeros dos layers
                   -- layer(1, 2, 3, 4, 5, 6, 7, 8)
camera:setParallax (1, 0.9, 0.8, 0.7, 0.6, 0.5, 0.1, 0)

camera.damping = 10 -- controla a fluidez da camera ao seguir o player.
camera:setFocus (player) -- define o player como foco da cazmera
camera:track() -- inicia a perseguiçao da camera
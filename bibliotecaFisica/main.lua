-- Física
-- Chamar a biblioteca: atribui a biblioteca interna de física à variável physics.
local physics = require ("physics")
-- Iniciar a física no projeto:
physics.start()
-- Definir a gravidade do projeto: Definimos a gravidade x e y do projeto. Geralmente utilizado de 0 a 15
physics.setGravity (0,9.8)
-- Definir a renderização da visualização da física (usado somente durante o desenvolvimento para testes)
-- Modos: normal: Aparece apenas as imagens, corpos físicos invisíveis (padrão do sistema)
--        hybrid: Mostra as imagens e os corpos físicos
--        debug: mostra apenas os corpos físicos 
physics.setDrawMode("hybrid")
-- Adicionando objetos físicos:
local retangulo = display.newRect(150, display.contentCenterY, 100, 40)
-- Corpo dinamico: interage com a gravidade e colide com todos os corpos
physics.addBody(retangulo, "dynamic")

local chao = display.newRect (display.contentCenterX, 400,400,20)
-- Corpo estatico: nao se movimenta e colide apenas com o dinamico.
physics.addBody(chao, "static")

local circulo = display.newCircle (300, 50, 30)
-- Corpo cinemático: nao interage com a gravidade e colide apenas com dinamico.
physics.addBody (circulo, "kinematic", {radius = 30})

local quadrado = display.newRect (display.contentCenterX, 0, 50, 50)
physics.addBody (quadrado, "dynamic", {bounce = 0.3, friction = 0.4, density = 0.2})
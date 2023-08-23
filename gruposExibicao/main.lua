--Criando grupos de exibição

--Back usado para plano de fundo, decorações que não terão interação com o jogo.
local backGroup = display.newGroup()

-- Usado para os objetos que terão interação dentro do jogo, grupo principal.
local mainGroup = display.newGroup() 

-- Utilizado para placar, vidas, texto, que ficarão na frente do jogo, porém sem interação.
local uiGroup = display.newGroup() 

-- Método embutido:
-- Inclui o objeto no grupo já na sua criação
local bg = display.newImageRect(backGroup, "imagens/bg.jpg", 509,339*1.5)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local cloud = display.newImageRect(backGroup, "imagens/cloud.png", 2360*0.1, 984*0.1)
cloud.x = display.contentCenterX
cloud.y = 150

local tree = display.newImageRect(mainGroup, "imagens/tree.png", 1024*0.2, 1024*0.2)
tree.x = 70
tree.y =  320

-- Método direto:
-- Inclui o objeto depois da sua criação

local sun = display.newImageRect("imagens/sun.png", 256*0.5, 256 *0.5)
sun.x = 50
sun.y = 75
backGroup:insert(sun)

local tree2 = display.newImageRect("imagens/tree.png", 1024*0.2, 1024*0.2)
tree2.x = 250
tree2.y = 320
mainGroup:insert(tree2)

local chao = display.newImageRect("imagens/chao.png",4503 *0.2,613*0.2)
chao.x = display.contentCenterX
chao.y = 430
mainGroup:insert(chao)

-- Comandos - toFront e toBack para alinhas os objetos conforme quiser.
chao:toFront()

-- Adicionar nova imagem na tela:
-- Comandos: display.newImageRect("pasta/arquivo.formato", largura, altura)
local bg = display.newImageRect("imagens/bg.jpg", 1280*1.25, 720*1.25)
-- Definir localizacao objeto.
-- Comando: variavel.linha que vou definir = localizacao na linha.
bg.x = display.contentCenterX -- Comando que centraliza a variavel em qualquer resolucao
bg.y = display.contentCenterY -- Comando que centraliza a variavel em qualquer resolucao

-- Alinhamento por pixel
local charmander = display.newImageRect("imagens/charmander.png", 507*0.3, 492*0.3)
charmander.x = 550
charmander.y = 350

local pikachu = display.newImageRect("imagens/pikachu.png", 1191*0.18, 1254*0.18)
pikachu.x = 600
pikachu.y = 600

-- Outra forma de alinhamento a partir do centro

-- local variavel = display.newImageRect("imagens/pikachu.png", 1191*0.18, 1254*0.18)
-- variavel.x = display.contentCenterX + 220
-- variavel.y = display.contentCenterY + 300

-- Criando um retangulo: 
-- Comandos: display.newRect(localizacao x, y, largura, altura)
local retangulo = display.newRect(260, 475, 250, 160)

-- Criando um circulo:
-- Comandos: display.newCircle(localizacao x, y, raio)
local pokeball = display.newImageRect("imagens/pokeball.png", 651*0.1,651*0.1)
pokeball.x = 650
pokeball.y = 250

local squirtle = display.newImageRect("imagens/mystery.png", 493*0.3, 506*0.3)
squirtle.x = 250
squirtle.y = 475
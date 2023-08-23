local retangulo = display.newRect(100, 80, 200, 140)
local ret = {
    type = "gradient", 
    color1 = { 0.8, 0.5, 0.9},
    color2 = { 0.1, 0.4, 0.8},
    direction = "right"
}

local circulo = display.newCircle(300, 80, 78)
local cir = {
    type = "gradient", 
    color1 = { 0.2, 0.1, 0.2},
    color2 = { 0.8, 0.8, 0.8},
    direction = "down"
}
local quadrado = display.newRect(700, 80, 150, 150)

-- Adicionar retângulo arredondado: 
-- Comandos: display.newRoundedRect(x, y, largura, altura, raio das bordas)

local retanguloArredondado = display.newRoundedRect(500, 80, 200, 140, 78)

-- Adicionar uma linha:
-- Comandos: display.newLine (xInicial, yInicial, xFinal, yFinal)
local linha = display.newLine(0,201,2100,200)

-- Criar um polígono:
-- Comandos: display.newPolygon (x, y, vertices)

local localizacaoX = 200
local localizacaoY = 350
local vertices = {0, -110, 27, -35, 105, -35, 43, 16, 65, 90, 0, 45, -65, 90, -43, 15, -105, -35, -27, -35}

local estrela = display.newPolygon(localizacaoX, localizacaoY, vertices)

-- Criar um novo texto: 
-- Comandos: display.newText ("Texto que eu quero inserir", x, y, fonte, fontSize)

local texto = display.newText("Hello World!", 500, 350, native.systemFont, 50)

local parametros = {
    text = "Olá Mundo!",
    x = 500,
    y = 450,
    font = "Arial",
    fontSize = 50,
    align = "right",
}

local olaMundo = display.newText (parametros)

-- Adicionar texto em relevo: 
-- Comando: display.newEmbossedText ("Texto que eu quero inserir", x, y, fonte, fontSize)

local opcoes = {
    text = "Lucas",
    x = 730,
    y = 450,
    font = "Arial",
    fontSize = 50
}

local textoRelevo = display.newEmbossedText(opcoes)

-- Adicionar cor ao objeto/texto:
-- Comandos: variavel:setFillColor (cinza, vermelho, verde, azul, alpha)
-- alpha -> transparencia

texto:setFillColor(0.9, 0.4, 0.5)
texto.alpha = 0.3

local color = {
    -- destaque
    highlight = {r = 1, g = 0, b = 1},
    -- sombra
    shadow = {r = 1, g = 0.2, b = 0.2},
}

textoRelevo:setEmbossColor(color)

-- Gradiente: 
-- Comandos: variavel = {type =, color1 = { , , }, color2 { , , }, direction = ""}
local gradiente = {
    type = "gradient", 
    color1 = { 1, 0.1, 0.9},
    color2 = { 0.8, 0.8, 0.8},
    direction = "down"
}

estrela:setFillColor (gradiente)
retangulo:setFillColor(ret)
circulo:setFillColor(cir)
quadrado:setFillColor(0.2, 0.4,0.0)
retanguloArredondado:setFillColor(0.5,0.2,0.2)
olaMundo:setFillColor(gradiente)

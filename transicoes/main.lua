 local circulo = display.newCircle (80, 50, 30)
-- Transições
-- Comandos> transition.to (variavel, {parametros})
function andar (event)
    transition.to (circulo, {time = 1000, x = 300,y = 50})
    return true
end

transition.to (circulo, {time = 1000, y = 400, onComplete = andar})

local circulo1 = display.newCircle(150, 50, 30)
transition.to (circulo1, {time = 3000, y = 400, delta = true})

local circulo2 = display.newCircle (250,50,30)
transition.to (circulo2, {time = 3000, y = 400, iterations = 4, transition=easing.outElastic}) 

local retangulo = display.newRect (200,250,50,70)
transition.to (retangulo, {time = 2000, rotation=470, yScale = 2, alpha = 0,iterations = -1})
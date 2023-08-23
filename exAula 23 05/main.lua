local localizacaoX = 50
local localizacaoY = 430
local vertices = {0, -110/2, 27/2, -35/2, 105/2, -35/2, 43/2, 16/2, 65/2, 90/2, 0, 45/2, -65/2, 90/2, -43/2, 15/2, -105/2, -35/2, -27/2, -35/2}

local estrela = display.newPolygon(localizacaoX, localizacaoY, vertices)
local gradiente = {
    type = "gradient", 
    color1 = { 1, 0.1, 0.9},
    color2 = { 0.8, 0.8, 0.8},
    direction = "down"
}

function direita (event)
        function descer (event)
                function esquerda(event)
                    transition.to (estrela, {time=3000, x = 50, transition=easing.inOutQuint, transition=estrela:setFillColor (gradiente)})
                    return true
                end
            transition.to (estrela, {time = 2000, y = 430, transition=easing.inOutBounce, onComplete = esquerda})
            return true
        end
    transition.to (estrela,{time = 2000, rotation = 360, x=300,onComplete = descer})
    return true
end

transition.to (estrela, {time = 2000, y = 50, transition = easing.inOutBounce, onComplete = direita})

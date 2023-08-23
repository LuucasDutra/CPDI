-- Incluindo funções:
-- Comando para iniciar a função local function nome da função seguido de parênteses
local function detectarTap(event) -- Determina o tipo da função, nesse caso, função de evento 
    -- Código que é executado quando o botão for tocado
    -- tostring: para sequenciar usado junto com a concatenação para trazer a sequencia das ações
    -- event.target: nomear o objeto do evento, ou objeto tocado.
    print("Objeto tocado:" .. tostring (event.target))

    return true -- "zera" todos os dados depois da função executada.

end -- Fecha a function

local botaoTap = display.newRect (200, 200, 200, 50)
botaoTap:addEventListener("tap", detectarTap) -- Adicionar um ouvinte "tap" ao objeto.

local function tapDuplo(event)
    if (event.numTaps == 2) then
        print ("objeto tocado duas vezes: " .. tostring(event.target))
    elseif (event.numTaps == 1) then
        print ("objeto tocado uma vezes: " .. tostring(event.target))
    end
    return true
end

local botaoDuplo = display.newRect(100, 300, 200, 50)
botaoDuplo:setFillColor(0.7, 0, 0.5)
botaoDuplo:addEventListener("tap", tapDuplo)

-- Evento de toque (touch)
-- Fases de toque:
    -- began = Primeira fase de toque, quando o usuário encosta na tela
    -- moved = Quando o usuário mantém o toque e move pela tela.
    -- ended = Quando o usuário retira o dedo da tela, solta o toque
    -- cancelled = Quando o evento de toque é cancelado pelo sistema. 

    local function fasesToque (event)
    -- Se a fase de toque for igual a began então
        if (event.phase == "began") then
            print ("Objeto tocado: " .. tostring(event.target))
    -- Senão se a fase de toque for igual a moved então  
        elseif (event.phase == "moved") then
            print ("Localização de toque nas seguintes coordenadas: x=" .. event.x .. ", y= " .. event.y)
    -- Senão se a fase de toque for igual ended ou cancelled então
        elseif (event.phase == "ended" or "cancelled") then
            print("Touch terminado no objeto: " .. tostring (event.target))
        end

        return true
    end

    local botaoTouch = display.newRect (200, 400, 200, 50)
    botaoTouch: setFillColor (0.2, 0.5, 0.3)
    botaoTouch: addEventListener("touch", fasesToque)

-----------------------------------------------------------------------------------------------------------

-- Multitoque: 
-- Para utilizar o multitouch precisamos habilitar (ativar) primeiro.
/*system.activate ("multitouch")      

local retangulo = display.newRect(display.contentCenterX, display.contentCenterY, 280,80)
retangulo:setFillColor(1,0,0.3)

local function eventoTouch (event)
    print("fase de toque" .. event.phase)
    print("Localização x:" .. tostring(event.x) .. ", localização y: " .. tostring (event.y))
    print("ID de toque exclusivo: ".. tostring(event.id))
    print("---------------")
    return true
end

retangulo:addEventListener("touch", eventoTouch)*/
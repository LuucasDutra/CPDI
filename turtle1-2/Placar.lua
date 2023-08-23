local Placar = {}

function Placar.novo ()
    local grupoPlacar = display.newGroup()

    local pontos = 0
    local vidas = 5

    local fundo = display.newRoundedRect (grupoPlacar, 0, 10, 350, 20, 30)
    fundo:setFillColor (30/255, 156/255, 26/255)

    local pontosText = display.newText (grupoPlacar, "Pontos: " .. pontos, 30, 10, native.systemFont, 20)
    pontosText:setFillColor (3/255, 247/255, 44/255)

    local vidasText  = display.newText (grupoPlacar, "Vidas: " .. vidas, 125, 10, native.systemFont, 20)
    vidasText:setFillColor (3/255, 247/255, 44/255)

    grupoPlacar.somarPontos = function ()
        pontos = pontos + 10
        pontosText.text = "Pontos: " .. pontos
        print (pontos)
    end

    grupoPlacar.somarVidas = function ()
        vidas = vidas -1
        vidasText.text = "Vidas: " .. vidas
    end

    grupoPlacar.comparar = function ()
        if (pontos >= 60) then
            print ("Finalizou")
        else
            print ("Falta pontos")
        end
    end

    return grupoPlacar
end

return Placar
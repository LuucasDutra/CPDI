local HUD = {}

function HUD.novo ()
    -- cria o grupo hud para armazenamento da funcao
    local grupoHUD = display.newGroup ()

    local pontos = 0
    local pontosText = display.newText ("Pontos: " .. pontos, 40,20, native.systemFont, 20)

    -- cria funcao de somar atribuida ao grupo
    grupoHUD.somar = function ()
        pontos = pontos + 1
        pontosText.text = "Pontos: " .. pontos
    end

    local vidas = 5
    local vidasText = display.newText("Vidas: ".. vidas,  140,20, native.systemFont, 20)

    grupoHUD.life = function()
        vidas = vidas - 1
        vidasText = "Vidas: " .. vidas
    end
    return grupoHUD
end

return HUD
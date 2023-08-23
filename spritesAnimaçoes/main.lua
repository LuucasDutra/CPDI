display.setStatusBar ( display.HiddenStatusBar)

-- inclusao de sprite de animaçao
-- ("pasta/arquivo.formato", {larguraFrame = , alturaFrame = , numeroFrames = })
local sprite1 = graphics.newImageSheet ("imagens/playerFem2.png", {width = 192, height = 256, numFrames = 45})

local spriteAnimacao = {
-- {"nome = "estagio da animaçao", frameInicial = , frameFinal = , tempo = , numeroDeLoops = (0 é infinito)},
    {name = "parado", start = 1, count = 1, time = 1000, loopCount = 0},
    {name = "andando", start = 37, count = 8, time = 1000, loopCount = 0},
    {name = "pulo", start = 2, count = 3, time = 1000, loopCount = 0}
}

-- newSprite é utilizado apenas para sprites de animaçao
local player = display.newSprite (sprite1, spriteAnimacao)
player.x = display.contentCenterX
player.y = display.contentCenterY
-- Escala da imagem
player.xScale = 0.5
player.yScale = 0.5
-- Definir sequencia de animacao inicial
player:setSequence ("parado")
-- inicia a sequencia de animacao
player:play ()
---------------------------------------------------------------

--sprites de elementos estaticos:

local spriteOpcoes = 
{

	frames= 
	{ 
		{ -- 1) menu
			x= 0,
			y= 0,
			width= 125,
			height= 100
		},
		{ -- 2) botao esquerda
			x= 0,
			y= 100,
			width= 125,
			height= 100
		},
		{-- 3) on/off
			x= 0,
			y= 200,
			width= 125,
			height= 100
		},
		{ -- 4) configurações
			x= 0,
			y= 300,
			width= 125,
			height= 100 
		}, 
		{ -- 5) mensagens
			x= 0, 
			y= 400, 
			width= 125,
			height= 100
		},
		{ -- 6) pause
			x= 125,
			y= 0,
			width= 125,
			height= 100
		},
		{ -- 7) botao direita
			x= 125,
			y= 100,
			width= 125,
			height= 100
		},
		{-- 8) return
			x= 125,
			y= 200,
			width= 125,
			height= 100
		},
		{ -- 9) volume
			x= 125,
			y= 300,
			width= 125,
			height= 100 
		}, 
		{ -- 10) compras
			x= 125, 
			y= 400, 
			width= 125,
			height= 100
			},
		{ -- 11) play
			x= 250,
			y= 0,
			width= 125,
			height= 100
		},
		{ -- 12) cima
			x= 250,
			y= 100,
			width= 125,
			height= 100
		},
		{-- 13) x/não
			x= 250,
			y= 200,
			width= 125,
			height= 100
		},
		{ -- 14) ajuda
			x= 250,
			y= 300,
			width= 125,
			height= 100 
		}, 
		{ -- 15) recordes
			x= 250, 
			y= 400, 
			width= 125,
			height= 100
		},
		{ -- 16) home
			x= 375,
			y= 0,
			width= 125,
			height= 100
		},
		{ -- 17) botao baixo
			x= 375,
			y= 100,
			width= 125,
			height= 100
		},
		{-- 18) yes
			x= 375,
			y= 200,
			width= 125,
			height= 100
		},
		{ -- 19) segurança
			x= 375,
			y= 300,
			width= 125,
			height= 100 
		}, 
		{ -- 20) música
			x= 375, 
			y= 400, 
			width= 125,
			height= 100
			}	
	}
}

local sprite2 = graphics.newImageSheet ("imagens/button.png", spriteOpcoes)

local botaoEsquerda = display.newImageRect (sprite2, 2, 125, 100)
botaoEsquerda.x = 50
botaoEsquerda.y = 420
botaoEsquerda.xScale = 0.8
botaoEsquerda.yScale = 0.8

local botaoDireita = display.newImageRect(sprite2, 7, 125, 100)
botaoDireita.x = 250
botaoDireita.y = 420
botaoDireita.xScale = 0.8
botaoDireita.yScale = 0.8

local botaoPulo = display.newImageRect (sprite2, 12, 125, 100)
botaoPulo.x = 157
botaoPulo.y = 420
botaoPulo.xScale = 0.8
botaoPulo.yScale = 0.8

local function moverEsquerda (event)
    if (event.phase == "began") then
        player.x = player.x - 1
        player:setSequence ("andando")
        player:play()
        player.xScale = - 0.5
    elseif (event.phase == "moved") then
        player.x = player.x - 1
    elseif (event.phase == "ended") then
        player:setSequence ("parado")
        player:play()
        player.xScale = - 0.5
    end
end
botaoEsquerda:addEventListener ("touch", moverEsquerda)

local function moverDireita (event)
    if (event.phase == "began") then
        player.x = player.x + 1
        player:setSequence ("andando")
        player:play()
        --xScale negativo faz o espelhamento
        player.xScale =  0.5
    elseif (event.phase == "moved") then
        player.x = player.x + 1
    elseif (event.phase == "ended") then
        player:setSequence ("parado")
        player:play()
        player.xScale = 0.5
    end
end
botaoDireita:addEventListener ("touch", moverDireita)

local function moverCima (event)
    if (event.phase == "began") then
        local playerY = player.y
        player.y = player.y -30
        player:setSequence ("pulo")
        player:play()
        timer.performWithDelay(500, function()
            player.y = playerY
            player:setSequence ("parado")
            player:play() 
        end)
    end
end

botaoPulo:addEventListener ("touch", moverCima)
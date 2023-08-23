-- Lista de imagens para as cartas
local cartas = { "card1", "card2", "card3", "card4", "card5", "card6" }
-- Número de colunas e linhas do tabuleiro
local numCols, numLinhas = 3, 4
-- Espaçamento entre as cartas
local distancia = 20
-- Largura e altura de cada carta
local larguraCarta, alturaCarta
--Variáveis para armazenar as cartas viradas
local card1, card2
-- Variável para controlar se as cartas podem ser viradas
local virar = true
-- Variável que representa o tabuleiro de cartas
local tabuleiro

-- Comando para esconder a barra de status
display.setStatusBar (display.HiddenStatusBar)

-- Adiciona background
local bg = display.newImageRect("assets/bg.jpg", 2000*0.25, 2000*0.25)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

-- Função para embaralhar uma tabela
local function embaralhar(tabela)
    -- Armazena o tamanho da tabela
    local n = #tabela
    -- Laço para embaralhar os elementos da tabela
    while n > 1 do
        -- Gera um número aleatório entre 1 e n
        local l = math.random(n)
        -- Troca os elementos n e k de posição
        tabela[n], tabela[l] = tabela[l], tabela[n]
        -- Reduz o tamanho da tabela para embaralhar os elementos restantes
        n = n - 1
    end
    -- Retorna a tabela com os elementos embaralhados
    return tabela
end

--Função para criar uma carta com imagem de frente e verso
local function criarCarta(x, y, frenteImagem, atrasImagem)
    -- Cria um novo grupo para as cartas
    local carta = display.newGroup()
    -- Adiciona a imagem do verso da carta
    local back = display.newImageRect(carta, atrasImagem, larguraCarta, alturaCarta)
    -- Armazena o nome da imagem da frente da carta
    carta.frenteImagem = frenteImagem
    -- Variável para controlar se a carta está virada
    carta.virada = false
    -- Define a posição inicial da carta
    carta.x, carta.y = x, y
    -- função para virar a carta
    function carta:virar()
        if not self.virada then
            self.virada = true
            transition.to(self, { time = 200, xScale = 0.1, onComplete = function()
                back.isVisible = false
                display.newImageRect(self, self.frenteImagem, larguraCarta, alturaCarta)
                transition.to(self, { time = 200, xScale = 1 })
            end})
        end
    end
    -- Função para reverter a carta para a posição inicial
    function carta:reset()
        self.virada = false
        back.isVisible = true
        display.remove(self[2])
    end
    -- Adiciona um evento de toque para a carta
    carta:addEventListener("tap", function(event)
        carta:virar()
    end)

    return carta
end

-- Função para calcular o tamanho ideal das cartas
local function tamanhoDaCarta()
    local larguraDisponivel = display.actualContentWidth - (distancia * (numCols + 1))
    local alturaDisponivel = display.actualContentHeight - (distancia * (numLinhas + 1))
    larguraCarta = larguraDisponivel / numCols
    alturaCarta = alturaDisponivel / numLinhas
end

-- Função para calcular o tamanho total do tabuleiro
local function tamanhoTabuleiro()
    tamanhoDaCarta()
    local larguraTabuleiro = larguraCarta * numCols + distancia * (numCols - 1)
    local alturaTabuleiro = alturaCarta * numLinhas + distancia * (numLinhas - 1)
    return larguraTabuleiro, alturaTabuleiro
end

-- Função para criar o tabuleiro
local function criarTab()
    -- Novo grupo para o tabuleiro
    local grupoTab = display.newGroup()
    -- Calcula o tamanho total do tabuleiro
    local larguraTabuleiro, alturaTabuleiro = tamanhoTabuleiro()
    -- Posiciona o tabuleiro a partir do centro
    local startX = (display.actualContentWidth - larguraTabuleiro) / 2 + 25
    local startY = (display.actualContentHeight - alturaTabuleiro) / 2 + 45
    -- Gera posições aleatórias para as cartas no tabuleiro
    local posicoes = {}
    for i = 1, numLinhas do
        for j = 1, numCols do
            table.insert(posicoes, { startX + (larguraCarta + distancia) * (j - 1), startY + (alturaCarta + distancia) * (i - 1) })
        end
    end

    posicoes = embaralhar(posicoes)
    -- Cria as cartas e adiciona elas ao grupo do tabuleiro
    for i = 1, numLinhas * numCols / 2 do
        for j = 1, 2 do
            local indice = (i - 1) * 2 + j
            local carta = criarCarta(posicoes[indice][1], posicoes[indice][2], "assets/"..cartas[i]..".png", "assets/back.png")
            grupoTab:insert(carta)
        end
    end

    return grupoTab
end

-- Função para verificar se duas cartas viradas são iguaais
local function checar()
    -- Cria uma tabela para armazenar as cartas viradas
    local cartasViradas = {}
    -- Percorre todas as cartas no tabuleiro
    for i = 1, tabuleiro.numChildren do
        local carta = tabuleiro[i]
        -- Se a carta estiver virada, adiciona a tabela de cartas viradas
        if carta.virada then
            table.insert(cartasViradas, carta)
        end
    end
    -- Se tiverem duas cartas viradas e a função de virar cartas estiver disponivel
    if #cartasViradas == 2 and virar then
        -- Bloqueia a função de virar cartas temporariamente
        virar = false
        -- Armazena as duas cartas viradas para comparação
        card1, card2 = cartasViradas[1], cartasViradas[2]
        -- Verifica se as duas cartas são iguais
        if card1 ~= card2 and card1.frenteImagem == card2.frenteImagem then
            -- Se forem iguais, remove as cartas do tabuleiro após um pequeno tempo
            timer.performWithDelay(1000, function()
                display.remove(card1)
                display.remove(card2)
                -- Libera a função de virar cartas novamente
                virar = true
            end)
        else
            -- Se não forem iguais, reverte as cartas após um intervalo
            timer.performWithDelay(1000, function()
                card1:reset()
                card2:reset()
                -- Libera a função de virar cartas novamente
                virar = true
            end)
        end
    end
end

-- Função chamada quando o jogador toca no tabuleiro
local function onBoardTap(event)
    checar()
end

-- Cria o tabuleiro e adiciona o evento "tap"
tabuleiro = criarTab()
tabuleiro:addEventListener("tap", onBoardTap)

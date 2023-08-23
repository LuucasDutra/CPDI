-- Carregando audio de fundo (strram indicado para audios longos)
--                               ("pasta/arquivo.formato")
local bgAudio = audio.loadStream ("audio/audio_bg.mp3")  
audio.reserveChannels (1)
-- Especificar o volume do canal
audio.setVolume (0.6, {channel = 1})
-- Reproduzir o audio
--          (audio a reproduzir, {canal, loopins (-1 infinito)})
audio.play (bgAudio, {channel = 1, loops = 0})

--loadSound é melhor utilizado com sons curtos
local audioTiro = audio.loadSound ("audio/tiro.wav")
-- informaçoes de como o audio deve ser reproduzido
local parametros = {time = 2000, fadein = 200}

local botaoTiro = display.newCircle (60, 300, 32)
botaoTiro:setFillColor (1,0,0)

local function tocarTiro()
    audio.play(audioTiro,parametros)
end

botaoTiro:addEventListener ("tap", tocarTiro)

local audioMoeda = audio.loadSound ("audio/moeda.wav")
local botaoMoeda = display.newRect (50,50,50,50)
botaoMoeda:setFillColor (0,1,0)

local function tocarMoeda ()
    audio.play (audioMoeda, parametros)
end
botaoMoeda:addEventListener("tap", tocarMoeda)

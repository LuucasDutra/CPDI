local composer = require ("composer")

display.setStatusBar (display.HiddenStatusBar)

math.randomseed (os.time ())

audio.reserveChannels (2)
audio.setVolume (0.1, {channel=1})
audio.setVolume (0.4, {channel = 2})
-- comando que inicia a cena principal
composer.gotoScene ("menu")
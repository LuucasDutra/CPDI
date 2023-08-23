local physics = require ("physics")
physics.start ()
physics.setGravity (0, 0)
physics.setDrawMode ("normal")

display.setStatusBar (display.HiddenStatusBar)

local backGroup = display.newGroup ()
local mainGroup = display.newGroup ()
local UIGroup = display.newGroup ()

local vidas = 3
local pontos = 0
local trashTable = {}
local foodTable = {}
local gameLoopTimer
math.randomseed (os.time())

local bg = display.newImageRect (backGroup, "imagens/sea.png", 1999*0.25, 2000*0.25)
bg.x = display.contentCenterX
bg.y = display.contentCenterY

local fundo = display.newRoundedRect (UIGroup, 0, 10, 350, 20, 30)
fundo:setFillColor (30/255, 156/255, 26/255)
local pontosText = display.newText (UIGroup, "Pontos: " .. pontos, 25, 10, native.systemFont, 20)
pontosText:setFillColor (3/255, 247/255, 44/255)
local vidasText  = display.newText (UIGroup, "Vidas: " .. vidas, 125, 10, native.systemFont, 20)
vidasText:setFillColor (3/255, 247/255, 44/255)

local player = display.newImageRect (mainGroup, "imagens/turtle2.png", 255*0.25, 265*0.25)
player.x = display.contentCenterX
player.y = 450
player.myName = "Turtle"
physics.addBody (player, "static")

local trashcan = display.newImageRect (mainGroup, "imagens/trashcan2.png", 167*0.35, 200*0.35)
trashcan.x = display.contentCenterX -150
trashcan.y = 450
trashcan.myName = "Trashcan"
physics.addBody (trashcan, "static")

local function moverPlayer (event)

    local player = event.target
    local phase = event.phase

    if ("began" == phase) then

        display.currentStage:setFocus (player)
        player.touchOffsetX = event.x - player.x 
        player.touchOffsetY = event.y - player.y 
    elseif ("moved" == phase) then
        player.x = event.x - player.touchOffsetX
        player.y = event.y - player.touchOffsetY
    elseif ("ended" == phase or "cancelled" == phase) then
        display.currentStage:setFocus (nil)
    end
    return true
end

player:addEventListener ("touch", moverPlayer)

local function criartrash ()
    local trash = display.newImageRect (mainGroup,"imagens/bag2.png", 210*0.25, 250*0.25)
    table.insert (trashTable, trash)
    physics.addBody (trash, "dynamic", {radius=20, bounce=0.8})
    trash.myName = "Trash"

    trash.x = -60
    trash.y = math.random (500)
    trash:setLinearVelocity (math.random(40,50), math.random(20,30))
end

local function criarfood ()
    local food = display.newImageRect (mainGroup,"imagens/jellyfish2.png", 512*0.15, 487*0.15)
    table.insert (foodTable, food)
    physics.addBody (food, "dynamic", {radius=20, bounce=0.8})
    food.myName = "Food"

    food.x = display.contentWidth + 60
    food.y = math.random (500)
    food:setLinearVelocity (math.random(-40,-25), math.random(20,25))
end

local function gameLoop ()
    criartrash ()

    for i = #trashTable, 1, -1 do 
        local thistrash = trashTable [1]

        if (thistrash.x < -100 or thistrash.x > display.contentWidth + 100 or thistrash.y < -100 or thistrash.y > display.contentHeight + 100) then
            display.remove (thistrash)
            table.remove (trashTable, i)
        end
    end 

    criarfood ()

    for i = #foodTable, 1, -1 do 
        local thisfood = foodTable [1]

        if (thisfood.x < -100 or thisfood.x > display.contentWidth + 100 or thisfood.y < -100 or thisfood.y > display.contentHeight + 100) then
            display.remove (thisfood)
            table.remove (foodTable, i)
        end
    end 
end

gameLoopTimer = timer.performWithDelay (2000, gameLoop, 0)


local function onCollision (event)

    if (event.phase == "began" ) then

        local obj1 = event.object1
        local obj2 = event.object2

        if ((obj1.myName == "Trashcan" and obj2.myName == "Food") or (obj1.myName == "Food" and obj2.myName == "Trashcan"))
        then

            display.remove (obj2)

            for i = #foodTable, 1, -1 do
                if (foodTable[i] == obj1 or foodTable[i] == obj2) then
                    table.remove (foodTable, i)
                    break
                end 
            end 

            vidas = vidas -1
            vidasText.text = "Vidas: " .. vidas
            if (vidas == 0) then
                display.remove (player)
            end

        elseif ((obj1.myName == "Trashcan" and obj2.myName == "Trash") or (obj1.myName == "Trash" and obj2.myName == "Trashcan"))
        then

            display.remove (obj2)

            for i = #trashTable, 1, -1 do
                if (trashTable[i] == obj1 or trashTable[i] == obj2) then
                    table.remove (trashTable, i)
                    break
                end
            end 

            pontos = pontos +10
            pontosText.text = "Pontos: " .. pontos
        end
    end
end

Runtime:addEventListener ("collision", onCollision)
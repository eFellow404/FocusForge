local grid = {} --for 8x8 grid
local currentscreen = "home" --to keep track of what page the user is on


function love.update(dt)
    -- Update game logic here
end

function love.load()

    love.window.setTitle("FocusForge")

    local screenWidth, screenHeight = love.window.getDesktopDimensions()

    -- Enable resize window
    love.window.setMode(screenWidth, screenHeight, {resizable = true, minwidth = 400, minheight = 300})

    -- Load logo
    logo = love.graphics.newImage("img/logo.png")

    -- Load font (size 100)
    font = love.graphics.newFont(100)
end

function love.draw()
    -- Set background color to dark grey
    love.graphics.clear(0.2, 0.2, 0.2, 1.0) -- RGBA values

    -- Box dimensions
    local boxWidth = 600
    local boxHeight = 100

    -- Box position (centered horizontally)
    local titlex = (love.graphics.getWidth() - boxWidth) / 2
    local titley = 10

    -- Draw title box (purple)
    love.graphics.setColor(0.5, 0, 1) -- Set color to purple
    love.graphics.rectangle("fill", titlex, titley, boxWidth, boxHeight)

    -- Draw text inside the box
    love.graphics.setColor(1, 1, 1) -- Set color to white (for text)
    local titletext = "Tools"

    -- Get text dimensions
    local textWidth = font:getWidth(titletext)
    local textHeight = font:getHeight()

    -- Set the font for the text
    love.graphics.setFont(font)

    -- Draw text centered horizontally and vertically inside the box
    love.graphics.print(titletext, titlex + (boxWidth - textWidth) / 2, titley + (boxHeight - textHeight) / 2)

    -- Define scaling for the logo
    local logoscaleX = 0.1
    local logoscaleY = 0.1

    -- Draw the logo at the top right (scaled)
    love.graphics.draw(logo, 10, 10, 0, logoscaleX, logoscaleY)
end

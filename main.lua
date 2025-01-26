function main()

    -- Define the grid variable and other necessary variables at the top level
    local grid = {}
    local startx, starty, boxWidth, boxHeight
    local screenWidth, screenHeight = love.graphics.getDimensions()
    local smallfont

    function love.load()
        love.window.setTitle("FocusForge")

        -- Enable resize window
        love.window.setMode(screenWidth, screenHeight, {resizable = true, minwidth = 1200, minheight = 800})

        -- Load logo
        logo = love.graphics.newImage("img/logo.png")

        -- Load font (size 100)
        font = love.graphics.newFont(100)

        -- Initialize small font based on screen width
        smallfont = love.graphics.newFont(screenWidth / 70)

        -- Define size of each box in the grid
        boxWidth = (screenWidth - 300) / 16
        boxHeight = boxWidth / 2 -- Make each box half as tall as it is wide
        startx = (screenWidth - 8 * boxWidth) / 2
        starty = (screenHeight - 8 * boxHeight) / 2

        -- Create 8x8 grid with specific text for the first two boxes
        for i = 1, 8 do
            grid[i] = {}
            for j = 1, 8 do
                local text = ""
                if i == 1 and j == 1 then
                    text = "hex to rgba" -- First box
                elseif i == 1 and j == 2 then
                    text = "inch to cm" -- Second box
                else
                    text = "Box " .. ((i - 1) * 8 + j) -- Default text for other boxes
                end

                grid[i][j] = {
                    x = startx + (j - 1) * boxWidth,
                    y = starty + (i - 1) * boxHeight,
                    width = boxWidth,
                    height = boxHeight,
                    text = text
                }
            end
        end
    end

    function love.update(dt)
        local screenWidth, screenHeight = love.graphics.getDimensions()

        -- Update small font based on screen width
        smallfont = love.graphics.newFont(screenWidth / 70)

            if screenWidth ~= nil and screenHeight ~= nil then
                boxWidth = ((math.min(screenWidth, screenHeight) * 3) - 300) / 16
                boxHeight = boxWidth / 2 -- Make each box half as tall as it is wide
                startx = (screenWidth - 8 * boxWidth) / 2
                starty = ((screenHeight - 8 * boxHeight) + 50) / 2

                -- Create 8x8 grid
                for i = 1, 8 do
                    grid[i] = {}
                    for j = 1, 8 do
                        local text = ""
                        if i == 1 and j == 1 then
                            text = "hex to rgba" -- First box
                        elseif i == 1 and j == 2 then
                            text = "inch to cm" -- Second box
                        else
                            text = "Box " .. ((i - 1) * 8 + j) -- Default text for other boxes
                        end

                        grid[i][j] = {
                            x = startx + (j - 1) * boxWidth,
                            y = starty + (i - 1) * boxHeight,
                            width = boxWidth,
                            height = boxHeight,
                            text = text
                        }
                    end
                end
            end
    end

    function love.mousepressed(x, y, button, istouch, presses)
        -- Check if the mouse was clicked
        if button == 1 then
            -- Check if the mouse was clicked inside the grid
            for i = 1, 8 do
                for j = 1, 8 do
                    if grid[i] and grid[i][j] and x >= grid[i][j].x and x <= grid[i][j].x + grid[i][j].width and y >= grid[i][j].y and y <= grid[i][j].y + grid[i][j].height then
                        GridSelected = {i, j}
                        print(GridSelected[1], GridSelected[2])

                        if GridSelected[1] == 1 and GridSelected[2] == 1 then
                            hexToRGBA()
                            return

                        elseif GridSelected[1] == 1 and GridSelected[2] == 2 then
                            print("You clicked on the second cell: inch to cm")
                        end
                    end
                end
            end
        end
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
        round_rectangle("fill", titlex, titley, boxWidth, boxHeight)

        -- Draw text inside the box
        love.graphics.setColor(1, 1, 1) -- Set color to white (for text)
        local titletext = "Tools"

        -- Ensure font is loaded before getting text dimensions
        if font then
            -- Get text dimensions
            local textWidth = font:getWidth(titletext)
            local textHeight = font:getHeight()

            -- Set the font for the text
            love.graphics.setFont(font)

            -- Draw text centered horizontally and vertically inside the box
            love.graphics.print(titletext, titlex + (boxWidth - textWidth) / 2, titley + (boxHeight - textHeight) / 2)
        else
            print("Font not loaded")
        end

        -- Ensure logo is loaded before drawing
        if logo then
            -- Define scaling for the logo
            local logoscaleX = 0.1
            local logoscaleY = 0.1

            -- Draw the logo at the top right (scaled)
            love.graphics.draw(logo, 10, 10, 0, logoscaleX, logoscaleY)
        else
            print("Logo not loaded")
        end

        -- Draw the grid with text
        love.graphics.setColor(1, 1, 1) -- White color for text
        for i = 1, 8 do
            for j = 1, 8 do
                local cell = grid[i][j]

                -- Draw the rectangle outline
                love.graphics.rectangle("line", cell.x, cell.y, cell.width, cell.height)

                -- Draw the text in the center of the cell
                local textWidth = smallfont:getWidth(cell.text)
                local textHeight = smallfont:getHeight()
                love.graphics.setFont(smallfont)
                love.graphics.print(cell.text, cell.x + (cell.width - textWidth) / 2, cell.y + (cell.height - textHeight) / 2)
            end
        end
    end

    -- Define the round_rectangle function
    function round_rectangle(mode, x, y, width, height, radius)
        radius = radius or 10
        love.graphics.rectangle(mode, x + radius, y, width - (radius * 2), height)
        love.graphics.rectangle(mode, x, y + radius, width, height - (radius * 2))
        love.graphics.arc(mode, x + radius, y + radius, radius, math.rad(-180), math.rad(-90))
        love.graphics.arc(mode, x + width - radius, y + radius, radius, math.rad(-90), math.rad(0))
        love.graphics.arc(mode, x + radius, y + height - radius, radius, math.rad(-180), math.rad(-270))
        love.graphics.arc(mode, x + width - radius, y + height - radius, radius, math.rad(0), math.rad(90))
    end
end

main()

function hexToRGBA()

    local screenWidth, screenHeight = love.graphics.getDimensions()

    function love.load()
        
        -- Enable resize window
        love.window.setMode(screenWidth, screenHeight, {resizable = true, minwidth = 1200, minheight = 800})

        -- Load logo
        logo = love.graphics.newImage("img/logo.png")

    end

    function love.draw()
        
        --set background to dark grey
        love.graphics.clear(0.2, 0.2, 0.2, 1.0)

        -- Ensure logo is loaded before drawing
        if logo then
            -- Define scaling for the logo
            local logoscaleX = 0.1
            local logoscaleY = 0.1

            -- Draw the logo at the top right (scaled)
            love.graphics.draw(logo, 10, 10, 0, logoscaleX, logoscaleY)
        else
            print("Logo not loaded")
        end
    end
end
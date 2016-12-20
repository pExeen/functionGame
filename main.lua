local utf8 = require("utf8")
function love.load()
  love.keyboard.setKeyRepeat(true)
  variables = {0, 0, 4, 0}
  love.graphics.setNewFont(40)
  love.mouse.setVisible(false)
  timeMax = 1
  time = timeMax + 1
  x = 0
  screenW, screenH = love.graphics.getDimensions()
  screenWMid, screenHMid = screenW/2, screenH/2
  pointerSize = 10
  inputedNumber = 1
end

function love.textinput(t)
  variables [inputedNumber] = variables [inputedNumber]..t
end

function love.draw()

  love.graphics.line(screenWMid, 0, screenWMid, screenH)
  love.graphics.line(0, screenHMid, screenW, screenHMid)
  love.graphics.print("x : "..x, 0, screenH-120)
  love.graphics.print("y : "..f(x), 0, screenH-80)
  love.graphics.print("y = "..variables[1].." x³ + "..variables[2].." x² + "..variables[3].." x + "..variables[4], 0, screenH-160)
  screenX, screenY = mapToScreen(x, y)
  love.graphics.rectangle('fill', screenX-pointerSize/2, screenY-pointerSize/2, pointerSize, pointerSize)

  for fX=-screenWMid,screenWMid do
    fY = f(fX)
    love.graphics.points(mapToScreen(fX, fY))
  end
end

function mapToScreen (mX, mY)
  return (mX + screenWMid), (-mY + screenHMid)
end

function love.update(dt)
  time = time + dt
  if time > timeMax then
    love.graphics.setColor(love.math.random(255), love.math.random(255), love.math.random(255))
    time = 0
  end
  mouseX, mouseY = love.mouse.getPosition()
  x = mouseX - screenWMid
  y = f(x)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()
  end
    if key == "backspace" and string.len(variables[inputedNumber]) > 1 then
        local byteoffset = utf8.offset(variables[inputedNumber], -1)

        if byteoffset then
            variables[inputedNumber] = string.sub(variables[inputedNumber], 1, byteoffset - 1)
        end
    end
    if key == 'right' and inputedNumber < 4 then
        inputedNumber = inputedNumber + 1
    end
    if key == 'left' and inputedNumber > 1 then
        inputedNumber = inputedNumber - 1
    end
end

function f(x)
  y = variables[1] * x*x*x + variables[2]*x*x + variables[3]*x + variables[4]
  return y
end

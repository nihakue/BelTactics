--fighter.lua

require 'class'

Fighter = class(
    function(f,
        name,
        pic,
        grid_x,
        grid_y,
        act_x,
        act_y,
        speed,
        color
    )
    f.name = name
    f.pic = pic
    f.grid_x = grid_x
    f.grid_y = grid_y
    f.act_x = act_x
    f.act_y = act_y
    f.speed = speed
    f.color = color
  end)

function Fighter:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.act_x, self.act_y, 32, 32)
end

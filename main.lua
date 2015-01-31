
-- TODO: switch to grid
-- TODO: register player colision
-- TODO: grid objects? 
-- TODO: engineering
-- TODO: player statuses/injuries

function love.load()
  bg = love.graphics.newImage("bg.png")
  love.graphics.setNewFont(12)
  love.graphics.setBackgroundColor(255,255,255)
  
  players = {
    player1 = {
      grid_x = 0,
      grid_y = 0,
      act_x = 200,
      act_y = 200,
      speed = 10,
      color = {50,150,50}
    },
    player2 = {
      grid_x = 30,
      grid_y = 22,
      act_x = 200,
      act_y = 200,
      speed = 10,     
      color = {150,50,50}
    }
  }

  activeplayer = players.player1

end

function love.update(dt)
  for idx, player in pairs(players) do
    player.act_y = player.act_y - ((player.act_y - player.grid_y * 32) * player.speed * dt)
    player.act_x = player.act_x - ((player.act_x - player.grid_x * 32) * player.speed * dt)
  end
end

function love.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(bg, imgx, imgy)

  for idx, player in pairs(players) do
    love.graphics.setColor(player.color)
    love.graphics.rectangle("fill", player.act_x, player.act_y, 32, 32)
  end
end 

function love.keypressed(key)
  if key == ' ' then
    if activeplayer == players.player1 then
      activeplayer = players.player2
    else
      activeplayer = players.player1
    end
  elseif key == "up" then
    activeplayer.grid_y = activeplayer.grid_y - 1
  elseif key == "down" then
    activeplayer.grid_y = activeplayer.grid_y + 1
  elseif key == "left" then
    activeplayer.grid_x = activeplayer.grid_x - 1
  elseif key == "right" then
    activeplayer.grid_x = activeplayer.grid_x + 1
  end

  print("ap:("..activeplayer.grid_x..","..activeplayer.grid_y..")")
end
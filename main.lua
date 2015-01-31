-- TODO: engineering
-- TODO: player statuses/injuries

function love.load()
  bg = love.graphics.newImage("bg.png")
  sybg = love.graphics.newImage("syb.jpg")
  shyg = love.graphics.newImage("shy.jpg")

  love.graphics.setNewFont(12)
  love.graphics.setBackgroundColor(255,255,255)
  
  leftFighter = {
    Ppx = 200,
    px = 200,
    py = 200
  }

  rightFighter = {
    px = 600,
    py = 200
  }

  players = {
    player1 = {
      name = "syb",
      pic = sybg,
      grid_x = 16,
      grid_y = 12,
      act_x = 200,
      act_y = 200,
      speed = 10,
      color = {50,150,50}
    },
    player2 = {
      name = "shy",
      pic = shyg,
      grid_x = 18,
      grid_y = 12,
      act_x = 200,
      act_y = 200,
      speed = 20,     
      color = {150,50,50}
    }
  }

  state = "map"
  activeplayer = players.player1

end

function doFight(player1 , player2)
  print("FIGHT: "..player1.name.." --> "..player2.name)
  state = "fight"
  leftFighter.g = player1.pic
  rightFighter.g = player2.pic
end

function testFight(x,y)
  for idx, player in pairs(players) do
    if player.grid_x == activeplayer.grid_x + x and player.grid_y == activeplayer.grid_y + y then
      doFight(activeplayer, player)
      return true
    end
  end
  return false  
end


function love.update(dt)
  leftFighter.px = leftFighter.px - ((leftFighter.px - leftFighter.Ppx) * activeplayer.speed  * dt)

  for idx, player in pairs(players) do
    player.act_y = player.act_y - ((player.act_y - player.grid_y * 32) * player.speed * dt)
    player.act_x = player.act_x - ((player.act_x - player.grid_x * 32) * player.speed * dt)
  end
end

function love.draw()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(bg, imgx, imgy)

  if state == "fight" then
    love.graphics.draw(leftFighter.g , leftFighter.px, leftFighter.py)
    love.graphics.draw(rightFighter.g, rightFighter.px, rightFighter.py)
  end
  
  if state == "map" then
    for idx, player in pairs(players) do
      love.graphics.setColor(player.color)
      love.graphics.rectangle("fill", player.act_x, player.act_y, 32, 32)
    end
  end
  love.graphics.setColor(150,150,255)
  love.graphics.rectangle("fill", 0, 0, 150, 32)
  love.graphics.setColor(activeplayer.color)
  love.graphics.print(activeplayer.name.."'s turn" , 0, 0, 0 , 2)

end 

function love.keypressed(key)
  if state == "fight" then
    if key == ' ' then
      leftFighter.px = 250
    else
      state ="map"
    end
    return
  end
  
  if state == 'map' then
    if key == ' ' then
      if activeplayer == players.player1 then
        activeplayer = players.player2
      else
        activeplayer = players.player1
      end
    elseif key == "up" then
      if not testFight(0 ,-1) then
        activeplayer.grid_y = activeplayer.grid_y - 1
      end
    elseif key == "down" then
      if not testFight(0 ,1) then
        activeplayer.grid_y = activeplayer.grid_y + 1
      end
    elseif key == "left" then
      if not testFight(-1 ,0) then
        activeplayer.grid_x = activeplayer.grid_x - 1
      end
    elseif key == "right" then
      if not testFight(1 ,0) then
        activeplayer.grid_x = activeplayer.grid_x + 1
      end
    end
    return
  end
end
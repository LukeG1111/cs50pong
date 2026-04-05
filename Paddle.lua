Paddle = Class{}

function Paddle:init(x, y, up_key, down_key)
    self.x = x
    self.y = y
    self.width = 5
    self.height = 20

    self.up = up_key
    self.down = down_key
end

function Paddle:update(speed, dt)
    if love.keyboard.isDown(self.up) then
        -- player_one_y = player_one_y + -PADDLE_SPEED * dt
        self.y = math.max(0, self.y + -speed * dt)
    elseif love.keyboard.isDown(self.down) then
        -- player_one_y = player_one_y + PADDLE_SPEED * dt
        self.y = math.min(VIRTUAL_HEIGHT - self.height, self.y + speed * dt)
    end
end

function Paddle:render()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
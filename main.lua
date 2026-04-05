WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

PADDLE_SPEED = 200

push = require 'push/push'
Class = require 'hump/class'

require 'Ball'
require 'Paddle'

function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')

    math.randomseed(os.time())

    debreosee = love.graphics.newFont('Debrosee-ALPnL.ttf', 32)
    debreosee_sm = love.graphics.newFont('Debrosee-ALPnL.ttf', 8)
    monas = love.graphics.newFont('Monas-BLBW8.ttf', 32)

    player_one_score = 0
    player_two_score = 0

    -- player_one_y = 10
    player_one = Paddle(10,10, 'w', 's')
    -- player_two_y = VIRTUAL_HEIGHT - 30
    player_two = Paddle(VIRTUAL_WIDTH - 15, VIRTUAL_HEIGHT - 30, 'up', 'down')

    -- ball_dx = math.random(2) == 1 and 100 or -100
    -- ball_dy = math.random(-50, 50)

    -- ball_x = VIRTUAL_WIDTH / 2 - 2
    -- ball_y = VIRTUAL_HEIGHT / 2 - 2

    ball = Ball(VIRTUAL_WIDTH / 2 - 2, VIRTUAL_HEIGHT / 2 - 2, 4, 4)

    game_state = 'start'

    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {resizable = false, vsync = true, fullscreen = false})
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT,  { upscale = "normal" })

end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if game_state == 'start' then
            game_state = 'play'
        else
            game_state = 'start'

            -- ball_x = VIRTUAL_WIDTH / 2 - 2
            -- ball_y = VIRTUAL_HEIGHT / 2 - 2

            -- ball_dx = math.random(2) == 1 and 100 or -100
            -- ball_dy = math.random(-50, 50) * 1.5
            ball:reset()
        end
    end
end

function love.update(dt)
    -- if love.keyboard.isDown('w') then
    --     -- player_one_y = player_one_y + -PADDLE_SPEED * dt
    --     player_one_y = math.max(0, player_one_y + -PADDLE_SPEED * dt)
    -- elseif love.keyboard.isDown('s') then
    --     -- player_one_y = player_one_y + PADDLE_SPEED * dt
    --     player_one_y = math.min(VIRTUAL_HEIGHT - 20, player_one_y + PADDLE_SPEED * dt)
    -- end
    player_one:update(PADDLE_SPEED, dt)
    -- if love.keyboard.isDown('up') then
    --     -- player_two_y = player_two_y + -PADDLE_SPEED * dt
    --     player_two_y = math.max(0, player_two_y + -PADDLE_SPEED * dt)
    -- elseif love.keyboard.isDown('down') then
    --     -- player_two_y = player_two_y + PADDLE_SPEED * dt
    --     player_two_y = math.min(VIRTUAL_HEIGHT - 20, player_two_y + PADDLE_SPEED * dt)
    -- end
    player_two:update(PADDLE_SPEED, dt)
    if game_state == 'play' then
        -- ball_x = ball_x + ball_dx * dt
        -- ball_y = ball_y + ball_dy * dt
        ball:update(dt)
    end
end

function love.draw()
    push:start()
    love.graphics.clear(40/255, 45/255, 52/255, 1)
    love.graphics.setFont(debreosee_sm)
    love.graphics.printf("Hello Pong", 0, VIRTUAL_HEIGHT / 2 - 120, VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(monas)
    love.graphics.print("0", VIRTUAL_WIDTH / 2 - 50, VIRTUAL_HEIGHT / 2 - 110)
    love.graphics.print(tostring(player_two_score), VIRTUAL_WIDTH / 2 + 30, VIRTUAL_HEIGHT / 2 - 110)

    -- paddle 1
    -- love.graphics.rectangle('fill', 10, player_one_y, 5, 20)
    player_one:render()
    -- paddle 2
    -- love.graphics.rectangle('fill', VIRTUAL_WIDTH - 15, player_two_y, 5, 20)
    player_two:render()

    -- love.graphics.rectangle('fill', ball_x, ball_y, 4, 4)
    ball:render()
    push:finish()
end
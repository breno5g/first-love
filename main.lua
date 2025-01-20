-- Constants
local CELL_SIZE = 10
local GRID_X_COUNT = 500
local GRID_Y_COUNT = 500
local WINDOW_WIDTH = 1000
local WINDOW_HEIGHT = 1000
local GRID_OFFSET_X = (WINDOW_WIDTH - (GRID_X_COUNT * CELL_SIZE)) / 2
local GRID_OFFSET_Y = (WINDOW_HEIGHT - (GRID_Y_COUNT * CELL_SIZE)) / 2

-- Colors
local COLORS = {
	background = { 1, 1, 1 },
	cell_dead = { 0.86, 0.86, 0.86 },
	cell_alive = { 1, 0, 1 },
	cell_selected = { 0, 1, 1 },
	brush_preview = { 0, 0.8, 0.8, 0.3 },
	text = { 0, 0, 0 },
}

-- Game state
local grid = {}
local nextGrid = {}
local selectedX = 0
local selectedY = 0
local isPaused = true
local simulationSpeed = 0.1
local timer = 0
local brushSize = 1
local maxBrushSize = 20

local function initializeGrids()
	for y = 1, GRID_Y_COUNT do
		grid[y] = {}
		nextGrid[y] = {}
		for x = 1, GRID_X_COUNT do
			grid[y][x] = false
			nextGrid[y][x] = false
		end
	end
end

local function drawWithBrush(centerX, centerY, state)
	local radius = math.floor(brushSize / 2)
	for dy = -radius, radius do
		for dx = -radius, radius do
			local x, y = centerX + dx, centerY + dy
			if x >= 1 and x <= GRID_X_COUNT and y >= 1 and y <= GRID_Y_COUNT then
				if dx * dx + dy * dy <= radius * radius then
					grid[y][x] = state
				end
			end
		end
	end
end

local function countNeighbors(x, y)
	local count = 0
	for dy = -1, 1 do
		for dx = -1, 1 do
			if not (dy == 0 and dx == 0) then
				local ny, nx = y + dy, x + dx
				if nx < 1 then
					nx = GRID_X_COUNT
				elseif nx > GRID_X_COUNT then
					nx = 1
				end
				if ny < 1 then
					ny = GRID_Y_COUNT
				elseif ny > GRID_Y_COUNT then
					ny = 1
				end

				if grid[ny][nx] then
					count = count + 1
				end
			end
		end
	end
	return count
end

local function updateSimulation()
	for y = 1, GRID_Y_COUNT do
		for x = 1, GRID_X_COUNT do
			local neighborCount = countNeighbors(x, y)
			nextGrid[y][x] = neighborCount == 3 or (grid[y][x] and neighborCount == 2)
		end
	end
	grid, nextGrid = nextGrid, grid
end

local function windowToGridCoords(windowX, windowY)
	local gridX = math.floor((windowX - GRID_OFFSET_X) / CELL_SIZE) + 1
	local gridY = math.floor((windowY - GRID_OFFSET_Y) / CELL_SIZE) + 1
	return gridX, gridY
end

local function isInGrid(x, y)
	return x >= 1 and x <= GRID_X_COUNT and y >= 1 and y <= GRID_Y_COUNT
end

local function drawCell(x, y, color)
	love.graphics.setColor(color)
	love.graphics.rectangle(
		"fill",
		GRID_OFFSET_X + (x - 1) * CELL_SIZE,
		GRID_OFFSET_Y + (y - 1) * CELL_SIZE,
		CELL_SIZE - 1,
		CELL_SIZE - 1
	)
end

local function drawBrushPreview()
	if isInGrid(selectedX, selectedY) then
		love.graphics.setColor(COLORS.brush_preview)
		local radius = (brushSize * CELL_SIZE) / 2
		love.graphics.circle(
			"fill",
			GRID_OFFSET_X + (selectedX - 0.5) * CELL_SIZE,
			GRID_OFFSET_Y + (selectedY - 0.5) * CELL_SIZE,
			radius
		)
	end
end

local function drawGrid()
	for y = 1, GRID_Y_COUNT do
		for x = 1, GRID_X_COUNT do
			if grid[y][x] then
				drawCell(x, y, COLORS.cell_alive)
			else
				drawCell(x, y, COLORS.cell_dead)
			end
		end
	end
	drawBrushPreview()
end

local function drawUI()
	love.graphics.setColor(COLORS.text)
	local status = isPaused and "PAUSED" or "RUNNING"
	love.graphics.print(
		string.format(
			"X: %d, Y: %d | %s | Speed: %.1f | Brush: %d\nSpace: Play/Pause | R: Reset | +/-: Speed | [/]: Brush Size",
			selectedX,
			selectedY,
			status,
			1 / simulationSpeed,
			brushSize
		),
		10,
		10
	)
end

function love.load()
	love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT)
	love.graphics.setBackgroundColor(COLORS.background)
	love.keyboard.setKeyRepeat(true)
	initializeGrids()
end

function love.keypressed(key)
	if key == "escape" then
		love.event.quit()
	elseif key == "space" then
		isPaused = not isPaused
	elseif key == "r" then
		initializeGrids()
	elseif key == "=" or key == "+" then
		simulationSpeed = math.max(simulationSpeed * 0.8, 0.01)
	elseif key == "-" then
		simulationSpeed = math.min(simulationSpeed * 1.2, 1)
	elseif key == "]" then
		brushSize = math.min(brushSize + 1, maxBrushSize)
	elseif key == "[" then
		brushSize = math.max(brushSize - 1, 1)
	end
end

function love.wheelmoved(x, y)
	if love.keyboard.isDown("lshift", "rshift") then
		if y > 0 then
			brushSize = math.min(brushSize + 1, maxBrushSize)
		else
			brushSize = math.max(brushSize - 1, 1)
		end
	end
end

function love.update(dt)
	local mouseX, mouseY = love.mouse.getPosition()
	selectedX, selectedY = windowToGridCoords(mouseX, mouseY)

	if love.mouse.isDown(1) or love.mouse.isDown(2) then
		if isInGrid(selectedX, selectedY) then
			drawWithBrush(selectedX, selectedY, love.mouse.isDown(1))
		end
	end

	if not isPaused then
		timer = timer + dt
		if timer >= simulationSpeed then
			timer = 0
			updateSimulation()
		end
	end
end

function love.draw()
	drawGrid()
	drawUI()
end


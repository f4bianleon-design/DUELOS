-- BORRAR GUI ANTERIOR
if game.CoreGui:FindFirstChild("TPMenu") then
	game.CoreGui.TPMenu:Destroy()
end

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

-- PUNTOS FIJOS
local puntos = {
	Vector3.new(-286, 22, 2919),
	Vector3.new(-277, 22, 2921),
	Vector3.new(-498, 19, 2452)
}

local activo = false

-- GUI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "TPMenu"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 260, 0, 170)
frame.Position = UDim2.new(0.1, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true

-- TITULO
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "Coin Farm Blox Donation"
title.TextColor3 = Color3.fromRGB(0,255,150)
title.TextScaled = true

-- BOTON TP
local btn = Instance.new("TextButton", frame)
btn.Size = UDim2.new(0.8, 0, 0, 40)
btn.Position = UDim2.new(0.1, 0, 0.4, 0)
btn.Text = "OFF"
btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
btn.TextColor3 = Color3.fromRGB(255,255,255)
btn.TextScaled = true

-- BOTON SERVER HOP
local hopBtn = Instance.new("TextButton", frame)
hopBtn.Size = UDim2.new(0.8, 0, 0, 30)
hopBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
hopBtn.Text = "SERVER HOP"
hopBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
hopBtn.TextColor3 = Color3.fromRGB(255,255,255)
hopBtn.TextScaled = true

-- TOGGLE TP
btn.MouseButton1Click:Connect(function()
	activo = not activo
	
	if activo then
		btn.Text = "ON"
		btn.BackgroundColor3 = Color3.fromRGB(0,170,0)
	else
		btn.Text = "OFF"
		btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
	end
end)

-- SERVER HOP FUNCION
hopBtn.MouseButton1Click:Connect(function()
	local placeId = game.PlaceId
	local JobId = game.JobId
	
	local servers = {}
	local cursor = ""
	
	local function getServers()
		local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"
		if cursor ~= "" then
			url = url .. "&cursor=" .. cursor
		end
		
		local success, response = pcall(function()
			return HttpService:GetAsync(url)
		end)
		
		if success then
			local data = HttpService:JSONDecode(response)
			
			for _, server in pairs(data.data) do
				if server.playing < server.maxPlayers and server.id ~= JobId then
					table.insert(servers, server.id)
				end
			end
			
			cursor = data.nextPageCursor or ""
		end
	end
	
	-- INTENTAR VARIAS PAGINAS
	for i = 1,3 do
		getServers()
		if #servers > 0 then break end
	end
	
	if #servers > 0 then
		local randomServer = servers[math.random(1, #servers)]
		TeleportService:TeleportToPlaceInstance(placeId, randomServer, player)
	else
		warn("No se encontraron servidores")
	end
end)

-- LOOP TP RAPIDO
spawn(function()
	while true do
		task.wait(0.5)
		if activo then
			for i = 1, #puntos do
				if not activo then break end
				
				if char and char:FindFirstChild("HumanoidRootPart") then
					char.HumanoidRootPart.CFrame = CFrame.new(puntos[i])
					char.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0,0,0)
					char.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0,0,0)
				end
				
				task.wait(0.5)
			end
		end
	end
end)

-- LEON SCRIPT FINAL

local player = game.Players.LocalPlayer
local remote = game:GetService("ReplicatedStorage"):WaitForChild("StPatricks2026"):WaitForChild("RemoteEvent")
local VirtualUser = game:GetService("VirtualUser")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

local activo = false
local antiAFK = false
local savedTP = nil
local tiempo = 0

if player.PlayerGui:FindFirstChild("LeonGUI") then
	player.PlayerGui.LeonGUI:Destroy()
end

--------------------------------------------------
-- GUI
--------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "LeonGUI"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

--------------------------------------------------
-- BLUR
--------------------------------------------------

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

--------------------------------------------------
-- BOTON TOGGLE
--------------------------------------------------

local toggleMenu = Instance.new("ImageButton")
toggleMenu.Parent = gui
toggleMenu.Size = UDim2.new(0,65,0,65)
toggleMenu.Position = UDim2.new(0,20,0,200)
toggleMenu.Image = "rbxassetid://13608413586"
toggleMenu.BackgroundColor3 = Color3.fromRGB(20,20,20)
toggleMenu.Active = true
toggleMenu.Draggable = true

Instance.new("UICorner",toggleMenu).CornerRadius = UDim.new(1,0)

local strokeBtn = Instance.new("UIStroke",toggleMenu)
strokeBtn.Color = Color3.fromRGB(170,0,255)
strokeBtn.Thickness = 3

local label = Instance.new("TextLabel")
label.Parent = toggleMenu
label.Size = UDim2.new(1,0,1,0)
label.BackgroundTransparency = 1
label.Text = "AL"
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.TextColor3 = Color3.fromRGB(170,0,255)

--------------------------------------------------
-- MENU
--------------------------------------------------

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0,330,0,360)
frame.Position = UDim2.new(0.4,0,0.4,0)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Visible = false
frame.Active = true
frame.Draggable = true

Instance.new("UICorner",frame)

local stroke = Instance.new("UIStroke",frame)
stroke.Color = Color3.fromRGB(170,0,255)
stroke.Thickness = 2

--------------------------------------------------
-- ANIMACION NEON
--------------------------------------------------

task.spawn(function()

	while true do
		TweenService:Create(
			stroke,
			TweenInfo.new(1),
			{Thickness = 4}
		):Play()

		task.wait(1)

		TweenService:Create(
			stroke,
			TweenInfo.new(1),
			{Thickness = 2}
		):Play()

		task.wait(1)
	end

end)

--------------------------------------------------
-- TITULO
--------------------------------------------------

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,45)
title.Text = "LEON SCRIPT"
title.BackgroundColor3 = Color3.fromRGB(20,20,20)
title.TextColor3 = Color3.fromRGB(170,0,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local titleStroke = Instance.new("UIStroke",title)
titleStroke.Color = Color3.fromRGB(60,0,100)
titleStroke.Thickness = 1

--------------------------------------------------
-- AUTOR
--------------------------------------------------

local author = Instance.new("TextLabel")
author.Parent = frame
author.Size = UDim2.new(1,0,0,20)
author.Position = UDim2.new(0,0,0.13,0)
author.Text = "by: alejandro_lxl"
author.BackgroundTransparency = 1
author.TextColor3 = Color3.fromRGB(170,0,255)
author.TextScaled = true

--------------------------------------------------
-- CONTADOR
--------------------------------------------------

local contador = Instance.new("TextLabel")
contador.Parent = frame
contador.Size = UDim2.new(1,0,0,25)
contador.Position = UDim2.new(0,0,0.22,0)
contador.Text = "Tiempo activo: 00:00:00"
contador.BackgroundTransparency = 1
contador.TextColor3 = Color3.new(1,1,1)

--------------------------------------------------
-- COORDS
--------------------------------------------------

local coords = Instance.new("TextLabel")
coords.Parent = frame
coords.Size = UDim2.new(1,0,0,25)
coords.Position = UDim2.new(0,0,0.30,0)
coords.Text = "TP: no seteado"
coords.BackgroundTransparency = 1
coords.TextColor3 = Color3.fromRGB(200,200,200)

--------------------------------------------------
-- FUNCION BOTONES
--------------------------------------------------

local function boton(texto,pos)

	local b = Instance.new("TextButton")
	b.Parent = frame
	b.Size = UDim2.new(0.75,0,0,40)
	b.Position = UDim2.new(0.125,0,pos,0)
	b.Text = texto
	b.BackgroundColor3 = Color3.fromRGB(30,0,45)
	b.TextColor3 = Color3.new(1,1,1)
	b.TextScaled = true
	b.Font = Enum.Font.GothamBold

	Instance.new("UICorner",b)

	local stroke = Instance.new("UIStroke",b)
	stroke.Color = Color3.fromRGB(170,0,255)
	stroke.Thickness = 2

	return b

end

--------------------------------------------------
-- BOTONES
--------------------------------------------------

local set = boton("SET TP",0.45)
local clear = boton("CLEAR TP",0.60)
local toggle = boton("SCRIPT OFF",0.75)
local afkBtn = boton("ANTI AFK OFF",0.90)

--------------------------------------------------
-- ABRIR MENU
--------------------------------------------------

toggleMenu.MouseButton1Click:Connect(function()

	if frame.Visible then
		frame.Visible = false
		blur.Size = 0
	else
		frame.Visible = true
		frame.Size = UDim2.new(0,0,0,0)
		blur.Size = 18

		TweenService:Create(
			frame,
			TweenInfo.new(0.25),
			{Size = UDim2.new(0,330,0,360)}
		):Play()
	end

end)

--------------------------------------------------
-- SET TP
--------------------------------------------------

set.MouseButton1Click:Connect(function()

	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")

	savedTP = hrp.CFrame
	local pos = hrp.Position

	coords.Text =
	"TP: "..math.floor(pos.X).." "..math.floor(pos.Y).." "..math.floor(pos.Z)

end)

--------------------------------------------------
-- CLEAR TP
--------------------------------------------------

clear.MouseButton1Click:Connect(function()

	savedTP = nil
	coords.Text = "TP: desactivado"

end)

--------------------------------------------------
-- SCRIPT ON OFF
--------------------------------------------------

toggle.MouseButton1Click:Connect(function()

	activo = not activo

	if activo then
		toggle.Text = "SCRIPT ON"
	else
		toggle.Text = "SCRIPT OFF"
	end

end)

--------------------------------------------------
-- ANTI AFK
--------------------------------------------------

afkBtn.MouseButton1Click:Connect(function()

	antiAFK = not antiAFK

	if antiAFK then
		afkBtn.Text = "ANTI AFK ON"
	else
		afkBtn.Text = "ANTI AFK OFF"
	end

end)

--------------------------------------------------
-- CONTADOR TIEMPO
--------------------------------------------------

task.spawn(function()

	while true do
		task.wait(1)

		if activo then
			tiempo += 1

			local h = math.floor(tiempo / 3600)
			local m = math.floor((tiempo % 3600) / 60)
			local s = tiempo % 60

			contador.Text =
			string.format("Tiempo activo: %02d:%02d:%02d",h,m,s)
		end

	end

end)

--------------------------------------------------
-- ANTI AFK SISTEMA
--------------------------------------------------

player.Idled:Connect(function()

	if antiAFK then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end

end)

--------------------------------------------------
-- TP LOOP
--------------------------------------------------

task.spawn(function()

	while true do
		task.wait(15)

		if activo and savedTP then
			local char = player.Character
			if char and char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.CFrame = savedTP
			end
		end

	end

end)

--------------------------------------------------
-- RECOLECTAR TREBOLES
--------------------------------------------------

task.spawn(function()

	while true do
		task.wait(0.03)

		if activo then
			remote:FireServer("collect")
		end

	end

end)

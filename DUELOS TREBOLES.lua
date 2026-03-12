-- LEON SCRIPT V2 - FIX (BOTONES CORREGIDOS)

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
-- GUI BASE
--------------------------------------------------
local gui = Instance.new("ScreenGui")
gui.Name = "LeonGUI"
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local blur = Instance.new("BlurEffect")
blur.Size = 0
blur.Parent = Lighting

--------------------------------------------------
-- PANTALLA DE BIENVENIDA (INTRO)
--------------------------------------------------
local introFrame = Instance.new("Frame")
introFrame.Size = UDim2.new(1, 0, 1, 0)
introFrame.BackgroundTransparency = 1
introFrame.Parent = gui

local introText = Instance.new("TextLabel")
introText.Parent = introFrame
introText.Size = UDim2.new(1, 0, 0, 100)
introText.Position = UDim2.new(0, 0, 0.45, 0)
introText.BackgroundTransparency = 1
introText.Text = "LEON SCRIPT"
introText.TextColor3 = Color3.fromRGB(170, 0, 255)
introText.Font = Enum.Font.GothamBold
introText.TextScaled = true
introText.TextTransparency = 1 

local function ejecutarIntro()
	TweenService:Create(blur, TweenInfo.new(1.2), {Size = 25}):Play()
	TweenService:Create(introText, TweenInfo.new(1.2), {TextTransparency = 0}):Play()
	task.wait(2.5) 
	TweenService:Create(blur, TweenInfo.new(1), {Size = 0}):Play()
	TweenService:Create(introText, TweenInfo.new(1), {TextTransparency = 1}):Play()
	task.wait(1)
	introFrame:Destroy()
end

--------------------------------------------------
-- BOTON INTERRUPTOR (EL PEQUEÑO)
--------------------------------------------------
local toggleMenu = Instance.new("ImageButton")
toggleMenu.Parent = gui
toggleMenu.Size = UDim2.new(0,65,0,65)
toggleMenu.Position = UDim2.new(0,20,0,200)
toggleMenu.Image = "rbxassetid://13608413586"
toggleMenu.BackgroundColor3 = Color3.fromRGB(20,20,20)
toggleMenu.Visible = false
toggleMenu.Draggable = true
toggleMenu.Active = true

Instance.new("UICorner",toggleMenu).CornerRadius = UDim.new(1,0)
local sBtn = Instance.new("UIStroke",toggleMenu)
sBtn.Color = Color3.fromRGB(170,0,255)
sBtn.Thickness = 3

local label = Instance.new("TextLabel", toggleMenu)
label.Size = UDim2.new(1,0,1,0)
label.BackgroundTransparency = 1
label.Text = "AL"
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.TextColor3 = Color3.fromRGB(170,0,255)

--------------------------------------------------
-- MENU PRINCIPAL
--------------------------------------------------
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 340, 0, 420)
frame.Position = UDim2.new(0.5, -170, 0.5, -210)
frame.BackgroundColor3 = Color3.fromRGB(15,15,15)
frame.Visible = false
frame.Active = true
frame.Draggable = true

Instance.new("UICorner",frame)
local mainStroke = Instance.new("UIStroke",frame)
mainStroke.Color = Color3.fromRGB(170,0,255)
mainStroke.Thickness = 2

local scroll = Instance.new("ScrollingFrame")
scroll.Parent = frame
scroll.Size = UDim2.new(1, -20, 1, -110)
scroll.Position = UDim2.new(0, 10, 0, 100)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 3
scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0) 

local layout = Instance.new("UIListLayout", scroll)
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--------------------------------------------------
-- CABECERA
--------------------------------------------------
local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.Text = "LEON EXECUTOR"
title.BackgroundColor3 = Color3.fromRGB(25, 0, 40)
title.TextColor3 = Color3.fromRGB(170,0,255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

local contador = Instance.new("TextLabel", frame)
contador.Size = UDim2.new(1,0,0,20)
contador.Position = UDim2.new(0,0,0.11,0)
contador.Text = "Tiempo: 00:00:00"
contador.BackgroundTransparency = 1
contador.TextColor3 = Color3.new(1,1,1)

local coords = Instance.new("TextLabel", frame)
coords.Parent = frame
coords.Size = UDim2.new(1,0,0,20)
coords.Position = UDim2.new(0,0,0.16,0)
coords.Text = "TP: desactivado"
coords.BackgroundTransparency = 1
coords.TextColor3 = Color3.fromRGB(200,200,200)

--------------------------------------------------
-- FUNCIÓN PARA CREAR BOTONES
--------------------------------------------------
local function crearBoton(texto, color)
	local b = Instance.new("TextButton")
	b.Parent = scroll
	b.Size = UDim2.new(0.9, 0, 0, 38)
	b.Text = texto
	b.BackgroundColor3 = color
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextScaled = true
	Instance.new("UICorner", b)
	local s = Instance.new("UIStroke", b)
	s.Color = Color3.fromRGB(170,0,255)
	return b
end

--------------------------------------------------
-- AGREGAR BOTONES
--------------------------------------------------

-- SCRIPTS EXTERNOS
local btnEmotes = crearBoton("EMOTES", Color3.fromRGB(40,40,40))
btnEmotes.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-7yd7-I-Emote-Script-48024"))()
end)

local btnAnim = crearBoton("ANIMACIONES", Color3.fromRGB(40,40,40))
btnAnim.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-GAZER-FE-ANIMATION-EDITOR-54459"))()
end)

local btnDuelos = crearBoton("DUELOS", Color3.fromRGB(40,40,40))
btnDuelos.MouseButton1Click:Connect(function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/renardofficiel/game/refs/heads/main/m_vs_s_fake/main.lua", true))()
end)

-- SEPARADOR
local sep = Instance.new("Frame", scroll)
sep.Size = UDim2.new(0.9, 0, 0, 2)
sep.BackgroundColor3 = Color3.fromRGB(170,0,255)

-- FUNCIONES ORIGINALES (CORREGIDAS)
local btnSet = crearBoton("SET TP", Color3.fromRGB(30,0,45))
btnSet.MouseButton1Click:Connect(function()
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")
	savedTP = hrp.CFrame
	coords.Text = "TP: "..math.floor(hrp.Position.X).." "..math.floor(hrp.Position.Y).." "..math.floor(hrp.Position.Z)
end)

local btnClear = crearBoton("CLEAR TP", Color3.fromRGB(30,0,45))
btnClear.MouseButton1Click:Connect(function()
	savedTP = nil
	coords.Text = "TP: desactivado"
end)

local btnToggle = crearBoton("SCRIPT OFF", Color3.fromRGB(30,0,45))
btnToggle.MouseButton1Click:Connect(function()
	activo = not activo
	if activo then
		btnToggle.Text = "SCRIPT ON"
		btnToggle.BackgroundColor3 = Color3.fromRGB(60, 0, 90) -- Brilla un poco más al estar ON
	else
		btnToggle.Text = "SCRIPT OFF"
		btnToggle.BackgroundColor3 = Color3.fromRGB(30,0,45)
	end
end)

local btnAFK = crearBoton("ANTI AFK OFF", Color3.fromRGB(30,0,45))
btnAFK.MouseButton1Click:Connect(function()
	antiAFK = not antiAFK
	if antiAFK then
		btnAFK.Text = "ANTI AFK ON"
		btnAFK.BackgroundColor3 = Color3.fromRGB(60, 0, 90)
	else
		btnAFK.Text = "ANTI AFK OFF"
		btnAFK.BackgroundColor3 = Color3.fromRGB(30,0,45)
	end
end)

--------------------------------------------------
-- LOOPS (NO TOCAR)
--------------------------------------------------

toggleMenu.MouseButton1Click:Connect(function()
	if frame.Visible then
		frame.Visible = false
		blur.Size = 0
	else
		frame.Visible = true
		blur.Size = 18
	end
end)

task.spawn(function()
	while true do
		task.wait(1)
		if activo then
			tiempo += 1
			local h, m, s = math.floor(tiempo/3600), math.floor((tiempo%3600)/60), tiempo%60
			contador.Text = string.format("Tiempo: %02d:%02d:%02d", h, m, s)
		end
	end
end)

player.Idled:Connect(function()
	if antiAFK then
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end
end)

task.spawn(function()
	while true do
		task.wait(5)
		if activo and savedTP then
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				player.Character.HumanoidRootPart.CFrame = savedTP
			end
		end
	end
end)

task.spawn(function()
	while true do
		task.wait(0.03)
		if activo then
			remote:FireServer("collect")
		end
	end
end)

--------------------------------------------------
-- EJECUCIÓN
--------------------------------------------------
task.spawn(function()
	ejecutarIntro()
	toggleMenu.Visible = true
end)

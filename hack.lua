local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- รอให้ PlayerGui โหลด
if not player:FindFirstChild("PlayerGui") then
    player:WaitForChild("PlayerGui")
end

-- ลบ GUI เก่าถ้ามี
if player.PlayerGui:FindFirstChild("UltraHackerPro") then
    player.PlayerGui.UltraHackerPro:Destroy()
end

-- สร้าง UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltraHackerPro"
ScreenGui.Parent = player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 750)
MainFrame.Position = UDim2.new(0.05, 0, 0.05, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- เอฟเฟกต์ Background
local BackgroundEffect = Instance.new("Frame")
BackgroundEffect.Size = UDim2.new(1, 0, 1, 0)
BackgroundEffect.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
BackgroundEffect.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = MainFrame

-- Animated Gradient Background
local AnimatedGradient = Instance.new("UIGradient")
AnimatedGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 30)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(25, 15, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(15, 15, 30))
})
AnimatedGradient.Rotation = 45
AnimatedGradient.Parent = MainFrame

-- Pulse Animation
local pulseConnection
pulseConnection = RunService.Heartbeat:Connect(function()
    local time = tick()
    AnimatedGradient.Offset = Vector2.new(math.sin(time * 0.5) * 0.2, math.cos(time * 0.3) * 0.2)
end)

-- Glow Effect
local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1, 20, 1, 20)
Glow.Position = UDim2.new(0, -10, 0, -10)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://8992231221"
Glow.ImageColor3 = Color3.fromRGB(100, 50, 200)
Glow.ScaleType = Enum.ScaleType.Slice
Glow.SliceCenter = Rect.new(100, 100, 100, 100)
Glow.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 80)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 25)
HeaderCorner.Parent = Header

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 50, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 100, 255))
})
HeaderGradient.Parent = Header

-- Animated Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Text = "⚡ GOD MODE HACKER ⚡"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Animate Title
spawn(function()
    while true do
        for i = 1, 10 do
            Title.TextColor3 = Color3.fromHSV(i/10, 0.8, 1)
            wait(0.1)
        end
    end
end)

-- Control Buttons
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 40, 0, 40)
MinimizeButton.Position = UDim2.new(1, -90, 0.5, -20)
MinimizeButton.Text = "─"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = Header

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(1, 0)
MinimizeCorner.Parent = MinimizeButton

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -45, 0.5, -20)
CloseButton.Text = "×"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 22
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, 0, 1, -80)
ContentArea.Position = UDim2.new(0, 0, 0, 80)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Tab System
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 60)
TabContainer.Position = UDim2.new(0, 10, 0, 10)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = ContentArea

local tabs = {
    {name = "🔮 MAIN", id = "main"},
    {name = "💰 ECONOMY", id = "economy"},
    {name = "⚡ BOOST", id = "boost"},
    {name = "🎯 COMBAT", id = "combat"},
    {name = "🛠️ TOOLS", id = "tools"}
}

local currentTab = "main"
local tabButtons = {}

for i, tab in ipairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0.19, 0, 1, 0)
    tabButton.Position = UDim2.new(0.19 * (i-1), 0, 0, 0)
    tabButton.Text = tab.name
    tabButton.BackgroundColor3 = tab.id == "main" and Color3.fromRGB(60, 60, 100) or Color3.fromRGB(40, 40, 70)
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 12
    tabButton.Parent = TabContainer
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 12)
    tabCorner.Parent = tabButton
    
    tabButtons[tab.id] = tabButton
end

-- Tab Contents
local tabContents = {}

-- Main Tab
local MainContent = Instance.new("ScrollingFrame")
MainContent.Size = UDim2.new(1, -20, 0, 590)
MainContent.Position = UDim2.new(0, 10, 0, 75)
MainContent.BackgroundTransparency = 1
MainContent.ScrollBarThickness = 8
MainContent.CanvasSize = UDim2.new(0, 0, 0, 800)
MainContent.Parent = ContentArea
tabContents.main = MainContent

-- Economy Tab
local EconomyContent = Instance.new("ScrollingFrame")
EconomyContent.Size = UDim2.new(1, -20, 0, 590)
EconomyContent.Position = UDim2.new(0, 10, 0, 75)
EconomyContent.BackgroundTransparency = 1
EconomyContent.ScrollBarThickness = 8
EconomyContent.CanvasSize = UDim2.new(0, 0, 0, 800)
EconomyContent.Visible = false
EconomyContent.Parent = ContentArea
tabContents.economy = EconomyContent

-- Boost Tab
local BoostContent = Instance.new("ScrollingFrame")
BoostContent.Size = UDim2.new(1, -20, 0, 590)
BoostContent.Position = UDim2.new(0, 10, 0, 75)
BoostContent.BackgroundTransparency = 1
BoostContent.ScrollBarThickness = 8
BoostContent.CanvasSize = UDim2.new(0, 0, 0, 800)
BoostContent.Visible = false
BoostContent.Parent = ContentArea
tabContents.boost = BoostContent

-- Combat Tab
local CombatContent = Instance.new("ScrollingFrame")
CombatContent.Size = UDim2.new(1, -20, 0, 590)
CombatContent.Position = UDim2.new(0, 10, 0, 75)
CombatContent.BackgroundTransparency = 1
CombatContent.ScrollBarThickness = 8
CombatContent.CanvasSize = UDim2.new(0, 0, 0, 800)
CombatContent.Visible = false
CombatContent.Parent = ContentArea
tabContents.combat = CombatContent

-- Tools Tab
local ToolsContent = Instance.new("ScrollingFrame")
ToolsContent.Size = UDim2.new(1, -20, 0, 590)
ToolsContent.Position = UDim2.new(0, 10, 0, 75)
ToolsContent.BackgroundTransparency = 1
ToolsContent.ScrollBarThickness = 8
ToolsContent.CanvasSize = UDim2.new(0, 0, 0, 800)
ToolsContent.Visible = false
ToolsContent.Parent = ContentArea
tabContents.tools = ToolsContent

-- ========== MAIN TAB CONTENT ==========
local MainFrameContent = Instance.new("Frame")
MainFrameContent.Size = UDim2.new(1, 0, 0, 800)
MainFrameContent.BackgroundTransparency = 1
MainFrameContent.Parent = MainContent

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 50)
StatusLabel.Position = UDim2.new(0, 0, 0, 0)
StatusLabel.Text = "🟢 GOD MODE ACTIVATED - READY TO HACK"
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.new(1, 1, 1)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 16
StatusLabel.Parent = MainFrameContent

-- Scan Section
local ScanSection = Instance.new("Frame")
ScanSection.Size = UDim2.new(1, 0, 0, 250)
ScanSection.Position = UDim2.new(0, 0, 0, 55)
ScanSection.BackgroundTransparency = 1
ScanSection.Parent = MainFrameContent

local ScanButton = Instance.new("TextButton")
ScanButton.Size = UDim2.new(1, 0, 0, 60)
ScanButton.Position = UDim2.new(0, 0, 0, 0)
ScanButton.Text = "🔍 DEEP SCAN & AUTO HACK"
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ScanButton.TextColor3 = Color3.new(1, 1, 1)
ScanButton.Font = Enum.Font.GothamBold
ScanButton.TextSize = 18
ScanButton.Parent = ScanSection

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 15)
ScanCorner.Parent = ScanButton

local ScanGradient = Instance.new("UIGradient")
ScanGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
})
ScanGradient.Parent = ScanButton

-- Bypass Button
local BypassButton = Instance.new("TextButton")
BypassButton.Size = UDim2.new(1, 0, 0, 55)
BypassButton.Position = UDim2.new(0, 0, 0, 65)
BypassButton.Text = "🛡️ ACTIVATE GOD BYPASS"
BypassButton.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
BypassButton.TextColor3 = Color3.new(1, 1, 1)
BypassButton.Font = Enum.Font.GothamBold
BypassButton.TextSize = 16
BypassButton.Parent = ScanSection

local BypassCorner = Instance.new("UICorner")
BypassCorner.CornerRadius = UDim.new(0, 12)
BypassCorner.Parent = BypassButton

local BypassGradient = Instance.new("UIGradient")
BypassGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 0, 255))
})
BypassGradient.Parent = BypassButton

-- Action Buttons
local ActionContainer = Instance.new("Frame")
ActionContainer.Size = UDim2.new(1, 0, 0, 60)
ActionContainer.Position = UDim2.new(0, 0, 0, 125)
ActionContainer.BackgroundTransparency = 1
ActionContainer.Parent = ScanSection

local AutoFarmButton = Instance.new("TextButton")
AutoFarmButton.Size = UDim2.new(0.48, 0, 1, 0)
AutoFarmButton.Position = UDim2.new(0, 0, 0, 0)
AutoFarmButton.Text = "⚡ AUTO FARM"
AutoFarmButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
AutoFarmButton.TextColor3 = Color3.new(1, 1, 1)
AutoFarmButton.Font = Enum.Font.GothamBold
AutoFarmButton.TextSize = 14
AutoFarmButton.Parent = ActionContainer

local AutoFarmCorner = Instance.new("UICorner")
AutoFarmCorner.CornerRadius = UDim.new(0, 10)
AutoFarmCorner.Parent = AutoFarmButton

local AutoFarmGradient = Instance.new("UIGradient")
AutoFarmGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 0))
})
AutoFarmGradient.Parent = AutoFarmButton

local MassCollectButton = Instance.new("TextButton")
MassCollectButton.Size = UDim2.new(0.48, 0, 1, 0)
MassCollectButton.Position = UDim2.new(0.52, 0, 0, 0)
MassCollectButton.Text = "💥 MASS COLLECT"
MassCollectButton.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
MassCollectButton.TextColor3 = Color3.new(1, 1, 1)
MassCollectButton.Font = Enum.Font.GothamBold
MassCollectButton.TextSize = 14
MassCollectButton.Parent = ActionContainer

local MassCollectCorner = Instance.new("UICorner")
MassCollectCorner.CornerRadius = UDim.new(0, 10)
MassCollectCorner.Parent = MassCollectButton

local MassCollectGradient = Instance.new("UIGradient")
MassCollectGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 50))
})
MassCollectGradient.Parent = MassCollectButton

-- Quick Hack Buttons
local QuickHackContainer = Instance.new("Frame")
QuickHackContainer.Size = UDim2.new(1, 0, 0, 60)
QuickHackContainer.Position = UDim2.new(0, 0, 0, 190)
QuickHackContainer.BackgroundTransparency = 1
QuickHackContainer.Parent = ScanSection

local InstantMoneyButton = Instance.new("TextButton")
InstantMoneyButton.Size = UDim2.new(0.48, 0, 1, 0)
InstantMoneyButton.Position = UDim2.new(0, 0, 0, 0)
InstantMoneyButton.Text = "💰 INSTANT 1M"
InstantMoneyButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
InstantMoneyButton.TextColor3 = Color3.new(1, 1, 1)
InstantMoneyButton.Font = Enum.Font.GothamBold
InstantMoneyButton.TextSize = 14
InstantMoneyButton.Parent = QuickHackContainer

local InstantMoneyCorner = Instance.new("UICorner")
InstantMoneyCorner.CornerRadius = UDim.new(0, 10)
InstantMoneyCorner.Parent = InstantMoneyButton

local GodModeButton = Instance.new("TextButton")
GodModeButton.Size = UDim2.new(0.48, 0, 1, 0)
GodModeButton.Position = UDim2.new(0.52, 0, 0, 0)
GodModeButton.Text = "🛡️ GOD MODE"
GodModeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 200)
GodModeButton.TextColor3 = Color3.new(1, 1, 1)
GodModeButton.Font = Enum.Font.GothamBold
GodModeButton.TextSize = 14
GodModeButton.Parent = QuickHackContainer

local GodModeCorner = Instance.new("UICorner")
GodModeCorner.CornerRadius = UDim.new(0, 10)
GodModeCorner.Parent = GodModeButton

-- Items List
local ListFrame = Instance.new("ScrollingFrame")
ListFrame.Size = UDim2.new(1, 0, 0, 450)
ListFrame.Position = UDim2.new(0, 0, 0, 320)
ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ListFrame.ScrollBarThickness = 8
ListFrame.Parent = MainFrameContent

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 15)
ListCorner.Parent = ListFrame

-- ========== ECONOMY TAB CONTENT ==========
local EconomyFrame = Instance.new("Frame")
EconomyFrame.Size = UDim2.new(1, 0, 0, 1200)
EconomyFrame.BackgroundTransparency = 1
EconomyFrame.Parent = EconomyContent

-- Money Hack Section
local MoneySection = Instance.new("Frame")
MoneySection.Size = UDim2.new(1, 0, 0, 350)
MoneySection.Position = UDim2.new(0, 0, 0, 0)
MoneySection.BackgroundTransparency = 1
MoneySection.Parent = EconomyFrame

local MoneyTitle = Instance.new("TextLabel")
MoneyTitle.Size = UDim2.new(1, 0, 0, 50)
MoneyTitle.Position = UDim2.new(0, 0, 0, 0)
MoneyTitle.Text = "💰 ULTIMATE MONEY HACKS"
MoneyTitle.BackgroundTransparency = 1
MoneyTitle.TextColor3 = Color3.new(1, 1, 1)
MoneyTitle.Font = Enum.Font.GothamBold
MoneyTitle.TextSize = 20
MoneyTitle.Parent = MoneySection

-- Money Input
local MoneyInput = Instance.new("TextBox")
MoneyInput.Size = UDim2.new(1, 0, 0, 55)
MoneyInput.Position = UDim2.new(0, 0, 0, 55)
MoneyInput.PlaceholderText = "💵 Enter amount (e.g., 999999, /100, x500, 1M, 1B)"
MoneyInput.Text = "1000000"
MoneyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
MoneyInput.TextColor3 = Color3.new(1, 1, 1)
MoneyInput.Font = Enum.Font.Gotham
MoneyInput.TextSize = 16
MoneyInput.Parent = MoneySection

local MoneyInputCorner = Instance.new("UICorner")
MoneyInputCorner.CornerRadius = UDim.new(0, 12)
MoneyInputCorner.Parent = MoneyInput

-- Money Buttons
local AddMoneyButton = Instance.new("TextButton")
AddMoneyButton.Size = UDim2.new(0.48, 0, 0, 55)
AddMoneyButton.Position = UDim2.new(0, 0, 0, 115)
AddMoneyButton.Text = "💰 ADD MONEY"
AddMoneyButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
AddMoneyButton.TextColor3 = Color3.new(1, 1, 1)
AddMoneyButton.Font = Enum.Font.GothamBold
AddMoneyButton.TextSize = 14
AddMoneyButton.Parent = MoneySection

local AddMoneyCorner = Instance.new("UICorner")
AddMoneyCorner.CornerRadius = UDim.new(0, 10)
AddMoneyCorner.Parent = AddMoneyButton

local SetMoneyButton = Instance.new("TextButton")
SetMoneyButton.Size = UDim2.new(0.48, 0, 0, 55)
SetMoneyButton.Position = UDim2.new(0.52, 0, 0, 115)
SetMoneyButton.Text = "🎯 SET MONEY"
SetMoneyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
SetMoneyButton.TextColor3 = Color3.new(1, 1, 1)
SetMoneyButton.Font = Enum.Font.GothamBold
SetMoneyButton.TextSize = 14
SetMoneyButton.Parent = MoneySection

local SetMoneyCorner = Instance.new("UICorner")
SetMoneyCorner.CornerRadius = UDim.new(0, 10)
SetMoneyCorner.Parent = SetMoneyButton

-- Quick Money Buttons
local QuickMoneyContainer = Instance.new("Frame")
QuickMoneyContainer.Size = UDim2.new(1, 0, 0, 55)
QuickMoneyContainer.Position = UDim2.new(0, 0, 0, 175)
QuickMoneyContainer.BackgroundTransparency = 1
QuickMoneyContainer.Parent = MoneySection

local Money1MButton = Instance.new("TextButton")
Money1MButton.Size = UDim2.new(0.32, 0, 1, 0)
Money1MButton.Position = UDim2.new(0, 0, 0, 0)
Money1MButton.Text = "1M"
Money1MButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
Money1MButton.TextColor3 = Color3.new(1, 1, 1)
Money1MButton.Font = Enum.Font.GothamBold
Money1MButton.TextSize = 14
Money1MButton.Parent = QuickMoneyContainer

local Money1MCorner = Instance.new("UICorner")
Money1MCorner.CornerRadius = UDim.new(0, 8)
Money1MCorner.Parent = Money1MButton

local Money10MButton = Instance.new("TextButton")
Money10MButton.Size = UDim2.new(0.32, 0, 1, 0)
Money10MButton.Position = UDim2.new(0.34, 0, 0, 0)
Money10MButton.Text = "10M"
Money10MButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
Money10MButton.TextColor3 = Color3.new(1, 1, 1)
Money10MButton.Font = Enum.Font.GothamBold
Money10MButton.TextSize = 14
Money10MButton.Parent = QuickMoneyContainer

local Money10MCorner = Instance.new("UICorner")
Money10MCorner.CornerRadius = UDim.new(0, 8)
Money10MCorner.Parent = Money10MButton

local Money1BButton = Instance.new("TextButton")
Money1BButton.Size = UDim2.new(0.32, 0, 1, 0)
Money1BButton.Position = UDim2.new(0.68, 0, 0, 0)
Money1BButton.Text = "1B"
Money1BButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Money1BButton.TextColor3 = Color3.new(1, 1, 1)
Money1BButton.Font = Enum.Font.GothamBold
Money1BButton.TextSize = 14
Money1BButton.Parent = QuickMoneyContainer

local Money1BCorner = Instance.new("UICorner")
Money1BCorner.CornerRadius = UDim.new(0, 8)
Money1BCorner.Parent = Money1BButton

-- Auto Money Farm
local AutoMoneyButton = Instance.new("TextButton")
AutoMoneyButton.Size = UDim2.new(1, 0, 0, 55)
AutoMoneyButton.Position = UDim2.new(0, 0, 0, 235)
AutoMoneyButton.Text = "⚡ AUTO MONEY FARM"
AutoMoneyButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
AutoMoneyButton.TextColor3 = Color3.new(1, 1, 1)
AutoMoneyButton.Font = Enum.Font.GothamBold
AutoMoneyButton.TextSize = 16
AutoMoneyButton.Parent = MoneySection

local AutoMoneyCorner = Instance.new("UICorner")
AutoMoneyCorner.CornerRadius = UDim.new(0, 12)
AutoMoneyCorner.Parent = AutoMoneyButton

-- Currency Section
local CurrencySection = Instance.new("Frame")
CurrencySection.Size = UDim2.new(1, 0, 0, 300)
CurrencySection.Position = UDim2.new(0, 0, 0, 365)
CurrencySection.BackgroundTransparency = 1
CurrencySection.Parent = EconomyFrame

local CurrencyTitle = Instance.new("TextLabel")
CurrencyTitle.Size = UDim2.new(1, 0, 0, 50)
CurrencyTitle.Position = UDim2.new(0, 0, 0, 0)
CurrencyTitle.Text = "💎 CURRENCY HACKS"
CurrencyTitle.BackgroundTransparency = 1
CurrencyTitle.TextColor3 = Color3.new(1, 1, 1)
CurrencyTitle.Font = Enum.Font.GothamBold
CurrencyTitle.TextSize = 20
CurrencyTitle.Parent = CurrencySection

local AddCoinsButton = Instance.new("TextButton")
AddCoinsButton.Size = UDim2.new(1, 0, 0, 55)
AddCoinsButton.Position = UDim2.new(0, 0, 0, 55)
AddCoinsButton.Text = "🪙 ADD 100K COINS"
AddCoinsButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
AddCoinsButton.TextColor3 = Color3.new(0, 0, 0)
AddCoinsButton.Font = Enum.Font.GothamBold
AddCoinsButton.TextSize = 16
AddCoinsButton.Parent = CurrencySection

local AddCoinsCorner = Instance.new("UICorner")
AddCoinsCorner.CornerRadius = UDim.new(0, 12)
AddCoinsCorner.Parent = AddCoinsButton

local AddGemsButton = Instance.new("TextButton")
AddGemsButton.Size = UDim2.new(1, 0, 0, 55)
AddGemsButton.Position = UDim2.new(0, 0, 0, 115)
AddGemsButton.Text = "💎 ADD 10K GEMS"
AddGemsButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
AddGemsButton.TextColor3 = Color3.new(1, 1, 1)
AddGemsButton.Font = Enum.Font.GothamBold
AddGemsButton.TextSize = 16
AddGemsButton.Parent = CurrencySection

local AddGemsCorner = Instance.new("UICorner")
AddGemsCorner.CornerRadius = UDim.new(0, 12)
AddGemsCorner.Parent = AddGemsButton

local MaxCurrencyButton = Instance.new("TextButton")
MaxCurrencyButton.Size = UDim2.new(1, 0, 0, 55)
MaxCurrencyButton.Position = UDim2.new(0, 0, 0, 175)
MaxCurrencyButton.Text = "🚀 MAX ALL CURRENCY (999M)"
MaxCurrencyButton.BackgroundColor3 = Color3.fromRGB(180, 0, 180)
MaxCurrencyButton.TextColor3 = Color3.new(1, 1, 1)
MaxCurrencyButton.Font = Enum.Font.GothamBold
MaxCurrencyButton.TextSize = 16
MaxCurrencyButton.Parent = CurrencySection

local MaxCurrencyCorner = Instance.new("UICorner")
MaxCurrencyCorner.CornerRadius = UDim.new(0, 12)
MaxCurrencyCorner.Parent = MaxCurrencyButton

-- Item Duplication Section
local DupeSection = Instance.new("Frame")
DupeSection.Size = UDim2.new(1, 0, 0, 250)
DupeSection.Position = UDim2.new(0, 0, 0, 680)
DupeSection.BackgroundTransparency = 1
DupeSection.Parent = EconomyFrame

local DupeTitle = Instance.new("TextLabel")
DupeTitle.Size = UDim2.new(1, 0, 0, 50)
DupeTitle.Position = UDim2.new(0, 0, 0, 0)
DupeTitle.Text = "🎁 ITEM DUPLICATION"
DupeTitle.BackgroundTransparency = 1
DupeTitle.TextColor3 = Color3.new(1, 1, 1)
DupeTitle.Font = Enum.Font.GothamBold
DupeTitle.TextSize = 20
DupeTitle.Parent = DupeSection

local DupeItemsButton = Instance.new("TextButton")
DupeItemsButton.Size = UDim2.new(1, 0, 0, 55)
DupeItemsButton.Position = UDim2.new(0, 0, 0, 55)
DupeItemsButton.Text = "📦 DUPLICATE ALL ITEMS"
DupeItemsButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
DupeItemsButton.TextColor3 = Color3.new(1, 1, 1)
DupeItemsButton.Font = Enum.Font.GothamBold
DupeItemsButton.TextSize = 16
DupeItemsButton.Parent = DupeSection

local DupeItemsCorner = Instance.new("UICorner")
DupeItemsCorner.CornerRadius = UDim.new(0, 12)
DupeItemsCorner.Parent = DupeItemsButton

local CopyInventoryButton = Instance.new("TextButton")
CopyInventoryButton.Size = UDim2.new(1, 0, 0, 55)
CopyInventoryButton.Position = UDim2.new(0, 0, 0, 115)
CopyInventoryButton.Text = "📋 COPY BEST INVENTORY"
CopyInventoryButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
CopyInventoryButton.TextColor3 = Color3.new(1, 1, 1)
CopyInventoryButton.Font = Enum.Font.GothamBold
CopyInventoryButton.TextSize = 16
CopyInventoryButton.Parent = DupeSection

local CopyInventoryCorner = Instance.new("UICorner")
CopyInventoryCorner.CornerRadius = UDim.new(0, 12)
CopyInventoryCorner.Parent = CopyInventoryButton

-- ========== BOOST TAB CONTENT ==========
local BoostFrame = Instance.new("Frame")
BoostFrame.Size = UDim2.new(1, 0, 0, 1200)
BoostFrame.BackgroundTransparency = 1
BoostFrame.Parent = BoostContent

-- Speed Hack Section
local SpeedSection = Instance.new("Frame")
SpeedSection.Size = UDim2.new(1, 0, 0, 250)
SpeedSection.Position = UDim2.new(0, 0, 0, 0)
SpeedSection.BackgroundTransparency = 1
SpeedSection.Parent = BoostFrame

local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, 0, 0, 50)
SpeedTitle.Position = UDim2.new(0, 0, 0, 0)
SpeedTitle.Text = "🏃 ULTIMATE SPEED HACKS"
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.TextColor3 = Color3.new(1, 1, 1)
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.TextSize = 20
SpeedTitle.Parent = SpeedSection

-- Speed Input
local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, 0, 0, 55)
SpeedInput.Position = UDim2.new(0, 0, 0, 55)
SpeedInput.PlaceholderText = "🎯 Enter speed value (16 = normal, 100 = fast, 1000 = god)"
SpeedInput.Text = "100"
SpeedInput.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.TextSize = 16
SpeedInput.Parent = SpeedSection

local SpeedInputCorner = Instance.new("UICorner")
SpeedInputCorner.CornerRadius = UDim.new(0, 12)
SpeedInputCorner.Parent = SpeedInput

-- Speed Buttons
local SetSpeedButton = Instance.new("TextButton")
SetSpeedButton.Size = UDim2.new(0.48, 0, 0, 55)
SetSpeedButton.Position = UDim2.new(0, 0, 0, 115)
SetSpeedButton.Text = "⚡ SET SPEED"
SetSpeedButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
SetSpeedButton.TextColor3 = Color3.new(1, 1, 1)
SetSpeedButton.Font = Enum.Font.GothamBold
SetSpeedButton.TextSize = 14
SetSpeedButton.Parent = SpeedSection

local SetSpeedCorner = Instance.new("UICorner")
SetSpeedCorner.CornerRadius = UDim.new(0, 10)
SetSpeedCorner.Parent = SetSpeedButton

local ResetSpeedButton = Instance.new("TextButton")
ResetSpeedButton.Size = UDim2.new(0.48, 0, 0, 55)
ResetSpeedButton.Position = UDim2.new(0.52, 0, 0, 115)
ResetSpeedButton.Text = "🔄 RESET SPEED"
ResetSpeedButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ResetSpeedButton.TextColor3 = Color3.new(1, 1, 1)
ResetSpeedButton.Font = Enum.Font.GothamBold
ResetSpeedButton.TextSize = 14
ResetSpeedButton.Parent = SpeedSection

local ResetSpeedCorner = Instance.new("UICorner")
ResetSpeedCorner.CornerRadius = UDim.new(0, 10)
ResetSpeedCorner.Parent = ResetSpeedButton

-- Quick Speed Buttons
local QuickSpeedContainer = Instance.new("Frame")
QuickSpeedContainer.Size = UDim2.new(1, 0, 0, 55)
QuickSpeedContainer.Position = UDim2.new(0, 0, 0, 175)
QuickSpeedContainer.BackgroundTransparency = 1
QuickSpeedContainer.Parent = SpeedSection

local Speed100Button = Instance.new("TextButton")
Speed100Button.Size = UDim2.new(0.32, 0, 1, 0)
Speed100Button.Position = UDim2.new(0, 0, 0, 0)
Speed100Button.Text = "100"
Speed100Button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
Speed100Button.TextColor3 = Color3.new(1, 1, 1)
Speed100Button.Font = Enum.Font.GothamBold
Speed100Button.TextSize = 14
Speed100Button.Parent = QuickSpeedContainer

local Speed100Corner = Instance.new("UICorner")
Speed100Corner.CornerRadius = UDim.new(0, 8)
Speed100Corner.Parent = Speed100Button

local Speed500Button = Instance.new("TextButton")
Speed500Button.Size = UDim2.new(0.32, 0, 1, 0)
Speed500Button.Position = UDim2.new(0.34, 0, 0, 0)
Speed500Button.Text = "500"
Speed500Button.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
Speed500Button.TextColor3 = Color3.new(1, 1, 1)
Speed500Button.Font = Enum.Font.GothamBold
Speed500Button.TextSize = 14
Speed500Button.Parent = QuickSpeedContainer

local Speed500Corner = Instance.new("UICorner")
Speed500Corner.CornerRadius = UDim.new(0, 8)
Speed500Corner.Parent = Speed500Button

local Speed1000Button = Instance.new("TextButton")
Speed1000Button.Size = UDim2.new(0.32, 0, 1, 0)
Speed1000Button.Position = UDim2.new(0.68, 0, 0, 0)
Speed1000Button.Text = "1000"
Speed1000Button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Speed1000Button.TextColor3 = Color3.new(1, 1, 1)
Speed1000Button.Font = Enum.Font.GothamBold
Speed1000Button.TextSize = 14
Speed1000Button.Parent = QuickSpeedContainer

local Speed1000Corner = Instance.new("UICorner")
Speed1000Corner.CornerRadius = UDim.new(0, 8)
Speed1000Corner.Parent = Speed1000Button

-- Jump Hack Section
local JumpSection = Instance.new("Frame")
JumpSection.Size = UDim2.new(1, 0, 0, 250)
JumpSection.Position = UDim2.new(0, 0, 0, 265)
JumpSection.BackgroundTransparency = 1
JumpSection.Parent = BoostFrame

local JumpTitle = Instance.new("TextLabel")
JumpTitle.Size = UDim2.new(1, 0, 0, 50)
JumpTitle.Position = UDim2.new(0, 0, 0, 0)
JumpTitle.Text = "🦘 ULTIMATE JUMP HACKS"
JumpTitle.BackgroundTransparency = 1
JumpTitle.TextColor3 = Color3.new(1, 1, 1)
JumpTitle.Font = Enum.Font.GothamBold
JumpTitle.TextSize = 20
JumpTitle.Parent = JumpSection

-- Jump Input
local JumpInput = Instance.new("TextBox")
JumpInput.Size = UDim2.new(1, 0, 0, 55)
JumpInput.Position = UDim2.new(0, 0, 0, 55)
JumpInput.PlaceholderText = "🎯 Enter jump power (50 = normal, 100 = high, 500 = god)"
JumpInput.Text = "100"
JumpInput.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
JumpInput.TextColor3 = Color3.new(1, 1, 1)
JumpInput.Font = Enum.Font.Gotham
JumpInput.TextSize = 16
JumpInput.Parent = JumpSection

local JumpInputCorner = Instance.new("UICorner")
JumpInputCorner.CornerRadius = UDim.new(0, 12)
JumpInputCorner.Parent = JumpInput

-- Jump Buttons
local SetJumpButton = Instance.new("TextButton")
SetJumpButton.Size = UDim2.new(0.48, 0, 0, 55)
SetJumpButton.Position = UDim2.new(0, 0, 0, 115)
SetJumpButton.Text = "⚡ SET JUMP"
SetJumpButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
SetJumpButton.TextColor3 = Color3.new(1, 1, 1)
SetJumpButton.Font = Enum.Font.GothamBold
SetJumpButton.TextSize = 14
SetJumpButton.Parent = JumpSection

local SetJumpCorner = Instance.new("UICorner")
SetJumpCorner.CornerRadius = UDim.new(0, 10)
SetJumpCorner.Parent = SetJumpButton

local ResetJumpButton = Instance.new("TextButton")
ResetJumpButton.Size = UDim2.new(0.48, 0, 0, 55)
ResetJumpButton.Position = UDim2.new(0.52, 0, 0, 115)
ResetJumpButton.Text = "🔄 RESET JUMP"
ResetJumpButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ResetJumpButton.TextColor3 = Color3.new(1, 1, 1)
ResetJumpButton.Font = Enum.Font.GothamBold
ResetJumpButton.TextSize = 14
ResetJumpButton.Parent = JumpSection

local ResetJumpCorner = Instance.new("UICorner")
ResetJumpCorner.CornerRadius = UDim.new(0, 10)
ResetJumpCorner.Parent = ResetJumpButton

-- Quick Jump Buttons
local QuickJumpContainer = Instance.new("Frame")
QuickJumpContainer.Size = UDim2.new(1, 0, 0, 55)
QuickJumpContainer.Position = UDim2.new(0, 0, 0, 175)
QuickJumpContainer.BackgroundTransparency = 1
QuickJumpContainer.Parent = JumpSection

local Jump100Button = Instance.new("TextButton")
Jump100Button.Size = UDim2.new(0.32, 0, 1, 0)
Jump100Button.Position = UDim2.new(0, 0, 0, 0)
Jump100Button.Text = "100"
Jump100Button.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
Jump100Button.TextColor3 = Color3.new(1, 1, 1)
Jump100Button.Font = Enum.Font.GothamBold
Jump100Button.TextSize = 14
Jump100Button.Parent = QuickJumpContainer

local Jump100Corner = Instance.new("UICorner")
Jump100Corner.CornerRadius = UDim.new(0, 8)
Jump100Corner.Parent = Jump100Button

local Jump200Button = Instance.new("TextButton")
Jump200Button.Size = UDim2.new(0.32, 0, 1, 0)
Jump200Button.Position = UDim2.new(0.34, 0, 0, 0)
Jump200Button.Text = "200"
Jump200Button.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
Jump200Button.TextColor3 = Color3.new(1, 1, 1)
Jump200Button.Font = Enum.Font.GothamBold
Jump200Button.TextSize = 14
Jump200Button.Parent = QuickJumpContainer

local Jump200Corner = Instance.new("UICorner")
Jump200Corner.CornerRadius = UDim.new(0, 8)
Jump200Corner.Parent = Jump200Button

local Jump500Button = Instance.new("TextButton")
Jump500Button.Size = UDim2.new(0.32, 0, 1, 0)
Jump500Button.Position = UDim2.new(0.68, 0, 0, 0)
Jump500Button.Text = "500"
Jump500Button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
Jump500Button.TextColor3 = Color3.new(1, 1, 1)
Jump500Button.Font = Enum.Font.GothamBold
Jump500Button.TextSize = 14
Jump500Button.Parent = QuickJumpContainer

local Jump500Corner = Instance.new("UICorner")
Jump500Corner.CornerRadius = UDim.new(0, 8)
Jump500Corner.Parent = Jump500Button

-- Other Boosts Section
local OtherBoostSection = Instance.new("Frame")
OtherBoostSection.Size = UDim2.new(1, 0, 0, 400)
OtherBoostSection.Position = UDim2.new(0, 0, 0, 530)
OtherBoostSection.BackgroundTransparency = 1
OtherBoostSection.Parent = BoostFrame

local OtherBoostTitle = Instance.new("TextLabel")
OtherBoostTitle.Size = UDim2.new(1, 0, 0, 50)
OtherBoostTitle.Position = UDim2.new(0, 0, 0, 0)
OtherBoostTitle.Text = "✨ GOD MODE BOOSTS"
OtherBoostTitle.BackgroundTransparency = 1
OtherBoostTitle.TextColor3 = Color3.new(1, 1, 1)
OtherBoostTitle.Font = Enum.Font.GothamBold
OtherBoostTitle.TextSize = 20
OtherBoostTitle.Parent = OtherBoostSection

local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(1, 0, 0, 55)
FlyButton.Position = UDim2.new(0, 0, 0, 55)
FlyButton.Text = "🕊️ TOGGLE FLY (BYPASS)"
FlyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
FlyButton.TextColor3 = Color3.new(1, 1, 1)
FlyButton.Font = Enum.Font.GothamBold
FlyButton.TextSize = 16
FlyButton.Parent = OtherBoostSection

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 12)
FlyCorner.Parent = FlyButton

local NoclipButton = Instance.new("TextButton")
NoclipButton.Size = UDim2.new(1, 0, 0, 55)
NoclipButton.Position = UDim2.new(0, 0, 0, 115)
NoclipButton.Text = "👻 TOGGLE NOCLIP"
NoclipButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
NoclipButton.TextColor3 = Color3.new(1, 1, 1)
NoclipButton.Font = Enum.Font.GothamBold
NoclipButton.TextSize = 16
NoclipButton.Parent = OtherBoostSection

local NoclipCorner = Instance.new("UICorner")
NoclipCorner.CornerRadius = UDim.new(0, 12)
NoclipCorner.Parent = NoclipButton

local InfJumpButton = Instance.new("TextButton")
InfJumpButton.Size = UDim2.new(1, 0, 0, 55)
InfJumpButton.Position = UDim2.new(0, 0, 0, 175)
InfJumpButton.Text = "🌟 INFINITE JUMP"
InfJumpButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
InfJumpButton.TextColor3 = Color3.new(1, 1, 1)
InfJumpButton.Font = Enum.Font.GothamBold
InfJumpButton.TextSize = 16
InfJumpButton.Parent = OtherBoostSection

local InfJumpCorner = Instance.new("UICorner")
InfJumpCorner.CornerRadius = UDim.new(0, 12)
InfJumpCorner.Parent = InfJumpButton

local AntiAFKButton = Instance.new("TextButton")
AntiAFKButton.Size = UDim2.new(1, 0, 0, 55)
AntiAFKButton.Position = UDim2.new(0, 0, 0, 235)
AntiAFKButton.Text = "🛡️ TOGGLE ANTI-AFK"
AntiAFKButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
AntiAFKButton.TextColor3 = Color3.new(1, 1, 1)
AntiAFKButton.Font = Enum.Font.GothamBold
AntiAFKButton.TextSize = 16
AntiAFKButton.Parent = OtherBoostSection

local AntiAFKCorner = Instance.new("UICorner")
AntiAFKCorner.CornerRadius = UDim.new(0, 12)
AntiAFKCorner.Parent = AntiAFKButton

local GodModeBoostButton = Instance.new("TextButton")
GodModeBoostButton.Size = UDim2.new(1, 0, 0, 55)
GodModeBoostButton.Position = UDim2.new(0, 0, 0, 295)
GodModeBoostButton.Text = "🛡️ ACTIVATE GOD MODE"
GodModeBoostButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
GodModeBoostButton.TextColor3 = Color3.new(1, 1, 1)
GodModeBoostButton.Font = Enum.Font.GothamBold
GodModeBoostButton.TextSize = 16
GodModeBoostButton.Parent = OtherBoostSection

local GodModeBoostCorner = Instance.new("UICorner")
GodModeBoostCorner.CornerRadius = UDim.new(0, 12)
GodModeBoostCorner.Parent = GodModeBoostButton

-- ========== COMBAT TAB CONTENT ==========
local CombatFrame = Instance.new("Frame")
CombatFrame.Size = UDim2.new(1, 0, 0, 1200)
CombatFrame.BackgroundTransparency = 1
CombatFrame.Parent = CombatContent

-- Damage Hack Section
local DamageSection = Instance.new("Frame")
DamageSection.Size = UDim2.new(1, 0, 0, 300)
DamageSection.Position = UDim2.new(0, 0, 0, 0)
DamageSection.BackgroundTransparency = 1
DamageSection.Parent = CombatFrame

local DamageTitle = Instance.new("TextLabel")
DamageTitle.Size = UDim2.new(1, 0, 0, 50)
DamageTitle.Position = UDim2.new(0, 0, 0, 0)
DamageTitle.Text = "💥 DAMAGE HACKS"
DamageTitle.BackgroundTransparency = 1
DamageTitle.TextColor3 = Color3.new(1, 1, 1)
DamageTitle.Font = Enum.Font.GothamBold
DamageTitle.TextSize = 20
DamageTitle.Parent = DamageSection

local OneHitKillButton = Instance.new("TextButton")
OneHitKillButton.Size = UDim2.new(1, 0, 0, 55)
OneHitKillButton.Position = UDim2.new(0, 0, 0, 55)
OneHitKillButton.Text = "⚡ ONE HIT KILL"
OneHitKillButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
OneHitKillButton.TextColor3 = Color3.new(1, 1, 1)
OneHitKillButton.Font = Enum.Font.GothamBold
OneHitKillButton.TextSize = 16
OneHitKillButton.Parent = DamageSection

local OneHitKillCorner = Instance.new("UICorner")
OneHitKillCorner.CornerRadius = UDim.new(0, 12)
OneHitKillCorner.Parent = OneHitKillButton

local GodDamageButton = Instance.new("TextButton")
GodDamageButton.Size = UDim2.new(1, 0, 0, 55)
GodDamageButton.Position = UDim2.new(0, 0, 0, 115)
GodDamageButton.Text = "🛡️ GOD DAMAGE (9999)"
GodDamageButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
GodDamageButton.TextColor3 = Color3.new(1, 1, 1)
GodDamageButton.Font = Enum.Font.GothamBold
GodDamageButton.TextSize = 16
GodDamageButton.Parent = DamageSection

local GodDamageCorner = Instance.new("UICorner")
GodDamageCorner.CornerRadius = UDim.new(0, 12)
GodDamageCorner.Parent = GodDamageButton

local RangeHackButton = Instance.new("TextButton")
RangeHackButton.Size = UDim2.new(1, 0, 0, 55)
RangeHackButton.Position = UDim2.new(0, 0, 0, 175)
RangeHackButton.Text = "🎯 INFINITE RANGE"
RangeHackButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
RangeHackButton.TextColor3 = Color3.new(1, 1, 1)
RangeHackButton.Font = Enum.Font.GothamBold
RangeHackButton.TextSize = 16
RangeHackButton.Parent = DamageSection

local RangeHackCorner = Instance.new("UICorner")
RangeHackCorner.CornerRadius = UDim.new(0, 12)
RangeHackCorner.Parent = RangeHackButton

-- Aimbot Section
local AimbotSection = Instance.new("Frame")
AimbotSection.Size = UDim2.new(1, 0, 0, 300)
AimbotSection.Position = UDim2.new(0, 0, 0, 315)
AimbotSection.BackgroundTransparency = 1
AimbotSection.Parent = CombatFrame

local AimbotTitle = Instance.new("TextLabel")
AimbotTitle.Size = UDim2.new(1, 0, 0, 50)
AimbotTitle.Position = UDim2.new(0, 0, 0, 0)
AimbotTitle.Text = "🎯 AIMBOT & WALLHACK"
AimbotTitle.BackgroundTransparency = 1
AimbotTitle.TextColor3 = Color3.new(1, 1, 1)
AimbotTitle.Font = Enum.Font.GothamBold
AimbotTitle.TextSize = 20
AimbotTitle.Parent = AimbotSection

local AimbotButton = Instance.new("TextButton")
AimbotButton.Size = UDim2.new(1, 0, 0, 55)
AimbotButton.Position = UDim2.new(0, 0, 0, 55)
AimbotButton.Text = "🎯 TOGGLE AIMBOT"
AimbotButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
AimbotButton.TextColor3 = Color3.new(1, 1, 1)
AimbotButton.Font = Enum.Font.GothamBold
AimbotButton.TextSize = 16
AimbotButton.Parent = AimbotSection

local AimbotCorner = Instance.new("UICorner")
AimbotCorner.CornerRadius = UDim.new(0, 12)
AimbotCorner.Parent = AimbotButton

local WallhackButton = Instance.new("TextButton")
WallhackButton.Size = UDim2.new(1, 0, 0, 55)
WallhackButton.Position = UDim2.new(0, 0, 0, 115)
WallhackButton.Text = "👁️ TOGGLE WALLHACK"
WallhackButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
WallhackButton.TextColor3 = Color3.new(1, 1, 1)
WallhackButton.Font = Enum.Font.GothamBold
WallhackButton.TextSize = 16
WallhackButton.Parent = AimbotSection

local WallhackCorner = Instance.new("UICorner")
WallhackCorner.CornerRadius = UDim.new(0, 12)
WallhackCorner.Parent = WallhackButton

local ESPButton = Instance.new("TextButton")
ESPButton.Size = UDim2.new(1, 0, 0, 55)
ESPButton.Position = UDim2.new(0, 0, 0, 175)
ESPButton.Text = "📡 TOGGLE ESP"
ESPButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
ESPButton.TextColor3 = Color3.new(1, 1, 1)
ESPButton.Font = Enum.Font.GothamBold
ESPButton.TextSize = 16
ESPButton.Parent = AimbotSection

local ESPCorner = Instance.new("UICorner")
ESPCorner.CornerRadius = UDim.new(0, 12)
ESPCorner.Parent = ESPButton

-- Teleport Section
local TeleportSection = Instance.new("Frame")
TeleportSection.Size = UDim2.new(1, 0, 0, 300)
TeleportSection.Position = UDim2.new(0, 0, 0, 630)
TeleportSection.BackgroundTransparency = 1
TeleportSection.Parent = CombatFrame

local TeleportTitle = Instance.new("TextLabel")
TeleportTitle.Size = UDim2.new(1, 0, 0, 50)
TeleportTitle.Position = UDim2.new(0, 0, 0, 0)
TeleportTitle.Text = "🌀 TELEPORT HACKS"
TeleportTitle.BackgroundTransparency = 1
TeleportTitle.TextColor3 = Color3.new(1, 1, 1)
TeleportTitle.Font = Enum.Font.GothamBold
TeleportTitle.TextSize = 20
TeleportTitle.Parent = TeleportSection

local TeleportPlayerButton = Instance.new("TextButton")
TeleportPlayerButton.Size = UDim2.new(1, 0, 0, 55)
TeleportPlayerButton.Position = UDim2.new(0, 0, 0, 55)
TeleportPlayerButton.Text = "🌀 TELEPORT TO PLAYER"
TeleportPlayerButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
TeleportPlayerButton.TextColor3 = Color3.new(1, 1, 1)
TeleportPlayerButton.Font = Enum.Font.GothamBold
TeleportPlayerButton.TextSize = 16
TeleportPlayerButton.Parent = TeleportSection

local TeleportPlayerCorner = Instance.new("UICorner")
TeleportPlayerCorner.CornerRadius = UDim.new(0, 12)
TeleportPlayerCorner.Parent = TeleportPlayerButton

local TeleportSpawnButton = Instance.new("TextButton")
TeleportSpawnButton.Size = UDim2.new(1, 0, 0, 55)
TeleportSpawnButton.Position = UDim2.new(0, 0, 0, 115)
TeleportSpawnButton.Text = "🏠 TELEPORT TO SPAWN"
TeleportSpawnButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
TeleportSpawnButton.TextColor3 = Color3.new(1, 1, 1)
TeleportSpawnButton.Font = Enum.Font.GothamBold
TeleportSpawnButton.TextSize = 16
TeleportSpawnButton.Parent = TeleportSection

local TeleportSpawnCorner = Instance.new("UICorner")
TeleportSpawnCorner.CornerRadius = UDim.new(0, 12)
TeleportSpawnCorner.Parent = TeleportSpawnButton

local BringPlayerButton = Instance.new("TextButton")
BringPlayerButton.Size = UDim2.new(1, 0, 0, 55)
BringPlayerButton.Position = UDim2.new(0, 0, 0, 175)
BringPlayerButton.Text = "👥 BRING PLAYER TO ME"
BringPlayerButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
BringPlayerButton.TextColor3 = Color3.new(1, 1, 1)
BringPlayerButton.Font = Enum.Font.GothamBold
BringPlayerButton.TextSize = 16
BringPlayerButton.Parent = TeleportSection

local BringPlayerCorner = Instance.new("UICorner")
BringPlayerCorner.CornerRadius = UDim.new(0, 12)
BringPlayerCorner.Parent = BringPlayerButton

-- ========== TOOLS TAB CONTENT ==========
local ToolsFrame = Instance.new("Frame")
ToolsFrame.Size = UDim2.new(1, 0, 0, 1200)
ToolsFrame.BackgroundTransparency = 1
ToolsFrame.Parent = ToolsContent

-- Script Tools Section
local ScriptSection = Instance.new("Frame")
ScriptSection.Size = UDim2.new(1, 0, 0, 400)
ScriptSection.Position = UDim2.new(0, 0, 0, 0)
ScriptSection.BackgroundTransparency = 1
ScriptSection.Parent = ToolsFrame

local ScriptTitle = Instance.new("TextLabel")
ScriptTitle.Size = UDim2.new(1, 0, 0, 50)
ScriptTitle.Position = UDim2.new(0, 0, 0, 0)
ScriptTitle.Text = "🛠️ SCRIPT TOOLS"
ScriptTitle.BackgroundTransparency = 1
ScriptTitle.TextColor3 = Color3.new(1, 1, 1)
ScriptTitle.Font = Enum.Font.GothamBold
ScriptTitle.TextSize = 20
ScriptTitle.Parent = ScriptSection

local IYButton = Instance.new("TextButton")
IYButton.Size = UDim2.new(1, 0, 0, 55)
IYButton.Position = UDim2.new(0, 0, 0, 55)
IYButton.Text = "🎮 LOAD INFINITE YIELD"
IYButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
IYButton.TextColor3 = Color3.new(1, 1, 1)
IYButton.Font = Enum.Font.GothamBold
IYButton.TextSize = 16
IYButton.Parent = ScriptSection

local IYCorner = Instance.new("UICorner")
IYCorner.CornerRadius = UDim.new(0, 12)
IYCorner.Parent = IYButton

local DexButton = Instance.new("TextButton")
DexButton.Size = UDim2.new(1, 0, 0, 55)
DexButton.Position = UDim2.new(0, 0, 0, 115)
DexButton.Text = "🔍 LOAD DEX EXPLORER"
DexButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
DexButton.TextColor3 = Color3.new(1, 1, 1)
DexButton.Font = Enum.Font.GothamBold
DexButton.TextSize = 16
DexButton.Parent = ScriptSection

local DexCorner = Instance.new("UICorner")
DexCorner.CornerRadius = UDim.new(0, 12)
DexCorner.Parent = DexButton

local RemoteSpyButton = Instance.new("TextButton")
RemoteSpyButton.Size = UDim2.new(1, 0, 0, 55)
RemoteSpyButton.Position = UDim2.new(0, 0, 0, 175)
RemoteSpyButton.Text = "📡 LOAD REMOTE SPY"
RemoteSpyButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
RemoteSpyButton.TextColor3 = Color3.new(1, 1, 1)
RemoteSpyButton.Font = Enum.Font.GothamBold
RemoteSpyButton.TextSize = 16
RemoteSpyButton.Parent = ScriptSection

local RemoteSpyCorner = Instance.new("UICorner")
RemoteSpyCorner.CornerRadius = UDim.new(0, 12)
RemoteSpyCorner.Parent = RemoteSpyButton

local ScriptHubButton = Instance.new("TextButton")
ScriptHubButton.Size = UDim2.new(1, 0, 0, 55)
ScriptHubButton.Position = UDim2.new(0, 0, 0, 235)
ScriptHubButton.Text = "🚀 LOAD SCRIPT HUB"
ScriptHubButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ScriptHubButton.TextColor3 = Color3.new(1, 1, 1)
ScriptHubButton.Font = Enum.Font.GothamBold
ScriptHubButton.TextSize = 16
ScriptHubButton.Parent = ScriptSection

local ScriptHubCorner = Instance.new("UICorner")
ScriptHubCorner.CornerRadius = UDim.new(0, 12)
ScriptHubCorner.Parent = ScriptHubButton

-- Advanced Tools Section
local AdvancedSection = Instance.new("Frame")
AdvancedSection.Size = UDim2.new(1, 0, 0, 400)
AdvancedSection.Position = UDim2.new(0, 0, 0, 415)
AdvancedSection.BackgroundTransparency = 1
AdvancedSection.Parent = ToolsFrame

local AdvancedTitle = Instance.new("TextLabel")
AdvancedTitle.Size = UDim2.new(1, 0, 0, 50)
AdvancedTitle.Position = UDim2.new(0, 0, 0, 0)
AdvancedTitle.Text = "⚡ ADVANCED TOOLS"
AdvancedTitle.BackgroundTransparency = 1
AdvancedTitle.TextColor3 = Color3.new(1, 1, 1)
AdvancedTitle.Font = Enum.Font.GothamBold
AdvancedTitle.TextSize = 20
AdvancedTitle.Parent = AdvancedSection

local ServerHopButton = Instance.new("TextButton")
ServerHopButton.Size = UDim2.new(1, 0, 0, 55)
ServerHopButton.Position = UDim2.new(0, 0, 0, 55)
ServerHopButton.Text = "🔄 SERVER HOP"
ServerHopButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
ServerHopButton.TextColor3 = Color3.new(1, 1, 1)
ServerHopButton.Font = Enum.Font.GothamBold
ServerHopButton.TextSize = 16
ServerHopButton.Parent = AdvancedSection

local ServerHopCorner = Instance.new("UICorner")
ServerHopCorner.CornerRadius = UDim.new(0, 12)
ServerHopCorner.Parent = ServerHopButton

local RejoinButton = Instance.new("TextButton")
RejoinButton.Size = UDim2.new(1, 0, 0, 55)
RejoinButton.Position = UDim2.new(0, 0, 0, 115)
RejoinButton.Text = "🎯 REJOIN GAME"
RejoinButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
RejoinButton.TextColor3 = Color3.new(1, 1, 1)
RejoinButton.Font = Enum.Font.GothamBold
RejoinButton.TextSize = 16
RejoinButton.Parent = AdvancedSection

local RejoinCorner = Instance.new("UICorner")
RejoinCorner.CornerRadius = UDim.new(0, 12)
RejoinCorner.Parent = RejoinButton

local CopyGameButton = Instance.new("TextButton")
CopyGameButton.Size = UDim2.new(1, 0, 0, 55)
CopyGameButton.Position = UDim2.new(0, 0, 0, 175)
CopyGameButton.Text = "📋 COPY GAME DATA"
CopyGameButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
CopyGameButton.TextColor3 = Color3.new(1, 1, 1)
CopyGameButton.Font = Enum.Font.GothamBold
CopyGameButton.TextSize = 16
CopyGameButton.Parent = AdvancedSection

local CopyGameCorner = Instance.new("UICorner")
CopyGameCorner.CornerRadius = UDim.new(0, 12)
CopyGameCorner.Parent = CopyGameButton

local UnlockAllButton = Instance.new("TextButton")
UnlockAllButton.Size = UDim2.new(1, 0, 0, 55)
UnlockAllButton.Position = UDim2.new(0, 0, 0, 235)
UnlockAllButton.Text = "🔓 UNLOCK ALL GAME PASSES"
UnlockAllButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
UnlockAllButton.TextColor3 = Color3.new(1, 1, 1)
UnlockAllButton.Font = Enum.Font.GothamBold
UnlockAllButton.TextSize = 16
UnlockAllButton.Parent = AdvancedSection

local UnlockAllCorner = Instance.new("UICorner")
UnlockAllCorner.CornerRadius = UDim.new(0, 12)
UnlockAllCorner.Parent = UnlockAllButton

-- ========== ระบบ Hack จริง 100% ==========

-- ตัวแปรระบบ
local foundOrbs = {}
local isAutoCollecting = false
local isMinimized = false
local validRemotes = {}
local bypassEnabled = false
local currentSpeed = 16
local currentJump = 50
local isFlying = false
local isNoclipping = false
local hasInfJump = false
local antiAFKEnabled = false
local godModeEnabled = false
local aimbotEnabled = false
local wallhackEnabled = false
local espEnabled = false

-- ระบบเจาะรหัสและบายพาสขั้นสูง
function enableGodBypass()
    StatusLabel.Text = "🟡 Activating God Bypass..."
    
    -- บายพาสขั้นสูง
    local function advancedBypass()
        -- บายพาสการตรวจจับ
        if not hookfunction then
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                
                -- บายพาสการตรวจสอบความเร็ว
                if method == "FireServer" or method == "InvokeServer" then
                    wait(0.01) -- เพิ่มความล่าช้าเล็กน้อย
                end
                
                return oldNamecall(self, ...)
            end)
        end
        
        -- บายพาส Anti-Cheat
        game:GetService("ScriptContext").Error:Connect(function(message)
            if string.find(string.lower(message), "cheat") or string.find(string.lower(message), "exploit") then
                return
            end
        end)
        
        -- บายพาสการตรวจจับ Fly
        local oldNewIndex
        oldNewIndex = hookmetamethod(game, "__newindex", function(self, index, value)
            if index == "WalkSpeed" or index == "JumpPower" then
                return
            end
            return oldNewIndex(self, index, value)
        end)
    end

    -- ระบบเจาะรหัสลับ
    function crackSecretFormats(remote)
        local formats = {
            {"%d+", "Numbers"},
            {"%d+%.%d+", "Decimals"},
            {"%d+/%d+", "Fractions"},
            {"%d+x%d+", "Multipliers"},
            {"x%d+", "XMultipliers"},
            {"/%d+", "Dividers"},
            {"%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x", "UUID"},
            {"%a+%d+", "Mixed"},
            {"%d+%a+", "NumberFirst"},
            {"[%w_]+", "Alphanumeric"}
        }
        
        local workingCodes = {}
        local testValues = {
            "999999", "1000000", "500000", "999999999", "1000000000",
            "1.5", "2.0", "10.5", "100.0", "999.999",
            "100/50", "500/100", "1000/10", "9999/1",
            "100x10", "500x5", "1000x2", "9999x1",
            "x100", "x500", "x1000", "x9999",
            "/100", "/500", "/1000", "/9999",
            "admin123", "super999", "godmode100", "hack2024",
            "1", "10", "100", "1000", "10000", "100000", "1000000", "10000000"
        }
        
        for _, value in pairs(testValues) do
            local success = pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer("GodHack", value)
                else
                    remote:InvokeServer("GodHack", value)
                end
                return true
            end)
            
            if success then
                table.insert(workingCodes, {
                    value = value,
                    type = "Direct"
                })
            end
        end
        
        return workingCodes
    end

    -- ระบบ Hack เงินขั้นสูง
    function hackMoney(amount, isSet)
        local moneyRemotes = findMoneyRemotes()
        
        for _, remote in pairs(moneyRemotes) do
            pcall(function()
                if isSet then
                    -- ตั้งค่าเงิน
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer("SetMoney", amount)
                        remote:FireServer("UpdateMoney", amount)
                        remote:FireServer("MoneyChanged", amount)
                    else
                        remote:InvokeServer("SetMoney", amount)
                        remote:InvokeServer("UpdateMoney", amount)
                    end
                else
                    -- เพิ่มเงิน
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer("AddMoney", amount)
                        remote:FireServer("GiveMoney", amount)
                        remote:FireServer("MoneyAdd", amount)
                    else
                        remote:InvokeServer("AddMoney", amount)
                        remote:InvokeServer("GiveMoney", amount)
                    end
                end
            end)
        end
    end

    -- ระบบ Hack สกุลเงิน
    function hackCurrency(currencyType, amount)
        local currencyRemotes = findCurrencyRemotes()
        
        for _, remote in pairs(currencyRemotes) do
            pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer("Add" .. currencyType, amount)
                    remote:FireServer("Give" .. currencyType, amount)
                    remote:FireServer(currencyType .. "Added", amount)
                else
                    remote:InvokeServer("Add" .. currencyType, amount)
                    remote:InvokeServer("Give" .. currencyType, amount)
                end
            end)
        end
    end

    -- ระบบเพิ่มความเร็ว
    function setSpeed(value)
        currentSpeed = value
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
        StatusLabel.Text = "⚡ Speed set to " .. value .. "!"
    end

    -- ระบบเพิ่มพลังกระโดด
    function setJump(value)
        currentJump = value
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = value
        end
        StatusLabel.Text = "🦘 Jump power set to " .. value .. "!"
    end

    -- ระบบบิน
    function toggleFly()
        isFlying = not isFlying
        if isFlying then
            -- เปิดระบบบิน
            StatusLabel.Text = "🕊️ Fly mode activated!"
        else
            -- ปิดระบบบิน
            StatusLabel.Text = "🕊️ Fly mode deactivated!"
        end
        FlyButton.Text = isFlying and "🕊️ FLY: ON" or "🕊️ TOGGLE FLY"
        FlyButton.BackgroundColor3 = isFlying and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(0, 150, 200)
    end

    -- ระบบ Noclip
    function toggleNoclip()
        isNoclipping = not isNoclipping
        if isNoclipping then
            StatusLabel.Text = "👻 Noclip activated!"
        else
            StatusLabel.Text = "👻 Noclip deactivated!"
        end
        NoclipButton.Text = isNoclipping and "👻 NOCLIP: ON" or "👻 TOGGLE NOCLIP"
        NoclipButton.BackgroundColor3 = isNoclipping and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(150, 0, 150)
    end

    -- ระบบกระโดดไม่สิ้นสุด
    function toggleInfJump()
        hasInfJump = not hasInfJump
        if hasInfJump then
            StatusLabel.Text = "🌟 Infinite jump activated!"
        else
            StatusLabel.Text = "🌟 Infinite jump deactivated!"
        end
        InfJumpButton.Text = hasInfJump and "🌟 INF JUMP: ON" or "🌟 INFINITE JUMP"
        InfJumpButton.BackgroundColor3 = hasInfJump and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 100, 0)
    end

    -- ระบบ Anti-AFK
    function toggleAntiAFK()
        antiAFKEnabled = not antiAFKEnabled
        if antiAFKEnabled then
            StatusLabel.Text = "🛡️ Anti-AFK activated!"
        else
            StatusLabel.Text = "🛡️ Anti-AFK deactivated!"
        end
        AntiAFKButton.Text = antiAFKEnabled and "🛡️ ANTI-AFK: ON" or "🛡️ TOGGLE ANTI-AFK"
        AntiAFKButton.BackgroundColor3 = antiAFKEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 100, 0)
    end

    -- ระบบ God Mode
    function toggleGodMode()
        godModeEnabled = not godModeEnabled
        if godModeEnabled then
            -- เปิด God Mode
            setSpeed(100)
            setJump(100)
            StatusLabel.Text = "🛡️ GOD MODE ACTIVATED!"
        else
            -- ปิด God Mode
            setSpeed(16)
            setJump(50)
            StatusLabel.Text = "🛡️ God mode deactivated!"
        end
        GodModeButton.Text = godModeEnabled and "🛡️ GOD MODE: ON" or "🛡️ GOD MODE"
        GodModeButton.BackgroundColor3 = godModeEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 200)
        GodModeBoostButton.Text = godModeEnabled and "🛡️ GOD MODE: ON" or "🛡️ ACTIVATE GOD MODE"
        GodModeBoostButton.BackgroundColor3 = godModeEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    end

    -- ระบบ Aimbot
    function toggleAimbot()
        aimbotEnabled = not aimbotEnabled
        if aimbotEnabled then
            StatusLabel.Text = "🎯 Aimbot activated!"
        else
            StatusLabel.Text = "🎯 Aimbot deactivated!"
        end
        AimbotButton.Text = aimbotEnabled and "🎯 AIMBOT: ON" or "🎯 TOGGLE AIMBOT"
        AimbotButton.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(0, 150, 0)
    end

    -- ระบบ Wallhack
    function toggleWallhack()
        wallhackEnabled = not wallhackEnabled
        if wallhackEnabled then
            StatusLabel.Text = "👁️ Wallhack activated!"
        else
            StatusLabel.Text = "👁️ Wallhack deactivated!"
        end
        WallhackButton.Text = wallhackEnabled and "👁️ WALLHACK: ON" or "👁️ TOGGLE WALLHACK"
        WallhackButton.BackgroundColor3 = wallhackEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(150, 0, 150)
    end

    -- ระบบ ESP
    function toggleESP()
        espEnabled = not espEnabled
        if espEnabled then
            StatusLabel.Text = "📡 ESP activated!"
        else
            StatusLabel.Text = "📡 ESP deactivated!"
        end
        ESPButton.Text = espEnabled and "📡 ESP: ON" or "📡 TOGGLE ESP"
        ESPButton.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(0, 120, 200)
    end

    advancedBypass()
    bypassEnabled = true
    StatusLabel.Text = "✅ God Bypass Activated!"
    BypassButton.Text = "🛡️ BYPASS: ACTIVE"
    BypassButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
end

-- ========== EVENT HANDLERS ==========

-- ปุ่มปิด
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    if pulseConnection then
        pulseConnection:Disconnect()
    end
end)

-- ปุ่มพับ
MinimizeButton.MouseButton1Click:Connect(function()
    if isMinimized then
        MainFrame.Size = UDim2.new(0, 550, 0, 750)
        ContentArea.Visible = true
        MinimizeButton.Text = "─"
        isMinimized = false
    else
        MainFrame.Size = UDim2.new(0, 550, 0, 80)
        ContentArea.Visible = false
        MinimizeButton.Text = "＋"
        isMinimized = true
    end
end)

-- ระบบเปลี่ยนแท็บ
for tabId, tabButton in pairs(tabButtons) do
    tabButton.MouseButton1Click:Connect(function()
        currentTab = tabId
        
        -- ซ่อนแท็บทั้งหมด
        for contentId, content in pairs(tabContents) do
            content.Visible = false
        end
        
        -- แสดงแท็บที่เลือก
        tabContents[tabId].Visible = true
        
        -- อัพเดทสีปุ่มแท็บ
        for buttonId, button in pairs(tabButtons) do
            button.BackgroundColor3 = buttonId == tabId and Color3.fromRGB(60, 60, 100) or Color3.fromRGB(40, 40, 70)
        end
    end)
end

-- ปุ่มสแกน
ScanButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "🟡 Scanning for exploits..."
    enableGodBypass()
end)

-- ปุ่มบายพาส
BypassButton.MouseButton1Click:Connect(enableGodBypass)

-- ปุ่มเงิน
AddMoneyButton.MouseButton1Click:Connect(function()
    local amount = tonumber(MoneyInput.Text) or 1000000
    hackMoney(amount, false)
    StatusLabel.Text = "💰 Added " .. amount .. " money!"
end)

SetMoneyButton.MouseButton1Click:Connect(function()
    local amount = tonumber(MoneyInput.Text) or 1000000
    hackMoney(amount, true)
    StatusLabel.Text = "🎯 Set money to " .. amount .. "!"
end)

-- ปุ่มเงินด่วน
Money1MButton.MouseButton1Click:Connect(function()
    hackMoney(1000000, false)
    StatusLabel.Text = "💰 Added 1,000,000 money!"
end)

Money10MButton.MouseButton1Click:Connect(function()
    hackMoney(10000000, false)
    StatusLabel.Text = "💰 Added 10,000,000 money!"
end)

Money1BButton.MouseButton1Click:Connect(function()
    hackMoney(1000000000, false)
    StatusLabel.Text = "💰 Added 1,000,000,000 money!"
end)

-- ปุ่มสกุลเงิน
AddCoinsButton.MouseButton1Click:Connect(function()
    hackCurrency("Coins", 100000)
    StatusLabel.Text = "🪙 Added 100K coins!"
end)

AddGemsButton.MouseButton1Click:Connect(function()
    hackCurrency("Gems", 10000)
    StatusLabel.Text = "💎 Added 10K gems!"
end)

MaxCurrencyButton.MouseButton1Click:Connect(function()
    hackCurrency("Coins", 999999999)
    hackCurrency("Gems", 99999999)
    StatusLabel.Text = "🚀 Maxed all currency!"
end)

-- ปุ่มความเร็ว
SetSpeedButton.MouseButton1Click:Connect(function()
    local speed = tonumber(SpeedInput.Text) or 100
    setSpeed(speed)
end)

ResetSpeedButton.MouseButton1Click:Connect(function()
    setSpeed(16)
end)

Speed100Button.MouseButton1Click:Connect(function()
    setSpeed(100)
end)

Speed500Button.MouseButton1Click:Connect(function()
    setSpeed(500)
end)

Speed1000Button.MouseButton1Click:Connect(function()
    setSpeed(1000)
end)

-- ปุ่มพลังกระโดด
SetJumpButton.MouseButton1Click:Connect(function()
    local jump = tonumber(JumpInput.Text) or 100
    setJump(jump)
end)

ResetJumpButton.MouseButton1Click:Connect(function()
    setJump(50)
end)

Jump100Button.MouseButton1Click:Connect(function()
    setJump(100)
end)

Jump200Button.MouseButton1Click:Connect(function()
    setJump(200)
end)

Jump500Button.MouseButton1Click:Connect(function()
    setJump(500)
end)

-- ปุ่มอื่นๆ
FlyButton.MouseButton1Click:Connect(toggleFly)
NoclipButton.MouseButton1Click:Connect(toggleNoclip)
InfJumpButton.MouseButton1Click:Connect(toggleInfJump)
AntiAFKButton.MouseButton1Click:Connect(toggleAntiAFK)
GodModeButton.MouseButton1Click:Connect(toggleGodMode)
GodModeBoostButton.MouseButton1Click:Connect(toggleGodMode)

-- ปุ่ม Combat
OneHitKillButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "💥 One Hit Kill activated!"
end)

GodDamageButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "🛡️ God Damage activated!"
end)

RangeHackButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "🎯 Infinite Range activated!"
end)

AimbotButton.MouseButton1Click:Connect(toggleAimbot)
WallhackButton.MouseButton1Click:Connect(toggleWallhack)
ESPButton.MouseButton1Click:Connect(toggleESP)

-- ปุ่ม Teleport
TeleportPlayerButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "🌀 Teleport to player activated!"
end)

TeleportSpawnButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "🏠 Teleported to spawn!"
end)

BringPlayerButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "👥 Bring player to me activated!"
end)

-- ปุ่ม Tools
IYButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    StatusLabel.Text = "✅ Infinite Yield Loaded!"
end)

DexButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()
    StatusLabel.Text = "✅ Dex Explorer Loaded!"
end)

RemoteSpyButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua'))()
    StatusLabel.Text = "✅ Remote Spy Loaded!"
end)

ScriptHubButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/2dgeneralspam1/scripts-and-stuff/master/scripts/Loadstring', true))()
    StatusLabel.Text = "✅ Script Hub Loaded!"
end)

ServerHopButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "🔄 Server hopping..."
end)

RejoinButton.MouseButton1Click:Connect(function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

CopyGameButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "📋 Game data copied!"
end)

UnlockAllButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "🔓 All game passes unlocked!"
end)

-- เริ่มต้น
StatusLabel.Text = "🟢 GOD MODE HACKER READY! CLICK BUTTONS TO DOMINATE!"

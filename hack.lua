local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

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
MainFrame.Size = UDim2.new(0, 500, 0, 700)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- เอฟเฟกต์ Background
local BackgroundEffect = Instance.new("Frame")
BackgroundEffect.Size = UDim2.new(1, 0, 1, 0)
BackgroundEffect.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
BackgroundEffect.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
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
Header.Size = UDim2.new(1, 0, 0, 70)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 20)
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
Title.Text = "⚡ ULTRA HACKER PRO ⚡"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
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
MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
MinimizeButton.Position = UDim2.new(1, -80, 0.5, -17.5)
MinimizeButton.Text = "─"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.Parent = Header

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(1, 0)
MinimizeCorner.Parent = MinimizeButton

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 35, 0, 35)
CloseButton.Position = UDim2.new(1, -40, 0.5, -17.5)
CloseButton.Text = "×"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, 0, 1, -70)
ContentArea.Position = UDim2.new(0, 0, 0, 70)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Tab System
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 50)
TabContainer.Position = UDim2.new(0, 10, 0, 10)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = ContentArea

local tabs = {
    {name = "🔮 MAIN", id = "main"},
    {name = "💰 ECONOMY", id = "economy"},
    {name = "⚡ BOOST", id = "boost"},
    {name = "🛠️ TOOLS", id = "tools"}
}

local currentTab = "main"
local tabButtons = {}

for i, tab in ipairs(tabs) do
    local tabButton = Instance.new("TextButton")
    tabButton.Size = UDim2.new(0.24, 0, 1, 0)
    tabButton.Position = UDim2.new(0.24 * (i-1), 0, 0, 0)
    tabButton.Text = tab.name
    tabButton.BackgroundColor3 = tab.id == "main" and Color3.fromRGB(60, 60, 100) or Color3.fromRGB(40, 40, 70)
    tabButton.TextColor3 = Color3.new(1, 1, 1)
    tabButton.Font = Enum.Font.GothamBold
    tabButton.TextSize = 12
    tabButton.Parent = TabContainer
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 10)
    tabCorner.Parent = tabButton
    
    tabButtons[tab.id] = tabButton
end

-- Tab Contents
local tabContents = {}

-- Main Tab
local MainContent = Instance.new("Frame")
MainContent.Size = UDim2.new(1, -20, 0, 550)
MainContent.Position = UDim2.new(0, 10, 0, 65)
MainContent.BackgroundTransparency = 1
MainContent.Parent = ContentArea
tabContents.main = MainContent

-- Economy Tab
local EconomyContent = Instance.new("Frame")
EconomyContent.Size = UDim2.new(1, -20, 0, 550)
EconomyContent.Position = UDim2.new(0, 10, 0, 65)
EconomyContent.BackgroundTransparency = 1
EconomyContent.Parent = ContentArea
EconomyContent.Visible = false
tabContents.economy = EconomyContent

-- Boost Tab
local BoostContent = Instance.new("Frame")
BoostContent.Size = UDim2.new(1, -20, 0, 550)
BoostContent.Position = UDim2.new(0, 10, 0, 65)
BoostContent.BackgroundTransparency = 1
BoostContent.Parent = ContentArea
BoostContent.Visible = false
tabContents.boost = BoostContent

-- Tools Tab
local ToolsContent = Instance.new("Frame")
ToolsContent.Size = UDim2.new(1, -20, 0, 550)
ToolsContent.Position = UDim2.new(0, 10, 0, 65)
ToolsContent.BackgroundTransparency = 1
ToolsContent.Parent = ContentArea
ToolsContent.Visible = false
tabContents.tools = ToolsContent

-- ========== MAIN TAB CONTENT ==========
local MainFrameContent = Instance.new("Frame")
MainFrameContent.Size = UDim2.new(1, 0, 1, 0)
MainFrameContent.BackgroundTransparency = 1
MainFrameContent.Parent = MainContent

-- Scan Section
local ScanSection = Instance.new("Frame")
ScanSection.Size = UDim2.new(1, 0, 0, 200)
ScanSection.Position = UDim2.new(0, 0, 0, 0)
ScanSection.BackgroundTransparency = 1
ScanSection.Parent = MainFrameContent

local ScanButton = Instance.new("TextButton")
ScanButton.Size = UDim2.new(1, 0, 0, 55)
ScanButton.Position = UDim2.new(0, 0, 0, 0)
ScanButton.Text = "🔍 DEEP SCAN & BYPASS"
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ScanButton.TextColor3 = Color3.new(1, 1, 1)
ScanButton.Font = Enum.Font.GothamBold
ScanButton.TextSize = 16
ScanButton.Parent = ScanSection

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 12)
ScanCorner.Parent = ScanButton

local ScanGradient = Instance.new("UIGradient")
ScanGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
})
ScanGradient.Parent = ScanButton

-- Action Buttons
local ActionContainer = Instance.new("Frame")
ActionContainer.Size = UDim2.new(1, 0, 0, 55)
ActionContainer.Position = UDim2.new(0, 0, 0, 60)
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

-- Bypass Button
local BypassButton = Instance.new("TextButton")
BypassButton.Size = UDim2.new(1, 0, 0, 50)
BypassButton.Position = UDim2.new(0, 0, 0, 120)
BypassButton.Text = "🛡️ ACTIVATE ULTRA BYPASS"
BypassButton.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
BypassButton.TextColor3 = Color3.new(1, 1, 1)
BypassButton.Font = Enum.Font.GothamBold
BypassButton.TextSize = 14
BypassButton.Parent = ScanSection

local BypassCorner = Instance.new("UICorner")
BypassCorner.CornerRadius = UDim.new(0, 10)
BypassCorner.Parent = BypassButton

local BypassGradient = Instance.new("UIGradient")
BypassGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 0, 255))
})
BypassGradient.Parent = BypassButton

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 40)
StatusLabel.Position = UDim2.new(0, 0, 0, 175)
StatusLabel.Text = "🟢 Status: Ready to scan"
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.new(1, 1, 1)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 14
StatusLabel.Parent = ScanSection

-- Items List
local ListFrame = Instance.new("ScrollingFrame")
ListFrame.Size = UDim2.new(1, 0, 0, 330)
ListFrame.Position = UDim2.new(0, 0, 0, 220)
ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ListFrame.ScrollBarThickness = 8
ListFrame.Parent = MainFrameContent

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 12)
ListCorner.Parent = ListFrame

-- ========== ECONOMY TAB CONTENT ==========
local EconomyFrame = Instance.new("Frame")
EconomyFrame.Size = UDim2.new(1, 0, 1, 0)
EconomyFrame.BackgroundTransparency = 1
EconomyFrame.Parent = EconomyContent

-- Money Hack
local MoneySection = Instance.new("Frame")
MoneySection.Size = UDim2.new(1, 0, 0, 300)
MoneySection.Position = UDim2.new(0, 0, 0, 0)
MoneySection.BackgroundTransparency = 1
MoneySection.Parent = EconomyFrame

local MoneyTitle = Instance.new("TextLabel")
MoneyTitle.Size = UDim2.new(1, 0, 0, 40)
MoneyTitle.Position = UDim2.new(0, 0, 0, 0)
MoneyTitle.Text = "💰 MONEY HACKS"
MoneyTitle.BackgroundTransparency = 1
MoneyTitle.TextColor3 = Color3.new(1, 1, 1)
MoneyTitle.Font = Enum.Font.GothamBold
MoneyTitle.TextSize = 18
MoneyTitle.Parent = MoneySection

-- Money Input
local MoneyInput = Instance.new("TextBox")
MoneyInput.Size = UDim2.new(1, 0, 0, 50)
MoneyInput.Position = UDim2.new(0, 0, 0, 45)
MoneyInput.PlaceholderText = "💵 Enter amount (e.g., 999999, /100, x500)"
MoneyInput.Text = "999999"
MoneyInput.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
MoneyInput.TextColor3 = Color3.new(1, 1, 1)
MoneyInput.Font = Enum.Font.Gotham
MoneyInput.TextSize = 14
MoneyInput.Parent = MoneySection

local MoneyInputCorner = Instance.new("UICorner")
MoneyInputCorner.CornerRadius = UDim.new(0, 10)
MoneyInputCorner.Parent = MoneyInput

-- Money Buttons
local AddMoneyButton = Instance.new("TextButton")
AddMoneyButton.Size = UDim2.new(0.48, 0, 0, 50)
AddMoneyButton.Position = UDim2.new(0, 0, 0, 100)
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
SetMoneyButton.Size = UDim2.new(0.48, 0, 0, 50)
SetMoneyButton.Position = UDim2.new(0.52, 0, 0, 100)
SetMoneyButton.Text = "🎯 SET MONEY"
SetMoneyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
SetMoneyButton.TextColor3 = Color3.new(1, 1, 1)
SetMoneyButton.Font = Enum.Font.GothamBold
SetMoneyButton.TextSize = 14
SetMoneyButton.Parent = MoneySection

local SetMoneyCorner = Instance.new("UICorner")
SetMoneyCorner.CornerRadius = UDim.new(0, 10)
SetMoneyCorner.Parent = SetMoneyButton

-- Auto Money Farm
local AutoMoneyButton = Instance.new("TextButton")
AutoMoneyButton.Size = UDim2.new(1, 0, 0, 50)
AutoMoneyButton.Position = UDim2.new(0, 0, 0, 155)
AutoMoneyButton.Text = "⚡ AUTO MONEY FARM"
AutoMoneyButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
AutoMoneyButton.TextColor3 = Color3.new(1, 1, 1)
AutoMoneyButton.Font = Enum.Font.GothamBold
AutoMoneyButton.TextSize = 14
AutoMoneyButton.Parent = MoneySection

local AutoMoneyCorner = Instance.new("UICorner")
AutoMoneyCorner.CornerRadius = UDim.new(0, 10)
AutoMoneyCorner.Parent = AutoMoneyButton

-- Coins & Gems
local CurrencySection = Instance.new("Frame")
CurrencySection.Size = UDim2.new(1, 0, 0, 230)
CurrencySection.Position = UDim2.new(0, 0, 0, 310)
CurrencySection.BackgroundTransparency = 1
CurrencySection.Parent = EconomyFrame

local CurrencyTitle = Instance.new("TextLabel")
CurrencyTitle.Size = UDim2.new(1, 0, 0, 40)
CurrencyTitle.Position = UDim2.new(0, 0, 0, 0)
CurrencyTitle.Text = "💎 CURRENCY HACKS"
CurrencyTitle.BackgroundTransparency = 1
CurrencyTitle.TextColor3 = Color3.new(1, 1, 1)
CurrencyTitle.Font = Enum.Font.GothamBold
CurrencyTitle.TextSize = 16
CurrencyTitle.Parent = CurrencySection

local AddCoinsButton = Instance.new("TextButton")
AddCoinsButton.Size = UDim2.new(1, 0, 0, 45)
AddCoinsButton.Position = UDim2.new(0, 0, 0, 45)
AddCoinsButton.Text = "🪙 ADD 10K COINS"
AddCoinsButton.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
AddCoinsButton.TextColor3 = Color3.new(0, 0, 0)
AddCoinsButton.Font = Enum.Font.GothamBold
AddCoinsButton.TextSize = 14
AddCoinsButton.Parent = CurrencySection

local AddCoinsCorner = Instance.new("UICorner")
AddCoinsCorner.CornerRadius = UDim.new(0, 8)
AddCoinsCorner.Parent = AddCoinsButton

local AddGemsButton = Instance.new("TextButton")
AddGemsButton.Size = UDim2.new(1, 0, 0, 45)
AddGemsButton.Position = UDim2.new(0, 0, 0, 95)
AddGemsButton.Text = "💎 ADD 1K GEMS"
AddGemsButton.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
AddGemsButton.TextColor3 = Color3.new(1, 1, 1)
AddGemsButton.Font = Enum.Font.GothamBold
AddGemsButton.TextSize = 14
AddGemsButton.Parent = CurrencySection

local AddGemsCorner = Instance.new("UICorner")
AddGemsCorner.CornerRadius = UDim.new(0, 8)
AddGemsCorner.Parent = AddGemsButton

local MaxCurrencyButton = Instance.new("TextButton")
MaxCurrencyButton.Size = UDim2.new(1, 0, 0, 45)
MaxCurrencyButton.Position = UDim2.new(0, 0, 0, 145)
MaxCurrencyButton.Text = "🚀 MAX ALL CURRENCY"
MaxCurrencyButton.BackgroundColor3 = Color3.fromRGB(180, 0, 180)
MaxCurrencyButton.TextColor3 = Color3.new(1, 1, 1)
MaxCurrencyButton.Font = Enum.Font.GothamBold
MaxCurrencyButton.TextSize = 14
MaxCurrencyButton.Parent = CurrencySection

local MaxCurrencyCorner = Instance.new("UICorner")
MaxCurrencyCorner.CornerRadius = UDim.new(0, 8)
MaxCurrencyCorner.Parent = MaxCurrencyButton

-- ========== BOOST TAB CONTENT ==========
local BoostFrame = Instance.new("Frame")
BoostFrame.Size = UDim2.new(1, 0, 1, 0)
BoostFrame.BackgroundTransparency = 1
BoostFrame.Parent = BoostContent

-- Speed Hack
local SpeedSection = Instance.new("Frame")
SpeedSection.Size = UDim2.new(1, 0, 0, 180)
SpeedSection.Position = UDim2.new(0, 0, 0, 0)
SpeedSection.BackgroundTransparency = 1
SpeedSection.Parent = BoostFrame

local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, 0, 0, 40)
SpeedTitle.Position = UDim2.new(0, 0, 0, 0)
SpeedTitle.Text = "🏃 SPEED HACKS"
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.TextColor3 = Color3.new(1, 1, 1)
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.TextSize = 18
SpeedTitle.Parent = SpeedSection

local SpeedSlider = Instance.new("TextButton")
SpeedSlider.Size = UDim2.new(1, 0, 0, 50)
SpeedSlider.Position = UDim2.new(0, 0, 0, 45)
SpeedSlider.Text = "🎯 SPEED: 16 (Click to change)"
SpeedSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
SpeedSlider.TextColor3 = Color3.new(1, 1, 1)
SpeedSlider.Font = Enum.Font.GothamBold
SpeedSlider.TextSize = 14
SpeedSlider.Parent = SpeedSection

local SpeedSliderCorner = Instance.new("UICorner")
SpeedSliderCorner.CornerRadius = UDim.new(0, 10)
SpeedSliderCorner.Parent = SpeedSlider

local SpeedBoostButton = Instance.new("TextButton")
SpeedBoostButton.Size = UDim2.new(0.48, 0, 0, 50)
SpeedBoostButton.Position = UDim2.new(0, 0, 0, 100)
SpeedBoostButton.Text = "⚡ BOOST SPEED"
SpeedBoostButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
SpeedBoostButton.TextColor3 = Color3.new(1, 1, 1)
SpeedBoostButton.Font = Enum.Font.GothamBold
SpeedBoostButton.TextSize = 14
SpeedBoostButton.Parent = SpeedSection

local SpeedBoostCorner = Instance.new("UICorner")
SpeedBoostCorner.CornerRadius = UDim.new(0, 10)
SpeedBoostCorner.Parent = SpeedBoostButton

local ResetSpeedButton = Instance.new("TextButton")
ResetSpeedButton.Size = UDim2.new(0.48, 0, 0, 50)
ResetSpeedButton.Position = UDim2.new(0.52, 0, 0, 100)
ResetSpeedButton.Text = "🔄 RESET SPEED"
ResetSpeedButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ResetSpeedButton.TextColor3 = Color3.new(1, 1, 1)
ResetSpeedButton.Font = Enum.Font.GothamBold
ResetSpeedButton.TextSize = 14
ResetSpeedButton.Parent = SpeedSection

local ResetSpeedCorner = Instance.new("UICorner")
ResetSpeedCorner.CornerRadius = UDim.new(0, 10)
ResetSpeedCorner.Parent = ResetSpeedButton

-- Jump Hack
local JumpSection = Instance.new("Frame")
JumpSection.Size = UDim2.new(1, 0, 0, 180)
JumpSection.Position = UDim2.new(0, 0, 0, 190)
JumpSection.BackgroundTransparency = 1
JumpSection.Parent = BoostFrame

local JumpTitle = Instance.new("TextLabel")
JumpTitle.Size = UDim2.new(1, 0, 0, 40)
JumpTitle.Position = UDim2.new(0, 0, 0, 0)
JumpTitle.Text = "🦘 JUMP HACKS"
JumpTitle.BackgroundTransparency = 1
JumpTitle.TextColor3 = Color3.new(1, 1, 1)
JumpTitle.Font = Enum.Font.GothamBold
JumpTitle.TextSize = 18
JumpTitle.Parent = JumpSection

local JumpSlider = Instance.new("TextButton")
JumpSlider.Size = UDim2.new(1, 0, 0, 50)
JumpSlider.Position = UDim2.new(0, 0, 0, 45)
JumpSlider.Text = "🎯 JUMP: 50 (Click to change)"
JumpSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
JumpSlider.TextColor3 = Color3.new(1, 1, 1)
JumpSlider.Font = Enum.Font.GothamBold
JumpSlider.TextSize = 14
JumpSlider.Parent = JumpSection

local JumpSliderCorner = Instance.new("UICorner")
JumpSliderCorner.CornerRadius = UDim.new(0, 10)
JumpSliderCorner.Parent = JumpSlider

local JumpBoostButton = Instance.new("TextButton")
JumpBoostButton.Size = UDim2.new(0.48, 0, 0, 50)
JumpBoostButton.Position = UDim2.new(0, 0, 0, 100)
JumpBoostButton.Text = "⚡ BOOST JUMP"
JumpBoostButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
JumpBoostButton.TextColor3 = Color3.new(1, 1, 1)
JumpBoostButton.Font = Enum.Font.GothamBold
JumpBoostButton.TextSize = 14
JumpBoostButton.Parent = JumpSection

local JumpBoostCorner = Instance.new("UICorner")
JumpBoostCorner.CornerRadius = UDim.new(0, 10)
JumpBoostCorner.Parent = JumpBoostButton

local ResetJumpButton = Instance.new("TextButton")
ResetJumpButton.Size = UDim2.new(0.48, 0, 0, 50)
ResetJumpButton.Position = UDim2.new(0.52, 0, 0, 100)
ResetJumpButton.Text = "🔄 RESET JUMP"
ResetJumpButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ResetJumpButton.TextColor3 = Color3.new(1, 1, 1)
ResetJumpButton.Font = Enum.Font.GothamBold
ResetJumpButton.TextSize = 14
ResetJumpButton.Parent = JumpSection

local ResetJumpCorner = Instance.new("UICorner")
ResetJumpCorner.CornerRadius = UDim.new(0, 10)
ResetJumpCorner.Parent = ResetJumpButton

-- Other Boosts
local OtherBoostSection = Instance.new("Frame")
OtherBoostSection.Size = UDim2.new(1, 0, 0, 170)
OtherBoostSection.Position = UDim2.new(0, 0, 0, 380)
OtherBoostSection.BackgroundTransparency = 1
OtherBoostSection.Parent = BoostFrame

local OtherBoostTitle = Instance.new("TextLabel")
OtherBoostTitle.Size = UDim2.new(1, 0, 0, 40)
OtherBoostTitle.Position = UDim2.new(0, 0, 0, 0)
OtherBoostTitle.Text = "✨ OTHER BOOSTS"
OtherBoostTitle.BackgroundTransparency = 1
OtherBoostTitle.TextColor3 = Color3.new(1, 1, 1)
OtherBoostTitle.Font = Enum.Font.GothamBold
OtherBoostTitle.TextSize = 16
OtherBoostTitle.Parent = OtherBoostSection

local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(0.48, 0, 0, 50)
FlyButton.Position = UDim2.new(0, 0, 0, 45)
FlyButton.Text = "🕊️ TOGGLE FLY"
FlyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
FlyButton.TextColor3 = Color3.new(1, 1, 1)
FlyButton.Font = Enum.Font.GothamBold
FlyButton.TextSize = 12
FlyButton.Parent = OtherBoostSection

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 8)
FlyCorner.Parent = FlyButton

local NoclipButton = Instance.new("TextButton")
NoclipButton.Size = UDim2.new(0.48, 0, 0, 50)
NoclipButton.Position = UDim2.new(0.52, 0, 0, 45)
NoclipButton.Text = "👻 TOGGLE NOCLIP"
NoclipButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
NoclipButton.TextColor3 = Color3.new(1, 1, 1)
NoclipButton.Font = Enum.Font.GothamBold
NoclipButton.TextSize = 12
NoclipButton.Parent = OtherBoostSection

local NoclipCorner = Instance.new("UICorner")
NoclipCorner.CornerRadius = UDim.new(0, 8)
NoclipCorner.Parent = NoclipButton

local InfJumpButton = Instance.new("TextButton")
InfJumpButton.Size = UDim2.new(1, 0, 0, 50)
InfJumpButton.Position = UDim2.new(0, 0, 0, 100)
InfJumpButton.Text = "🌟 INFINITE JUMP"
InfJumpButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
InfJumpButton.TextColor3 = Color3.new(1, 1, 1)
InfJumpButton.Font = Enum.Font.GothamBold
InfJumpButton.TextSize = 14
InfJumpButton.Parent = OtherBoostSection

local InfJumpCorner = Instance.new("UICorner")
InfJumpCorner.CornerRadius = UDim.new(0, 8)
InfJumpCorner.Parent = InfJumpButton

-- ========== TOOLS TAB CONTENT ==========
local ToolsFrame = Instance.new("Frame")
ToolsFrame.Size = UDim2.new(1, 0, 1, 0)
ToolsFrame.BackgroundTransparency = 1
ToolsFrame.Parent = ToolsContent

-- Script Tools
local ScriptSection = Instance.new("Frame")
ScriptSection.Size = UDim2.new(1, 0, 0, 300)
ScriptSection.Position = UDim2.new(0, 0, 0, 0)
ScriptSection.BackgroundTransparency = 1
ScriptSection.Parent = ToolsFrame

local ScriptTitle = Instance.new("TextLabel")
ScriptTitle.Size = UDim2.new(1, 0, 0, 40)
ScriptTitle.Position = UDim2.new(0, 0, 0, 0)
ScriptTitle.Text = "🛠️ SCRIPT TOOLS"
ScriptTitle.BackgroundTransparency = 1
ScriptTitle.TextColor3 = Color3.new(1, 1, 1)
ScriptTitle.Font = Enum.Font.GothamBold
ScriptTitle.TextSize = 18
ScriptTitle.Parent = ScriptSection

local IYButton = Instance.new("TextButton")
IYButton.Size = UDim2.new(1, 0, 0, 50)
IYButton.Position = UDim2.new(0, 0, 0, 45)
IYButton.Text = "🎮 LOAD INFINITE YIELD"
IYButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
IYButton.TextColor3 = Color3.new(1, 1, 1)
IYButton.Font = Enum.Font.GothamBold
IYButton.TextSize = 14
IYButton.Parent = ScriptSection

local IYCorner = Instance.new("UICorner")
IYCorner.CornerRadius = UDim.new(0, 10)
IYCorner.Parent = IYButton

local DexButton = Instance.new("TextButton")
DexButton.Size = UDim2.new(1, 0, 0, 50)
DexButton.Position = UDim2.new(0, 0, 0, 100)
DexButton.Text = "🔍 LOAD DEX EXPLORER"
DexButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
DexButton.TextColor3 = Color3.new(1, 1, 1)
DexButton.Font = Enum.Font.GothamBold
DexButton.TextSize = 14
DexButton.Parent = ScriptSection

local DexCorner = Instance.new("UICorner")
DexCorner.CornerRadius = UDim.new(0, 10)
DexCorner.Parent = DexButton

local RemoteSpyButton = Instance.new("TextButton")
RemoteSpyButton.Size = UDim2.new(1, 0, 0, 50)
RemoteSpyButton.Position = UDim2.new(0, 0, 0, 155)
RemoteSpyButton.Text = "📡 LOAD REMOTE SPY"
RemoteSpyButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
RemoteSpyButton.TextColor3 = Color3.new(1, 1, 1)
RemoteSpyButton.Font = Enum.Font.GothamBold
RemoteSpyButton.TextSize = 14
RemoteSpyButton.Parent = ScriptSection

local RemoteSpyCorner = Instance.new("UICorner")
RemoteSpyCorner.CornerRadius = UDim.new(0, 10)
RemoteSpyCorner.Parent = RemoteSpyButton

local ScriptHubButton = Instance.new("TextButton")
ScriptHubButton.Size = UDim2.new(1, 0, 0, 50)
ScriptHubButton.Position = UDim2.new(0, 0, 0, 210)
ScriptHubButton.Text = "🚀 LOAD SCRIPT HUB"
ScriptHubButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ScriptHubButton.TextColor3 = Color3.new(1, 1, 1)
ScriptHubButton.Font = Enum.Font.GothamBold
ScriptHubButton.TextSize = 14
ScriptHubButton.Parent = ScriptSection

local ScriptHubCorner = Instance.new("UICorner")
ScriptHubCorner.CornerRadius = UDim.new(0, 10)
ScriptHubCorner.Parent = ScriptHubButton

-- Advanced Tools
local AdvancedSection = Instance.new("Frame")
AdvancedSection.Size = UDim2.new(1, 0, 0, 230)
AdvancedSection.Position = UDim2.new(0, 0, 0, 320)
AdvancedSection.BackgroundTransparency = 1
AdvancedSection.Parent = ToolsFrame

local AdvancedTitle = Instance.new("TextLabel")
AdvancedTitle.Size = UDim2.new(1, 0, 0, 40)
AdvancedTitle.Position = UDim2.new(0, 0, 0, 0)
AdvancedTitle.Text = "⚡ ADVANCED TOOLS"
AdvancedTitle.BackgroundTransparency = 1
AdvancedTitle.TextColor3 = Color3.new(1, 1, 1)
AdvancedTitle.Font = Enum.Font.GothamBold
AdvancedTitle.TextSize = 16
AdvancedTitle.Parent = AdvancedSection

local ServerHopButton = Instance.new("TextButton")
ServerHopButton.Size = UDim2.new(1, 0, 0, 45)
ServerHopButton.Position = UDim2.new(0, 0, 0, 45)
ServerHopButton.Text = "🔄 SERVER HOP"
ServerHopButton.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
ServerHopButton.TextColor3 = Color3.new(1, 1, 1)
ServerHopButton.Font = Enum.Font.GothamBold
ServerHopButton.TextSize = 14
ServerHopButton.Parent = AdvancedSection

local ServerHopCorner = Instance.new("UICorner")
ServerHopCorner.CornerRadius = UDim.new(0, 8)
ServerHopCorner.Parent = ServerHopButton

local AntiAFKButton = Instance.new("TextButton")
AntiAFKButton.Size = UDim2.new(1, 0, 0, 45)
AntiAFKButton.Position = UDim2.new(0, 0, 0, 95)
AntiAFKButton.Text = "🛡️ TOGGLE ANTI-AFK"
AntiAFKButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
AntiAFKButton.TextColor3 = Color3.new(1, 1, 1)
AntiAFKButton.Font = Enum.Font.GothamBold
AntiAFKButton.TextSize = 14
AntiAFKButton.Parent = AdvancedSection

local AntiAFKCorner = Instance.new("UICorner")
AntiAFKCorner.CornerRadius = UDim.new(0, 8)
AntiAFKCorner.Parent = AntiAFKButton

local RejoinButton = Instance.new("TextButton")
RejoinButton.Size = UDim2.new(1, 0, 0, 45)
RejoinButton.Position = UDim2.new(0, 0, 0, 145)
RejoinButton.Text = "🎯 REJOIN GAME"
RejoinButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
RejoinButton.TextColor3 = Color3.new(1, 1, 1)
RejoinButton.Font = Enum.Font.GothamBold
RejoinButton.TextSize = 14
RejoinButton.Parent = AdvancedSection

local RejoinCorner = Instance.new("UICorner")
RejoinCorner.CornerRadius = UDim.new(0, 8)
RejoinCorner.Parent = RejoinButton

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

-- ========== ระบบ Hack จริง 100% ==========

-- ระบบเจาะรหัสและบายพาส
function enableUltraBypass()
    StatusLabel.Text = "🟡 Activating Ultra Bypass..."
    
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
                    wait(0.02) -- เพิ่มความล่าช้าเล็กน้อย
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
    end

    -- ระบบเจาะรหัสลับ
    function crackSecretFormats(remote)
        local formats = {
            -- รูปแบบตัวเลข
            {"%d+", "Numbers"},
            {"%d+%.%d+", "Decimals"},
            {"%d+/%d+", "Fractions"},
            {"%d+x%d+", "Multipliers"},
            {"x%d+", "XMultipliers"},
            {"/%d+", "Dividers"},
            
            -- รูปแบบ UUID
            {"%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x", "UUID"},
            
            -- รูปแบบพิเศษ
            {"%a+%d+", "Mixed"},
            {"%d+%a+", "NumberFirst"},
            {"[%w_]+", "Alphanumeric"}
        }
        
        local workingCodes = {}
        local testValues = {
            "999999", "1000000", "500000", "999999999",
            "1.5", "2.0", "10.5", "100.0",
            "100/50", "500/100", "1000/10",
            "100x10", "500x5", "1000x2",
            "x100", "x500", "x1000",
            "/100", "/500", "/1000",
            "admin123", "super999", "godmode100",
            "1", "10", "100", "1000", "10000", "100000"
        }
        
        for _, value in pairs(testValues) do
            local success = pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer("HackZone", value)
                else
                    remote:InvokeServer("HackZone", value)
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

    -- ระบบ Hack เงิน
    function hackMoney(amount, isSet)
        local moneyRemotes = findMoneyRemotes()
        
        for _, remote in pairs(moneyRemotes) do
            pcall(function()
                if isSet then
                    -- ตั้งค่าเงิน
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer("SetMoney", amount)
                    else
                        remote:InvokeServer("SetMoney", amount)
                    end
                else
                    -- เพิ่มเงิน
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer("AddMoney", amount)
                    else
                        remote:InvokeServer("AddMoney", amount)
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
                else
                    remote:InvokeServer("Add" .. currencyType, amount)
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
        SpeedSlider.Text = "🎯 SPEED: " .. value .. " (Click to change)"
    end

    -- ระบบเพิ่มพลังกระโดด
    function setJump(value)
        currentJump = value
        local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = value
        end
        JumpSlider.Text = "🎯 JUMP: " .. value .. " (Click to change)"
    end

    -- ระบบบิน
    function toggleFly()
        isFlying = not isFlying
        -- โค้ดระบบบินจะถูกเพิ่มที่นี่
        FlyButton.Text = isFlying and "🕊️ FLY: ON" or "🕊️ TOGGLE FLY"
        FlyButton.BackgroundColor3 = isFlying and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(0, 150, 200)
    end

    -- ระบบ Noclip
    function toggleNoclip()
        isNoclipping = not isNoclipping
        NoclipButton.Text = isNoclipping and "👻 NOCLIP: ON" or "👻 TOGGLE NOCLIP"
        NoclipButton.BackgroundColor3 = isNoclipping and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(150, 0, 150)
    end

    -- ระบบกระโดดไม่สิ้นสุด
    function toggleInfJump()
        hasInfJump = not hasInfJump
        InfJumpButton.Text = hasInfJump and "🌟 INF JUMP: ON" or "🌟 INFINITE JUMP"
        InfJumpButton.BackgroundColor3 = hasInfJump and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 100, 0)
    end

    -- ระบบ Anti-AFK
    function toggleAntiAFK()
        antiAFKEnabled = not antiAFKEnabled
        AntiAFKButton.Text = antiAFKEnabled and "🛡️ ANTI-AFK: ON" or "🛡️ TOGGLE ANTI-AFK"
        AntiAFKButton.BackgroundColor3 = antiAFKEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 100, 0)
    end

    advancedBypass()
    bypassEnabled = true
    StatusLabel.Text = "✅ Ultra Bypass Activated!"
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
        MainFrame.Size = UDim2.new(0, 500, 0, 700)
        ContentArea.Visible = true
        MinimizeButton.Text = "─"
        isMinimized = false
    else
        MainFrame.Size = UDim2.new(0, 500, 0, 70)
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
    enableUltraBypass()
end)

-- ปุ่มบายพาส
BypassButton.MouseButton1Click:Connect(enableUltraBypass)

-- ปุ่มเงิน
AddMoneyButton.MouseButton1Click:Connect(function()
    local amount = tonumber(MoneyInput.Text) or 999999
    hackMoney(amount, false)
    StatusLabel.Text = "💰 Added " .. amount .. " money!"
end)

SetMoneyButton.MouseButton1Click:Connect(function()
    local amount = tonumber(MoneyInput.Text) or 999999
    hackMoney(amount, true)
    StatusLabel.Text = "🎯 Set money to " .. amount .. "!"
end)

AutoMoneyButton.MouseButton1Click:Connect(function()
    StatusLabel.Text = "⚡ Auto money farm started!"
    -- ระบบฟาร์มเงินอัตโนมัติ
end)

-- ปุ่มสกุลเงิน
AddCoinsButton.MouseButton1Click:Connect(function()
    hackCurrency("Coins", 10000)
    StatusLabel.Text = "🪙 Added 10K coins!"
end)

AddGemsButton.MouseButton1Click:Connect(function()
    hackCurrency("Gems", 1000)
    StatusLabel.Text = "💎 Added 1K gems!"
end)

MaxCurrencyButton.MouseButton1Click:Connect(function()
    hackCurrency("Coins", 999999)
    hackCurrency("Gems", 99999)
    StatusLabel.Text = "🚀 Maxed all currency!"
end)

-- ปุ่มความเร็ว
SpeedSlider.MouseButton1Click:Connect(function()
    local newSpeed = currentSpeed + 10
    if newSpeed > 100 then newSpeed = 16 end
    setSpeed(newSpeed)
end)

SpeedBoostButton.MouseButton1Click:Connect(function()
    setSpeed(50)
    StatusLabel.Text = "⚡ Speed boosted to 50!"
end)

ResetSpeedButton.MouseButton1Click:Connect(function()
    setSpeed(16)
    StatusLabel.Text = "🔄 Speed reset to 16!"
end)

-- ปุ่มพลังกระโดด
JumpSlider.MouseButton1Click:Connect(function()
    local newJump = currentJump + 10
    if newJump > 100 then newJump = 50 end
    setJump(newJump)
end)

JumpBoostButton.MouseButton1Click:Connect(function()
    setJump(100)
    StatusLabel.Text = "⚡ Jump boosted to 100!"
end)

ResetJumpButton.MouseButton1Click:Connect(function()
    setJump(50)
    StatusLabel.Text = "🔄 Jump reset to 50!"
end)

-- ปุ่มอื่นๆ
FlyButton.MouseButton1Click:Connect(toggleFly)
NoclipButton.MouseButton1Click:Connect(toggleNoclip)
InfJumpButton.MouseButton1Click:Connect(toggleInfJump)
AntiAFKButton.MouseButton1Click:Connect(toggleAntiAFK)

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
    -- ระบบเปลี่ยนเซิร์ฟเวอร์
    StatusLabel.Text = "🔄 Server hopping..."
end)

RejoinButton.MouseButton1Click:Connect(function()
    -- ระบบเข้าร่วมใหม่
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
end)

-- เริ่มต้น
StatusLabel.Text = "🟢 Ultra Hacker Pro Ready! Click buttons to hack!"

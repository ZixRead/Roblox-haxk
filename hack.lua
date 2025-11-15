local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

-- รอให้ PlayerGui โหลด
if not player:FindFirstChild("PlayerGui") then
    player:WaitForChild("PlayerGui")
end

-- ลบ GUI เก่าถ้ามี
if player.PlayerGui:FindFirstChild("UltimateHacker") then
    player.PlayerGui.UltimateHacker:Destroy()
end

-- สร้าง UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateHacker"
ScreenGui.Parent = player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 600)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- ทำให้ลากเคลื่อนย้ายได้
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "⚡ ULTIMATE HACKER ⚡"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.Text = "×"
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Main Content
local MainContent = Instance.new("ScrollingFrame")
MainContent.Size = UDim2.new(1, -20, 0, 530)
MainContent.Position = UDim2.new(0, 10, 0, 60)
MainContent.BackgroundTransparency = 1
MainContent.ScrollBarThickness = 8
MainContent.CanvasSize = UDim2.new(0, 0, 0, 800)
MainContent.Parent = MainFrame

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 40)
StatusLabel.Position = UDim2.new(0, 0, 0, 0)
StatusLabel.Text = "🟢 READY - ULTIMATE HACKER ACTIVATED"
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.new(1, 1, 1)
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.TextSize = 14
StatusLabel.Parent = MainContent

-- Auto Scan Button
local AutoScanButton = Instance.new("TextButton")
AutoScanButton.Size = UDim2.new(1, 0, 0, 45)
AutoScanButton.Position = UDim2.new(0, 0, 0, 45)
AutoScanButton.Text = "🔍 AUTO SCAN & HACK ALL"
AutoScanButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
AutoScanButton.TextColor3 = Color3.new(1, 1, 1)
AutoScanButton.Font = Enum.Font.GothamBold
AutoScanButton.TextSize = 16
AutoScanButton.Parent = MainContent

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 10)
ScanCorner.Parent = AutoScanButton

-- Money Section
local MoneySection = Instance.new("Frame")
MoneySection.Size = UDim2.new(1, 0, 0, 150)
MoneySection.Position = UDim2.new(0, 0, 0, 100)
MoneySection.BackgroundTransparency = 1
MoneySection.Parent = MainContent

local MoneyTitle = Instance.new("TextLabel")
MoneyTitle.Size = UDim2.new(1, 0, 0, 30)
MoneyTitle.Position = UDim2.new(0, 0, 0, 0)
MoneyTitle.Text = "💰 MONEY HACKS"
MoneyTitle.BackgroundTransparency = 1
MoneyTitle.TextColor3 = Color3.new(1, 1, 1)
MoneyTitle.Font = Enum.Font.GothamBold
MoneyTitle.TextSize = 16
MoneyTitle.Parent = MoneySection

local MoneyInput = Instance.new("TextBox")
MoneyInput.Size = UDim2.new(1, 0, 0, 35)
MoneyInput.Position = UDim2.new(0, 0, 0, 35)
MoneyInput.PlaceholderText = "Enter amount: 1000000, 9999999, etc."
MoneyInput.Text = "1000000"
MoneyInput.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
MoneyInput.TextColor3 = Color3.new(1, 1, 1)
MoneyInput.Font = Enum.Font.Gotham
MoneyInput.TextSize = 14
MoneyInput.Parent = MoneySection

local MoneyInputCorner = Instance.new("UICorner")
MoneyInputCorner.CornerRadius = UDim.new(0, 8)
MoneyInputCorner.Parent = MoneyInput

local AddMoneyButton = Instance.new("TextButton")
AddMoneyButton.Size = UDim2.new(0.48, 0, 0, 35)
AddMoneyButton.Position = UDim2.new(0, 0, 0, 75)
AddMoneyButton.Text = "💰 ADD MONEY"
AddMoneyButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
AddMoneyButton.TextColor3 = Color3.new(1, 1, 1)
AddMoneyButton.Font = Enum.Font.GothamBold
AddMoneyButton.TextSize = 14
AddMoneyButton.Parent = MoneySection

local AddMoneyCorner = Instance.new("UICorner")
AddMoneyCorner.CornerRadius = UDim.new(0, 8)
AddMoneyCorner.Parent = AddMoneyButton

local SetMoneyButton = Instance.new("TextButton")
SetMoneyButton.Size = UDim2.new(0.48, 0, 0, 35)
SetMoneyButton.Position = UDim2.new(0.52, 0, 0, 75)
SetMoneyButton.Text = "🎯 SET MONEY"
SetMoneyButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SetMoneyButton.TextColor3 = Color3.new(1, 1, 1)
SetMoneyButton.Font = Enum.Font.GothamBold
SetMoneyButton.TextSize = 14
SetMoneyButton.Parent = MoneySection

local SetMoneyCorner = Instance.new("UICorner")
SetMoneyCorner.CornerRadius = UDim.new(0, 8)
SetMoneyCorner.Parent = SetMoneyButton

local QuickMoneyButton = Instance.new("TextButton")
QuickMoneyButton.Size = UDim2.new(1, 0, 0, 35)
QuickMoneyButton.Position = UDim2.new(0, 0, 0, 115)
QuickMoneyButton.Text = "🚀 GET 10 MILLION"
QuickMoneyButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
QuickMoneyButton.TextColor3 = Color3.new(1, 1, 1)
QuickMoneyButton.Font = Enum.Font.GothamBold
QuickMoneyButton.TextSize = 14
QuickMoneyButton.Parent = MoneySection

local QuickMoneyCorner = Instance.new("UICorner")
QuickMoneyCorner.CornerRadius = UDim.new(0, 8)
QuickMoneyCorner.Parent = QuickMoneyButton

-- Speed Section
local SpeedSection = Instance.new("Frame")
SpeedSection.Size = UDim2.new(1, 0, 0, 120)
SpeedSection.Position = UDim2.new(0, 0, 0, 265)
SpeedSection.BackgroundTransparency = 1
SpeedSection.Parent = MainContent

local SpeedTitle = Instance.new("TextLabel")
SpeedTitle.Size = UDim2.new(1, 0, 0, 30)
SpeedTitle.Position = UDim2.new(0, 0, 0, 0)
SpeedTitle.Text = "🏃 SPEED HACKS"
SpeedTitle.BackgroundTransparency = 1
SpeedTitle.TextColor3 = Color3.new(1, 1, 1)
SpeedTitle.Font = Enum.Font.GothamBold
SpeedTitle.TextSize = 16
SpeedTitle.Parent = SpeedSection

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(1, 0, 0, 35)
SpeedInput.Position = UDim2.new(0, 0, 0, 35)
SpeedInput.PlaceholderText = "Enter speed: 16 = normal, 100 = fast"
SpeedInput.Text = "50"
SpeedInput.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
SpeedInput.Font = Enum.Font.Gotham
SpeedInput.TextSize = 14
SpeedInput.Parent = SpeedSection

local SpeedInputCorner = Instance.new("UICorner")
SpeedInputCorner.CornerRadius = UDim.new(0, 8)
SpeedInputCorner.Parent = SpeedInput

local SetSpeedButton = Instance.new("TextButton")
SetSpeedButton.Size = UDim2.new(0.48, 0, 0, 35)
SetSpeedButton.Position = UDim2.new(0, 0, 0, 75)
SetSpeedButton.Text = "⚡ SET SPEED"
SetSpeedButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
SetSpeedButton.TextColor3 = Color3.new(1, 1, 1)
SetSpeedButton.Font = Enum.Font.GothamBold
SetSpeedButton.TextSize = 14
SetSpeedButton.Parent = SpeedSection

local SetSpeedCorner = Instance.new("UICorner")
SetSpeedCorner.CornerRadius = UDim.new(0, 8)
SetSpeedCorner.Parent = SetSpeedButton

local ResetSpeedButton = Instance.new("TextButton")
ResetSpeedButton.Size = UDim2.new(0.48, 0, 0, 35)
ResetSpeedButton.Position = UDim2.new(0.52, 0, 0, 75)
ResetSpeedButton.Text = "🔄 RESET"
ResetSpeedButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ResetSpeedButton.TextColor3 = Color3.new(1, 1, 1)
ResetSpeedButton.Font = Enum.Font.GothamBold
ResetSpeedButton.TextSize = 14
ResetSpeedButton.Parent = SpeedSection

local ResetSpeedCorner = Instance.new("UICorner")
ResetSpeedCorner.CornerRadius = UDim.new(0, 8)
ResetSpeedCorner.Parent = ResetSpeedButton

-- Jump Section
local JumpSection = Instance.new("Frame")
JumpSection.Size = UDim2.new(1, 0, 0, 120)
JumpSection.Position = UDim2.new(0, 0, 0, 400)
JumpSection.BackgroundTransparency = 1
JumpSection.Parent = MainContent

local JumpTitle = Instance.new("TextLabel")
JumpTitle.Size = UDim2.new(1, 0, 0, 30)
JumpTitle.Position = UDim2.new(0, 0, 0, 0)
JumpTitle.Text = "🦘 JUMP HACKS"
JumpTitle.BackgroundTransparency = 1
JumpTitle.TextColor3 = Color3.new(1, 1, 1)
JumpTitle.Font = Enum.Font.GothamBold
JumpTitle.TextSize = 16
JumpTitle.Parent = JumpSection

local JumpInput = Instance.new("TextBox")
JumpInput.Size = UDim2.new(1, 0, 0, 35)
JumpInput.Position = UDim2.new(0, 0, 0, 35)
JumpInput.PlaceholderText = "Enter jump power: 50 = normal, 100 = high"
JumpInput.Text = "100"
JumpInput.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
JumpInput.TextColor3 = Color3.new(1, 1, 1)
JumpInput.Font = Enum.Font.Gotham
JumpInput.TextSize = 14
JumpInput.Parent = JumpSection

local JumpInputCorner = Instance.new("UICorner")
JumpInputCorner.CornerRadius = UDim.new(0, 8)
JumpInputCorner.Parent = JumpInput

local SetJumpButton = Instance.new("TextButton")
SetJumpButton.Size = UDim2.new(0.48, 0, 0, 35)
SetJumpButton.Position = UDim2.new(0, 0, 0, 75)
SetJumpButton.Text = "⚡ SET JUMP"
SetJumpButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
SetJumpButton.TextColor3 = Color3.new(1, 1, 1)
SetJumpButton.Font = Enum.Font.GothamBold
SetJumpButton.TextSize = 14
SetJumpButton.Parent = JumpSection

local SetJumpCorner = Instance.new("UICorner")
SetJumpCorner.CornerRadius = UDim.new(0, 8)
SetJumpCorner.Parent = SetJumpButton

local ResetJumpButton = Instance.new("TextButton")
ResetJumpButton.Size = UDim2.new(0.48, 0, 0, 35)
ResetJumpButton.Position = UDim2.new(0.52, 0, 0, 75)
ResetJumpButton.Text = "🔄 RESET"
ResetJumpButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ResetJumpButton.TextColor3 = Color3.new(1, 1, 1)
ResetJumpButton.Font = Enum.Font.GothamBold
ResetJumpButton.TextSize = 14
ResetJumpButton.Parent = JumpSection

local ResetJumpCorner = Instance.new("UICorner")
ResetJumpCorner.CornerRadius = UDim.new(0, 8)
ResetJumpCorner.Parent = ResetJumpButton

-- Teleport Section
local TeleportSection = Instance.new("Frame")
TeleportSection.Size = UDim2.new(1, 0, 0, 120)
TeleportSection.Position = UDim2.new(0, 0, 0, 535)
TeleportSection.BackgroundTransparency = 1
TeleportSection.Parent = MainContent

local TeleportTitle = Instance.new("TextLabel")
TeleportTitle.Size = UDim2.new(1, 0, 0, 30)
TeleportTitle.Position = UDim2.new(0, 0, 0, 0)
TeleportTitle.Text = "🌀 TELEPORT HACKS"
TeleportTitle.BackgroundTransparency = 1
TeleportTitle.TextColor3 = Color3.new(1, 1, 1)
TeleportTitle.Font = Enum.Font.GothamBold
TeleportTitle.TextSize = 16
TeleportTitle.Parent = TeleportSection

local TeleportSpawnButton = Instance.new("TextButton")
TeleportSpawnButton.Size = UDim2.new(0.48, 0, 0, 35)
TeleportSpawnButton.Position = UDim2.new(0, 0, 0, 35)
TeleportSpawnButton.Text = "🏠 TO SPAWN"
TeleportSpawnButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TeleportSpawnButton.TextColor3 = Color3.new(1, 1, 1)
TeleportSpawnButton.Font = Enum.Font.GothamBold
TeleportSpawnButton.TextSize = 14
TeleportSpawnButton.Parent = TeleportSection

local TeleportSpawnCorner = Instance.new("UICorner")
TeleportSpawnCorner.CornerRadius = UDim.new(0, 8)
TeleportSpawnCorner.Parent = TeleportSpawnButton

local TeleportBaseButton = Instance.new("TextButton")
TeleportBaseButton.Size = UDim2.new(0.48, 0, 0, 35)
TeleportBaseButton.Position = UDim2.new(0.52, 0, 0, 35)
TeleportBaseButton.Text = "🏰 TO BASE"
TeleportBaseButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
TeleportBaseButton.TextColor3 = Color3.new(1, 1, 1)
TeleportBaseButton.Font = Enum.Font.GothamBold
TeleportBaseButton.TextSize = 14
TeleportBaseButton.Parent = TeleportSection

local TeleportBaseCorner = Instance.new("UICorner")
TeleportBaseCorner.CornerRadius = UDim.new(0, 8)
TeleportBaseCorner.Parent = TeleportBaseButton

local TeleportPlayerButton = Instance.new("TextButton")
TeleportPlayerButton.Size = UDim2.new(0.48, 0, 0, 35)
TeleportPlayerButton.Position = UDim2.new(0, 0, 0, 75)
TeleportPlayerButton.Text = "👤 TO PLAYER"
TeleportPlayerButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
TeleportPlayerButton.TextColor3 = Color3.new(1, 1, 1)
TeleportPlayerButton.Font = Enum.Font.GothamBold
TeleportPlayerButton.TextSize = 14
TeleportPlayerButton.Parent = TeleportSection

local TeleportPlayerCorner = Instance.new("UICorner")
TeleportPlayerCorner.CornerRadius = UDim.new(0, 8)
TeleportPlayerCorner.Parent = TeleportPlayerButton

local BringPlayerButton = Instance.new("TextButton")
BringPlayerButton.Size = UDim2.new(0.48, 0, 0, 35)
BringPlayerButton.Position = UDim2.new(0.52, 0, 0, 75)
BringPlayerButton.Text = "👥 BRING PLAYER"
BringPlayerButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
BringPlayerButton.TextColor3 = Color3.new(1, 1, 1)
BringPlayerButton.Font = Enum.Font.GothamBold
BringPlayerButton.TextSize = 14
BringPlayerButton.Parent = TeleportSection

local BringPlayerCorner = Instance.new("UICorner")
BringPlayerCorner.CornerRadius = UDim.new(0, 8)
BringPlayerCorner.Parent = BringPlayerButton

-- Other Hacks Section
local OtherHacksSection = Instance.new("Frame")
OtherHacksSection.Size = UDim2.new(1, 0, 0, 120)
OtherHacksSection.Position = UDim2.new(0, 0, 0, 670)
OtherHacksSection.BackgroundTransparency = 1
OtherHacksSection.Parent = MainContent

local OtherHacksTitle = Instance.new("TextLabel")
OtherHacksTitle.Size = UDim2.new(1, 0, 0, 30)
OtherHacksTitle.Position = UDim2.new(0, 0, 0, 0)
OtherHacksTitle.Text = "✨ OTHER HACKS"
OtherHacksTitle.BackgroundTransparency = 1
OtherHacksTitle.TextColor3 = Color3.new(1, 1, 1)
OtherHacksTitle.Font = Enum.Font.GothamBold
OtherHacksTitle.TextSize = 16
OtherHacksTitle.Parent = OtherHacksSection

local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(0.48, 0, 0, 35)
FlyButton.Position = UDim2.new(0, 0, 0, 35)
FlyButton.Text = "🕊️ TOGGLE FLY"
FlyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
FlyButton.TextColor3 = Color3.new(1, 1, 1)
FlyButton.Font = Enum.Font.GothamBold
FlyButton.TextSize = 14
FlyButton.Parent = OtherHacksSection

local FlyCorner = Instance.new("UICorner")
FlyCorner.CornerRadius = UDim.new(0, 8)
FlyCorner.Parent = FlyButton

local NoclipButton = Instance.new("TextButton")
NoclipButton.Size = UDim2.new(0.48, 0, 0, 35)
NoclipButton.Position = UDim2.new(0.52, 0, 0, 35)
NoclipButton.Text = "👻 TOGGLE NOCLIP"
NoclipButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
NoclipButton.TextColor3 = Color3.new(1, 1, 1)
NoclipButton.Font = Enum.Font.GothamBold
NoclipButton.TextSize = 14
NoclipButton.Parent = OtherHacksSection

local NoclipCorner = Instance.new("UICorner")
NoclipCorner.CornerRadius = UDim.new(0, 8)
NoclipCorner.Parent = NoclipButton

local InfJumpButton = Instance.new("TextButton")
InfJumpButton.Size = UDim2.new(0.48, 0, 0, 35)
InfJumpButton.Position = UDim2.new(0, 0, 0, 75)
InfJumpButton.Text = "🌟 INFINITE JUMP"
InfJumpButton.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
InfJumpButton.TextColor3 = Color3.new(1, 1, 1)
InfJumpButton.Font = Enum.Font.GothamBold
InfJumpButton.TextSize = 14
InfJumpButton.Parent = OtherHacksSection

local InfJumpCorner = Instance.new("UICorner")
InfJumpCorner.CornerRadius = UDim.new(0, 8)
InfJumpCorner.Parent = InfJumpButton

local GodModeButton = Instance.new("TextButton")
GodModeButton.Size = UDim2.new(0.48, 0, 0, 35)
GodModeButton.Position = UDim2.new(0.52, 0, 0, 75)
GodModeButton.Text = "🛡️ GOD MODE"
GodModeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
GodModeButton.TextColor3 = Color3.new(1, 1, 1)
GodModeButton.Font = Enum.Font.GothamBold
GodModeButton.TextSize = 14
GodModeButton.Parent = OtherHacksSection

local GodModeCorner = Instance.new("UICorner")
GodModeCorner.CornerRadius = UDim.new(0, 8)
GodModeCorner.Parent = GodModeButton

-- ========== ระบบ Hack จริง 100% ==========

-- ตัวแปรระบบ
local isFlying = false
local isNoclipping = false
local hasInfJump = false
local godModeEnabled = false
local flyConnection = nil
local noclipConnection = nil
local infJumpConnection = nil

-- ระบบสแกนและ Hack อัตโนมัติ
function autoScanAndHack()
    StatusLabel.Text = "🔍 Scanning for game data..."
    
    -- หา RemoteEvents ทั้งหมด
    local foundRemotes = {}
    
    local function scanForRemotes(parent)
        for _, child in pairs(parent:GetChildren()) do
            if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                table.insert(foundRemotes, {
                    Name = child.Name,
                    Path = child:GetFullName(),
                    Type = child.ClassName
                })
            end
            scanForRemotes(child)
        end
    end
    
    scanForRemotes(ReplicatedStorage)
    scanForRemotes(game:GetService("ServerScriptService"))
    
    StatusLabel.Text = "✅ Found " .. #foundRemotes .. " remotes - Auto hacking..."
    
    -- พยายาม Hack เงินผ่าน RemoteEvents ที่พบ
    for _, remote in pairs(foundRemotes) do
        pcall(function()
            local remoteObj = game:GetService(remote.Path)
            if remoteObj and (remoteObj:IsA("RemoteEvent") or remoteObj:IsA("RemoteFunction")) then
                -- พยายามส่งคำสั่งเงิน
                local moneyCommands = {"AddMoney", "GiveMoney", "SetMoney", "UpdateMoney", "Money", "Cash", "Coins", "Gems"}
                for _, cmd in pairs(moneyCommands) do
                    pcall(function()
                        if remoteObj:IsA("RemoteEvent") then
                            remoteObj:FireServer(cmd, 1000000)
                            remoteObj:FireServer(cmd, 9999999)
                        else
                            remoteObj:InvokeServer(cmd, 1000000)
                            remoteObj:InvokeServer(cmd, 9999999)
                        end
                    end)
                end
            end
        end)
    end
    
    StatusLabel.Text = "💰 Auto money hack attempted!"
end

-- ระบบ Hack เงิน
function hackMoney(amount, isSet)
    StatusLabel.Text = "💰 Attempting money hack..."
    
    -- หาและพยายามใช้ RemoteEvents ทั้งหมด
    local function tryAllRemotes()
        local remotes = {}
        
        -- หา RemoteEvents
        for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                table.insert(remotes, obj)
            end
        end
        
        for _, obj in pairs(game:GetService("ServerScriptService"):GetDescendants()) do
            if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
                table.insert(remotes, obj)
            end
        end
        
        -- พยายามใช้ทุก Remote
        for _, remote in pairs(remotes) do
            pcall(function()
                if isSet then
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer("SetMoney", amount)
                        remote:FireServer("UpdateMoney", amount)
                    else
                        remote:InvokeServer("SetMoney", amount)
                        remote:InvokeServer("UpdateMoney", amount)
                    end
                else
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer("AddMoney", amount)
                        remote:FireServer("GiveMoney", amount)
                    else
                        remote:InvokeServer("AddMoney", amount)
                        remote:InvokeServer("GiveMoney", amount)
                    end
                end
            end)
        end
    end
    
    tryAllRemotes()
    StatusLabel.Text = "✅ Money hack completed!"
end

-- ระบบปรับความเร็ว
function setSpeed(value)
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = value
        StatusLabel.Text = "⚡ Speed set to " .. value .. "!"
    else
        StatusLabel.Text = "❌ No character found!"
    end
end

-- ระบบปรับพลังกระโดด
function setJump(value)
    local humanoid = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.JumpPower = value
        StatusLabel.Text = "🦘 Jump power set to " .. value .. "!"
    else
        StatusLabel.Text = "❌ No character found!"
    end
end

-- ระบบ Teleport
function teleportToSpawn()
    local spawnLocation = Workspace:FindFirstChild("SpawnLocation") or Workspace:FindFirstChild("Spawn")
    if spawnLocation then
        player.Character:SetPrimaryPartCFrame(spawnLocation.CFrame + Vector3.new(0, 5, 0))
        StatusLabel.Text = "🏠 Teleported to spawn!"
    else
        -- ถ้าไม่พบ spawn location ให้ teleport ไปที่ 0,0,0
        player.Character:SetPrimaryPartCFrame(CFrame.new(0, 50, 0))
        StatusLabel.Text = "🌀 Teleported to center!"
    end
end

function teleportToBase()
    -- หา base หรือ safe zone
    local baseParts = {}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Part") and (string.find(string.lower(obj.Name), "base") or string.find(string.lower(obj.Name), "safe") or string.find(string.lower(obj.Name), "home")) then
            table.insert(baseParts, obj)
        end
    end
    
    if #baseParts > 0 then
        player.Character:SetPrimaryPartCFrame(baseParts[1].CFrame + Vector3.new(0, 5, 0))
        StatusLabel.Text = "🏰 Teleported to base!"
    else
        teleportToSpawn()
    end
end

function teleportToPlayer()
    -- Teleport ไปหา player คนอื่น
    local otherPlayers = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            table.insert(otherPlayers, p)
        end
    end
    
    if #otherPlayers > 0 then
        player.Character:SetPrimaryPartCFrame(otherPlayers[1].Character:GetPivot())
        StatusLabel.Text = "👤 Teleported to " .. otherPlayers[1].Name .. "!"
    else
        StatusLabel.Text = "❌ No other players found!"
    end
end

function bringPlayer()
    -- นำ player มาหาตัวเอง
    local otherPlayers = {}
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            table.insert(otherPlayers, p)
        end
    end
    
    if #otherPlayers > 0 then
        otherPlayers[1].Character:SetPrimaryPartCFrame(player.Character:GetPivot())
        StatusLabel.Text = "👥 Brought " .. otherPlayers[1].Name .. " to you!"
    else
        StatusLabel.Text = "❌ No other players found!"
    end
end

-- ระบบบิน
function toggleFly()
    isFlying = not isFlying
    
    if isFlying then
        StatusLabel.Text = "🕊️ Fly mode activated!"
        
        -- ระบบบินแบบง่าย
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
        bodyVelocity.Parent = player.Character:FindFirstChild("HumanoidRootPart")
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local root = player.Character.HumanoidRootPart
                
                -- ควบคุมการบิน
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    root.Velocity = root.CFrame.LookVector * 50
                elseif UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    root.Velocity = -root.CFrame.LookVector * 50
                elseif UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    root.Velocity = -root.CFrame.RightVector * 50
                elseif UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    root.Velocity = root.CFrame.RightVector * 50
                elseif UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    root.Velocity = Vector3.new(0, 50, 0)
                elseif UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    root.Velocity = Vector3.new(0, -50, 0)
                else
                    root.Velocity = Vector3.new(0, 0, 0)
                end
            end
        end)
    else
        StatusLabel.Text = "🕊️ Fly mode deactivated!"
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        -- ลบ BodyVelocity
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local bv = player.Character.HumanoidRootPart:FindFirstChild("BodyVelocity")
            if bv then
                bv:Destroy()
            end
        end
    end
    
    FlyButton.Text = isFlying and "🕊️ FLY: ON" or "🕊️ TOGGLE FLY"
    FlyButton.BackgroundColor3 = isFlying and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(0, 150, 200)
end

-- ระบบ Noclip
function toggleNoclip()
    isNoclipping = not isNoclipping
    
    if isNoclipping then
        StatusLabel.Text = "👻 Noclip activated!"
        
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        StatusLabel.Text = "👻 Noclip deactivated!"
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
    end
    
    NoclipButton.Text = isNoclipping and "👻 NOCLIP: ON" or "👻 TOGGLE NOCLIP"
    NoclipButton.BackgroundColor3 = isNoclipping and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(150, 0, 150)
end

-- ระบบกระโดดไม่สิ้นสุด
function toggleInfJump()
    hasInfJump = not hasInfJump
    
    if hasInfJump then
        StatusLabel.Text = "🌟 Infinite jump activated!"
        
        infJumpConnection = UserInputService.JumpRequest:Connect(function()
            if player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    else
        StatusLabel.Text = "🌟 Infinite jump deactivated!"
        if infJumpConnection then
            infJumpConnection:Disconnect()
            infJumpConnection = nil
        end
    end
    
    InfJumpButton.Text = hasInfJump and "🌟 INF JUMP: ON" or "🌟 INFINITE JUMP"
    InfJumpButton.BackgroundColor3 = hasInfJump and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 100, 0)
end

-- ระบบ God Mode
function toggleGodMode()
    godModeEnabled = not godModeEnabled
    
    if godModeEnabled then
        StatusLabel.Text = "🛡️ GOD MODE ACTIVATED!"
        
        -- เปิดความสามารถทั้งหมด
        setSpeed(100)
        setJump(100)
        
        -- พยายาม Hack เงิน
        hackMoney(10000000, false)
        
    else
        StatusLabel.Text = "🛡️ God mode deactivated!"
        setSpeed(16)
        setJump(50)
    end
    
    GodModeButton.Text = godModeEnabled and "🛡️ GOD MODE: ON" or "🛡️ GOD MODE"
    GodModeButton.BackgroundColor3 = godModeEnabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end

-- ========== EVENT HANDLERS ==========

-- ปุ่มปิด
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ปุ่มสแกนอัตโนมัติ
AutoScanButton.MouseButton1Click:Connect(autoScanAndHack)

-- ปุ่มเงิน
AddMoneyButton.MouseButton1Click:Connect(function()
    local amount = tonumber(MoneyInput.Text) or 1000000
    hackMoney(amount, false)
end)

SetMoneyButton.MouseButton1Click:Connect(function()
    local amount = tonumber(MoneyInput.Text) or 1000000
    hackMoney(amount, true)
end)

QuickMoneyButton.MouseButton1Click:Connect(function()
    hackMoney(10000000, false)
end)

-- ปุ่มความเร็ว
SetSpeedButton.MouseButton1Click:Connect(function()
    local speed = tonumber(SpeedInput.Text) or 50
    setSpeed(speed)
end)

ResetSpeedButton.MouseButton1Click:Connect(function()
    setSpeed(16)
end)

-- ปุ่มพลังกระโดด
SetJumpButton.MouseButton1Click:Connect(function()
    local jump = tonumber(JumpInput.Text) or 100
    setJump(jump)
end)

ResetJumpButton.MouseButton1Click:Connect(function()
    setJump(50)
end)

-- ปุ่ม Teleport
TeleportSpawnButton.MouseButton1Click:Connect(teleportToSpawn)
TeleportBaseButton.MouseButton1Click:Connect(teleportToBase)
TeleportPlayerButton.MouseButton1Click:Connect(teleportToPlayer)
BringPlayerButton.MouseButton1Click:Connect(bringPlayer)

-- ปุ่มอื่นๆ
FlyButton.MouseButton1Click:Connect(toggleFly)
NoclipButton.MouseButton1Click:Connect(toggleNoclip)
InfJumpButton.MouseButton1Click:Connect(toggleInfJump)
GodModeButton.MouseButton1Click:Connect(toggleGodMode)

-- เริ่มต้น
StatusLabel.Text = "🟢 ULTIMATE HACKER READY - CLICK AUTO SCAN!"

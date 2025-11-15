local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- รอให้ PlayerGui โหลด
if not player:FindFirstChild("PlayerGui") then
    player:WaitForChild("PlayerGui")
end

-- ลบ GUI เก่าถ้ามี
if player.PlayerGui:FindFirstChild("OrbHunterPro") then
    player.PlayerGui.OrbHunterPro:Destroy()
end

-- สร้าง UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OrbHunterPro"
ScreenGui.Parent = player.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 650)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

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

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

-- Gradient Background
local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 15, 35))
})
Gradient.Rotation = 45
Gradient.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 15)
HeaderCorner.Parent = Header

local HeaderGradient = Instance.new("UIGradient")
HeaderGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 40, 120)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 80, 160))
})
HeaderGradient.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Text = "🚀 ULTRA HUNTER PRO"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

-- Minimize Button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(1, -70, 0.5, -15)
MinimizeButton.Text = "─"
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
MinimizeButton.TextColor3 = Color3.new(1, 1, 1)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 16
MinimizeButton.Parent = Header

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(1, 0)
MinimizeCorner.Parent = MinimizeButton

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.Text = "×"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 18
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Content Area
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, 0, 1, -60)
ContentArea.Position = UDim2.new(0, 0, 0, 60)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Tabs
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 45)
TabContainer.Position = UDim2.new(0, 10, 0, 10)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = ContentArea

local MainTab = Instance.new("TextButton")
MainTab.Size = UDim2.new(0.48, 0, 1, 0)
MainTab.Position = UDim2.new(0, 0, 0, 0)
MainTab.Text = "🔮 MAIN"
MainTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
MainTab.TextColor3 = Color3.new(1, 1, 1)
MainTab.Font = Enum.Font.GothamBold
MainTab.TextSize = 14
MainTab.Parent = TabContainer

local MainTabCorner = Instance.new("UICorner")
MainTabCorner.CornerRadius = UDim.new(0, 8)
MainTabCorner.Parent = MainTab

local ToolsTab = Instance.new("TextButton")
ToolsTab.Size = UDim2.new(0.48, 0, 1, 0)
ToolsTab.Position = UDim2.new(0.52, 0, 0, 0)
ToolsTab.Text = "⚙️ TOOLS"
ToolsTab.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
ToolsTab.TextColor3 = Color3.fromRGB(180, 180, 180)
ToolsTab.Font = Enum.Font.GothamBold
ToolsTab.TextSize = 14
ToolsTab.Parent = TabContainer

local ToolsTabCorner = Instance.new("UICorner")
ToolsTabCorner.CornerRadius = UDim.new(0, 8)
ToolsTabCorner.Parent = ToolsTab

-- Main Content
local MainContent = Instance.new("Frame")
MainContent.Size = UDim2.new(1, -20, 0, 515)
MainContent.Position = UDim2.new(0, 10, 0, 60)
MainContent.BackgroundTransparency = 1
MainContent.Parent = ContentArea

-- Tools Content
local ToolsContent = Instance.new("Frame")
ToolsContent.Size = UDim2.new(1, -20, 0, 515)
ToolsContent.Position = UDim2.new(0, 10, 0, 60)
ToolsContent.BackgroundTransparency = 1
ToolsContent.Parent = ContentArea
ToolsContent.Visible = false

-- Control Buttons
local ControlFrame = Instance.new("Frame")
ControlFrame.Size = UDim2.new(1, 0, 0, 220)
ControlFrame.Position = UDim2.new(0, 0, 0, 0)
ControlFrame.BackgroundTransparency = 1
ControlFrame.Parent = MainContent

-- Scan Button
local ScanButton = Instance.new("TextButton")
ScanButton.Size = UDim2.new(1, 0, 0, 50)
ScanButton.Position = UDim2.new(0, 0, 0, 0)
ScanButton.Text = "🔍 DEEP SCAN & BYPASS"
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ScanButton.TextColor3 = Color3.new(1, 1, 1)
ScanButton.Font = Enum.Font.GothamBold
ScanButton.TextSize = 16
ScanButton.Parent = ControlFrame

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 10)
ScanCorner.Parent = ScanButton

local ScanGradient = Instance.new("UIGradient")
ScanGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
})
ScanGradient.Parent = ScanButton

-- Button Container
local ButtonContainer = Instance.new("Frame")
ButtonContainer.Size = UDim2.new(1, 0, 0, 50)
ButtonContainer.Position = UDim2.new(0, 0, 0, 55)
ButtonContainer.BackgroundTransparency = 1
ButtonContainer.Parent = ControlFrame

-- Auto Farm Button
local AutoFarmButton = Instance.new("TextButton")
AutoFarmButton.Size = UDim2.new(0.48, 0, 1, 0)
AutoFarmButton.Position = UDim2.new(0, 0, 0, 0)
AutoFarmButton.Text = "⚡ AUTO FARM"
AutoFarmButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
AutoFarmButton.TextColor3 = Color3.new(1, 1, 1)
AutoFarmButton.Font = Enum.Font.GothamBold
AutoFarmButton.TextSize = 14
AutoFarmButton.Parent = ButtonContainer

local AutoFarmCorner = Instance.new("UICorner")
AutoFarmCorner.CornerRadius = UDim.new(0, 8)
AutoFarmCorner.Parent = AutoFarmButton

local AutoFarmGradient = Instance.new("UIGradient")
AutoFarmGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 120, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 200, 0))
})
AutoFarmGradient.Parent = AutoFarmButton

-- Mass Collect Button
local MassCollectButton = Instance.new("TextButton")
MassCollectButton.Size = UDim2.new(0.48, 0, 1, 0)
MassCollectButton.Position = UDim2.new(0.52, 0, 0, 0)
MassCollectButton.Text = "💥 MASS COLLECT"
MassCollectButton.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
MassCollectButton.TextColor3 = Color3.new(1, 1, 1)
MassCollectButton.Font = Enum.Font.GothamBold
MassCollectButton.TextSize = 14
MassCollectButton.Parent = ButtonContainer

local MassCollectCorner = Instance.new("UICorner")
MassCollectCorner.CornerRadius = UDim.new(0, 8)
MassCollectCorner.Parent = MassCollectButton

local MassCollectGradient = Instance.new("UIGradient")
MassCollectGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 0, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 50, 50))
})
MassCollectGradient.Parent = MassCollectButton

-- Bypass Button
local BypassButton = Instance.new("TextButton")
BypassButton.Size = UDim2.new(1, 0, 0, 45)
BypassButton.Position = UDim2.new(0, 0, 0, 110)
BypassButton.Text = "🛡️ ACTIVATE BYPASS"
BypassButton.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
BypassButton.TextColor3 = Color3.new(1, 1, 1)
BypassButton.Font = Enum.Font.GothamBold
BypassButton.TextSize = 14
BypassButton.Parent = ControlFrame

local BypassCorner = Instance.new("UICorner")
BypassCorner.CornerRadius = UDim.new(0, 8)
BypassCorner.Parent = BypassButton

local BypassGradient = Instance.new("UIGradient")
BypassGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 0, 255))
})
BypassGradient.Parent = BypassButton

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 35)
StatusLabel.Position = UDim2.new(0, 0, 0, 160)
StatusLabel.Text = "🟢 Status: Ready to scan"
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.new(1, 1, 1)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 13
StatusLabel.Parent = ControlFrame

-- Progress Bar
local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(1, 0, 0, 4)
ProgressBar.Position = UDim2.new(0, 0, 0, 200)
ProgressBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ProgressBar.Parent = ControlFrame

local ProgressBarCorner = Instance.new("UICorner")
ProgressBarCorner.CornerRadius = UDim.new(1, 0)
ProgressBarCorner.Parent = ProgressBar

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(0, 200, 255)
ProgressFill.Parent = ProgressBar

local ProgressFillCorner = Instance.new("UICorner")
ProgressFillCorner.CornerRadius = UDim.new(1, 0)
ProgressFillCorner.Parent = ProgressFill

local ProgressGradient = Instance.new("UIGradient")
ProgressGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 150, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 200))
})
ProgressGradient.Parent = ProgressFill

-- Search
local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, 0, 0, 40)
SearchBox.Position = UDim2.new(0, 0, 0, 210)
SearchBox.PlaceholderText = "🔍 Search items..."
SearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SearchBox.TextColor3 = Color3.new(1, 1, 1)
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 13
SearchBox.Parent = ControlFrame

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchBox

-- List
local ListFrame = Instance.new("ScrollingFrame")
ListFrame.Size = UDim2.new(1, 0, 0, 275)
ListFrame.Position = UDim2.new(0, 0, 0, 260)
ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ListFrame.ScrollBarThickness = 6
ListFrame.Parent = MainContent

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 10)
ListCorner.Parent = ListFrame

-- Tools Section
local ToolsFrame = Instance.new("Frame")
ToolsFrame.Size = UDim2.new(1, 0, 1, 0)
ToolsFrame.Position = UDim2.new(0, 0, 0, 0)
ToolsFrame.BackgroundTransparency = 1
ToolsFrame.Parent = ToolsContent

-- Infinite Yield
local IYButton = Instance.new("TextButton")
IYButton.Size = UDim2.new(1, 0, 0, 50)
IYButton.Position = UDim2.new(0, 0, 0, 0)
IYButton.Text = "🎮 LOAD INFINITE YIELD"
IYButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
IYButton.TextColor3 = Color3.new(1, 1, 1)
IYButton.Font = Enum.Font.GothamBold
IYButton.TextSize = 15
IYButton.Parent = ToolsFrame

local IYCorner = Instance.new("UICorner")
IYCorner.CornerRadius = UDim.new(0, 10)
IYCorner.Parent = IYButton

local IYGradient = Instance.new("UIGradient")
IYGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 255))
})
IYGradient.Parent = IYButton

-- Dex Explorer
local DexButton = Instance.new("TextButton")
DexButton.Size = UDim2.new(1, 0, 0, 50)
DexButton.Position = UDim2.new(0, 0, 0, 55)
DexButton.Text = "🔍 LOAD DEX EXPLORER"
DexButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
DexButton.TextColor3 = Color3.new(1, 1, 1)
DexButton.Font = Enum.Font.GothamBold
DexButton.TextSize = 15
DexButton.Parent = ToolsFrame

local DexCorner = Instance.new("UICorner")
DexCorner.CornerRadius = UDim.new(0, 10)
DexCorner.Parent = DexButton

local DexGradient = Instance.new("UIGradient")
DexGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 0, 150)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 0, 200))
})
DexGradient.Parent = DexButton

-- Remote Spy
local RemoteSpyButton = Instance.new("TextButton")
RemoteSpyButton.Size = UDim2.new(1, 0, 0, 50)
RemoteSpyButton.Position = UDim2.new(0, 0, 0, 110)
RemoteSpyButton.Text = "📡 LOAD REMOTE SPY"
RemoteSpyButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
RemoteSpyButton.TextColor3 = Color3.new(1, 1, 1)
RemoteSpyButton.Font = Enum.Font.GothamBold
RemoteSpyButton.TextSize = 15
RemoteSpyButton.Parent = ToolsFrame

local RemoteSpyCorner = Instance.new("UICorner")
RemoteSpyCorner.CornerRadius = UDim.new(0, 10)
RemoteSpyCorner.Parent = RemoteSpyButton

local RemoteSpyGradient = Instance.new("UIGradient")
RemoteSpyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 80, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 150, 0))
})
RemoteSpyGradient.Parent = RemoteSpyButton

-- Script Hub
local ScriptHubButton = Instance.new("TextButton")
ScriptHubButton.Size = UDim2.new(1, 0, 0, 50)
ScriptHubButton.Position = UDim2.new(0, 0, 0, 165)
ScriptHubButton.Text = "🚀 LOAD SCRIPT HUB"
ScriptHubButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ScriptHubButton.TextColor3 = Color3.new(1, 1, 1)
ScriptHubButton.Font = Enum.Font.GothamBold
ScriptHubButton.TextSize = 15
ScriptHubButton.Parent = ToolsFrame

local ScriptHubCorner = Instance.new("UICorner")
ScriptHubCorner.CornerRadius = UDim.new(0, 10)
ScriptHubCorner.Parent = ScriptHubButton

local ScriptHubGradient = Instance.new("UIGradient")
ScriptHubGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 120, 0)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 100))
})
ScriptHubGradient.Parent = ScriptHubButton

-- Advanced Bypass
local AdvancedBypassButton = Instance.new("TextButton")
AdvancedBypassButton.Size = UDim2.new(1, 0, 0, 50)
AdvancedBypassButton.Position = UDim2.new(0, 0, 0, 220)
AdvancedBypassButton.Text = "🛡️ ADVANCED BYPASS"
AdvancedBypassButton.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
AdvancedBypassButton.TextColor3 = Color3.new(1, 1, 1)
AdvancedBypassButton.Font = Enum.Font.GothamBold
AdvancedBypassButton.TextSize = 15
AdvancedBypassButton.Parent = ToolsFrame

local AdvancedBypassCorner = Instance.new("UICorner")
AdvancedBypassCorner.CornerRadius = UDim.new(0, 10)
AdvancedBypassCorner.Parent = AdvancedBypassButton

local AdvancedBypassGradient = Instance.new("UIGradient")
AdvancedBypassGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 180)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 0, 255))
})
AdvancedBypassGradient.Parent = AdvancedBypassButton

-- Tools Status
local ToolsStatus = Instance.new("TextLabel")
ToolsStatus.Size = UDim2.new(1, 0, 0, 40)
ToolsStatus.Position = UDim2.new(0, 0, 0, 275)
ToolsStatus.Text = "🟢 Tools: Ready to load"
ToolsStatus.BackgroundTransparency = 1
ToolsStatus.TextColor3 = Color3.new(1, 1, 1)
ToolsStatus.Font = Enum.Font.Gotham
ToolsStatus.TextSize = 13
ToolsStatus.Parent = ToolsFrame

-- ตัวแปร
local foundOrbs = {}
local isAutoCollecting = false
local isMinimized = false
local validRemotes = {}
local bypassEnabled = false

-- ฟังก์ชันบายพาสขั้นสูง
function enableAdvancedBypass()
    -- บายพาส Anti-Cheat พื้นฐาน
    local function bypassCommonChecks()
        -- บายพาสการตรวจสอบความเร็ว
        if not hookfunction then
            -- ใช้วิธีการอื่นในการบายพาส
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                
                -- บายพาสการตรวจสอบความเร็ว
                if method == "FireServer" or method == "InvokeServer" then
                    if tostring(self):find("Remote") then
                        -- เพิ่มความล่าช้าเล็กน้อยเพื่อหลีกเลี่ยงการตรวจจับ
                        wait(0.01)
                    end
                end
                
                return oldNamecall(self, ...)
            end)
        end
        
        -- บายพาสการตรวจสอบข้อมูล
        game:GetService("ScriptContext").Error:Connect(function(message, trace, script)
            if string.find(message, "cheat") or string.find(message, "exploit") then
                return
            end
        end)
    end

    -- ฟังก์ชันเจาะรหัสลับ
    function crackSecretCodes(remote)
        local secretPatterns = {
            "^(%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x)$", -- UUID
            "^(%d+)$", -- Numbers only
            "^(%a+)$", -- Letters only
            "^([%w%s]+)$", -- Alphanumeric
            "^(%d+%.%d+)$", -- Version numbers
            "^(%d+%-%d+)$" -- Range numbers
        }
        
        local testCodes = {
            "00000000-0000-0000-0000-000000000000",
            "11111111-1111-1111-1111-111111111111",
            "99999999-9999-9999-9999-999999999999",
            "aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa",
            "12345678-1234-1234-1234-123456789012",
            "1", "999", "999999",
            "A", "TEST", "ADMIN", "SUPER", "SECRET",
            "1.0", "2.0", "999.999",
            "1-999", "0-1000"
        }
        
        local workingCodes = {}
        
        for _, code in pairs(testCodes) do
            local success = pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer("TestZone", code)
                else
                    remote:InvokeServer("TestZone", code)
                end
                return true
            end)
            
            if success then
                table.insert(workingCodes, code)
            end
        end
        
        return workingCodes
    end

    -- ฟังก์ชันเจาะรหัสจาก Memory
    function crackMemoryPatterns()
        local memoryPatterns = {}
        
        -- สแกน StringValues สำหรับรหัสลับ
        for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("StringValue") then
                local value = obj.Value
                if value and (string.len(value) == 36 or string.find(string.lower(obj.Name), "secret") or string.find(string.lower(obj.Name), "code")) then
                    table.insert(memoryPatterns, {
                        name = obj.Name,
                        value = value,
                        path = obj:GetFullName()
                    })
                end
            end
        end
        
        -- สแกน Scripts สำหรับรหัสลับ
        for _, script in pairs(ReplicatedStorage:GetDescendants()) do
            if script:IsA("Script") or script:IsA("LocalScript") or script:IsA("ModuleScript") then
                local success, source = pcall(function()
                    return script.Source
                end)
                
                if success and source then
                    -- หารูปแบบรหัสลับในโค้ด
                    local patterns = {
                        "[\"'](%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x)[\"']",
                        "[\"'](%d+)[\"']",
                        "[\"']([%a%d]+)[\"']",
                        "= (%d+)",
                        "= [\"']([%w%s]+)[\"']"
                    }
                    
                    for _, pattern in pairs(patterns) do
                        for code in string.gmatch(source, pattern) do
                            if string.len(code) > 3 and string.len(code) < 100 then
                                table.insert(memoryPatterns, {
                                    name = script.Name .. " Code",
                                    value = code,
                                    path = script:GetFullName()
                                })
                            end
                        end
                    end
                end
            end
        end
        
        return memoryPatterns
    end

    bypassCommonChecks()
    bypassEnabled = true
    return true
end

-- ฟังก์ชันอัพเดท Progress Bar
function updateProgress(percent, text)
    ProgressFill.Size = UDim2.new(percent, 0, 1, 0)
    if text then
        StatusLabel.Text = text
    end
end

-- ฟังก์ชันหาและตรวจสอบ RemoteEvent จริง + เจาะรหัส
function findAndValidateRemotes()
    validRemotes = {}
    
    local remotePaths = {
        "ReplicatedStorage.Packages.Knit.Services.OrbService.RF.Collect",
        "ReplicatedStorage.Packages.Network.RE.Orb Collected",
        "ReplicatedStorage.RemoteEvents.OrbCollected",
        "ReplicatedStorage.Events.OrbCollection",
        "ReplicatedStorage.OrbEvents.CollectOrb",
        "ReplicatedStorage.CustomEvents.OrbCollect",
        "ReplicatedStorage.OrbRemote",
        "ReplicatedStorage.RE.OrbCollected",
        "ReplicatedStorage.RemoteFunction.OrbCollect",
        "ReplicatedStorage.Events.CollectOrb",
        "ReplicatedStorage.RemoteEvents.CollectItem",
        "ReplicatedStorage.Events.ItemPickup"
    }
    
    -- ตรวจสอบ paths ที่กำหนด
    for _, path in ipairs(remotePaths) do
        local current = game
        local valid = true
        
        for _, part in ipairs(string.split(path, ".")) do
            if current:FindFirstChild(part) then
                current = current[part]
            else
                valid = false
                break
            end
        end
        
        if valid and (current:IsA("RemoteEvent") or current:IsA("RemoteFunction")) then
            -- ทดสอบว่าใช้งานได้จริง
            local success = pcall(function()
                if current:IsA("RemoteEvent") then
                    current:FireServer("TestZone", "TestOrb")
                else
                    current:InvokeServer("TestZone", "TestOrb")
                end
                return true
            end)
            
            if success then
                table.insert(validRemotes, current)
            end
        end
    end
    
    -- สแกนหาแบบอัตโนมัติและทดสอบ
    local function scanAndTestRemotes(parent)
        for _, child in pairs(parent:GetChildren()) do
            if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                local name = string.lower(child.Name)
                if string.find(name, "orb") or string.find(name, "collect") or 
                   string.find(name, "pickup") or string.find(name, "item") or
                   string.find(name, "reward") or string.find(name, "coin") then
                   
                    -- ทดสอบว่า Remote ใช้งานได้จริง
                    local success = pcall(function()
                        if child:IsA("RemoteEvent") then
                            child:FireServer("TestZone", "TestOrb")
                        else
                            child:InvokeServer("TestZone", "TestOrb")
                        end
                        return true
                    end)
                    
                    if success then
                        table.insert(validRemotes, child)
                    end
                end
            end
            scanAndTestRemotes(child)
        end
    end
    
    scanAndTestRemotes(ReplicatedStorage)
    scanAndTestRemotes(game:GetService("ServerScriptService"))
    
    return #validRemotes > 0 and validRemotes[1] or nil
end

-- ฟังก์ชันทดสอบ Orb ว่าทำงานได้จริง + เจาะรหัส
function testOrbWithCrack(remote, zone, orbId)
    local success, result = pcall(function()
        if remote:IsA("RemoteEvent") then
            remote:FireServer(zone, orbId)
        else
            remote:InvokeServer(zone, orbId)
        end
        return true
    end)
    
    -- ถ้าไม่สำเร็จ ให้ลองเจาะรหัส
    if not success then
        local crackedCodes = crackSecretCodes(remote)
        for _, code in pairs(crackedCodes) do
            local crackSuccess = pcall(function()
                if remote:IsA("RemoteEvent") then
                    remote:FireServer(zone, code)
                else
                    remote:InvokeServer(zone, code)
                end
                return true
            end)
            
            if crackSuccess then
                return true, code
            end
        end
    end
    
    return success, orbId
end

-- ฟังก์ชันสแกนหาของจริงและทดสอบ + เจาะรหัส
function deepScanAndBypass()
    StatusLabel.Text = "🟡 Status: Starting deep scan with bypass..."
    updateProgress(0.1, "🟡 Activating bypass...")
    foundOrbs = {}
    
    -- เปิดใช้งานบายพาส
    if not bypassEnabled then
        enableAdvancedBypass()
    end
    
    -- หาและตรวจสอบ RemoteEvent
    updateProgress(0.2, "🟡 Finding remote events...")
    local orbRemote = findAndValidateRemotes()
    
    if orbRemote then
        updateProgress(0.4, "🟢 Found: " .. orbRemote.Name)
        
        -- เจาะรหัสลับจาก Remote นี้
        updateProgress(0.5, "🟡 Cracking secret codes...")
        local crackedCodes = crackSecretCodes(orbRemote)
        local memoryCodes = crackMemoryPatterns()
        
        -- เพิ่มรหัสที่เจาะได้
        for _, code in pairs(crackedCodes) do
            table.insert(foundOrbs, {
                zone = "Cracked Code",
                orbId = code,
                name = "Secret Code: " .. code,
                verified = true,
                remote = orbRemote,
                cracked = true
            })
        end
        
        for _, codeData in pairs(memoryCodes) do
            local success = pcall(function()
                if orbRemote:IsA("RemoteEvent") then
                    orbRemote:FireServer("Memory", codeData.value)
                else
                    orbRemote:InvokeServer("Memory", codeData.value)
                end
                return true
            end)
            
            if success then
                table.insert(foundOrbs, {
                    zone = "Memory: " .. codeData.path,
                    orbId = codeData.value,
                    name = codeData.name,
                    verified = true,
                    remote = orbRemote,
                    cracked = true
                })
            end
        end
    else
        updateProgress(0.4, "🔴 No valid remote found")
    end

    -- สแกน Workspace
    updateProgress(0.6, "🟡 Scanning workspace...")
    local scannedItems = 0
    
    local function scanWorkspace(parent, path, depth)
        if depth > 6 then return end
        
        for _, obj in pairs(parent:GetChildren()) do
            pcall(function()
                local name = string.lower(obj.Name)
                local isCollectible = string.find(name, "orb") or string.find(name, "crystal") or
                                    string.find(name, "collect") or string.find(name, "pickup") or
                                    string.find(name, "item") or string.find(name, "reward") or
                                    string.find(name, "coin") or string.find(name, "gem") or
                                    string.find(name, "chest") or string.find(name, "treasure")
                
                if isCollectible and orbRemote then
                    scannedItems = scannedItems + 1
                    
                    local orbId = obj:GetAttribute("OrbId") or obj:GetAttribute("ItemId") or 
                                 obj:GetAttribute("UUID") or obj:GetAttribute("ID") or
                                 tostring(obj:GetDebugId())
                    
                    -- ทดสอบว่า Orb ใช้งานได้จริง
                    local isValid, crackedCode = testOrbWithCrack(orbRemote, path, orbId)
                    
                    if isValid then
                        table.insert(foundOrbs, {
                            zone = path,
                            orbId = crackedCode or orbId,
                            name = obj.Name,
                            object = obj,
                            verified = true,
                            remote = orbRemote,
                            cracked = crackedCode ~= nil
                        })
                    end
                end
                
                -- เรียกซ้ำ
                scanWorkspace(obj, path .. " > " .. obj.Name, depth + 1)
            end)
        end
    end

    scanWorkspace(workspace, "Workspace", 0)
    
    -- สแกน ReplicatedStorage
    updateProgress(0.8, "🟡 Scanning data...")
    local function scanReplicated()
        for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
            pcall(function()
                if obj:IsA("StringValue") then
                    local value = obj.Value
                    if value and (string.len(value) == 36 or string.find(string.lower(obj.Name), "id")) then
                        scannedItems = scannedItems + 1
                        
                        if orbRemote then
                            local isValid, crackedCode = testOrbWithCrack(orbRemote, "Data", value)
                            
                            if isValid then
                                table.insert(foundOrbs, {
                                    zone = "ReplicatedStorage",
                                    orbId = crackedCode or value,
                                    name = obj.Name,
                                    verified = true,
                                    remote = orbRemote,
                                    cracked = crackedCode ~= nil
                                })
                            end
                        end
                    end
                end
            end)
        end
    end
    
    scanReplicated()
    
    updateProgress(1.0, "🟢 Scan complete! Found " .. #foundOrbs .. " working items")
    wait(1)
    updateProgress(0, "🟢 Ready - " .. #foundOrbs .. " working items")
    
    updateOrbList()
end

-- อัพเดตลิสต์ (แสดงเฉพาะของที่ใช้งานได้)
function updateOrbList(searchTerm)
    ListFrame:ClearAllChildren()
    ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local yPosition = 5
    local validCount = 0
    
    for _, orb in pairs(foundOrbs) do
        -- แสดงเฉพาะของที่ verified และใช้งานได้จริง
        if orb.verified then
            local displayText = orb.name
            local searchText = displayText .. orb.orbId .. orb.zone
            
            if not searchTerm or searchTerm == "" or string.find(string.lower(searchText), string.lower(searchTerm)) then
                validCount = validCount + 1
                
                local OrbFrame = Instance.new("Frame")
                OrbFrame.Size = UDim2.new(1, -10, 0, 65)
                OrbFrame.Position = UDim2.new(0, 5, 0, yPosition)
                
                if orb.cracked then
                    OrbFrame.BackgroundColor3 = Color3.fromRGB(80, 40, 120) -- สีม่วงสำหรับรหัสที่เจาะได้
                else
                    OrbFrame.BackgroundColor3 = Color3.fromRGB(30, 60, 40) -- สีเขียวสำหรับของปกติ
                end
                
                OrbFrame.Parent = ListFrame
                
                local OrbCorner = Instance.new("UICorner")
                OrbCorner.CornerRadius = UDim.new(0, 8)
                OrbCorner.Parent = OrbFrame

                local OrbGradient = Instance.new("UIGradient")
                if orb.cracked then
                    OrbGradient.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 40, 120)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 60, 180))
                    })
                else
                    OrbGradient.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 80, 50)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 100, 70))
                    })
                end
                OrbGradient.Parent = OrbFrame

                local InfoLabel = Instance.new("TextLabel")
                InfoLabel.Size = UDim2.new(0.7, 0, 0.5, 0)
                InfoLabel.Position = UDim2.new(0, 10, 0, 5)
                
                if orb.cracked then
                    InfoLabel.Text = "🔓 " .. displayText
                else
                    InfoLabel.Text = "✅ " .. displayText
                end
                
                InfoLabel.BackgroundTransparency = 1
                InfoLabel.TextColor3 = Color3.new(1, 1, 1)
                InfoLabel.Font = Enum.Font.Gotham
                InfoLabel.TextSize = 12
                InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
                InfoLabel.Parent = OrbFrame
                
                local IDLabel = Instance.new("TextLabel")
                IDLabel.Size = UDim2.new(0.7, 0, 0.3, 0)
                IDLabel.Position = UDim2.new(0, 10, 0.5, 0)
                IDLabel.Text = "🎯 " .. string.sub(orb.orbId, 1, 20) .. "..."
                IDLabel.BackgroundTransparency = 1
                IDLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
                IDLabel.Font = Enum.Font.Gotham
                IDLabel.TextSize = 10
                IDLabel.TextXAlignment = Enum.TextXAlignment.Left
                IDLabel.Parent = OrbFrame
                
                local TypeLabel = Instance.new("TextLabel")
                TypeLabel.Size = UDim2.new(0.7, 0, 0.2, 0)
                TypeLabel.Position = UDim2.new(0, 10, 0.8, 0)
                
                if orb.cracked then
                    TypeLabel.Text = "💎 CRACKED CODE"
                    TypeLabel.TextColor3 = Color3.fromRGB(255, 200, 255)
                else
                    TypeLabel.Text = "✨ VALID ITEM"
                    TypeLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
                end
                
                TypeLabel.BackgroundTransparency = 1
                TypeLabel.Font = Enum.Font.GothamBold
                TypeLabel.TextSize = 9
                TypeLabel.TextXAlignment = Enum.TextXAlignment.Left
                TypeLabel.Parent = OrbFrame
                
                local CollectButton = Instance.new("TextButton")
                CollectButton.Size = UDim2.new(0.25, 0, 0.6, 0)
                CollectButton.Position = UDim2.new(0.73, 0, 0.2, 0)
                CollectButton.Text = "🚀 FIRE"
                CollectButton.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
                CollectButton.TextColor3 = Color3.new(1, 1, 1)
                CollectButton.Font = Enum.Font.GothamBold
                CollectButton.TextSize = 11
                CollectButton.Parent = OrbFrame
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 6)
                ButtonCorner.Parent = CollectButton

                local ButtonGradient = Instance.new("UIGradient")
                ButtonGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 160, 70)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 220, 120))
                })
                ButtonGradient.Parent = CollectButton
                
                CollectButton.MouseButton1Click:Connect(function()
                    if orb.remote then
                        local args = {orb.zone, orb.orbId}
                        if orb.remote:IsA("RemoteEvent") then
                            orb.remote:FireServer(unpack(args))
                        else
                            orb.remote:InvokeServer(unpack(args))
                        end
                        StatusLabel.Text = "🎯 Fired: " .. orb.name
                    end
                end)
                
                yPosition = yPosition + 70
                ListFrame.CanvasSize = UDim2.new(0, 0, 0, yPosition)
            end
        end
    end
    
    if validCount == 0 then
        local NoResults = Instance.new("TextLabel")
        NoResults.Size = UDim2.new(1, 0, 0, 80)
        NoResults.Position = UDim2.new(0, 0, 0, 10)
        NoResults.Text = "No working items found.\nClick Deep Scan to find working items!"
        NoResults.BackgroundTransparency = 1
        NoResults.TextColor3 = Color3.fromRGB(150, 150, 150)
        NoResults.Font = Enum.Font.Gotham
        NoResults.TextSize = 14
        NoResults.TextYAlignment = Enum.TextYAlignment.Center
        NoResults.Parent = ListFrame
    end
    
    StatusLabel.Text = "🟢 Ready - " .. validCount .. " working items available"
end

-- Auto Farm
function startAutoFarm()
    if isAutoCollecting then return end
    
    if #foundOrbs == 0 then
        StatusLabel.Text = "🔴 No working items to farm"
        return
    end
    
    isAutoCollecting = true
    AutoFarmButton.Text = "🛑 STOP"
    AutoFarmButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    
    spawn(function()
        local cycle = 0
        while isAutoCollecting do
            cycle = cycle + 1
            StatusLabel.Text = "🌟 Farming - Cycle " .. cycle
            
            for _, orb in pairs(foundOrbs) do
                if not isAutoCollecting then break end
                if orb.verified and orb.remote then
                    local args = {orb.zone, orb.orbId}
                    if orb.remote:IsA("RemoteEvent") then
                        orb.remote:FireServer(unpack(args))
                    else
                        orb.remote:InvokeServer(unpack(args))
                    end
                    wait(0.1)
                end
            end
            wait(0.3)
        end
    end)
end

function stopAutoFarm()
    isAutoCollecting = false
    AutoFarmButton.Text = "⚡ AUTO FARM"
    AutoFarmButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    StatusLabel.Text = "🟢 Auto farm stopped"
end

-- Mass Collect
function massCollectAll()
    if #foundOrbs == 0 then
        StatusLabel.Text = "🔴 No working items to collect"
        return
    end
    
    local collected = 0
    for _, orb in pairs(foundOrbs) do
        if orb.verified and orb.remote then
            local args = {orb.zone, orb.orbId}
            if orb.remote:IsA("RemoteEvent") then
                orb.remote:FireServer(unpack(args))
            else
                orb.remote:InvokeServer(unpack(args))
            end
            collected = collected + 1
            StatusLabel.Text = "💥 Collecting: " .. collected .. "/" .. #foundOrbs
            wait(0.05)
        end
    end
    StatusLabel.Text = "✅ Collected " .. collected .. " items"
end

-- โหลดสคริปต์
function loadInfiniteYield()
    ToolsStatus.Text = "🟡 Loading Infinite Yield..."
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        ToolsStatus.Text = "✅ Infinite Yield Loaded!"
    end)
end

function loadDexExplorer()
    ToolsStatus.Text = "🟡 Loading Dex Explorer..."
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()
        ToolsStatus.Text = "✅ Dex Explorer Loaded!"
    end)
end

function loadRemoteSpy()
    ToolsStatus.Text = "🟡 Loading Remote Spy..."
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/exxtremestuffs/SimpleSpySource/master/SimpleSpy.lua'))()
        ToolsStatus.Text = "✅ Remote Spy Loaded!"
    end)
end

function loadScriptHub()
    ToolsStatus.Text = "🟡 Loading Script Hub..."
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/2dgeneralspam1/scripts-and-stuff/master/scripts/Loadstring', true))()
        ToolsStatus.Text = "✅ Script Hub Loaded!"
    end)
end

function activateAdvancedBypass()
    ToolsStatus.Text = "🟡 Activating Advanced Bypass..."
    local success = enableAdvancedBypass()
    if success then
        ToolsStatus.Text = "✅ Advanced Bypass Activated!"
        BypassButton.Text = "🛡️ BYPASS ACTIVE"
        BypassButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
    else
        ToolsStatus.Text = "🔴 Bypass Failed"
    end
end

-- Minimize Function
function toggleMinimize()
    if isMinimized then
        -- ขยาย
        MainFrame.Size = UDim2.new(0, 450, 0, 650)
        ContentArea.Visible = true
        MinimizeButton.Text = "─"
        isMinimized = false
    else
        -- พับ
        MainFrame.Size = UDim2.new(0, 450, 0, 60)
        ContentArea.Visible = false
        MinimizeButton.Text = "＋"
        isMinimized = true
    end
end

-- Event Handlers
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.MouseButton1Click:Connect(toggleMinimize)

MainTab.MouseButton1Click:Connect(function()
    MainContent.Visible = true
    ToolsContent.Visible = false
    MainTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    ToolsTab.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
end)

ToolsTab.MouseButton1Click:Connect(function()
    MainContent.Visible = false
    ToolsContent.Visible = true
    MainTab.BackgroundColor3 = Color3.fromRGB(70, 70, 90)
    ToolsTab.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
end)

ScanButton.MouseButton1Click:Connect(deepScanAndBypass)
BypassButton.MouseButton1Click:Connect(activateAdvancedBypass)

AutoFarmButton.MouseButton1Click:Connect(function()
    if isAutoCollecting then
        stopAutoFarm()
    else
        startAutoFarm()
    end
end)

MassCollectButton.MouseButton1Click:Connect(massCollectAll)

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateOrbList(SearchBox.Text)
end)

IYButton.MouseButton1Click:Connect(loadInfiniteYield)
DexButton.MouseButton1Click:Connect(loadDexExplorer)
RemoteSpyButton.MouseButton1Click:Connect(loadRemoteSpy)
ScriptHubButton.MouseButton1Click:Connect(loadScriptHub)
AdvancedBypassButton.MouseButton1Click:Connect(activateAdvancedBypass)

-- เริ่มต้น
StatusLabel.Text = "🟢 Ready! Click Deep Scan to find working items"

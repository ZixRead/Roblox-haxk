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
MainFrame.Size = UDim2.new(0, 400, 0, 550)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
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
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 50)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Header.Parent = MainFrame

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 12)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "🔮 ORB HUNTER PRO"
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Header

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0.5, -15)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = Header

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Tabs
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 40)
TabContainer.Position = UDim2.new(0, 10, 0, 55)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local MainTab = Instance.new("TextButton")
MainTab.Size = UDim2.new(0.48, 0, 1, 0)
MainTab.Position = UDim2.new(0, 0, 0, 0)
MainTab.Text = "MAIN"
MainTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainTab.TextColor3 = Color3.new(1, 1, 1)
MainTab.Font = Enum.Font.GothamBold
MainTab.TextSize = 12
MainTab.Parent = TabContainer

local MainTabCorner = Instance.new("UICorner")
MainTabCorner.CornerRadius = UDim.new(0, 6)
MainTabCorner.Parent = MainTab

local ToolsTab = Instance.new("TextButton")
ToolsTab.Size = UDim2.new(0.48, 0, 1, 0)
ToolsTab.Position = UDim2.new(0.52, 0, 0, 0)
ToolsTab.Text = "TOOLS"
ToolsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToolsTab.TextColor3 = Color3.fromRGB(180, 180, 180)
ToolsTab.Font = Enum.Font.GothamBold
ToolsTab.TextSize = 12
ToolsTab.Parent = TabContainer

local ToolsTabCorner = Instance.new("UICorner")
ToolsTabCorner.CornerRadius = UDim.new(0, 6)
ToolsTabCorner.Parent = ToolsTab

-- Main Content
local MainContent = Instance.new("Frame")
MainContent.Size = UDim2.new(1, -20, 0, 450)
MainContent.Position = UDim2.new(0, 10, 0, 100)
MainContent.BackgroundTransparency = 1
MainContent.Parent = MainFrame

-- Tools Content
local ToolsContent = Instance.new("Frame")
ToolsContent.Size = UDim2.new(1, -20, 0, 450)
ToolsContent.Position = UDim2.new(0, 10, 0, 100)
ToolsContent.BackgroundTransparency = 1
ToolsContent.Parent = MainFrame
ToolsContent.Visible = false

-- Control Buttons
local ControlFrame = Instance.new("Frame")
ControlFrame.Size = UDim2.new(1, 0, 0, 180)
ControlFrame.Position = UDim2.new(0, 0, 0, 0)
ControlFrame.BackgroundTransparency = 1
ControlFrame.Parent = MainContent

-- Scan Button
local ScanButton = Instance.new("TextButton")
ScanButton.Size = UDim2.new(1, 0, 0, 45)
ScanButton.Position = UDim2.new(0, 0, 0, 0)
ScanButton.Text = "🔍 DEEP SCAN ORBS"
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ScanButton.TextColor3 = Color3.new(1, 1, 1)
ScanButton.Font = Enum.Font.GothamBold
ScanButton.TextSize = 14
ScanButton.Parent = ControlFrame

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 8)
ScanCorner.Parent = ScanButton

-- Auto Farm Button
local AutoFarmButton = Instance.new("TextButton")
AutoFarmButton.Size = UDim2.new(0.48, 0, 0, 40)
AutoFarmButton.Position = UDim2.new(0, 0, 0, 50)
AutoFarmButton.Text = "⚡ AUTO FARM"
AutoFarmButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
AutoFarmButton.TextColor3 = Color3.new(1, 1, 1)
AutoFarmButton.Font = Enum.Font.GothamBold
AutoFarmButton.TextSize = 12
AutoFarmButton.Parent = ControlFrame

local AutoFarmCorner = Instance.new("UICorner")
AutoFarmCorner.CornerRadius = UDim.new(0, 6)
AutoFarmCorner.Parent = AutoFarmButton

-- Mass Collect Button
local MassCollectButton = Instance.new("TextButton")
MassCollectButton.Size = UDim2.new(0.48, 0, 0, 40)
MassCollectButton.Position = UDim2.new(0.52, 0, 0, 50)
MassCollectButton.Text = "💥 MASS COLLECT"
MassCollectButton.BackgroundColor3 = Color3.fromRGB(220, 0, 0)
MassCollectButton.TextColor3 = Color3.new(1, 1, 1)
MassCollectButton.Font = Enum.Font.GothamBold
MassCollectButton.TextSize = 12
MassCollectButton.Parent = ControlFrame

local MassCollectCorner = Instance.new("UICorner")
MassCollectCorner.CornerRadius = UDim.new(0, 6)
MassCollectCorner.Parent = MassCollectButton

-- Status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0, 95)
StatusLabel.Text = "Status: Ready to scan"
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.new(1, 1, 1)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.Parent = ControlFrame

-- Search
local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, 0, 0, 35)
SearchBox.Position = UDim2.new(0, 0, 0, 130)
SearchBox.PlaceholderText = "🔍 Search items..."
SearchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SearchBox.TextColor3 = Color3.new(1, 1, 1)
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 12
SearchBox.Parent = ControlFrame

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchBox

-- List
local ListFrame = Instance.new("ScrollingFrame")
ListFrame.Size = UDim2.new(1, 0, 0, 250)
ListFrame.Position = UDim2.new(0, 0, 0, 180)
ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ListFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ListFrame.ScrollBarThickness = 5
ListFrame.Parent = MainContent

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 8)
ListCorner.Parent = ListFrame

-- Tools Section
local ToolsFrame = Instance.new("Frame")
ToolsFrame.Size = UDim2.new(1, 0, 1, 0)
ToolsFrame.Position = UDim2.new(0, 0, 0, 0)
ToolsFrame.BackgroundTransparency = 1
ToolsFrame.Parent = ToolsContent

-- Infinite Yield
local IYButton = Instance.new("TextButton")
IYButton.Size = UDim2.new(1, 0, 0, 45)
IYButton.Position = UDim2.new(0, 0, 0, 0)
IYButton.Text = "🎮 LOAD INFINITE YIELD"
IYButton.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
IYButton.TextColor3 = Color3.new(1, 1, 1)
IYButton.Font = Enum.Font.GothamBold
IYButton.TextSize = 14
IYButton.Parent = ToolsFrame

local IYCorner = Instance.new("UICorner")
IYCorner.CornerRadius = UDim.new(0, 8)
IYCorner.Parent = IYButton

-- Dex Explorer
local DexButton = Instance.new("TextButton")
DexButton.Size = UDim2.new(1, 0, 0, 45)
DexButton.Position = UDim2.new(0, 0, 0, 50)
DexButton.Text = "🔍 LOAD DEX EXPLORER"
DexButton.BackgroundColor3 = Color3.fromRGB(150, 0, 150)
DexButton.TextColor3 = Color3.new(1, 1, 1)
DexButton.Font = Enum.Font.GothamBold
DexButton.TextSize = 14
DexButton.Parent = ToolsFrame

local DexCorner = Instance.new("UICorner")
DexCorner.CornerRadius = UDim.new(0, 8)
DexCorner.Parent = DexButton

-- Remote Spy
local RemoteSpyButton = Instance.new("TextButton")
RemoteSpyButton.Size = UDim2.new(1, 0, 0, 45)
RemoteSpyButton.Position = UDim2.new(0, 0, 0, 100)
RemoteSpyButton.Text = "📡 LOAD REMOTE SPY"
RemoteSpyButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
RemoteSpyButton.TextColor3 = Color3.new(1, 1, 1)
RemoteSpyButton.Font = Enum.Font.GothamBold
RemoteSpyButton.TextSize = 14
RemoteSpyButton.Parent = ToolsFrame

local RemoteSpyCorner = Instance.new("UICorner")
RemoteSpyCorner.CornerRadius = UDim.new(0, 8)
RemoteSpyCorner.Parent = RemoteSpyButton

-- Script Hub
local ScriptHubButton = Instance.new("TextButton")
ScriptHubButton.Size = UDim2.new(1, 0, 0, 45)
ScriptHubButton.Position = UDim2.new(0, 0, 0, 150)
ScriptHubButton.Text = "🚀 LOAD SCRIPT HUB"
ScriptHubButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
ScriptHubButton.TextColor3 = Color3.new(1, 1, 1)
ScriptHubButton.Font = Enum.Font.GothamBold
ScriptHubButton.TextSize = 14
ScriptHubButton.Parent = ToolsFrame

local ScriptHubCorner = Instance.new("UICorner")
ScriptHubCorner.CornerRadius = UDim.new(0, 8)
ScriptHubCorner.Parent = ScriptHubButton

-- Tools Status
local ToolsStatus = Instance.new("TextLabel")
ToolsStatus.Size = UDim2.new(1, 0, 0, 40)
ToolsStatus.Position = UDim2.new(0, 0, 0, 200)
ToolsStatus.Text = "Tools: Ready to load"
ToolsStatus.BackgroundTransparency = 1
ToolsStatus.TextColor3 = Color3.new(1, 1, 1)
ToolsStatus.Font = Enum.Font.Gotham
ToolsStatus.TextSize = 12
ToolsStatus.Parent = ToolsFrame

-- ตัวแปร
local foundOrbs = {}
local isAutoCollecting = false

-- ฟังก์ชันหา RemoteEvent จริง
function findOrbRemote()
    -- ลองหาใน paths ต่างๆ
    local paths = {
        "ReplicatedStorage.Packages.Knit.Services.OrbService.RF.Collect",
        "ReplicatedStorage.Packages.Network.RE.Orb Collected",
        "ReplicatedStorage.RemoteEvents.OrbCollected",
        "ReplicatedStorage.Events.OrbCollection",
        "ReplicatedStorage.OrbEvents.CollectOrb",
        "ReplicatedStorage.CustomEvents.OrbCollect",
        "ReplicatedStorage.OrbRemote",
        "ReplicatedStorage.RE.OrbCollected",
        "ReplicatedStorage.RemoteFunction.OrbCollect"
    }
    
    for _, path in ipairs(paths) do
        local current = game
        for _, part in ipairs(string.split(path, ".")) do
            if current:FindFirstChild(part) then
                current = current[part]
            else
                current = nil
                break
            end
        end
        if current and (current:IsA("RemoteEvent") or current:IsA("RemoteFunction")) then
            return current
        end
    end
    
    -- สแกนหาแบบอัตโนมัติ
    local function scanForRemote(parent)
        for _, child in pairs(parent:GetChildren()) do
            if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                local name = string.lower(child.Name)
                if string.find(name, "orb") or string.find(name, "collect") or string.find(name, "pickup") then
                    return child
                end
            end
            local result = scanForRemote(child)
            if result then return result end
        end
        return nil
    end
    
    return scanForRemote(ReplicatedStorage)
end

-- ฟังก์ชันสแกนหาของจริง
function deepScanForOrbs()
    StatusLabel.Text = "Status: 🔍 Starting deep scan..."
    foundOrbs = {}
    
    -- หา RemoteEvent
    local orbRemote = findOrbRemote()
    
    if orbRemote then
        StatusLabel.Text = "Status: ✅ Found Remote: " .. orbRemote.Name
        table.insert(foundOrbs, {
            zone = "RemoteEvent",
            orbId = "AUTO_DETECT",
            name = orbRemote.Name,
            verified = true
        })
    else
        StatusLabel.Text = "Status: ❌ No RemoteEvent found"
    end

    -- สแกน Workspace
    local function scanWorkspace(parent, path)
        for _, obj in pairs(parent:GetChildren()) do
            pcall(function()
                local name = string.lower(obj.Name)
                
                -- ตรวจสอบชื่อที่เกี่ยวข้อง
                if string.find(name, "orb") or string.find(name, "crystal") or 
                   string.find(name, "collect") or string.find(name, "pickup") or
                   string.find(name, "item") or string.find(name, "reward") or
                   string.find(name, "coin") or string.find(name, "gem") or
                   string.find(name, "chest") or string.find(name, "treasure") then
                    
                    local orbId = obj:GetAttribute("OrbId") or 
                                 obj:GetAttribute("ItemId") or 
                                 obj:GetAttribute("UUID") or
                                 obj:GetAttribute("ID") or
                                 tostring(obj:GetDebugId())
                    
                    table.insert(foundOrbs, {
                        zone = path,
                        orbId = orbId,
                        name = obj.Name,
                        object = obj,
                        verified = true
                    })
                end
                
                -- ตรวจสอบ Attributes
                for attrName, attrValue in pairs(obj:GetAttributes()) do
                    if type(attrValue) == "string" and (string.len(attrValue) == 36 or string.find(string.lower(attrName), "id")) then
                        table.insert(foundOrbs, {
                            zone = path .. " [Attr]",
                            orbId = attrValue,
                            name = obj.Name .. "." .. attrName,
                            verified = false
                        })
                    end
                end
                
                -- เรียกซ้ำ
                if #obj:GetChildren() > 0 then
                    scanWorkspace(obj, path .. " > " .. obj.Name)
                end
            end)
        end
    end

    -- สแกน ReplicatedStorage
    local function scanReplicated()
        for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
            pcall(function()
                if obj:IsA("StringValue") then
                    local value = obj.Value
                    if value and (string.len(value) == 36 or string.find(string.lower(obj.Name), "id")) then
                        table.insert(foundOrbs, {
                            zone = "ReplicatedStorage",
                            orbId = value,
                            name = obj.Name,
                            verified = true
                        })
                    end
                elseif obj:IsA("Folder") and (string.find(string.lower(obj.Name), "orb") or string.find(string.lower(obj.Name), "item")) then
                    for _, item in pairs(obj:GetChildren()) do
                        if item:IsA("StringValue") then
                            table.insert(foundOrbs, {
                                zone = "Folder: " .. obj.Name,
                                orbId = item.Value or item.Name,
                                name = item.Name,
                                verified = true
                            })
                        end
                    end
                end
            end)
        end
    end

    -- เริ่มสแกน
    scanWorkspace(workspace, "Workspace")
    scanReplicated()
    
    -- ถ้าไม่พบอะไรเลย ให้เพิ่มตัวอย่าง
    if #foundOrbs == 0 then
        table.insert(foundOrbs, {
            zone = "Town",
            orbId = "53b59272-a881-43c0-8205-46a16d893bac",
            name = "Sample Orb 1",
            verified = false
        })
        table.insert(foundOrbs, {
            zone = "Forest", 
            orbId = "f50fea77-0689-4c6a-93f2-1a2b3c4d5e6f",
            name = "Sample Orb 2",
            verified = false
        })
    end
    
    StatusLabel.Text = "Status: ✅ Found " .. #foundOrbs .. " items"
    updateOrbList()
end

-- อัพเดตลิสต์
function updateOrbList(searchTerm)
    ListFrame:ClearAllChildren()
    ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local yPosition = 5
    local count = 0
    
    for _, orb in pairs(foundOrbs) do
        local displayText = orb.name
        local searchText = displayText .. orb.orbId .. orb.zone
        
        if not searchTerm or searchTerm == "" or string.find(string.lower(searchText), string.lower(searchTerm)) then
            count = count + 1
            
            local OrbFrame = Instance.new("Frame")
            OrbFrame.Size = UDim2.new(1, -10, 0, 55)
            OrbFrame.Position = UDim2.new(0, 5, 0, yPosition)
            OrbFrame.BackgroundColor3 = orb.verified and Color3.fromRGB(30, 60, 30) or Color3.fromRGB(60, 50, 30)
            OrbFrame.Parent = ListFrame
            
            local OrbCorner = Instance.new("UICorner")
            OrbCorner.CornerRadius = UDim.new(0, 6)
            OrbCorner.Parent = OrbFrame

            local InfoLabel = Instance.new("TextLabel")
            InfoLabel.Size = UDim2.new(0.7, 0, 0.6, 0)
            InfoLabel.Position = UDim2.new(0, 8, 0, 5)
            InfoLabel.Text = displayText
            InfoLabel.BackgroundTransparency = 1
            InfoLabel.TextColor3 = Color3.new(1, 1, 1)
            InfoLabel.Font = Enum.Font.Gotham
            InfoLabel.TextSize = 11
            InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
            InfoLabel.Parent = OrbFrame
            
            local IDLabel = Instance.new("TextLabel")
            IDLabel.Size = UDim2.new(0.7, 0, 0.4, 0)
            IDLabel.Position = UDim2.new(0, 8, 0.6, 0)
            IDLabel.Text = string.sub(orb.orbId, 1, 20) .. "..."
            IDLabel.BackgroundTransparency = 1
            IDLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            IDLabel.Font = Enum.Font.Gotham
            IDLabel.TextSize = 9
            IDLabel.TextXAlignment = Enum.TextXAlignment.Left
            IDLabel.Parent = OrbFrame
            
            local CollectButton = Instance.new("TextButton")
            CollectButton.Size = UDim2.new(0.25, 0, 0.6, 0)
            CollectButton.Position = UDim2.new(0.73, 0, 0.2, 0)
            CollectButton.Text = orb.verified and "🚀 FIRE" or "❓ TRY"
            CollectButton.BackgroundColor3 = orb.verified and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 120, 0)
            CollectButton.TextColor3 = Color3.new(1, 1, 1)
            CollectButton.Font = Enum.Font.GothamBold
            CollectButton.TextSize = 10
            CollectButton.Parent = OrbFrame
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 4)
            ButtonCorner.Parent = CollectButton
            
            CollectButton.MouseButton1Click:Connect(function()
                local remote = findOrbRemote()
                if remote then
                    local args = {orb.zone, orb.orbId}
                    remote:FireServer(unpack(args))
                    StatusLabel.Text = "Status: 🎯 Fired: " .. orb.name
                else
                    StatusLabel.Text = "Status: ❌ No remote found!"
                end
            end)
            
            yPosition = yPosition + 60
            ListFrame.CanvasSize = UDim2.new(0, 0, 0, yPosition)
        end
    end
    
    if count == 0 then
        local NoResults = Instance.new("TextLabel")
        NoResults.Size = UDim2.new(1, 0, 0, 50)
        NoResults.Position = UDim2.new(0, 0, 0, 10)
        NoResults.Text = "No items found. Try Deep Scan!"
        NoResults.BackgroundTransparency = 1
        NoResults.TextColor3 = Color3.fromRGB(150, 150, 150)
        NoResults.Font = Enum.Font.Gotham
        NoResults.TextSize = 12
        NoResults.Parent = ListFrame
    end
end

-- Auto Farm
function startAutoFarm()
    if isAutoCollecting then return end
    
    local remote = findOrbRemote()
    if not remote then
        StatusLabel.Text = "Status: ❌ No remote found!"
        return
    end
    
    isAutoCollecting = true
    AutoFarmButton.Text = "🛑 STOP"
    AutoFarmButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    
    spawn(function()
        local cycle = 0
        while isAutoCollecting do
            cycle = cycle + 1
            StatusLabel.Text = "Status: 🌟 Farming - Cycle " .. cycle
            
            for _, orb in pairs(foundOrbs) do
                if not isAutoCollecting then break end
                local args = {orb.zone, orb.orbId}
                remote:FireServer(unpack(args))
                wait(0.1)
            end
            wait(0.3)
        end
    end)
end

function stopAutoFarm()
    isAutoCollecting = false
    AutoFarmButton.Text = "⚡ AUTO FARM"
    AutoFarmButton.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    StatusLabel.Text = "Status: Auto farm stopped"
end

-- Mass Collect
function massCollectAll()
    local remote = findOrbRemote()
    if not remote then
        StatusLabel.Text = "Status: ❌ No remote found!"
        return
    end
    
    local collected = 0
    for _, orb in pairs(foundOrbs) do
        local args = {orb.zone, orb.orbId}
        remote:FireServer(unpack(args))
        collected = collected + 1
        StatusLabel.Text = "Status: 💥 Collecting: " .. collected .. "/" .. #foundOrbs
        wait(0.05)
    end
    StatusLabel.Text = "Status: ✅ Collected " .. collected .. " items"
end

-- โหลดสคริปต์
function loadInfiniteYield()
    ToolsStatus.Text = "Loading Infinite Yield..."
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        ToolsStatus.Text = "✅ Infinite Yield Loaded!"
    end)
end

function loadDexExplorer()
    ToolsStatus.Text = "Loading Dex Explorer..."
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/infyiff/backup/main/dex.lua'))()
        ToolsStatus.Text = "✅ Dex Explorer Loaded!"
    end)
end

function loadRemoteSpy()
    ToolsStatus.Text = "Loading Remote Spy..."
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/78n/SimpleSpy/main/SimpleSpySource.lua'))()
        ToolsStatus.Text = "✅ Remote Spy Loaded!"
    end)
end

function loadScriptHub()
    ToolsStatus.Text = "Loading Script Hub..."
    pcall(function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/2dgeneralspam1/scripts-and-stuff/master/scripts/Loadstring', true))()
        ToolsStatus.Text = "✅ Script Hub Loaded!"
    end)
end

-- Event Handlers
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MainTab.MouseButton1Click:Connect(function()
    MainContent.Visible = true
    ToolsContent.Visible = false
    MainTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    ToolsTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
end)

ToolsTab.MouseButton1Click:Connect(function()
    MainContent.Visible = false
    ToolsContent.Visible = true
    MainTab.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ToolsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)

ScanButton.MouseButton1Click:Connect(deepScanForOrbs)

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

-- เริ่มต้น
StatusLabel.Text = "Status: 🚀 Ready! Click Deep Scan"

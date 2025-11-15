local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- รอให้ PlayerGui โหลด
if not player:FindFirstChild("PlayerGui") then
    player:WaitForChild("PlayerGui")
end

-- หา RemoteEvent
local networkFolder = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Network")
local orbRemote = networkFolder:WaitForChild("RE"):WaitForChild("Orb Collected")

-- สร้าง UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OrbHunter"
ScreenGui.Parent = player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 450, 0, 500)
Frame.Position = UDim2.new(0.5, -225, 0.5, -250)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "🔮 ORB HUNTER - AUTO SCANNER"
Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Frame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = Title

-- Control Buttons Frame
local ControlFrame = Instance.new("Frame")
ControlFrame.Size = UDim2.new(1, -20, 0, 100)
ControlFrame.Position = UDim2.new(0, 10, 0, 45)
ControlFrame.BackgroundTransparency = 1
ControlFrame.Parent = Frame

-- Scan Button
local ScanButton = Instance.new("TextButton")
ScanButton.Size = UDim2.new(0.48, 0, 0, 40)
ScanButton.Position = UDim2.new(0, 0, 0, 0)
ScanButton.Text = "🔍 SCAN ORBS"
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
ScanButton.TextColor3 = Color3.new(1,1,1)
ScanButton.Font = Enum.Font.GothamBold
ScanButton.TextSize = 14
ScanButton.Parent = ControlFrame

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 6)
ScanCorner.Parent = ScanButton

-- Auto Collect Button
local AutoCollectButton = Instance.new("TextButton")
AutoCollectButton.Size = UDim2.new(0.48, 0, 0, 40)
AutoCollectButton.Position = UDim2.new(0.52, 0, 0, 0)
AutoCollectButton.Text = "⚡ AUTO COLLECT"
AutoCollectButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
AutoCollectButton.TextColor3 = Color3.new(1,1,1)
AutoCollectButton.Font = Enum.Font.GothamBold
AutoCollectButton.TextSize = 14
AutoCollectButton.Parent = ControlFrame

local AutoCorner = Instance.new("UICorner")
AutoCorner.CornerRadius = UDim.new(0, 6)
AutoCorner.Parent = AutoCollectButton

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0, 50)
StatusLabel.Text = "Status: Ready to scan"
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.new(1,1,1)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.Parent = ControlFrame

-- Search Box
local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, 0, 0, 35)
SearchBox.Position = UDim2.new(0, 0, 0, 85)
SearchBox.PlaceholderText = "🔍 Search by Zone or Orb ID..."
SearchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SearchBox.TextColor3 = Color3.new(1,1,1)
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 12
SearchBox.Parent = ControlFrame

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchBox

-- List Frame
local ListFrame = Instance.new("ScrollingFrame")
ListFrame.Size = UDim2.new(1, -20, 0, 300)
ListFrame.Position = UDim2.new(0, 10, 0, 160)
ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ListFrame.ScrollBarThickness = 6
ListFrame.Parent = Frame

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 6)
ListCorner.Parent = ListFrame

-- ตัวแปรเก็บข้อมูล
local foundOrbs = {}
local isAutoCollecting = false

-- ฟังก์ชันสแกนหา Orb IDs
function scanForOrbs()
    StatusLabel.Text = "Status: Scanning for orbs..."
    foundOrbs = {}
    
    -- ตรวจสอบ RemoteEvent และเก็บข้อมูล
    if orbRemote then
        table.insert(foundOrbs, {
            zone = "Town", 
            orbId = "53b59272-a881-43c0-8205-46a16d893bac",
            name = "Scanned Orb"
        })
    end
    
    -- สแกนใน Workspace สำหรับ part ที่อาจเป็น orb
    local function scanWorkspace(parent)
        for _, obj in pairs(parent:GetChildren()) do
            -- ตรวจสอบชื่อที่เกี่ยวข้องกับ orb
            if obj:IsA("Part") or obj:IsA("MeshPart") then
                local name = string.lower(obj.Name)
                if string.find(name, "orb") or string.find(name, "crystal") or string.find(name, "collect") then
                    table.insert(foundOrbs, {
                        zone = obj:FindFirstAncestorOfClass("Model") and obj:FindFirstAncestorOfClass("Model").Name or "Unknown",
                        orbId = obj:GetAttribute("OrbId") or tostring(obj:GetDebugId()),
                        name = obj.Name
                    })
                end
            end
            
            -- เรียกซ้ำสำหรับ folder อื่นๆ
            if #obj:GetChildren() > 0 then
                scanWorkspace(obj)
            end
        end
    end
    
    -- เริ่มสแกน
    scanWorkspace(workspace)
    
    -- ตรวจสอบ ReplicatedStorage สำหรับข้อมูล orb
    local function scanReplicatedStorage(parent, path)
        for _, obj in pairs(parent:GetChildren()) do
            if obj:IsA("Folder") and (string.find(string.lower(obj.Name), "orb") or string.find(string.lower(obj.Name), "collect")) then
                for _, item in pairs(obj:GetChildren()) do
                    if item:IsA("StringValue") or item:IsA("ObjectValue") then
                        table.insert(foundOrbs, {
                            zone = path,
                            orbId = item.Value or item.Name,
                            name = item.Name
                        })
                    end
                end
            end
            
            if #obj:GetChildren() > 0 then
                scanReplicatedStorage(obj, path .. " > " .. obj.Name)
            end
        end
    end
    
    scanReplicatedStorage(ReplicatedStorage, "ReplicatedStorage")
    
    StatusLabel.Text = "Status: Found " .. #foundOrbs .. " orbs"
    updateOrbList()
end

-- อัพเดตลิสต์ Orb
function updateOrbList(searchTerm)
    ListFrame:ClearAllChildren()
    ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local yPosition = 5
    local count = 0
    
    for _, orb in pairs(foundOrbs) do
        local displayText = orb.zone .. " - " .. orb.name
        
        -- กรองด้วย search term ถ้ามี
        if not searchTerm or searchTerm == "" or 
           string.find(string.lower(displayText), string.lower(searchTerm)) or
           string.find(string.lower(orb.orbId), string.lower(searchTerm)) then
            
            count = count + 1
            
            local OrbFrame = Instance.new("Frame")
            OrbFrame.Size = UDim2.new(1, -10, 0, 60)
            OrbFrame.Position = UDim2.new(0, 5, 0, yPosition)
            OrbFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            OrbFrame.Parent = ListFrame
            
            local OrbCorner = Instance.new("UICorner")
            OrbCorner.CornerRadius = UDim.new(0, 6)
            OrbCorner.Parent = OrbFrame
            
            local InfoLabel = Instance.new("TextLabel")
            InfoLabel.Size = UDim2.new(0.7, 0, 0.6, 0)
            InfoLabel.Position = UDim2.new(0, 10, 0, 5)
            InfoLabel.Text = displayText
            InfoLabel.BackgroundTransparency = 1
            InfoLabel.TextColor3 = Color3.new(1,1,1)
            InfoLabel.Font = Enum.Font.Gotham
            InfoLabel.TextSize = 12
            InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
            InfoLabel.Parent = OrbFrame
            
            local IDLabel = Instance.new("TextLabel")
            IDLabel.Size = UDim2.new(0.7, 0, 0.4, 0)
            IDLabel.Position = UDim2.new(0, 10, 0.6, 0)
            IDLabel.Text = "ID: " .. string.sub(orb.orbId, 1, 20) .. "..."
            IDLabel.BackgroundTransparency = 1
            IDLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            IDLabel.Font = Enum.Font.Gotham
            IDLabel.TextSize = 10
            IDLabel.TextXAlignment = Enum.TextXAlignment.Left
            IDLabel.Parent = OrbFrame
            
            local CollectButton = Instance.new("TextButton")
            CollectButton.Size = UDim2.new(0.25, 0, 0.7, 0)
            CollectButton.Position = UDim2.new(0.73, 0, 0.15, 0)
            CollectButton.Text = "COLLECT"
            CollectButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            CollectButton.TextColor3 = Color3.new(1,1,1)
            CollectButton.Font = Enum.Font.GothamBold
            CollectButton.TextSize = 12
            CollectButton.Parent = OrbFrame
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = CollectButton
            
            CollectButton.MouseButton1Click:Connect(function()
                local args = {
                    orb.zone,
                    orb.orbId
                }
                orbRemote:FireServer(unpack(args))
                StatusLabel.Text = "Status: Collected " .. orb.name
            end)
            
            yPosition = yPosition + 65
            ListFrame.CanvasSize = UDim2.new(0, 0, 0, yPosition)
        end
    end
    
    if count == 0 then
        local NoResults = Instance.new("TextLabel")
        NoResults.Size = UDim2.new(1, 0, 0, 50)
        NoResults.Position = UDim2.new(0, 0, 0, 10)
        NoResults.Text = "No orbs found. Try scanning!"
        NoResults.BackgroundTransparency = 1
        NoResults.TextColor3 = Color3.fromRGB(150, 150, 150)
        NoResults.Font = Enum.Font.Gotham
        NoResults.TextSize = 14
        NoResults.Parent = ListFrame
    end
end

-- ฟังก์ชัน Auto Collect
function startAutoCollect()
    if isAutoCollecting then return end
    
    isAutoCollecting = true
    AutoCollectButton.Text = "🛑 STOP AUTO"
    AutoCollectButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    
    spawn(function()
        while isAutoCollecting do
            for _, orb in pairs(foundOrbs) do
                if not isAutoCollecting then break end
                
                local args = {
                    orb.zone,
                    orb.orbId
                }
                orbRemote:FireServer(unpack(args))
                StatusLabel.Text = "Status: Auto-collecting " .. orb.name
                wait(0.5) -- รอครึ่งวินาทีระหว่างการเก็บ
            end
            wait(1)
        end
    end)
end

function stopAutoCollect()
    isAutoCollecting = false
    AutoCollectButton.Text = "⚡ AUTO COLLECT"
    AutoCollectButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    StatusLabel.Text = "Status: Auto-collect stopped"
end

-- Event Handlers
ScanButton.MouseButton1Click:Connect(scanForOrbs)

AutoCollectButton.MouseButton1Click:Connect(function()
    if isAutoCollecting then
        stopAutoCollect()
    else
        startAutoCollect()
    end
end)

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateOrbList(SearchBox.Text)
end)

-- สแกนอัตโนมัติเมื่อเริ่ม
wait(2)
scanForOrbs()

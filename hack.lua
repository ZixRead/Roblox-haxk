local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- รอให้ PlayerGui โหลด
if not player:FindFirstChild("PlayerGui") then
    player:WaitForChild("PlayerGui")
end

-- สร้าง UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OrbHunterPro"
ScreenGui.Parent = player.PlayerGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 500, 0, 600)
Frame.Position = UDim2.new(0.5, -250, 0.5, -300)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

-- Drop Shadow
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 0, 1, 0)
Shadow.Position = UDim2.new(0, 0, 0, 0)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
Shadow.ImageTransparency = 0.8
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.Parent = Frame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "🔮 ORB HUNTER PRO - AUTO EXPLOIT"
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.Parent = Frame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Control Buttons Frame
local ControlFrame = Instance.new("Frame")
ControlFrame.Size = UDim2.new(1, -20, 0, 120)
ControlFrame.Position = UDim2.new(0, 10, 0, 55)
ControlFrame.BackgroundTransparency = 1
ControlFrame.Parent = Frame

-- Scan Button
local ScanButton = Instance.new("TextButton")
ScanButton.Size = UDim2.new(0.48, 0, 0, 45)
ScanButton.Position = UDim2.new(0, 0, 0, 0)
ScanButton.Text = "🔍 DEEP SCAN"
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
ScanButton.TextColor3 = Color3.new(1,1,1)
ScanButton.Font = Enum.Font.GothamBold
ScanButton.TextSize = 14
ScanButton.Parent = ControlFrame

local ScanCorner = Instance.new("UICorner")
ScanCorner.CornerRadius = UDim.new(0, 8)
ScanCorner.Parent = ScanButton

-- Auto Collect Button
local AutoCollectButton = Instance.new("TextButton")
AutoCollectButton.Size = UDim2.new(0.48, 0, 0, 45)
AutoCollectButton.Position = UDim2.new(0.52, 0, 0, 0)
AutoCollectButton.Text = "⚡ AUTO FARM"
AutoCollectButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
AutoCollectButton.TextColor3 = Color3.new(1,1,1)
AutoCollectButton.Font = Enum.Font.GothamBold
AutoCollectButton.TextSize = 14
AutoCollectButton.Parent = ControlFrame

local AutoCorner = Instance.new("UICorner")
AutoCorner.CornerRadius = UDim.new(0, 8)
AutoCorner.Parent = AutoCollectButton

-- Mass Collect Button
local MassCollectButton = Instance.new("TextButton")
MassCollectButton.Size = UDim2.new(1, 0, 0, 45)
MassCollectButton.Position = UDim2.new(0, 0, 0, 50)
MassCollectButton.Text = "💥 MASS COLLECT ALL"
MassCollectButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
MassCollectButton.TextColor3 = Color3.new(1,1,1)
MassCollectButton.Font = Enum.Font.GothamBold
MassCollectButton.TextSize = 14
MassCollectButton.Parent = ControlFrame

local MassCorner = Instance.new("UICorner")
MassCorner.CornerRadius = UDim.new(0, 8)
MassCorner.Parent = MassCollectButton

-- Status Label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 100)
StatusLabel.Text = "Status: Ready to scan"
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.new(1,1,1)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.Parent = ControlFrame

-- Search Box
local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, 0, 0, 40)
SearchBox.Position = UDim2.new(0, 0, 0, 180)
SearchBox.PlaceholderText = "🔍 Search by Zone, Orb ID or Name..."
SearchBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
SearchBox.TextColor3 = Color3.new(1,1,1)
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 12
SearchBox.Parent = Frame

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchBox

-- List Frame
local ListFrame = Instance.new("ScrollingFrame")
ListFrame.Size = UDim2.new(1, -20, 0, 350)
ListFrame.Position = UDim2.new(0, 10, 0, 230)
ListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ListFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ListFrame.ScrollBarThickness = 8
ListFrame.Parent = Frame

local ListCorner = Instance.new("UICorner")
ListCorner.CornerRadius = UDim.new(0, 8)
ListCorner.Parent = ListFrame

-- ตัวแปรเก็บข้อมูล
local foundOrbs = {}
local isAutoCollecting = false
local isMassCollecting = false

-- ฟังก์ชันหา RemoteEvent
function findOrbRemote()
    local possiblePaths = {
        "ReplicatedStorage.Packages.Network.RE.Orb Collected",
        "ReplicatedStorage.RemoteEvents.OrbCollected", 
        "ReplicatedStorage.OrbEvents.CollectOrb",
        "ReplicatedStorage.OrbRemote",
        "ReplicatedStorage.RE.OrbCollected",
        "ReplicatedStorage.Events.OrbCollection",
        "ReplicatedStorage.Orb.Collected",
        "ReplicatedStorage.CustomEvents.OrbCollect"
    }
    
    for _, path in ipairs(possiblePaths) do
        local current = ReplicatedStorage
        local parts = string.split(path, ".")
        local found = true
        
        for i, part in ipairs(parts) do
            if i == 1 then continue end -- ข้าม ReplicatedStorage
            if current:FindFirstChild(part) then
                current = current:FindFirstChild(part)
            else
                found = false
                break
            end
        end
        
        if found and current:IsA("RemoteEvent") then
            return current
        end
    end
    
    return nil
end

-- ฟังก์ชันสแกนหา Orb IDs แบบลึก
function deepScanForOrbs()
    StatusLabel.Text = "Status: 🔍 Deep scanning started..."
    foundOrbs = {}
    
    -- หา RemoteEvent
    local orbRemote = findOrbRemote()
    
    if orbRemote then
        StatusLabel.Text = "Status: Found RemoteEvent: " .. orbRemote:GetFullName()
    else
        StatusLabel.Text = "Status: ❌ No Orb RemoteEvent found!"
        return
    end

    -- สแกนใน Workspace
    local function scanWorkspace(parent, depth)
        if depth > 10 then return end -- จำกัดความลึก
        
        for _, obj in pairs(parent:GetChildren()) do
            -- ตรวจสอบทุก Object
            local success, result = pcall(function()
                -- ตรวจสอบชื่อ
                local name = string.lower(obj.Name)
                local isOrbRelated = string.find(name, "orb") or 
                                   string.find(name, "crystal") or 
                                   string.find(name, "collect") or
                                   string.find(name, "item") or
                                   string.find(name, "pickup") or
                                   string.find(name, "reward")
                
                if isOrbRelated then
                    local orbId = obj:GetAttribute("OrbId") or 
                                 obj:GetAttribute("ID") or 
                                 obj:GetAttribute("UUID") or
                                 tostring(obj:GetDebugId())
                    
                    table.insert(foundOrbs, {
                        zone = obj:FindFirstAncestorOfClass("Model") and obj:FindFirstAncestorOfClass("Model").Name or "Workspace",
                        orbId = orbId,
                        name = obj.Name,
                        object = obj
                    })
                end
                
                -- ตรวจสอบ Attributes
                for attrName, attrValue in pairs(obj:GetAttributes()) do
                    if type(attrValue) == "string" and string.len(attrValue) == 36 then -- UUID format
                        if string.find(string.lower(attrName), "id") or string.find(string.lower(attrName), "uuid") then
                            table.insert(foundOrbs, {
                                zone = "Attribute: " .. attrName,
                                orbId = attrValue,
                                name = obj.Name .. " [" .. attrName .. "]",
                                object = obj
                            })
                        end
                    end
                end
                
                -- เรียกซ้ำ
                if #obj:GetChildren() > 0 then
                    scanWorkspace(obj, depth + 1)
                end
            end)
            
            if not success then
                -- ไม่ต้องทำอะไร ถ้าเกิด error
            end
        end
    end

    -- สแกน ReplicatedStorage สำหรับข้อมูล
    local function scanReplicatedStorage(parent, path)
        for _, obj in pairs(parent:GetChildren()) do
            pcall(function()
                -- ตรวจสอบ Folders
                if obj:IsA("Folder") then
                    local folderName = string.lower(obj.Name)
                    if string.find(folderName, "orb") or 
                       string.find(folderName, "item") or 
                       string.find(folderName, "collect") or
                       string.find(folderName, "data") then
                        
                        for _, item in pairs(obj:GetChildren()) do
                            if item:IsA("StringValue") or item:IsA("ObjectValue") then
                                table.insert(foundOrbs, {
                                    zone = path,
                                    orbId = item.Value or item.Name,
                                    name = item.Name,
                                    object = item
                                })
                            end
                        end
                    end
                end
                
                -- ตรวจสอบ StringValues สำหรับ UUIDs
                if obj:IsA("StringValue") then
                    local value = obj.Value
                    if value and string.len(value) == 36 then -- UUID format
                        table.insert(foundOrbs, {
                            zone = path,
                            orbId = value,
                            name = obj.Name,
                            object = obj
                        })
                    end
                end
                
                -- เรียกซ้ำ
                if #obj:GetChildren() > 0 then
                    scanReplicatedStorage(obj, path .. " > " .. obj.Name)
                end
            end)
        end
    end

    -- เริ่มสแกน
    scanWorkspace(workspace, 0)
    scanReplicatedStorage(ReplicatedStorage, "ReplicatedStorage")
    
    -- เพิ่มค่าเดโมถ้าไม่พบอะไร
    if #foundOrbs == 0 then
        table.insert(foundOrbs, {
            zone = "Town",
            orbId = "53b59272-a881-43c0-8205-46a16d893bac",
            name = "Demo Orb 1"
        })
        table.insert(foundOrbs, {
            zone = "Forest", 
            orbId = "f50fea77-0689-4c6a-93f2-1a2b3c4d5e6f",
            name = "Demo Orb 2"
        })
    end
    
    StatusLabel.Text = "Status: ✅ Found " .. #foundOrbs .. " orbs"
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
        
        -- กรองด้วย search term
        if not searchTerm or searchTerm == "" or 
           string.find(string.lower(displayText), string.lower(searchTerm)) or
           string.find(string.lower(orb.orbId), string.lower(searchTerm)) then
            
            count = count + 1
            
            local OrbFrame = Instance.new("Frame")
            OrbFrame.Size = UDim2.new(1, -10, 0, 70)
            OrbFrame.Position = UDim2.new(0, 5, 0, yPosition)
            OrbFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            OrbFrame.Parent = ListFrame
            
            local OrbCorner = Instance.new("UICorner")
            OrbCorner.CornerRadius = UDim.new(0, 6)
            OrbCorner.Parent = OrbFrame

            local InfoLabel = Instance.new("TextLabel")
            InfoLabel.Size = UDim2.new(0.7, 0, 0.5, 0)
            InfoLabel.Position = UDim2.new(0, 10, 0, 5)
            InfoLabel.Text = displayText
            InfoLabel.BackgroundTransparency = 1
            InfoLabel.TextColor3 = Color3.new(1,1,1)
            InfoLabel.Font = Enum.Font.Gotham
            InfoLabel.TextSize = 12
            InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
            InfoLabel.Parent = OrbFrame
            
            local IDLabel = Instance.new("TextLabel")
            IDLabel.Size = UDim2.new(0.7, 0, 0.3, 0)
            IDLabel.Position = UDim2.new(0, 10, 0.5, 0)
            IDLabel.Text = "ID: " .. orb.orbId
            IDLabel.BackgroundTransparency = 1
            IDLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            IDLabel.Font = Enum.Font.Gotham
            IDLabel.TextSize = 10
            IDLabel.TextXAlignment = Enum.TextXAlignment.Left
            IDLabel.Parent = OrbFrame
            
            local CollectButton = Instance.new("TextButton")
            CollectButton.Size = UDim2.new(0.25, 0, 0.6, 0)
            CollectButton.Position = UDim2.new(0.73, 0, 0.2, 0)
            CollectButton.Text = "🚀 FIRE"
            CollectButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
            CollectButton.TextColor3 = Color3.new(1,1,1)
            CollectButton.Font = Enum.Font.GothamBold
            CollectButton.TextSize = 12
            CollectButton.Parent = OrbFrame
            
            local ButtonCorner = Instance.new("UICorner")
            ButtonCorner.CornerRadius = UDim.new(0, 6)
            ButtonCorner.Parent = CollectButton
            
            CollectButton.MouseButton1Click:Connect(function()
                local orbRemote = findOrbRemote()
                if orbRemote then
                    local args = {orb.zone, orb.orbId}
                    orbRemote:FireServer(unpack(args))
                    StatusLabel.Text = "Status: 🎯 Fired: " .. orb.name
                else
                    StatusLabel.Text = "Status: ❌ No RemoteEvent found!"
                end
            end)
            
            yPosition = yPosition + 75
            ListFrame.CanvasSize = UDim2.new(0, 0, 0, yPosition)
        end
    end
    
    if count == 0 then
        local NoResults = Instance.new("TextLabel")
        NoResults.Size = UDim2.new(1, 0, 0, 50)
        NoResults.Position = UDim2.new(0, 0, 0, 10)
        NoResults.Text = "No orbs found. Try Deep Scan!"
        NoResults.BackgroundTransparency = 1
        NoResults.TextColor3 = Color3.fromRGB(150, 150, 150)
        NoResults.Font = Enum.Font.Gotham
        NoResults.TextSize = 14
        NoResults.Parent = ListFrame
    end
end

-- ฟังก์ชัน Auto Farm
function startAutoFarm()
    if isAutoCollecting then return end
    
    local orbRemote = findOrbRemote()
    if not orbRemote then
        StatusLabel.Text = "Status: ❌ No RemoteEvent found for auto farm!"
        return
    end
    
    isAutoCollecting = true
    AutoCollectButton.Text = "🛑 STOP FARM"
    AutoCollectButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    
    spawn(function()
        local iteration = 0
        while isAutoCollecting do
            iteration = iteration + 1
            StatusLabel.Text = "Status: 🌟 Auto Farming - Cycle " .. iteration
            
            for _, orb in pairs(foundOrbs) do
                if not isAutoCollecting then break end
                
                local args = {orb.zone, orb.orbId}
                orbRemote:FireServer(unpack(args))
                wait(0.3) -- รอระหว่างการยิง
            end
            
            if isAutoCollecting then
                wait(1) -- รอระหว่างรอบ
            end
        end
    end)
end

function stopAutoFarm()
    isAutoCollecting = false
    AutoCollectButton.Text = "⚡ AUTO FARM"
    AutoCollectButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
    StatusLabel.Text = "Status: Auto farm stopped"
end

-- ฟังก์ชัน Mass Collect
function massCollectAll()
    if isMassCollecting then return end
    
    local orbRemote = findOrbRemote()
    if not orbRemote then
        StatusLabel.Text = "Status: ❌ No RemoteEvent found!"
        return
    end
    
    isMassCollecting = true
    MassCollectButton.Text = "💥 COLLECTING..."
    MassCollectButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    
    spawn(function()
        local collected = 0
        for _, orb in pairs(foundOrbs) do
            local args = {orb.zone, orb.orbId}
            orbRemote:FireServer(unpack(args))
            collected = collected + 1
            StatusLabel.Text = "Status: 💥 Mass Collect: " .. collected .. "/" .. #foundOrbs
            wait(0.1) -- รอเร็วๆ
        end
        
        isMassCollecting = false
        MassCollectButton.Text = "💥 MASS COLLECT ALL"
        MassCollectButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        StatusLabel.Text = "Status: ✅ Mass collect completed: " .. collected .. " orbs"
    end)
end

-- Event Handlers
ScanButton.MouseButton1Click:Connect(deepScanForOrbs)

AutoCollectButton.MouseButton1Click:Connect(function()
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

-- สแกนอัตโนมัติเมื่อเริ่ม
wait(1)
StatusLabel.Text = "Status: 🚀 Orb Hunter Pro Ready!" 1
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

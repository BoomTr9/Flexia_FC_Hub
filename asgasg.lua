if _G.Key == "UpdateBeta.2" then
    print("\nTheKey: '"..tostring(_G.Key).."' is vaild")
else
    game:GetService("Players").LocalPlayer:Kick("\n Your Key Is Wrong!\nPlease contact supporter")
end

local Characters = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()

if not Characters then wait(3) end
wait(2)

_G.WalkSpeed = _G.Settings.Main["Walk Speed"] or 22
_G.TweenSpeed = _G.Settings.Main["Fly Speed"] or 100
_G.Attack = _G.Settings.Main["Auto Attack"] or false
_G.Skill = _G.Settings.Main["Auto Skill"] or false
_G.AutoWalk = _G.Settings.Main["Auto Walk"] or false
_G.SpeedAttack = _G.Settings.Main["Speed Attack"] or 2
_G.AttackType = _G.Settings.Main["Attack Type"] or "VClick"
_G.GodMode = true

_G.radius = _G.Settings.Main["Radius Fly Circle"] or 15 -- ระยะห่างจากศูนย์กลาง
_G.speed = _G.Settings.Main["Speed Fly Circle"] or 90 -- ความเร็ว (องศาต่อวินาที)

if game.PlaceId == 125503319883299 and _G.Settings.Main["Auto Join World"] then
    local args = {
        [1] = "Corrupted Forest",
        [2] = _G.Settings.Main["World Select"],
        [3] = 1,
        [4] = 1
    }
    game:GetService("ReplicatedStorage"):WaitForChild("PartyCreate"):FireServer(unpack(args))
    
    local args = {
        [1] = "Computer"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("SendDevices"):FireServer(unpack(args))
    game:GetService("ReplicatedStorage"):WaitForChild("PartyStart"):FireServer()
end

local posmons = nil

local canw = true
local StarterPack = game:GetService("StarterPack")
local VirtualInputManager = game:GetService("VirtualInputManager")
local TweenService = game:GetService("TweenService")

-- ฟังก์ชันบินวนรอบตำแหน่งที่กำหนด
local function flyInCircle(centerPart)
	local RunService = game:GetService("RunService")
	local object = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
	local radius = _G.radius
	local speed = _G.speed
	if not centerPart then
			warn("CenterPart is missing")
			return
		end
	
	local angle = 0 -- มุมเริ่มต้น
	local connection
	
	connection = RunService.Heartbeat:Connect(function(deltaTime)
		angle = angle + speed * deltaTime -- อัปเดตมุม
		local radians = math.rad(angle) -- แปลงเป็นเรเดียน
	
		-- คำนวณตำแหน่งใหม่ของวัตถุ
		local newX = centerPart.Position.X + radius * math.cos(radians)
		local newZ = centerPart.Position.Z + radius * math.sin(radians)
		local newPosition = Vector3.new(newX, centerPart.Position.Y, newZ)
	
		-- อัปเดตตำแหน่งและการหมุนของวัตถุ
		object.CFrame = CFrame.new(newPosition) * CFrame.Angles(0, math.rad(angle), 0)
	
		-- รีเซ็ตมุมเมื่อครบ 360 องศา
		if angle >= 360 then
			angle = angle - 360
		end
	end)
	
	return connection
end

-- ฟังก์ชั่นจำลองการคลิกเมาส์
local onattack = false
spawn(function()
    while wait(_G.SpeedAttack) do
        if _G.Attack then
            if _G.AttackType == "Long" then
                local args = {
                    [1] = true
                }
                
                game:GetService("ReplicatedStorage").Click:FireServer(unpack(args))
            elseif _G.AttackType == "Short" then
                game:GetService("ReplicatedStorage"):WaitForChild("Click"):FireServer(true)
                wait()
                game:GetService("ReplicatedStorage"):WaitForChild("Click"):FireServer(false)
            elseif _G.AttackType == "VClick" then
                -- จำลองการคลิกซ้ายของเมาส์
                local VirtualInputManager = game:GetService("VirtualInputManager")
            	sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                task.wait(0.1) -- เวลาระหว่างกดและปล่อย
                VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
            end
        end
    end
end)

-- ฟังก์ชั่นจำลองการกดปุ่ม Q
spawn(function()
    while task.wait() do
        if _G.Skill then
            if posmons then
                local args = {
                    [1] = "Spell1",
                    [2] = posmons,
                    [3] = Vector3.zero,
                    [4] = 0
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Spell"):FireServer(unpack(args))                
            end
        end
    end
end)

-- ฟังก์ชั่นจำลองการกดปุ่ม E
spawn(function()
    while task.wait() do
        if _G.Skill then
            if posmons then
                local args = {
                    [1] = "Spell2",
                    [2] = posmons,
                    [3] = Vector3.zero,
                    [4] = 0
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Spell"):FireServer(unpack(args))                
            end
        end
    end
end)

-- ฟังก์ชั่นจำลองการกดปุ่ม R
spawn(function()
    while task.wait() do
        if _G.Skill then
            if posmons then
                local args = {
                    [1] = "Spell3",
                    [2] = posmons,
                    [3] = Vector3.zero,
                    [4] = 0
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Spell"):FireServer(unpack(args))                
            end
        end
    end
end)

-- ฟังก์ชั่นจำลองการกดปุ่ม T
spawn(function()
    while task.wait() do
        if _G.Skill then
            if posmons then
                local args = {
                    [1] = "Spell4",
                    [2] = posmons,
                    [3] = Vector3.zero,
                    [4] = 0
                }
                
                game:GetService("ReplicatedStorage"):WaitForChild("Spell"):FireServer(unpack(args))                
            end
        end
    end
end)

-- ฟังก์ชันสำหรับเคลื่อนที่ไปยังตำแหน่งเป้าหมายด้วย TweenService
function AiAttackWithTP(Pos)
    local plr = game:GetService("Players").LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()
    local humanoid = char:FindFirstChildOfClass("Humanoid")
    local rootPart = char:FindFirstChild("HumanoidRootPart")

    if not humanoid or not rootPart then return end

    -- ตรวจสอบระยะห่างจากเป้าหมาย
    local distanceToTarget = (rootPart.Position - Pos).Magnitude

    -- การตั้งค่าข้อมูล Tween
    local tweenInfo = TweenInfo.new(
        distanceToTarget / _G.TweenSpeed, -- ความเร็วในการเคลื่อนที่ (ยิ่งใกล้ยิ่งเร็ว)
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )

    -- สร้างการเคลื่อนที่ไปยังจุดเป้าหมาย
    local goal = {CFrame = CFrame.new(Pos)}
    local tween = TweenService:Create(rootPart, tweenInfo, goal)
    tween:Play()
    spawn(function()
        while task.wait() do
            if distanceToTarget < 20 then
                tween:Stop()
                break
            end
        end
    end)
    -- รอจนกว่า tween จะเสร็จ
    tween.Completed:Wait()
    -- หลังจากเคลื่อนที่ถึงเป้าหมาย สามารถเพิ่มการโจมตีได้ที่นี่
end

-- แก้ลูปการหาและโจมตีศัตรูโดยใช้ TweenService
spawn(function()
    while task.wait() do
        pcall(function()
            if _G.AutoWalk then
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("Start"):FireServer()
                    for i, v in next, workspace:GetChildren() do
                        if v.Name == "EnemyWall" then
                            v:Destroy()
                        end
                    end
                    if workspace.Map:FindFirstChild("InvisiWalls") then
                        workspace.Map.InvisiWalls:Destroy()
                    end
                    if workspace:FindFirstChild("Death") then
                        workspace.Death:Destroy()
                    end
                end)

                local plr = game:GetService("Players").LocalPlayer
                local char = plr.Character or plr.CharacterAdded:Wait()
                local charPos = char:FindFirstChild("HumanoidRootPart") and char.HumanoidRootPart.Position

                local fly
                        
                if not charPos then return end

                local closestEnemy, closestDistance = nil, math.huge

                -- หาเป้าหมายศัตรูที่ใกล้ที่สุด
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    local health = v:FindFirstChild("HealthValue")
                    local enemyRootPart = v:FindFirstChild("HumanoidRootPart")
                    if health and enemyRootPart and health.Value > 0 then        
                        local distance = (charPos - enemyRootPart.Position).Magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestEnemy = v
                            spawn(function()
                                while task.wait() do
                                    if health.Value <= 0 then
                                        posmons = nil
                                        if fly then
                                            fly:Disconnect()
                                            fly = nil
                                        end
                                        break
                                    end
                                end
                            end)
                        end
                    end
                end

                -- หากพบศัตรู ให้เคลื่อนที่ไปหา
                if closestEnemy then
                    local enemyRootPart = closestEnemy:FindFirstChild("HumanoidRootPart")
                    if enemyRootPart then
                        if plr:DistanceFromCharacter(enemyRootPart.Position) < 20 then
                            fly = flyInCircle(enemyRootPart)
                            posmons = enemyRootPart.Position
                        else
                            AiAttackWithTP(enemyRootPart.Position)
                        end
                    end
                end
            end
        end)
    end
end)

spawn(function()
    local p
    while task.wait() do
        if _G.AutoWalk then
            for _, part in pairs(game:GetService("Players").LocalPlayer.Character:GetChildren()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                    p = part
                end
            end
        else
            if p then
                p.CanCollide = true
            end
        end
    end
end)


-- ฟังก์ชัน God Mode
spawn(function()
    local nah = false
    print("God Mode Is On!")
    while task.wait() do -- ลดความถี่การตรวจสอบ
        pcall(function()
            if _G.GodMode then
                for _, hit in next, workspace.EnemyAttacks:GetChildren() do
                    if hit:FindFirstChild("Hitbox") then
                        hit.Hitbox.CanTouch = nah
                        hit.Hitbox.CanCollide = nah
                        hit.Hitbox.CanQuery = nah
                        hit.Damage.Value = 0
                    end
                end
            end
        end)
    end
end)

-- ต้นไม้
spawn(function()
    local Attack_Boss = false
    while wait() do
        pcall(function()
            local plr = game:GetService("Players").LocalPlayer
            local char = plr.Character or plr.CharacterAdded:Wait()
            local humanoid = char:FindFirstChildOfClass("Humanoid")
            local frame_Boss = plr.PlayerGui.BaseGui.Timer:FindFirstChild("Boss")
            local fly

            if frame_Boss and frame_Boss.Visible and frame_Boss.BossName.Text == "Ancient Fell Oak" then
                spawn(function()
                    while task.wait() do
                        -- ตรวจสอบว่า Boss ยังอยู่หรือไม่
                        if not (frame_Boss and frame_Boss.Visible and frame_Boss.BossName.Text == "Ancient Fell Oak") then
                            _G.AutoWalk = true
                            Attack_Boss = false
                            break
                        end
                    end
                end)

                _G.AutoWalk = false -- หยุดการเดินอัตโนมัติ
                Attack_Boss = true

                while wait(1) do
                    -- ตรวจสอบว่ามี "Corrupting Crystal" หรือไม่
                    local crystal = nil
                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                        if enemy:IsA("Model") and enemy.Name == "Corrupting Crystal" then
                            crystal = enemy
                            break -- เจอ Crystal แล้วหยุดค้นหา
                        end
                    end

                    -- ถ้าเจอ Crystal ให้เดินไปหา
                    if crystal then
                        local crystalRoot = crystal:FindFirstChild("HumanoidRootPart") or crystal:FindFirstChild("PrimaryPart")
                        if crystalRoot and humanoid then
                            repeat
                                if plr:DistanceFromCharacter(crystalRoot.Position) < 20 then
                                    posmons = crystalRoot.Position
                                    fly = flyInCircle(crystalRoot)
                                else
                                    AiAttackWithTP(crystalRoot.Position)
                                end
                                wait(0.1) -- รอระหว่างการเคลื่อนที่
                            until not crystal or crystal.HealthValue.Value <= 0

                            if posmons ~= nil then
                                posmons = nil
                            end
                            if fly then
                                fly:Disconnect()
                                fly = nil
                            end
                            -- ลบ Crystal หลังจากจัดการเสร็จ
                            if crystal then
                                crystal:Destroy()
                            end
                        end
                    else
                        -- ถ้าไม่มี Crystal ให้จัดการศัตรูตัวอื่น
                        for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                            if enemy:IsA("Model") then
                                local enemyRoot = enemy:FindFirstChild("HumanoidRootPart") or enemy:FindFirstChild("PrimaryPart")
                                if enemyRoot and humanoid and enemy.Name == "Ancient Fell Oak" then
                                    if plr:DistanceFromCharacter(enemyRoot.Position) < 200000000 then
                                        fly = flyInCircle(enemyRoot)
                                        posmons = enemyRoot.Position
                                    else
                                        AiAttackWithTP(enemyRoot.Position)
                                    end
                                    if enemy.HealthValue.Value <= 0 then
                                        posmons = nil
                                        if fly then
                                            fly:Disconnect()
                                            fly = nil
                                        end
                                        break
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end)
    end
end)

local TweenService = game:GetService("TweenService")

-- ฟังก์ชันสำหรับการ Tween ไปยังตำแหน่งเป้าหมาย
local function TweenToPosition(targetPosition)
    local plr = game:GetService("Players").LocalPlayer
    local char = plr.Character or plr.CharacterAdded:Wait()
    local rootPart = char:FindFirstChild("HumanoidRootPart")

    if not rootPart then return end

    -- กำหนดข้อมูล Tween
    local tweenInfo = TweenInfo.new(
        (Vector3.new(targetPosition) - rootPart.Position).Magnitude / _G.TweenSpeed, -- ระยะเวลาในการ Tween
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )

    local tweenGoal = { CFrame = CFrame.new(targetPosition) }
    local tween = TweenService:Create(rootPart, tweenInfo, tweenGoal)

    -- เริ่ม Tween
    tween:Play()
    tween.Completed:Wait()
end

-- ตั้งค่า low graphics
local lowQualityParts = true   -- ปรับใช้วัสดุเป็น Plastic
local deleteDecalsAndTextures = true  -- ลบ Decals และ Textures
local disableShadows = false -- ปิดหรือเปิดการแสดงเงา (True = ปิดเงา, False = เปิดเงา)

local lightning = game:GetService("Lighting")

-- ปิดการแสดงเงาหากต้องการ
if disableShadows then
    lightning.GlobalShadows = false
end

-- ลบ Decals และ Texturesอ
if deleteDecalsAndTextures then
    local ClassTypes = {
        "Decal",
        "Texture"
    }

    for _, v in ipairs(workspace:GetDescendants()) do
        if table.find(ClassTypes, v.ClassName) then
            print("Deleting: " .. v.ClassName)
            v:Destroy()
        end
    end
end

local RunService = game:GetService("RunService")

-- 🎨 ฟังก์ชันสร้างสีรุ้ง
local function rainbowColor(speed)
    local t = tick() * speed
    return Color3.fromHSV(t % 1, 1, 1) -- เปลี่ยนสีตามค่าเวลา
end

local highlight = Instance.new("Highlight", game.Players.LocalPlayer.Character)
RunService.RenderStepped:Connect(function()
    highlight.FillColor = rainbowColor(0.25)
end)
game:GetService("Players").LocalPlayer.Character.Head.StatsBar.Enabled = false
game:GetService("Players").LocalPlayer.PlayerGui.BaseGui.PlayerStats.Visible = false
game:GetService("Players").LocalPlayer.PlayerGui.BaseGui.PlayerList.Visible = false


-- ปรับวัสดุเป็น Plastic สำหรับ BasePart ทั้งหมดในเกม
if lowQualityParts then
    for i, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
        end
    end
end

local function delObject(object)
    if object then
        print("กำลังลบ: " .. object.Name)
        object:Destroy() -- ทำการลบอ็อบเจ็กต์
    end
end

local function removeAllObjectsInLighting()
    print("กำลังลบอ็อบเจ็กต์ทั้งหมดใน Lighting")

    -- ลบอ็อบเจ็กต์ทั้งหมดใน Lighting
    for _, object in ipairs(game.Lighting:GetChildren()) do
        delObject(object)
    end

    print("การลบอ็อบเจ็กต์ทั้งหมดใน Lighting เสร็จสิ้น")
end
--[[
local part = Instance.new("Part", workspace)
part.Anchored = true
part.Size = Vector3.new(10, 0.01, 10)
part.Transparency = 0.75
spawn(function()
    while task.wait() do
        part.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 3, 0))
        part.Color = rainbowColor(0.25)
        if not part then
            break
        end
    end
end)
]]
removeAllObjectsInLighting()

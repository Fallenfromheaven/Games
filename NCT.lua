-- dear game dev if your reading this dont just rename the remote (most useless remote update ever) also i can just copy paste the entire remote name if you think making the name extra long will change something you idiot
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local remote
local remoteParentName
local currentTycoon = nil

local team_tycoon_association = { 
	["Neutral"]     = nil,
	["Blue Team"]   = "TycoonA",
	["Red Team"]    = "TycoonB",
	["Yeller Team"] = "TycoonC",
	["Green Team"]  = "TycoonD",
	["Black Team"]  = "TycoonE",
	["Pink Team"]   = "TycoonF",
}

local function updateTycoon()
	local player = Players.LocalPlayer
	if player and player.Team then
		currentTycoon = team_tycoon_association[player.Team.Name] or nil
	else
		currentTycoon = nil
	end
end

updateTycoon()
Players.LocalPlayer:GetPropertyChangedSignal("Team"):Connect(updateTycoon)

local function getCurrentTycoon()
	return currentTycoon
end

local function findRemote()
    local modulesFolder = ReplicatedStorage:FindFirstChild("Modules")
    if not modulesFolder then return nil end
    for _, obj in ipairs(modulesFolder:GetChildren()) do
        local lootRemote = obj:FindFirstChild("LootSendinghdollas7eventeenfartdontreadifyoureacheaterifyouareimsosorryyouhavetotypeallthisinjusttog")
        if lootRemote then
            remote = lootRemote
            remoteParentName = obj.Name
            return remote
        end
    end
    return nil
end

local function getRemote()
    local parentModule = ReplicatedStorage.Modules:FindFirstChild(remoteParentName)
    return parentModule and parentModule:FindFirstChild("LootSendinghdollas7eventeenfartdontreadifyoureacheaterifyouareimsosorryyouhavetotypeallthisinjusttog")
end

remote = findRemote()
if not remote then
    findRemote()
end

local worthTable = {}
for i = 1, 2500 do
    worthTable[i] = {math.huge}
end

local args = {
    [1] = {
        ["worth"] = worthTable
    }
}

local autoMoney = false
local autoRebirth = false
local autoOutputMultiplier = false
local autoUpgrades = false
local spamDelay = 0

local function spamRemote()
    while autoMoney do
        local dynamicRemote = getRemote()
        if dynamicRemote then
            dynamicRemote:FireServer(unpack(args))
        else
            remote = findRemote()
            while not remote do
                task.wait(0)
                remote = findRemote()
            end
        end
        task.wait(spamDelay)
    end
end

local function spamRebirth()
	while autoRebirth do
		local currentTycoon = getCurrentTycoon()
		if currentTycoon then
			local rebirthArgs = { [1] = workspace:WaitForChild(currentTycoon) }
			ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Upgrades"):WaitForChild("ConfirmCheck"):FireServer(unpack(rebirthArgs))
		end
		task.wait(spamDelay)
	end
end

local function spamCombined()
	local firstRun = true
	local player = Players.LocalPlayer
	local leaderstats = player:WaitForChild("leaderstats")
	local dollasStat = leaderstats:WaitForChild("Dollas")
	local lastFired = tick()
	while autoMoney and autoRebirth do
		if firstRun then
			for i = 1, 5 do
				local dynamicRemote = getRemote()
				if dynamicRemote then
					dynamicRemote:FireServer(unpack(args))
				else
					remote = findRemote()
					while not remote do
						task.wait(0)
						remote = findRemote()
					end
				end
				task.wait(spamDelay)
			end
			local currentTycoon = getCurrentTycoon()
			if currentTycoon then
				local rebirthArgs = { [1] = workspace:WaitForChild(currentTycoon) }
				ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Upgrades"):WaitForChild("ConfirmCheck"):FireServer(unpack(rebirthArgs))
			end
			firstRun = false
			lastFired = tick()
		else
			if dollasStat.Value == 0 then
				task.wait(3)
				for i = 1, 10 do
					local dynamicRemote = getRemote()
					if dynamicRemote then
						dynamicRemote:FireServer(unpack(args))
					else
						remote = findRemote()
						while not remote do
							task.wait(0)
							remote = findRemote()
						end
					end
					task.wait(spamDelay)
				end
				local currentTycoon = getCurrentTycoon()
				if currentTycoon then
					local rebirthArgs = { [1] = workspace:WaitForChild(currentTycoon) }
					ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Upgrades"):WaitForChild("ConfirmCheck"):FireServer(unpack(rebirthArgs))
				end
				lastFired = tick()
			elseif tick() - lastFired >= 10 then
				for i = 1, 5 do
					local dynamicRemote = getRemote()
					if dynamicRemote then
						dynamicRemote:FireServer(unpack(args))
					else
						remote = findRemote()
						while not remote do
							task.wait(0)
							remote = findRemote()
						end
					end
					task.wait(spamDelay)
				end
				local currentTycoon = getCurrentTycoon()
				if currentTycoon then
					local rebirthArgs = { [1] = workspace:WaitForChild(currentTycoon) }
					ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Upgrades"):WaitForChild("ConfirmCheck"):FireServer(unpack(rebirthArgs))
				end
				lastFired = tick()
			end
		end
		task.wait(0.1)
	end
end

local function spamOutputMultiplier()
	local currentTycoon = getCurrentTycoon()
	if not currentTycoon then return end
	local tycoonFolder = workspace:FindFirstChild(currentTycoon)
	if not tycoonFolder then return end
	while autoOutputMultiplier do
		local buttonsFolder = tycoonFolder:FindFirstChild("Buttons")
		if buttonsFolder then
			for _, button in ipairs(buttonsFolder:GetChildren()) do
				if button.Name == "Upgrade" then
					for _, descendant in ipairs(button:GetDescendants()) do
						if descendant.Name == "Machine" then
							if tostring(descendant.Value) == "OutputMultiplierUpgrade" then
								local touchInterest = button:FindFirstChild("TouchInterest")
								if touchInterest then
									firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, button, 0)
									task.wait(0.1)
									firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, button, 1)
									break
								end
							end
						end
					end
				end
			end
		end
		task.wait(0.5)
	end
end

local function activateAllButtons()
	local currentTycoon = getCurrentTycoon()
	if not currentTycoon then return end
	local tycoonFolder = workspace:FindFirstChild(currentTycoon)
	if not tycoonFolder then return end
	local buttonsFolder = tycoonFolder:FindFirstChild("Buttons")
	if not buttonsFolder then return end
	while autoUpgrades do
		for _, button in ipairs(buttonsFolder:GetChildren()) do
			if button.Name ~= "PickupWeapon" then
				local hasInvalidMachine = false
				for _, descendant in ipairs(button:GetDescendants()) do
					if descendant.Name == "Machine" and descendant:IsA("ValueBase") then
						local machineValue = tostring(descendant.Value)
						if machineValue == "OutputMultiplierUpgrade" or machineValue == "Rebirth" then
							hasInvalidMachine = true
							break
						end
					end
				end
				if not hasInvalidMachine and button:FindFirstChild("ButtonSelectionBox") then
					local touchInterest = button:FindFirstChild("TouchInterest")
					if touchInterest then
						firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, button, 0)
						task.wait(0.1)
						firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, button, 1)
					end
				end
			end
		end
		task.wait(0.5)
	end
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.Name = "SpamToggleGui"

local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0, 250, 0, 250)
Frame.Position = UDim2.new(0.5, -125, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.BackgroundTransparency = 0.2

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

local Header = Instance.new("TextLabel")
Header.Parent = Frame
Header.Size = UDim2.new(1, 0, 0, 30)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.Text = "Noob Crusher Tycoon"
Header.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Header.TextColor3 = Color3.fromRGB(255, 255, 255)
Header.Font = Enum.Font.SourceSansBold
Header.TextSize = 16
Header.TextXAlignment = Enum.TextXAlignment.Center

local CloseButton = Instance.new("TextButton")
CloseButton.Parent = Frame
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18

CloseButton.MouseButton1Click:Connect(function()
	ScreenGui:Destroy()
end)

local function createToggleButton(parent, position, text, callback)
	local button = Instance.new("TextButton")
	button.Parent = parent
	button.Size = UDim2.new(0, 230, 0, 40)
	button.Position = position
	button.Text = text
	button.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	button.MouseButton1Click:Connect(function()
		callback(button)
	end)
	return button
end

local function toggleState(state, button, onText, offText)
	state = not state
	button.Text = state and onText or offText
	button.BackgroundColor3 = state and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
	return state
end

local MoneyButton = createToggleButton(Frame, UDim2.new(0.5, -115, 0, 40), "Start Auto-Money", function(button)
	autoMoney = toggleState(autoMoney, button, "Stop Auto-Money", "Start Auto-Money")
	if autoMoney then
		if autoRebirth then
			task.spawn(spamCombined)
		else
			task.spawn(spamRemote)
		end
	end
end)

local RebirthButton = createToggleButton(Frame, UDim2.new(0.5, -115, 0, 90), "Start Auto-Rebirthing", function(button)
	autoRebirth = toggleState(autoRebirth, button, "Stop Auto-Rebirthing", "Start Auto-Rebirthing")
	if autoRebirth then
		if autoMoney then
			task.spawn(spamCombined)
		else
			task.spawn(spamRebirth)
		end
	else
		if autoMoney then
			task.spawn(spamRemote)
		end
	end
end)

local OutputMultiplierButton = createToggleButton(Frame, UDim2.new(0.5, -115, 0, 140), "Start Auto-OutputMultiplier", function(button)
	autoOutputMultiplier = toggleState(autoOutputMultiplier, button, "Stop Auto-OutputMultiplier", "Start Auto-OutputMultiplier")
	if autoOutputMultiplier then task.spawn(spamOutputMultiplier) end
end)

local UpgradesButton = createToggleButton(Frame, UDim2.new(0.5, -115, 0, 190), "Start Auto-Upgrades", function(button)
	autoUpgrades = toggleState(autoUpgrades, button, "Stop Auto-Upgrades", "Start Auto-Upgrades")
	if autoUpgrades then task.spawn(activateAllButtons) end
end)

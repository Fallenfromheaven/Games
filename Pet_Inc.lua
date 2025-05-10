---------------- Variables

local Rayfield          = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local coinsdone         = false
local coinsnoti         = false
local gemsdone          = false
local gemnoti           = false
local rubydone          = false
local rubynoti          = false
local ruby_convert_done = false
local conversion_noti   = false
local Plasmadone        = false
local Plasmanoti        = false

local suffixes  = {
	["K"]   = 1e3,
	["M"]   = 1e6,
	["B"]   = 1e9,
	["T"]   = 1e12,
	["Qd"]  = 1e15,
	["Qn"]  = 1e18,
    ["Sx"]  = 1e21,
    ["Sp"]  = 1e24,
    ["Oc"]  = 1e27,
    ["N"]   = 1e30,
    ["Dc"]  = 1e33,
    ["Ud"]  = 1e36,
    ["Dd"]  = 1e39,
    ["Td"]  = 1e42,
    ["Qdd"] = 1e45
}

---------------- custom funcs

function ReverseFormattedNumber(input)
	input = input:gsub("%s+", "")

	local numPart, suffix = input:match("([%d%.]+)([A-Za-z]+)")
	if numPart and suffixes[suffix] then
		return tonumber(numPart) * suffixes[suffix]
	end

	local clean = input:gsub(",", "")
	local num = tonumber(clean)
	if num then
		return num
	else
		error("Invalid input format: " .. tostring(input))
	end
end

---------------- Function dependant Vars

-- empty for now

---------------- UI 

local Window = Rayfield:CreateWindow({
   Name = "Pet Incremental",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "The ultimate Pet Incremental Script :)",
   LoadingSubtitle = "by Fallen_from_heaven",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "PetInc",
      FileName = "loader-data"
   }
})

local PetInc = Window:CreateTab("Pet Incremental", 4483362458)

---------------- UI BUTTONS

local Section_1 = PetInc:CreateSection("Pet Stuff")
local Toggle_0 = PetInc:CreateToggle({
    Name = "Auto-Open-Eggs (pretty much useless)",
    CurrentValue = false,
    Flag = "toggle_0",
    Callback = function(Value)
        while Rayfield.Flags["toggle_0"].CurrentValu do
            local args = {"OpenEgg"}
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
            task.wait(1)
            end
        end
    })
local Divider_0 = PetInc:CreateDivider()

local Toggle_1 = PetInc:CreateToggle({
    Name = "Auto-Evolve-all-Pets",
    CurrentValue = false,
    Flag = "toggle_1",
    Callback = function(Value)
        while Rayfield.Flags["toggle_1"].CurrentValue do
            local args = {"EvolveAll"}
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
            task.wait(1)
            end
        end
    })
local Divider_1 = PetInc:CreateDivider()

local Toggle_2 = PetInc:CreateToggle({
    Name = "Auto-Equip-best-Pets",
    CurrentValue = false,
    Flag = "toggle_2",
    Callback = function(Value)
        while Rayfield.Flags["toggle_2"].CurrentValue do
            local args = {"EquipBest"}
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
            task.wait(1)
            end
        end
    })
local Divider_2 = PetInc:CreateDivider()

local Section_2 = PetInc:CreateSection("Misc Automations + Auto Upgrades (always buys cheapest!)")
local Toggle_3 = PetInc:CreateToggle({
    Name = "Auto-Coin-Upgrades",
    CurrentValue = false,
    Flag = "toggle_3",
    Callback = function(Value)
        while Rayfield.Flags["toggle_3"].CurrentValue and coinsdone == false do
            local path = game:GetService("Players").LocalPlayer.PlayerGui.CoinUpgrades.Bg.List
            local UpgradeList  = {
                ["CoinMulti"]  = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.CoinUpgrades.Bg.List.CoinMulti.Buy.Cost.text),
                ["EggSpeed"]   = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.CoinUpgrades.Bg.List.EggSpeed.Buy.Cost.text),
                ["EggLuck"]    = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.CoinUpgrades.Bg.List.EggLuck.Buy.Cost.text),
                ["PetEquip"]   = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.CoinUpgrades.Bg.List.PetEquip.Buy.Cost.text),
                ["PetStorage"] = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.CoinUpgrades.Bg.List.PetStorage.Buy.Cost.text),
                ["EggClone"]   = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.CoinUpgrades.Bg.List.EggClone.Buy.Cost.text),
            }
            for key, value in pairs(UpgradeList) do    
                if path[key].Max.Visible == true then
                    UpgradeList[key] = nil
                end
            end

            local lowestKey, lowestValue = nil, nil
            local rawText = game:GetService("Players").LocalPlayer.PlayerGui.UI.Stats.Coins.TextLabel.Text
            local numericText = ReverseFormattedNumber(rawText)

            for key, value in pairs(UpgradeList) do
                if value and (not lowestValue or value < lowestValue) then
                    lowestKey, lowestValue = key, value
                end
            end

            local args = {"CoinUpgrade", lowestKey}
            if lowestValue == nil then
                Rayfield:Notify({
                    Title = "Coin-Upgrade Notification",
                    Content = "All Coin Upgrades are max Level!",
                    Duration = 10,
                    Image = 4483362458,
                })
                coinsdone = true
            elseif game:GetService("Players").LocalPlayer.leaderstats.Rank.value >= 3 and coinsnoti == false then
                Rayfield:Notify({
                    Title = "Coin-Upgrade Notification",
                    Content = "Auto-Coin Upgrades no longer needed above Rank 3 thus disabled",
                    Duration = 10,
                    Image = 4483362458,
                })
                coinsdone = true
                coinsnoti = true
            elseif numericText >= lowestValue then
                game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
            end
            task.wait(0.5)

            end
        end
    })
local Divider_3 = PetInc:CreateDivider()

local Toggle_4 = PetInc:CreateToggle({
    Name = "Auto-Gem-Upgrades",
    CurrentValue = false,
    Flag = "toggle_4",
    Callback = function(Value)
        while Rayfield.Flags["toggle_4"].CurrentValue and gemsdone == false do
            local path = game:GetService("Players").LocalPlayer.PlayerGui.GemUpgrades.Bg.List
		    local UpgradeList  = {
            	["GemMulti"]   = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.GemUpgrades.Bg.List.GemMulti.Buy.Cost.text),
            	["CoinMulti"]  = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.GemUpgrades.Bg.List.CoinMulti.Buy.Cost.text),
            	["EvolveGems"] = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.GemUpgrades.Bg.List.EvolveGems.Buy.Cost.text),
            	["PetEquip"]   = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.GemUpgrades.Bg.List.PetEquip.Buy.Cost.text),
            	["CoinSpeed"]  = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.GemUpgrades.Bg.List.CoinSpeed.Buy.Cost.text),
            	["PetClone"]   = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.GemUpgrades.Bg.List.PetClone.Buy.Cost.text),
            }
            for key, value in pairs(UpgradeList) do    
                if path[key].Max.Visible == true then
                    UpgradeList[key] = nil
                end
            end
            local lowestKey, lowestValue = nil, nil
            local rawText = game:GetService("Players").LocalPlayer.PlayerGui.UI.Stats.Gems.TextLabel.Text
            local numericText = ReverseFormattedNumber(rawText)

            for key, value in pairs(UpgradeList) do
                if value and (not lowestValue or value < lowestValue) then
                    lowestKey, lowestValue = key, value
                end
            end

            local args = {"GemUpgrade", lowestKey}
            if lowestValue == nil then
                Rayfield:Notify({
                    Title = "Gem-Upgrade Notification",
                    Content = "All Gem Upgrades are max Level!",
                    Duration = 10,
                    Image = 4483362458,
                })
                gemsdone = true
            elseif game:GetService("Players").LocalPlayer.leaderstats.Rank.value >= 5 and gemnoti == false then
                Rayfield:Notify({
                    Title = "Gem-Upgrade Notification",
                    Content = "Auto-Gem Upgrades no longer needed above Rank 5 thus disabled",
                    Duration = 10,
                    Image = 4483362458,
                })
                gemdone = true
                gemnoti = true
            elseif tonumber(numericText) >= lowestValue then
                game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
            end
            task.wait(0.5)

            end
        end
    })
local Divider_4 = PetInc:CreateDivider()

local Toggle_5 = PetInc:CreateToggle({
    Name = "Auto-Ruby-Convert (waits 5 seconds for more rubys)",
    CurrentValue = false,
    Flag = "toggle_5",
    Callback = function(Value)
        while Rayfield.Flags["toggle_5"].CurrentValue and ruby_convert_done == false do
            local tagText = game:GetService("Players").LocalPlayer.PlayerGui.UI.Guide.Tag.Text
            local rawText = game:GetService("Players").LocalPlayer.PlayerGui.UI.Stats.Coins.TextLabel.Text
            local numericText = ReverseFormattedNumber(rawText)
            local args = {"RubyConvert"}

            if string.match(tagText, "^Reach%s+[%d,.]+%s*%a*%s+[Cc]oins$") then
                Rayfield:Notify({
                    Title = "Ruby-Conversion Notification",
                    Content = "Stopping Conversion to reach Coin Target!",
                    Duration = 10,
                    Image = 4483362458,
                })
                ruby_convert_done = true
            elseif game:GetService("Players").LocalPlayer.leaderstats.Rank.value >= 7 and conversion_noti == false then
                Rayfield:Notify({
                    Title = "Ruby-Conversion Notification",
                    Content = "Auto Conversion no longer neccesary above rank 7!",
                    Duration = 10,
                    Image = 4483362458,
                })
                conversion_noti   = true
                ruby_convert_done = true
            elseif numericText >= 5000000000 then
                task.wait(5)
                game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
            end
            task.wait(0.5)
            end
        end
    })
local Divider_5 = PetInc:CreateDivider()

local Toggle_6 = PetInc:CreateToggle({
    Name = "Auto-Ruby-Upgrades",
    CurrentValue = false,
    Flag = "toggle_6",
    Callback = function(Value)
        while Rayfield.Flags["toggle_6"].CurrentValue and rubydone == false do
            local path = game:GetService("Players").LocalPlayer.PlayerGui.RubyUpgrades.Bg.List
		    local UpgradeList  = {
            	["CoinMulti"]   = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.RubyUpgrades.Bg.List.CoinMulti.Buy.Cost.text),
            	["RubyMulti"]  = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.RubyUpgrades.Bg.List.RubyMulti.Buy.Cost.text),
            	["GemMulti"] = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.RubyUpgrades.Bg.List.GemMulti.Buy.Cost.text),
            	["EggLuck"]   = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.RubyUpgrades.Bg.List.EggLuck.Buy.Cost.text),
            	["EggClone"]  = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.RubyUpgrades.Bg.List.EggClone.Buy.Cost.text),
            	["PetClone"]   = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.RubyUpgrades.Bg.List.PetClone.Buy.Cost.text),
            }
            for key, value in pairs(UpgradeList) do    
                if path[key].Max.Visible == true then
                    UpgradeList[key] = nil
                end
            end
            local lowestKey, lowestValue = nil, nil
            local rawText = game:GetService("Players").LocalPlayer.PlayerGui.UI.Stats.Ruby.TextLabel.Text
            local numericText = ReverseFormattedNumber(rawText)

            for key, value in pairs(UpgradeList) do
                if value and (not lowestValue or value < lowestValue) then
                    lowestKey, lowestValue = key, value
                end
            end

            local args = {"RubyUpgrade", lowestKey}
            if lowestValue == nil then
                Rayfield:Notify({
                    Title = "Ruby-Upgrade Notification",
                    Content = "All Ruby Upgrades are max Level!",
                    Duration = 10,
                    Image = 4483362458,
                })
                rubydone = true
            elseif game:GetService("Players").LocalPlayer.leaderstats.Rank.value >= 7 and rubynoti == false then
                Rayfield:Notify({
                    Title = "Ruby-Upgrade Notification",
                    Content = "Auto-Ruby Upgrades no longer needed above Rank 7 thus disabled",
                    Duration = 10,
                    Image = 4483362458,
                })
                rubydone = true
                rubynoti = true
            elseif tonumber(numericText) >= lowestValue then
                game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
            end
            task.wait(0.5)

            end
        end
    })
local Divider_6 = PetInc:CreateDivider()

local Toggle_7 = PetInc:CreateToggle({
    Name = "Auto-Plasma-giver",
    CurrentValue = false,
    Flag = "toggle_7",
    Callback = function(Value)
        while Rayfield.Flags["toggle_7"].CurrentValue do
            local args = {"Plasma",true}
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
            task.wait(0.1)
            end
        end
    })
local Divider_7 = PetInc:CreateDivider()

local Toggle_8 = PetInc:CreateToggle({
    Name = "Auto-Plasma-Upgrades",
    CurrentValue = false,
    Flag = "toggle_8",
    Callback = function(Value)
        while Rayfield.Flags["toggle_8"].CurrentValue and Plasmadone == false do
            local path = game:GetService("Players").LocalPlayer.PlayerGui.PlasmaUpgrades.Bg.List
		    local UpgradeList  = {
            	["PlasmaMulti"] = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.PlasmaUpgrades.Bg.List.PlasmaMulti.Buy.Cost.text),
            	["PlasmaMax"]   = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.PlasmaUpgrades.Bg.List.PlasmaMax.Buy.Cost.text),
            	["PlasmaGold"]  = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.PlasmaUpgrades.Bg.List.PlasmaGold.Buy.Cost.text),
            	["Robots"]      = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.PlasmaUpgrades.Bg.List.Robots.Buy.Cost.text),
            	["RobotSpeed"]  = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.PlasmaUpgrades.Bg.List.RobotSpeed.Buy.Cost.text),
            	["RubyMulti"]   = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.PlasmaUpgrades.Bg.List.RubyMulti.Buy.Cost.text),
                ["CoinMulti"]   = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.PlasmaUpgrades.Bg.List.CoinMulti.Buy.Cost.text),
            }
            for key, value in pairs(UpgradeList) do    
                if path[key].Max.Visible == true then
                    UpgradeList[key] = nil
                end
            end
            local lowestKey, lowestValue = nil, nil
            local rawText = game:GetService("Players").LocalPlayer.PlayerGui.UI.Stats.Plasma.TextLabel.Text
            local numericText = ReverseFormattedNumber(rawText)

            for key, value in pairs(UpgradeList) do
                if value and (not lowestValue or value < lowestValue) then
                    lowestKey, lowestValue = key, value
                end
            end

            local args = {"PlasmaUpgrade", lowestKey}
            if lowestValue == nil then
                Rayfield:Notify({
                    Title = "Plasma-Upgrade Notification",
                    Content = "All Plasma Upgrades are max Level!",
                    Duration = 10,
                    Image = 4483362458,
                })
                Plasmadone = true
            elseif game:GetService("Players").LocalPlayer.leaderstats.Rank.value >= 8 and Plasmanoti == false then
                Rayfield:Notify({
                    Title = "Plasma-Upgrade Notification",
                    Content = "Auto-Plasma Upgrades no longer needed above Rank 8 thus disabled",
                    Duration = 10,
                    Image = 4483362458,
                })
                Plasmanoti = true
            elseif tonumber(numericText) >= lowestValue then
                game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
            end
            task.wait(0.5)

            end
        end
    })
local Divider_8 = PetInc:CreateDivider()

local Toggle_9 = PetInc:CreateToggle({
    Name = "Auto-Rank-Up",
    CurrentValue = false,
    Flag = "toggle_9",
    Callback = function(Value)
        while Rayfield.Flags["toggle_9"].CurrentValue do
            local rankup_cost = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.RankUp.Bg.List.Buy.Cost.text)
            local rawText = game:GetService("Players").LocalPlayer.PlayerGui.UI.Stats.Coins.TextLabel.Text
            local numericText = ReverseFormattedNumber(rawText)
            local args = {"RankUp"}
            if numericText >= rankup_cost then
                game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
                coinsdone         = false
                gemsdone          = false
                rubydone          = false
                ruby_convert_done = false
                Plasmadone        = false
            end
            task.wait(2)
            end
        end
    })
local Divider_9 = PetInc:CreateDivider()

local Toggle_10 = PetInc:CreateToggle({
    Name = "Auto-Sacrifice",
    CurrentValue = false,
    Flag = "toggle_10",
    Callback = function(Value)
        while Rayfield.Flags["toggle_10"].CurrentValue do
            local rankup_cost = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.Sacrifice.Bg.List.Buy.Cost.text)
            local rawText = game:GetService("Players").LocalPlayer.PlayerGui.UI.Stats.Coins.TextLabel.Text
            local numericText = ReverseFormattedNumber(rawText)
            local args = {"Sacrifice"}
            if numericText >= rankup_cost then
                game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
                coinsdone         = false
                gemsdone          = false
                rubydone          = false
                ruby_convert_done = false
                Plasmadone        = false
            end
            task.wait(2)
            end
        end
    })

---------------- Settings + lib_init

local settings_ = Window:CreateTab("Settings", 4483362458)

local s_Section_1 = settings_:CreateSection("Settings")
local s_Button_1 = settings_:CreateButton({
    Name = "Destroy GUI",
    Callback = function()
        Rayfield:Destroy()
    end
    })
local s_Divider_1 = settings_:CreateDivider()

Rayfield:LoadConfiguration()

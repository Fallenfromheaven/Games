---------------- Variables

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local suffixes = {
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
local Toggle_0 = PetInc:CreateToggle({
    Name = "Auto-Open-Eggs (requieres close proximity untill rank3)",
    CurrentValue = false,
    Flag = "toggle_0",
    Callback = function(Value)
        while Rayfield.Flags["toggle_0"].CurrentValue do
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

local Toggle_3 = PetInc:CreateToggle({
    Name = "Auto-Coin-Upgrades",
    CurrentValue = false,
    Flag = "toggle_3",
    Callback = function(Value)
        while Rayfield.Flags["toggle_3"].CurrentValue do
            
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
            if tonumber(numericText) >= lowestValue then
                game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
            end
            task.wait(0.5)

            end
        end
    })
local Divider_3 = PetInc:CreateDivider()

local Toggle_4 = PetInc:CreateToggle({
    Name = "Auto-Rank-Up",
    CurrentValue = false,
    Flag = "toggle_4",
    Callback = function(Value)
        while Rayfield.Flags["toggle_4"].CurrentValue do
            break
            end
        end
    })
        

local Toggle_5 = PetInc:CreateToggle({
    Name = "Auto-Rank-Up",
    CurrentValue = false,
    Flag = "toggle_5",
    Callback = function(Value)
        while Rayfield.Flags["toggle_5"].CurrentValue do
            local rankup_cost = ReverseFormattedNumber(game:GetService("Players").LocalPlayer.PlayerGui.RankUp.Bg.List.Buy.Cost.text)
            local rawText = game:GetService("Players").LocalPlayer.PlayerGui.UI.Stats.Coins.TextLabel.Text
            local numericText = ReverseFormattedNumber(rawText)
            local args = {"RankUp"}
            if numericText >= rankup_cost then
                game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
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
local s_Toggle_1 = settings_:CreateToggle({
    Name = "Queue on Teleport",
    CurrentValue = false,
    Flag = "s_toggle_1",
    Callback = function(Value)
        if Rayfield.Flags["s_toggle_1"].CurrentValue then
            queue_on_teleport("task.wait(10)loadstring(game:HttpGet('https://raw.githubusercontent.com/Fallenfromheaven/Scriptloader-V2/refs/heads/main/source.lua'))()")
        end
    end
    })
local s_Divider_1 = settings_:CreateDivider()

Rayfield:LoadConfiguration()

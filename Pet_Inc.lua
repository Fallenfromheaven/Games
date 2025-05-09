---------------- Variables

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

---------------- UI 

local Window = Rayfield:CreateWindow({
   Name = "Scriptloader",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Der Ultimative Scriptloader :)",
   LoadingSubtitle = "by Fallen_from_heaven",
   Theme = "Default", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true,
      FolderName = "Scriptloader",
      FileName = "loader-data"
   }
})

local PetInc = Window:CreateTab("Pet Incremental", 4483362458)

---------------- UI BUTTONS + FUNCTIONS

local Toggle_1 = PetInc:CreateToggle({
    Name = "Auto-Evolve-all-pets",
    CurrentValue = false,
    Flag = "toggle_1",
    Callback = function(Value)
        while Rayfield.Flags["toggle_1"].CurrentValue do
            local args = {"EquipBest"}
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
            task.wait(2)
            end
        end
    })

local Toggle_2 = PetInc:CreateToggle({
    Name = "Auto-Equip-best-Pets",
    CurrentValue = false,
    Flag = "toggle_2",
    Callback = function(Value)
        while Rayfield.Flags["toggle_2"].CurrentValue do
            local args = {"EquipBest"}
            game:GetService("ReplicatedStorage"):WaitForChild("RE"):FireServer(unpack(args))
            task.wait(2)
            end
        end
    })

---------------- Settings + lin_init

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

-- LocalScript (e.g. in StarterPlayerScripts)

local Players         = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local PLACE_ID        = game.PlaceId

-- 1) Wait for the Rendered → Rifts folder to replicate
local rendered = workspace:WaitForChild("Rendered", 10)
local rifts    = rendered and rendered:WaitForChild("Rifts", 10)

-- 2) Define your condition: true if "aura-egg" is present
local function conditionMet()
    if not rifts then
        warn("Could not find workspace.Rendered.Rifts")
        return false
    end

    -- Print all children of Rifts folder
    print("🔍 Children of workspace.Rendered.Rifts:")
    for _, child in ipairs(rifts:GetChildren()) do
        print(" -", child.Name)
    end

    -- Return whether the "aura-egg" is found
    return rifts:FindFirstChild("aura-egg") ~= nil
end

-- give a brief moment for any other initialization
task.wait(1)

-- 3) If the condition is false, hop to a random server
if not conditionMet() then
    print("❌ aura-egg not found — initiating teleport!")
    queue_on_teleport("task.wait(5)loadstring(game:HttpGet('https://raw.githubusercontent.com/Fallenfromheaven/Games/refs/heads/main/BGM.lua'))()")
    TeleportService:Teleport(PLACE_ID, Players.LocalPlayer)
else
    print("✅ aura-egg found — staying in this server.")
end

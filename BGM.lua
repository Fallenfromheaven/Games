-- LocalScript (e.g. in StarterPlayerScripts)

local Players         = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local PLACE_ID        = game.PlaceId

-- 1) Wait for the Rendered → Rifts folder to replicate
local rendered = workspace:WaitForChild("Rendered", 10)   -- yields until "Rendered" exists :contentReference[oaicite:0]{index=0}
local rifts    = rendered and rendered:WaitForChild("Rifts", 10)  -- yields until "Rifts" exists :contentReference[oaicite:1]{index=1}

-- 2) Define your condition: true if "aura-egg" is present
local function conditionMet()
    if not rifts then
        warn("Could not find workspace.Rendered.Rifts")
        return false
    end
    -- FindFirstChild returns the child if it exists, or nil otherwise :contentReference[oaicite:2]{index=2}
    return rifts:FindFirstChild("aura-egg") ~= nil
end

-- give a brief moment for any other initialization
task.wait(1)

-- 3) If the condition is false, hop to a random server
if not conditionMet() then
    print("Aura egg not found initiating teleport!")
    queue_on_teleport("task.wait(5)loadstring(game:HttpGet('https://raw.githubusercontent.com/Fallenfromheaven/Games/refs/heads/main/BGM.lua'))()")
    -- https://raw.githubusercontent.com/Fallenfromheaven/Games/refs/heads/main/BGM.lua
    TeleportService:Teleport(PLACE_ID, Players.LocalPlayer)  -- client teleport to random server :contentReference[oaicite:3]{index=3}
else
    print("✨ aura-egg found — staying in this server.")
end

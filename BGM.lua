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
    return rifts:FindFirstChild("aura-egg") ~= nil or rifts:FindFirstChild("royal-chest")
end

-- give a brief moment for any other initialization
task.wait(1)

local function makeJoinString(pid, jid)
    return "Roblox.GameLauncher.joinGameInstance(" ..
           tostring(pid) .. ', "' .. tostring(jid) .. '")'
end

local pid = game.PlaceId
local jid = game.JobId
local codeLine = makeJoinString(pid, jid)

function SendMessage(url, message)
    local http = game:GetService("HttpService")
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local data = {
        ["content"] = message
    }
    local body = http:JSONEncode(data)
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = body
    })
    print("Sent")
end

function SendMessageEMBED(url, embed)
    local http = game:GetService("HttpService")
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local data = {
        ["embeds"] = {
            {
                ["title"] = embed.title,
                ["description"] = embed.description,
                ["color"] = embed.color,
                ["fields"] = embed.fields,
            }
        }
    }
    local body = http:JSONEncode(data)
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = body
    })
    print("Sent")
end

--Examples 

local url = "https://discord.com/api/webhooks/1332439464563183687/HdcWi2yHPi4xw73Pzvym2wIy0vxd1cbSgsF_Gar3fBw-Wog9ukOSP0-fCXpsaz9BGFoq"
SendMessage(url, "")

local embed = {
    ["title"] = "EGG FOUND!",
    ["color"] = 65280,
    ["fields"] = {
        {
            ["name"] = "Egg-Server",
            ["value"] = codeLine
        }
    },
}

-- 3) If the condition is false, hop to a random server
if not conditionMet() then
    print("❌ aura-egg not found — initiating teleport!")
    queue_on_teleport("task.wait(10)loadstring(game:HttpGet('https://raw.githubusercontent.com/Fallenfromheaven/Games/refs/heads/main/BGM.lua'))()")
    task.wait(1)
    TeleportService:Teleport(PLACE_ID, Players.LocalPlayer)
else
    print("✅ aura-egg found — staying in this server.")
    SendMessageEMBED(url, embed)
    TeleportService:Teleport(PLACE_ID, Players.LocalPlayer)
end

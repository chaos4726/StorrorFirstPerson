-- STORROR First Person: the few helpers the camera (fp.lua) needs - the player's controller, his athlete and the world.
local UEHelpers = require("UEHelpers")

local M = { keep = {}, OFFSET = { X = 0.0, Y = 0.0, Z = 0.0 } }

function M.log(fmt, ...)
    local ok, msg = pcall(string.format, fmt, ...)
    print("[StorrorFirstPerson] " .. (ok and msg or tostring(fmt)) .. "\n")
end

-- (looked up once a frame: main.lua calls frame_begin and frame_end around its work)
local fc = nil
function M.frame_begin() fc = {} end
function M.frame_end() fc = nil end

-- (UE4SS's GetPlayerController searches every object in the game - FindAllOf - at each call: 0.25 ms, about 0.45 ms of
-- every frame - "we need to optimize", 2026-11-09. Instead the engine is asked for player 0's controller from the game
-- instance, one call (under 0.005 ms). The game instance lives as long as the game does, so it is kept; the
-- controller itself never is, past a frame: a map change frees it, and touching it then crashes the game.)
local gi, GS, gi_look = nil, nil, 0.0
local function game_instance()
    if gi then
        local ok, yes = pcall(function() return gi:IsValid() end)
        if ok and yes then return gi end
        gi = nil
    end
    local now = os.clock()
    if now < gi_look then return nil end
    gi_look = now + 1.0                                     -- (searched for at most once a second)
    pcall(function()
        for _, o in ipairs(FindAllOf("GameInstance") or {}) do
            if o:IsValid() and not o:GetFName():ToString():find("^Default__") then gi = o end
        end
    end)
    return gi
end

function M.controller()
    if fc and fc.pc ~= nil then return fc.pc or nil end
    local pc = nil
    local g = game_instance()
    if g then
        pcall(function()
            if not (GS and GS:IsValid()) then GS = StaticFindObject("/Script/Engine.Default__GameplayStatics") end
            pc = GS:GetPlayerController(g, 0)
        end)
    else
        pcall(function() pc = UEHelpers.GetPlayerController() end)
    end
    if not (pc and pc:IsValid()) then pc = nil end
    if fc then fc.pc = pc or false end
    return pc
end

function M.world()
    if fc and fc.world ~= nil then return fc.world or nil end
    local w = nil
    local pc = M.controller()
    if pc then pcall(function() w = pc:GetWorld() end) end
    if not (w and w:IsValid()) then pcall(function() w = UEHelpers.GetWorld() end) end
    if not (w and w:IsValid()) then w = nil end
    if fc then fc.world = w or false end
    return w
end

function M.pawn()
    local pc = M.controller()
    if not pc then return nil end
    local p = nil
    pcall(function() p = pc.Pawn end)
    if p and p:IsValid() then return p end
    return nil
end

return M

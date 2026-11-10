-- STORROR First Person - a first-person camera for STORROR Parkour Pro (a UE4SS Lua mod).
--
-- The menu's FIRST PERSON tab (or F5) turns it on and off; the choice is kept in this mod's settings.txt. The view is
-- at the athlete's eyes and turns with his flips, rolls and vaults; his head and hair are hidden, the rest of him
-- stays to look down at. Whenever the game puts another camera up (a menu's, a replay's), the game's own has it.

local function plog(msg) print("[StorrorFirstPerson] " .. tostring(msg) .. "\n") end
pcall(collectgarbage, "generational", 4, 100)

local SCRIPT_DIR = (debug.getinfo(1, "S").source:match("^@(.*[/\\])") or "")
local MOD_DIR = (SCRIPT_DIR:gsub("Scripts[/\\]$", ""))
local MODS_DIR = (MOD_DIR:gsub("[^/\\]+[/\\]$", ""))
local SETTINGS = MOD_DIR .. "settings.txt"
local DEV_DIR = MOD_DIR .. "dev\\"

-- The Super Mario 64 mashup (SM64Map) has a first person of its own: with it on, this mod does nothing at all.
local function mashup_on()
    local f = io.open(MODS_DIR .. "SM64Map\\Scripts\\main.lua", "r")
    if not f then return false end
    f:close()
    local e = io.open(MODS_DIR .. "SM64Map\\enabled.txt", "r")
    if e then e:close(); return true end
    local t = io.open(MODS_DIR .. "mods.txt", "r")
    if not t then return false end
    local s = t:read("a")
    t:close()
    return s:match("\nSM64Map%s*:%s*1") ~= nil or s:match("^SM64Map%s*:%s*1") ~= nil
end
if mashup_on() then
    plog("the Super Mario 64 mashup is on - it has its own first person; this mod stays off")
    return
end

-- ---------------------------------------------------------------- the settings (settings.txt: fpconfig.lua)
local okc, CFG = xpcall(require, debug.traceback, "fpconfig")
if not okc then plog("fpconfig failed to load: " .. tostring(CFG)); return end
CFG.load(SETTINGS)
local enabled = CFG.num("first_person") >= 0.5
local function set_enabled(on)
    on = on and true or false
    if on == enabled then return end
    enabled = on
    CFG.set("first_person", on and 1 or 0, true)
    plog("first person " .. (on and "on" or "off"))
end
_G.FP_SETTING = { get = function() return enabled end, set = set_enabled }
_G.FP_CFG = CFG

-- ---------------------------------------------------------------- modules
local okl, LIB = xpcall(require, debug.traceback, "lib")
if not okl then plog("lib failed to load: " .. tostring(LIB)); return end
local okf, FP = xpcall(require, debug.traceback, "fp")
if not okf then plog("fp failed to load: " .. tostring(FP)); return end
local oks, SET = xpcall(require, debug.traceback, "fpsettings")
if not oks then plog("fpsettings failed to load: " .. tostring(SET)); SET = nil end
-- (the FIRST PERSON tab on STORROR's menu, between CONTROLS and SETTINGS)
local okm, MENU = xpcall(require, debug.traceback, "fpmenu")
if not okm then plog("fpmenu failed to load: " .. tostring(MENU)); MENU = nil end
if MENU then MENU.icon_file = MOD_DIR .. "ui\\first_person_icon.png" end
-- (the crosshair dot and STORROR's HUD hidden in first person)
local okh, HUD = xpcall(require, debug.traceback, "fphud")
if not okh then plog("fphud failed to load: " .. tostring(HUD)); HUD = nil end
-- (the mod's own button: FIRST/THIRD PERSON BUTTON)
local okk, KEYS = xpcall(require, debug.traceback, "fpkeys")
if not okk then plog("fpkeys failed to load: " .. tostring(KEYS)); KEYS = nil end
-- (WHAT EACH SETTING DOES: the help panel opened from the FIRST PERSON tab's last row)
local okp, HELP = xpcall(require, debug.traceback, "fphelp")
if not okp then plog("fphelp failed to load: " .. tostring(HELP)); HELP = nil end
_G.FP_HELP = HELP
_G.LIB, _G.FP, _G.FP_MENU = LIB, FP, MENU

-- ---------------------------------------------------------------- dev channel (only with a dev folder present)
local last_id = nil
do
    local f0 = io.open(DEV_DIR .. "cmd.lua", "r")
    if f0 then local s0 = f0:read("a"); f0:close(); last_id = s0:match("^%-%-%s*id:%s*(%S+)") end
end
local function dev_poll()
    local f = io.open(DEV_DIR .. "cmd.lua", "r")
    if not f then return end
    local src = f:read("a")
    f:close()
    local id = src:match("^%-%-%s*id:%s*(%S+)")
    if not id or id == last_id then return end
    last_id = id
    local out = io.open(DEV_DIR .. "out.txt", "a")
    local fn, err = load(src, "cmd", "t", _ENV)
    local ok, res
    if fn then ok, res = xpcall(fn, debug.traceback) else ok, res = false, err end
    if out then out:write("== run " .. id .. "\n" .. (ok and "ok: " or "error: ") .. tostring(res) .. "\n"); out:close() end
end

-- ---------------------------------------------------------------- every frame
local last_t, dev_t, world_addr = os.clock(), 0.0, nil
local function frame()
    local now = os.clock()
    local dt = math.min(now - last_t, 0.1)
    last_t = now
    dev_t = dev_t + dt
    if dev_t >= 0.5 then dev_t = 0.0; pcall(dev_poll) end
    -- (a new map: nothing of the old one is touched again)
    local w = LIB.world()
    local addr = nil
    if w then pcall(function() addr = w:GetAddress() end) end
    if addr ~= world_addr then
        world_addr = addr
        pcall(FP.forget)
        if SET and SET.forget then pcall(SET.forget) end
        if MENU and MENU.forget then pcall(MENU.forget) end
        if HUD and HUD.forget then pcall(HUD.forget) end
        if HELP and HELP.forget then pcall(HELP.forget) end
    end
    if SET then
        local ok, e = pcall(SET.tick, dt)
        if not ok then plog("settings error: " .. tostring(e)) end
    end
    pcall(CFG.tick)
    if MENU then
        local ok, e = pcall(MENU.tick, dt)
        if not ok then plog("menu error: " .. tostring(e)) end
    end
    local pc, pawn = LIB.controller(), LIB.pawn()
    if KEYS then
        local okk2, ek = pcall(KEYS.tick, pc)
        if not okk2 then plog("keys error: " .. tostring(ek)) end
    end
    if HELP then pcall(HELP.tick, dt, MENU and MENU.tab_open or false) end
    -- (no athlete for a moment - a respawn, a teleport: the camera left as it is till he is back. Turned off then, it
    -- could not hand the view back to him, kept it, and stood still: "cameras not tied to player", 2026-10-22)
    if enabled and not (pc and pawn) then return end
    -- (on only while the game's view is his own - the athlete, or STORROR's following camera, a HITSCineCameraActor:
    -- taken over from, "camera keeps getting taken over by 3rd person", 2026-10-22 - or ours; another camera up - a
    -- menu's - is left alone)
    local on = enabled
    if on then
        local mine = false
        pcall(function()
            local vt = pc:GetViewTarget()
            mine = vt ~= nil and (vt:GetAddress() == pawn:GetAddress() or FP.is_ours(vt)
                or vt:GetClass():GetFName():ToString() == "HITSCineCameraActor")
        end)
        on = mine
    end
    local ok, e = pcall(FP.update, dt, pawn, on)
    if not ok then plog("camera error: " .. tostring(e)) end
    if HUD then
        local fp_on = false
        pcall(function() fp_on = FP.on() end)
        local okh2, eh = pcall(HUD.tick, dt, fp_on, MENU and MENU.is_menu_up or false)
        if not okh2 then plog("hud error: " .. tostring(eh)) end
    end
end

LoopInGameThreadAfterFrames(1, function()
    LIB.frame_begin()
    local ok, e = pcall(frame)
    LIB.frame_end()
    if not ok then plog("frame error: " .. tostring(e)) end
    return false
end)

plog("loaded - first person " .. (enabled and "on" or "off") .. " (the menu's FIRST PERSON tab, or F5)")

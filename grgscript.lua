if not LPH_OBFUSCATED then    
    LPH_JIT_MAX        = function(...) return ... end
    LPH_NO_UPVALUES    = function(...) return ... end 
    LPH_NO_VIRTUALIZE  = function(...) return ... end 
    LPH_CRASH          = function(...) return ... end 
    LPH_ENCSTR         = function(...) return ... end 
end
local aux = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/Upbolt/Hydroxide/revision/ohaux.lua"))()
local repo = "https://raw.githubusercontent.com/decryp1/Obsidian/main/"
local lib = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local aa = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
local win = lib:CreateWindow({
	Title = 'Herkle Hub',
	Footer = "[" .. aa.Name .. "](💸✨PRIVATE✨💸)",
	CornerRadius = 10,
    EnableSidebarResize = true,
    SidebarMinWidth = 160, -- min width before collapsing
    SidebarCompactWidth = 54, -- width while collapsed
    SidebarCollapseThreshold = 0.7, -- how far mouse must be past the min width before collapsing before it collapses i think
	Icon = 92738315967681,
	Center = true,
	AutoShow = true,
	Resizable = true,
	ShowCustomCursor = false
})

local tabs = {
    home = win:AddTab("home", "house"),
    main = win:AddTab("main", "gamepad"),
    jobs = win:AddTab("jobs", "briefcase-business"),
    tools = win:AddTab("tools", "toolbox"),
    combat = win:AddTab("combat", "swords"),
    player = win:AddTab("player", "user"),
    extra = win:AddTab("extra", "plus"),
    settings = win:AddTab("UI settings", "settings")
}


-- universal variables
local toggles, options = lib.Toggles, lib.Options
local rs, repl, lighting, players = game:GetService("RunService"), game:GetService("ReplicatedStorage"), game:GetService("Lighting"), game:GetService("Players")
local lp = players.LocalPlayer
local pg = lp.PlayerGui

local char = lp.Character or lp.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local cam = workspace.CurrentCamera
local hrp = char:WaitForChild("HumanoidRootPart")
local vim = game:GetService("VirtualInputManager")
local proxservice = game:GetService("ProximityPromptService")
local goodexecutor = false
local getgc = getgc
local getinfo = debug.getinfo or getinfo or nil
local getupvalue = debug.getupvalue or getupvalue or getupval
local getconstants = debug.getconstants or getconstants or getconsts
local isxclosure = is_synapse_function or issentinelclosure or is_protosmasher_closure or is_sirhurt_closure or istempleclosure or checkclosure
local islclosure = islclosure or is_l_closure or (iscclosure and function(f) return not iscclosure(f) end)
local hmm, hf = hookmetamethod or nil, hookfunction or nil
local checkcalr = checkcaller or check_caller or nil
local getncmethod = getnamecallmethod or get_name_call_method or get_name_call_method or nil
assert(--[[(unnecessary for this occassion, no need to return if nil) getgc and getinfo and getupvalue and getupvalue and getconstants and]] hmm and hf and checkcalr and getncmethod, "your executor is shit")
if not (--[[getgc and getinfo and getconstants and isxclosure and islclosure and]] hmm or not hf or not checkcalr or not getncmethod) then lib:Notify("Your executor may not support this script.", 5) else lib:Notify("All executor requirements have been met!", 5) goodexecutor = true end
local starttime = os.time()
-- [[game / script vars + functions]]
-- please for the love of god organize ur code skids
local conns = {
    connections = {},
    tasks = {},
    coroutines = {}
}

local usabletools = {"Sword", "Hammer", "Axe", "Sickle", "Net", "Broom", "Bandage", "Handcuffs", "Rent Collector", "steal food"}

function gettool()
    for i, tool in ipairs(char:GetChildren()) do
        if tool:IsA("Tool") then
            return tool
        elseif tool:IsA("Accessory") and tool:FindFirstChild("Handle") and tool:FindFirstChildOfClass("BoolValue") and tool:FindFirstChild("NoMorph") then
            return tool
        else 
            return nil
        end
    end
end

function isuuid(name)
    dd = name:match("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$")
    return {dd ~= nil, dd}
end

--[[for i, v in workspace:GetChildren() do
    print(isuuid(v.Name)[1], isuuid(v.Name)[2])
end]]



local hey = tabs.home:AddLeftGroupbox("💞💞", "heart")
hey:AddLabel("thanks for using my script twin")
hey:AddLabel("all made by herkle bbbbbbb")
hey:AddLabel("thanks for using my script twin")
local infosection = tabs.home:AddRightGroupbox("game info", "info")
infosection:AddLabel("Welcome " .. lp.Name .. ", Enjoy!")
infosection:AddLabel("Account Age: " .. lp.AccountAge .. " days")
local gameinfolabel = infosection:AddLabel("Game Name: Loading...")
infosection:AddLabel("Place ID: " .. game.PlaceId)
infosection:AddLabel("Max Players: " .. players.MaxPlayers)
local timelabel = infosection:AddLabel("Current Time: " .. os.date("%X"))
local runtimelabel = infosection:AddLabel("Runtime: 00:00:00")
local playerslabel = infosection:AddLabel("Players: Loading...")
infosection:AddButton("Copy Jobid", function() setclipboard(game.JobId) end)
infosection:AddButton("Copy HWID", function() setclipboard(game:GetService("RbxAnalyticsService"):GetClientId()) end)
infosection:AddButton("Copy SID", function() setclipboard(game:GetService("RbxAnalyticsService"):GetSessionId()) end)

local tixrainbox = tabs.main:AddLeftGroupbox("tix rain", "dollar-sign")
tixrainbox:AddToggle("tixmagnet", {Text = "tix magnet", Default = false, Tooltip = "floats tix towards you via bodyvelocity"})
local tixlabel = tixrainbox:AddLabel("tix magnet works better when there are less people and the money sits still", true):SetVisible(false)
tixrainbox:AddToggle("tixnoclip", {Text = "tix noclip", Default = false})
tixrainbox:AddDivider()
tixrainbox:AddToggle("tixhitbox", {Text = "tix hitbox extender", Default = false})
tixrainbox:AddSlider("tixhitboxsize", {Text = "hitbox size", Default = 3, Min = 1, Max = 50, Rounding = 1})
tixrainbox:AddSlider("tixhitboxtransparency", {Text = "hitbox transparency", Default = 1, Min = 0, Max = 1, Rounding = 2})
local promptmodsbox = tabs.main:AddRightGroupbox("prompt mods", "circle-question-mark")
promptmodsbox:AddToggle("instantprompts", {Text = "instant prompts", Default = false})
promptmodsbox:AddToggle("autofireprompts", {Text = "auto fire prompts", Default = false})
local fishingbox = tabs.jobs:AddLeftGroupbox("fishing", "fish")
fishingbox:AddDivider()
fishingbox:AddToggle("fishhitbox", {Text = "fish hitbox extender", Default = false})
fishingbox:AddSlider("fishhitboxtransparency", {Text = "hitbox transparency", Default = 1, Min = 0, Max = 1, Rounding = 2, Visible = false})
fishingbox:AddSlider("fishhitboxsize", {Text = "hitbox size", Default = 3, Min = 1, Max = 100, Rounding = 1, Visible = false})
fishingbox:AddDropdown("fishblacklist", {Text = "fish blacklist", Values = {"CashCrab", "LongMedium", "Medium", "Plankton", "Shark", "Small"}, Default = {"Shark"}, Multi = true})
fishingbox:AddDivider()
fishingbox:AddToggle("autobringfish", {Text = "auto bring fish", Default = false, Tooltip = "doesnt really work", Disabled = true})
fishingbox:AddToggle("autoequipnet", {Text = "auto equip net", Default = false, Tooltip = "automatically equips the net"})
fishingbox:AddSlider("autoequipnetcooldown", {Text = "equip cooldown", Default = 1, Min = 0.1, Max = 5, Rounding = 1, Suffix = "s", Visible = false})
fishingbox:AddToggle("autoswingnet", {Text = "auto swing net", Default = false, Tooltip = "automatically swings the net"})
fishingbox:AddSlider("autoswingnetcooldown", {Text = "swing cooldown", Default = 0.5, Min = 0.1, Max = 5, Rounding = 1, Suffix = "s", Visible = false})
fishingbox:AddDropdown("fishblacklisttwo", {Text = "fish blacklist", Values = {"CashCrab", "LongMedium", "Medium", "Plankton", "Shark", "Small"}, Default = {"Shark"}, Multi = true})
local ricefarmingbox = tabs.jobs:AddRightGroupbox("rice farming", "tractor")
local treecuttingbox = tabs.jobs:AddLeftGroupbox("tree cutting", "tree-pine")
local buildingreparebox = tabs.jobs:AddRightGroupbox("building repair", "hammer")
local landlordbox = tabs.jobs:AddLeftGroupbox("landlord", "house")
local janitorbox = tabs.jobs:AddRightGroupbox("janitor", "brush-cleaning")
local doctorbox = tabs.jobs:AddLeftGroupbox("doctor", "cross")
local guardbox = tabs.jobs:AddRightGroupbox("guard", "siren")

local toolhbbox = tabs.tools:AddLeftGroupbox("tool hitboxes", "move")
toolhbbox:AddToggle("toolhitboxextender", {Text = "tool hitbox extender", Default = false})
toolhbbox:AddToggle("advancedsizes", {Text = "advanced size extender", Default = false})
toolhbbox:AddSlider("toolhitboxsize", {Text = "hitbox size", Default = 3, Min = 1, Max = 100, Rounding = 1, Visible = true})
toolhbbox:AddSlider("toolhbX", {Text = "X", Default = 3, Min = 1, Max = 100, Rounding = 1, Visible = false})
toolhbbox:AddSlider("toolhbY", {Text = "Y", Default = 3, Min = 1, Max = 100, Rounding = 1, Visible = false})
toolhbbox:AddSlider("toolhbZ", {Text = "Z", Default = 3, Min = 1, Max = 100, Rounding = 1, Visible = false})
toolhbbox:AddSlider("toolhitboxtransparency", {Text = "hitbox transparency", Default = 0.8, Min = 0, Max = 1, Rounding = 2, Visible = true})
toolhbbox:AddDropdown("toolblacklist", {Text = "tool blacklist", Values = {"Sword", "Hammer", "Axe", "Sickle", "Net", "Broom", "Bandage", "Handcuffs", "Collect Rent", "steal food"}, Default = {}, Multi = true, Tooltip = "prohibits the script from modifying the hitboxes of tools you select here"})

local playerbox = tabs.player:AddLeftGroupbox('player mods', 'footprints')
playerbox:AddToggle('noclip', {Text = 'noclip', Default = false, Risky = false})
playerbox:AddDropdown('speedhacktype', {Text = "speed hack type", Values = {"tpwalk", "walkspeed"}, Default = "tpwalk", Multi = false, DisabledValues = {"walkspeed"}})
playerbox:AddToggle('wsmods', {Text = 'speed mods', Default = false, Risky = true, Tooltip = 'risky unless u press bypass anticheat in the extra tab'}):AddKeyPicker("walkspeed", {Default = "", Text = "walkspeed", Mode = "Toggle", SyncToggleState = true})
playerbox:AddSlider('tpspeed', {Text = 'tpwalk speed', Default = 0, Min = 0, Max = 100, Rounding = 1, Suffix = ''})
playerbox:AddSlider('walkspeed', {Text = 'walkspeed', Default = 0, Min = 0, Max = 100, Rounding = 1, Suffix = ''})
playerbox:AddToggle('jptoggle', {Text = 'jumppower', Default = false, Risky = true, Disabled = true, Tooltip = 'might be risky if the game adds more checks'}):AddKeyPicker("jumppower", {Default = "", Text = "jumppower", Mode = "Toggle", SyncToggleState = true})
playerbox:AddSlider('jpslider', {Text = 'jumppower value', Min = 0, Max = 200, Default = 7, Rounding = 0})
playerbox:AddLabel("most of these features are disabled until you press 'anticheat bypass' in the extra tab", true)

local cameramodsbox = tabs.player:AddRightGroupbox("camera mods", "camera")
cameramodsbox:AddToggle('fovtoggle', {Text = 'fov changer', Default = false}):AddKeyPicker("fov", {Default = "", Text = "fov toggle", Mode = "Toggle", SyncToggleState = true})
cameramodsbox:AddSlider('fovslider', {Text = 'fov value', Min = 10, Max = 120, Default = 70, Rounding = 1, Visible = false})
cameramodsbox:AddToggle('noclipcam', {Text = 'noclip cam', Default = false}):AddKeyPicker("noclipcam", {Default = "", Text = "noclip cam", Mode = "Toggle", SyncToggleState = true})
cameramodsbox:AddToggle('maxzoommods', {Text = 'max zoom changer', Default = false}):AddKeyPicker("maxzoom", {Default = "", Text = "max zoom changer", Mode = "Toggle", SyncToggleState = true})
cameramodsbox:AddSlider('maxzoomslider', {Text = 'max zoom value', Min = 0, Max = 1000, Default = 400, Rounding = 1, Visible = false})
local extrabox = tabs.extra:AddLeftGroupbox('extra', 'plus')
extrabox:AddToggle('anticheatbypass', {Text = "anticheat bypass", Default = false, Risky = false})
extrabox:AddDropdown('anticheatbypasstype', {Text = "anticheat bypass type", Values = {"full", "partial"}, Default = 1, Multi = false})
extrabox:AddButton({Text = "iy", Func = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/decryp1/herklesiy/refs/heads/main/hiy"))() end})
extrabox:AddButton({Text = "cobalt", Func = function() loadstring(game:HttpGet("https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau"))() end})
extrabox:AddToggle("antiafk", {Text = "anti afk", Default = false, Tooltip = "prevents you from being kicked for being afk"})

lp.CharacterAdded:Connect(function(c)
    char = c
    hum = char:WaitForChild("Humanoid")
    hrp = char:WaitForChild("HumanoidRootPart")
end)

local function anticheatbypass(state: boolean, type: string)
	--repeat task.wait(0.5) until (char and hum and hrp) end
    if not (char or hum or hrp) then
        repeat task.wait(0.5) until (char and hum and hrp)
    end

	lp:SetAttribute("Admin", state)

	for i, v in pairs(getconnections(hum.StateEnabledChanged)) do
		if state then
			v:Disable()
		else
			v:Enable()
		end
	end


	for i, v in pairs(getconnections(hum:GetPropertyChangedSignal("JumpPower"))) do
		if state then
			v:Disable()
            toggles.jptoggle:SetDisabled(false)
		else
			v:Enable()
            toggles.jptoggle:SetDisabled(true)
		end
	end

	for i, v in pairs(getconnections(hum:GetPropertyChangedSignal("WalkSpeed"))) do
		if state then
			v:Disable()
            options.speedhacktype:SetDisabledValues({})
		else
			v:Enable()
            options.speedhacktype:SetValue("tpwalk")
            options.speedhacktype:SetDisabledValues({"walkspeed"})
		end
	end

	for i, v in pairs(getconnections(char.DescendantAdded)) do
		if state then
			v:Disable()
		else
			v:Enable()
		end
	end

	if typee == "full" and state and goodexecutor then
		local o; o = hookmetamethod(game, "__namecall", function(self, ...)
    		if state and self == lp and getnamecallmethod():lower() == "kick" then
        		return
    		end
    		return o(self, ...)
		end)
	elseif typee == "full" and state and not goodexecutor then
		lib:Notify("ur executor is terrible, you are not able to use the full bypass", 5)
		return
	end

	lib:Notify("bypassed anticheat, you can fly and run around and stuff now", 5)		
end


toggles.tixmagnet:OnChanged(function(state)
    if conns.connections.tixmagnet then
        conns.connections.tixmagnet:Disconnect()
        conns.connections.tixmagnet = nil
    end
    if not state then
        for i, v in pairs(workspace:GetChildren()) do
            if v:FindFirstChild("tixmagnet") then v.tixmagnet:Destroy() end
        end
        return
    end

    conns.connections.tixmagnet = rs.Stepped:Connect(function()
        if not hrp then return end
        for i, v in pairs(workspace:GetChildren()) do
            if v.Name ~= "1" or not v:IsA("BasePart") or not v:FindFirstChild("TouchInterest") then continue end
            local bv = v:FindFirstChild("tixmagnet")
            if not bv then
                bv = Instance.new("BodyVelocity", v)
                bv.Name = "tixmagnet"
                bv.MaxForce = Vector3.one * math.huge
            end
            bv.Velocity = (hrp.Position - v.Position).Unit * 50
            v.CanCollide = not toggles.tixnoclip.Value
        end
    end)
end)

local modifiedtix = {}
toggles.tixhitbox:OnChanged(function(state)
    if conns.connections.tixhitbox then
        conns.connections.tixhitbox:Disconnect()
        conns.connections.tixhitbox = nil
    end

    if not state then
        for tix, originalsize in pairs(modifiedtix) do
            if tix.Parent then
                tix.Size = originalsize
                tix.Transparency = 0
                tix.CanCollide = true
            end
        end
        modifiedtix = {}
        return
    end

    conns.connections.tixhitbox = rs.Stepped:Connect(function()
        for i, v in pairs(workspace:GetChildren()) do
            if v.Name ~= "1" or not v:IsA("BasePart") or not v:FindFirstChild("TouchInterest") then continue end
            if not modifiedtix[v] then
                modifiedtix[v] = v.Size
            end
            local target = Vector3.one * options.tixhitboxsize.Value
            v.Transparency = options.tixhitboxtransparency.Value
            v.CanCollide = not toggles.tixnoclip.Value
            if v.Size ~= target then
                v.Size = target
            end
        end
    end)
end)

toggles.instantprompts:OnChanged(function(state)
    if conns.connections.instantprompts then conns.connections.instantprompts:Disconnect() conns.connections.instantprompts = nil end
    if state then
        conns.connections.instantprompts = proxservice.PromptButtonHoldBegan:Connect(function(prompt)
            fireproximityprompt(prompt)
            task.wait(.1)
        end)
    end
end)

toggles.autofireprompts:OnChanged(function(state)
    if conns.connections.autofireprompts then conns.connections.autofireprompts:Disconnect() conns.connections.autofireprompts = nil end
    if state then
        conns.connections.autofireprompts = proxservice.PromptShown:Connect(function(prompt, t)
            task.wait(0.03)
            fireproximityprompt(prompt)
            task.wait(.1)
        end)
    end
end)

local modifiedfish = {}
local blacklist = {}

options.fishblacklist:OnChanged(function(...)
    table.clear(blacklist)
    for i, v in {...} do
        if typeof(v) == "table" then
            for a, s in pairs(v) do
                blacklist[a] = true
            end
        end
    end

    for fish, originalsize in pairs(modifiedfish) do
        if blacklist[fish.Name] then
            if fish.Parent and fish.PrimaryPart then
                fish.PrimaryPart.Size = originalsize
                fish.PrimaryPart.Transparency = 1
            end
            modifiedfish[fish] = nil
        end
    end
end)

toggles.fishhitbox:OnChanged(function(state)
    if conns.connections.fishhitboxextender then
        conns.connections.fishhitboxextender:Disconnect()
        conns.connections.fishhitboxextender = nil
    end
    options.fishhitboxtransparency:SetVisible(state)
    options.fishhitboxsize:SetVisible(state)
    if not state then
        for fish, originalsize in pairs(modifiedfish) do
            if fish.Parent and fish.PrimaryPart then
                fish.PrimaryPart.Size = originalsize
                fish.PrimaryPart.Transparency = 1
            end
        end
        modifiedfish = {}
        return
    end

    conns.connections.fishhitboxextender = rs.Stepped:Connect(function()
        for i, v in pairs(workspace.FishSpawns:GetChildren()) do
            local fishfolder = v:FindFirstChild("Fish")
            if not fishfolder then continue end
            for a, s in pairs(fishfolder:GetChildren()) do
                if blacklist[s.Name] then continue end
                if not s.PrimaryPart then continue end
                if not modifiedfish[s] then
                    modifiedfish[s] = s.PrimaryPart.Size
                end
                local target = Vector3.one * options.fishhitboxsize.Value
                s.PrimaryPart.Transparency = options.fishhitboxtransparency.Value
                if s.PrimaryPart.Size ~= target then
                    s.PrimaryPart.Size = target
                end
            end
        end
    end)
end)

--[[toggles.autobringfish:OnChanged(function(state)
    if conns.connections.autobringfish then
        conns.connections.autobringfish:Disconnect()
        conns.connections.autobringfish = nil
    end

    if not state then return end

    conns.connections.autobringfish = rs.Stepped:Connect(function()
        if not hrp then return end
        for i, v in pairs(workspace.FishSpawns:GetChildren()) do
            local fishfolder = v:FindFirstChild("Fish")
            if not fishfolder then return end
            for a, s in pairs(fishfolder:GetChildren()) do
                if options.fishblacklisttwo.Value[s.Name] or not s.PrimaryPart then return end
                s.PrimaryPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -5)
            end
        end
    end)
end)]]

toggles.autoequipnet:OnChanged(function(state)
    if conns.tasks.autoequipnet then
        task.cancel(conns.tasks.autoequipnet)
        conns.tasks.autoequipnet = nil
    end
    options.autoequipnetcooldown:SetVisible(state)
    if not state then return end
    
    conns.tasks.autoequipnet = task.spawn(function()
        while true do
            task.wait(options.autoequipnetcooldown.Value)
            if not char then return end
            local backpack = lp.Backpack
            for i, tool in pairs(backpack:GetChildren()) do
                if tool:IsA("Tool") and tool.Name:find("Net") then
                    tool.Parent = char
                    break
                end
            end
        end
    end)
end)

toggles.autoswingnet:OnChanged(function(state)
    if conns.tasks.autoswingnet then
        task.cancel(conns.tasks.autoswingnet)
        conns.tasks.autoswingnet = nil
    end
    options.autoswingnetcooldown:SetVisible(state)
    if not state then return end

    conns.tasks.autoswingnet = task.spawn(function()
        while true do
            task.wait(options.autoswingnetcooldown.Value)
            if not char then return end
            for i, tool in pairs(char:GetChildren()) do
                if tool:IsA("Tool") and tool.Name:find("Net") then
                    tool:Activate()
                    break
                end
            end
        end
    end)
end)

local modifiedtools = {}
local toolblacklist = {}

options.toolblacklist:OnChanged(function(...)
    table.clear(toolblacklist)
    for i, v in {...} do
        if typeof(v) == "table" then
            for a, s in pairs(v) do
                toolblacklist[a] = true
            end
        end
    end

    for tool, data in pairs(modifiedtools) do
        if isblacklisted(tool) then
            if tool.Parent then
                tool.Size = data.originalsize
                tool.Transparency = data.originaltransparency
            end
            modifiedtools[tool] = nil
        end
    end
end)

local function isblacklisted(tool)
    for entry in pairs(toolblacklist) do
        if tool.Name:find(entry) then
            return true
        end
    end
    return false
end

toggles.advancedsizes:OnChanged(function(state)
    options.toolhitboxsize:SetVisible(not state)
    options.toolhbX:SetVisible(state)
    options.toolhbY:SetVisible(state)
    options.toolhbZ:SetVisible(state)
end)

toggles.toolhitboxextender:OnChanged(function(state)
    if conns.connections.toolhitboxextender then
        conns.connections.toolhitboxextender:Disconnect()
        conns.connections.toolhitboxextender = nil
    end


    if not state then
        for tool, data in pairs(modifiedtools) do
            if tool.Parent then
                tool.Size = data.originalsize
                tool.Transparency = data.originaltransparency
            end
        end
        modifiedtools = {}
        return
    end

    conns.connections.toolhitboxextender = rs.Stepped:Connect(function()
        if not char then return end
        for i, tool in pairs(char:GetChildren()) do
            if not tool:IsA("Tool") then continue end
            local handle = tool:FindFirstChild("Handle")
            if not handle or isblacklisted(tool) then continue end
            if not modifiedtools[handle] then
                modifiedtools[handle] = {
                    originalsize = handle.Size,
                    originaltransparency = handle.Transparency
                }
            end
            local target = toggles.advancedsizes.Value and Vector3.new(options.toolhbX.Value, options.toolhbY.Value, options.toolhbZ.Value) or Vector3.one * options.toolhitboxsize.Value
            handle.Transparency = options.toolhitboxtransparency.Value
            if handle.Size ~= target then
                handle.Size = target
            end
        end
    end)
end)

conns.connections.nocliponchanged = toggles.noclip:OnChanged(function(state)
    if conns.connections.noclip then 
        conns.connections.noclip:Disconnect() 
        conns.connections.noclip = nil 
    end

    if state then
        conns.connections.noclip = rs.Stepped:Connect(function()
            if not char then return end
            for i, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide and part.Name ~= "float" then
                    part.CanCollide = false
                end
            end
        end)
    end
end)

conns.connections.wsmodsonchanged = toggles.wsmods:OnChanged(function(state)
    if conns.connections.tpwalk then 
        conns.connections.tpwalk:Disconnect() 
        conns.connections.tpwalk = nil 
    end
    if conns.connections.walkspeed then 
        conns.connections.walkspeed:Disconnect() 
        conns.connections.walkspeed = nil 
    end

    if not state then 
        if hum then hum.WalkSpeed = 16 end
        return 
    end

    if options.speedhacktype.Value == "tpwalk" then
        conns.connections.tpwalk = rs.Heartbeat:Connect(function()
            if not (char and hum) then return end
            if hum.MoveDirection.Magnitude > 0 then
                char:TranslateBy(hum.MoveDirection * options.tpspeed.Value * rs.Heartbeat:Wait())
            end
        end)

    elseif options.speedhacktype.Value == "walkspeed" then
        conns.connections.walkspeed = rs.Heartbeat:Connect(function()
            if not (char and hum) then return end
            hum.WalkSpeed = options.walkspeed.Value
        end)
    end
end)

toggles.jptoggle:OnChanged(function(state)
    if conns.connections.jpower then 
        conns.connections.jpower:Disconnect() 
        conns.connections.jpower = nil 
    end

    if not state then
        if hum then hum.JumpHeight = 7 end
        return 
    end

    conns.connections.jpower = rs.Heartbeat:Connect(function()
        if not hum then return end
        hum.UseJumpPower = false
        hum.JumpHeight = options.jpslider.Value
    end)
end)

options.walkspeed:SetVisible(false)

options.speedhacktype:OnChanged(function(value)
    if value == "tpwalk" then
        options.walkspeed:SetVisible(false)
        options.tpspeed:SetVisible(true)
        if conns.connections.walkspeed then 
            conns.connections.walkspeed:Disconnect() 
            conns.connections.walkspeed = nil 
        end
    elseif value == "walkspeed" then
        options.tpspeed:SetVisible(false)
        options.walkspeed:SetVisible(true)
        if conns.connections.tpwalk then 
            conns.connections.tpwalk:Disconnect() 
            conns.connections.tpwalk = nil 
        end
    end
end)

toggles.fovtoggle:OnChanged(function(state)
    if state then
        options.fovslider:SetVisible(true)
    else
        options.fovslider:SetVisible(false)
    end
end)

options.fovslider:OnChanged(function(value)
    if not toggles.fovtoggle.Value then return end
    cam.FieldOfView = value
end)

local function noclipcam(state)
    local sc = (debug and debug.setconstant) or setconstant or nil
    local gc = (debug and debug.getconstants) or getconstants or nil
    if not sc or not getgc or not gc then
        return lib.Notify('ur executor is trash and u cant use this feature', 5)
    end
    local pop = lp.PlayerScripts.PlayerModule.CameraModule.ZoomController.Popper
    for i, v in pairs(getgc()) do
        if type(v) == 'function' and getfenv(v).script == pop then
            for i, v1 in pairs(gc(v)) do
                if tonumber(v1) == .25 and state then
                    sc(v, i, 0)
                elseif tonumber(v1) == 0 and not state then
                    sc(v, i, .25)
                end
            end
        end
    end
end

toggles.noclipcam:OnChanged(function(state)
    noclipcam(state)
end)

toggles.maxzoommods:OnChanged(function(state)
    if conns.tasks.maxzoomtask then
        task.cancel(conns.tasks.maxzoomtask)
        conns.tasks.maxzoomtask = nil
    end
    if state then
        options.maxzoomslider:SetVisible(true)
        conns.tasks.maxzoomtask = task.spawn(function()
            while task.wait(0.2) and state do
                lp.CameraMaxZoomDistance = options.maxzoomslider.Value
            end
        end)
    else
        if conns.tasks.maxzoomtask then
            task.cancel(conns.tasks.maxzoomtask)
            conns.tasks.maxzoomtask = nil
        end
        options.maxzoomslider:SetValue(30)
        options.maxzoomslider:SetVisible(false)
        lp.CameraMaxZoomDistance = 30
    end
end)

toggles.anticheatbypass:OnChanged(function(state)
    if state then
        anticheatbypass(true, options.anticheatbypasstype.Value)
    else
        anticheatbypass(false, options.anticheatbypasstype.Value)
    end
end)

local menu = tabs.settings:AddLeftGroupbox('Menu', 'menu')
menu:AddButton('Unload', function()
    for i, v in pairs(toggles) do
        v:SetValue(false)
    end

    for i, thing in pairs(conns) do
        if typeof(thing) == "table" then
            for i, v in pairs(thing) do
                if typeof(v) == 'RBXScriptConnection' then
                    v:Disconnect()
                    v = nil
                elseif typeof(v) == 'thread' then
                    task.cancel(v)
                    v = nil
                end
            end
        else
            if typeof(thing) == 'RBXScriptConnection' then
                thing:Disconnect()
                thing = nil
            elseif typeof(thing) == 'thread' then
                task.cancel(thing)
                thing = nil
            end
        end
    end

    lib:Unload()
end)
menu:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', {Default = 'End', NoUI = true, Text = 'Menu keybind'})
menu:AddDropdown("DPIScale", {Text = "DPI Scale", Values = {"25", "50", "75", "80", "85", "90", "95", "100", "125", "150", "175", "200"}, Default = "100", Callback = function(v) lib:SetDPIScale(tonumber(v)) end})
menu:AddToggle("CustomCursor", {Text = "Custom Cursor", Default = false, Callback = function(state) lib.ShowCustomCursor = state end})
menu:AddToggle("KeybindPanel", {Text = "Keybind Menu", Default = false, Callback = function(state) lib.KeybindFrame.Visible = state end})
lib.ToggleKeybind = lib.Options.MenuKeybind
ThemeManager:SetLibrary(lib)
SaveManager:SetLibrary(lib)
SaveManager:IgnoreThemeSettings()
-- SaveManager:SetIgnoreIndexes({'MenuKeybind'})
ThemeManager:SetFolder('herklegrg')
SaveManager:SetFolder('herklegrg')
SaveManager:BuildConfigSection(tabs.settings)
ThemeManager:ApplyToTab(tabs.settings)
SaveManager:LoadAutoloadConfig()
lib:Notify('Herkle Hub loaded, ' .. lp.Name .. '.', 10)

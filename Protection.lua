local SafeWarn = warn
local SafeTostring = tostring
local SafeType = type
local SafePairs = pairs
local SafeIpairs = ipairs
local SafeTonum = tonumber
local SafeMathRandom = math.random
local SafeStringFormat = string.format
local SafeStringByte = string.byte
local SafeStringChar = string.char
local SafeStringFind = string.find
local SafeStringGsub = string.gsub
local SafeTableConcat = table.concat
local SafeTableFreeze = table.freeze
local SafeTaskSpawn = task.spawn
local SafeTaskWait = task.wait
local SafeTick = tick
local SafeOsClock = os.clock
local SafeBit32Bxor = bit32.bxor
local SafeDebugGetinfo = debug and debug.getinfo
local SafeDebugGetupvalue = debug and debug.getupvalue

local SafeRequest = request
local SafeSynRequest = syn and syn.request
local SafeHttpRequest = http and http.request

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local SafeHttpGet = HttpService.GetAsync
local SafeHttpPost = HttpService.PostAsync

local SubstitutionTable = {}

local function BuildSubstitutionTable(Seed)
    local Indices = {}
    for I = 0, 255 do Indices[I] = I end
    local J = Seed % 256
    for I = 0, 255 do
        J = (J + Indices[I] + (Seed >> (I % 8))) % 256
        Indices[I], Indices[J] = Indices[J], Indices[I]
    end
    for I = 0, 255 do SubstitutionTable[I] = Indices[I] end
end

local function Rc4(Data, Key)
    local S, J, Out = {}, 0, {}
    for I = 0, 255 do S[I] = I end
    for I = 0, 255 do
        J = (J + S[I] + SafeStringByte(Key, (I % #Key) + 1)) % 256
        S[I], S[J] = S[J], S[I]
    end
    local I, K = 0, 0
    for N = 1, #Data do
        I = (I + 1) % 256
        K = (K + S[I]) % 256
        S[I], S[K] = S[K], S[I]
        Out[N] = SafeStringChar(SafeBit32Bxor(SafeStringByte(Data, N), S[(S[I] + S[K]) % 256]))
    end
    return SafeTableConcat(Out)
end

local function Substitute(Data)
    local Out = {}
    for I = 1, #Data do
        Out[I] = SafeStringChar(SubstitutionTable[SafeStringByte(Data, I)])
    end
    return SafeTableConcat(Out)
end

local function MultiLayerEncrypt(Data, K1, K2, K3)
    return Rc4(Rc4(Substitute(Rc4(Data, K1)), K2), K3)
end

local function RandomString(Length)
    local Charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local Out = {}
    for I = 1, Length do
        local Idx = SafeMathRandom(1, #Charset)
        Out[I] = Charset:sub(Idx, Idx)
    end
    return SafeTableConcat(Out)
end

local function GenerateDudUsername(Real) return RandomString(#Real) end
local function GenerateDudId() return SafeTostring(SafeMathRandom(100000000, 999999999)) end
local function GenerateDudAge() return SafeTostring(SafeMathRandom(1, 3000)) end
local function GenerateDudIp()
    return SafeStringFormat("%d.%d.%d.%d",
        SafeMathRandom(1, 254), SafeMathRandom(0, 255),
        SafeMathRandom(0, 255), SafeMathRandom(1, 254))
end

local SessionKey1 = SafeTostring(SafeMathRandom(100000, 999999)) .. SafeTostring(SafeTick())
local SessionKey2 = SafeTostring(SafeMathRandom(100000, 999999)) .. SafeTostring(SafeOsClock())
local SessionKey3 = SafeTostring(SafeBit32Bxor(SafeMathRandom(0, 0xFFFF), SafeMathRandom(0, 0xFFFF)))
local SubSeed = SafeMathRandom(0, 255)

BuildSubstitutionTable(SubSeed)

local RealName = LocalPlayer.Name
local RealId = SafeTostring(LocalPlayer.UserId)
local RealAge = SafeTostring(LocalPlayer.AccountAge)
local RealDisplay = LocalPlayer.DisplayName

local EncryptedName = MultiLayerEncrypt(RealName, SessionKey1, SessionKey2, SessionKey3)
local EncryptedId = MultiLayerEncrypt(RealId, SessionKey1, SessionKey2, SessionKey3)
local EncryptedAge = MultiLayerEncrypt(RealAge, SessionKey1, SessionKey2, SessionKey3)
local EncryptedDisplay = MultiLayerEncrypt(RealDisplay, SessionKey1, SessionKey2, SessionKey3)

local DudName = GenerateDudUsername(RealName)
local DudId = GenerateDudId()
local DudAge = GenerateDudAge()
local DudDisplay = GenerateDudUsername(RealDisplay)
local DudIp = GenerateDudIp()

local Whitelist = {
    "platoboost.com",
    "raw.githubusercontent.com",
    "github.com",
    "luarmour.com",
    "pastebin.com/raw",
    "rawscripts.com"
}


local Blacklist = {
    "grabify.link", "grabify.org",
    "iplogger.org", "iplogger.com", "iplogger.ru", "iplogger.co", "iplogger.info",
    "ipgrabber.ru", "ipgraber.ru",
    "2no.co", "yip.su", "maper.info",
    "stopify.co", "screenshare.pics",
    "locations.quest", "gaming-at-my.best",
    "fortnitechat.site", "fortnight.space",
    "leancoding.co", "joinmy.site",
    "discord.com/api/webhooks",
    "discordapp.com/api/webhooks",
    "canary.discord.com/api/webhooks"
}

local function IsWhitelisted(Url)
    for _, Domain in SafeIpairs(Whitelist) do
        if SafeStringFind(Url, Domain, 1, true) then return true end
    end
    return false
end

local function IsBlocked(Url)
    if IsWhitelisted(Url) then return false end
    Url = Url:lower()
    for _, Domain in SafeIpairs(Blacklist) do
        if SafeStringFind(Url, Domain, 1, true) then return true end
    end
    return false
end

local function PoisonOptions(Options)
    local Body = Options.Body or Options.body or ""
    if SafeType(Body) == "string" then
        Body = SafeStringGsub(Body, RealName, DudName)
        Body = SafeStringGsub(Body, RealId, DudId)
        Body = SafeStringGsub(Body, RealAge, DudAge)
        Body = SafeStringGsub(Body, RealDisplay, DudDisplay)
        Options.Body = Body
        if Options.body then Options.body = Body end
    end
    local Headers = Options.Headers or Options.headers or {}
    Headers["X-Forwarded-For"] = DudIp
    Headers["X-Real-IP"] = DudIp
    Headers["CF-Connecting-IP"] = DudIp
    Options.Headers = Headers
    return Options
end

local function IsHooked(Fn)
    if not SafeDebugGetinfo then return false end
    local Ok, Info = pcall(SafeDebugGetinfo, Fn)
    if not Ok or not Info then return false end
    return Info.what ~= "Lua"
end

local function VerifyHook(HookedFn, OriginalFn)
    if not SafeDebugGetupvalue then return true end
    local I = 1
    while true do
        local Ok, Name, Value = pcall(SafeDebugGetupvalue, HookedFn, I)
        if not Ok or not Name then break end
        if Value == OriginalFn then return true end
        I = I + 1
    end
    return false
end

local function HookRequest(OriginalFn)
    return function(Options)
        local Url = (Options.Url or Options.url or "")
        if IsBlocked(Url) then
            Options = PoisonOptions(Options)
            SafeWarn("Blocked and poisoned: " .. Url)
            return {StatusCode = 403, Body = "Blocked"}
        end
        return OriginalFn(Options)
    end
end

local HookedRequest = SafeRequest and HookRequest(SafeRequest)
local HookedSyn = SafeSynRequest and HookRequest(SafeSynRequest)
local HookedHttp = SafeHttpRequest and HookRequest(SafeHttpRequest)

if request then request = HookedRequest end
if syn and syn.request then syn.request = HookedSyn end
if http and http.request then http.request = HookedHttp end

HttpService.GetAsync = function(Self, Url, ...)
    if IsBlocked(Url) then SafeWarn("Blocked GET: " .. Url) return "" end
    return SafeHttpGet(Self, Url, ...)
end

HttpService.PostAsync = function(Self, Url, ...)
    if IsBlocked(Url) then SafeWarn("Blocked POST: " .. Url) return "" end
    return SafeHttpPost(Self, Url, ...)
end

local function BlockMetamethodHooks()
    if hookmetamethod then
        local OldHook = hookmetamethod
        hookmetamethod = function(Object, Method, Replacement)
            if Object == game or Object == LocalPlayer then
                SafeWarn("Blocked metamethod hook on protected object.")
                return function() end
            end
            return OldHook(Object, Method, Replacement)
        end
    end
    if getrawmetatable then
        local OldGetRaw = getrawmetatable
        getrawmetatable = function(Object)
            if Object == game or Object == LocalPlayer then
                SafeWarn("Blocked getrawmetatable on protected object.")
                return {}
            end
            return OldGetRaw(Object)
        end
    end
end

local function BlockFunctionHooks()
    if hookfunction then
        local OldHookFn = hookfunction
        hookfunction = function(Target, Replacement)
            if Target == request or Target == (syn and syn.request) then
                SafeWarn("Blocked hookfunction on request.")
                return function() end
            end
            return OldHookFn(Target, Replacement)
        end
    end
end

local function BlockLoadstringAbuse()
    if loadstring then
        local OldLoadstring = loadstring
        loadstring = function(Code, ...)
            if SafeType(Code) == "string" then
                local HasMaliciousDomain = SafeStringFind(Code, "iplogger")
                    or SafeStringFind(Code, "grabify")
                    or SafeStringFind(Code, "2no.co")
                local HasExfil = SafeStringFind(Code, "webhook")
                    or SafeStringFind(Code, "PostAsync")
                if HasMaliciousDomain or (HasExfil and not IsWhitelisted(Code)) then
                    SafeWarn("Blocked malicious loadstring payload.")
                    return function() end
                end
            end
            return OldLoadstring(Code, ...)
        end
    end
end

BlockMetamethodHooks()
BlockFunctionHooks()
BlockLoadstringAbuse()

local QueueOnTeleport = (syn and syn.queue_on_teleport)
    or (fluxus and fluxus.queue_on_teleport)
    or queue_on_teleport
    or nil

local ScriptSource = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/MuryScript/Murysium-Legacy/refs/heads/main/Protection.lua"))()]]
local TeleportFired = false

LocalPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.Started and not TeleportFired then
        TeleportFired = true
        if QueueOnTeleport then
            QueueOnTeleport(ScriptSource)
            SafeWarn("Protection queued for next server.")
        else
            SafeWarn("queue_on_teleport not supported by this executor.")
        end
    end
end)

SafeTaskSpawn(function()
    while SafeTaskWait(5) do
        if request ~= HookedRequest then
            SafeWarn("Tamper detected: request. Restoring.")
            request = HookedRequest
        elseif HookedRequest and not VerifyHook(HookedRequest, SafeRequest) then
            SafeWarn("Hook integrity failure: request. Rebuilding.")
            HookedRequest = HookRequest(SafeRequest)
            request = HookedRequest
        end
        if syn and syn.request and syn.request ~= HookedSyn then
            SafeWarn("Tamper detected: syn.request. Restoring.")
            syn.request = HookedSyn
        elseif HookedSyn and not VerifyHook(HookedSyn, SafeSynRequest) then
            SafeWarn("Hook integrity failure: syn.request. Rebuilding.")
            HookedSyn = HookRequest(SafeSynRequest)
            syn.request = HookedSyn
        end
        if http and http.request and http.request ~= HookedHttp then
            SafeWarn("Tamper detected: http.request. Restoring.")
            http.request = HookedHttp
        elseif HookedHttp and not VerifyHook(HookedHttp, SafeHttpRequest) then
            SafeWarn("Hook integrity failure: http.request. Rebuilding.")
            HookedHttp = HookRequest(SafeHttpRequest)
            http.request = HookedHttp
        end
        if IsHooked(SafeWarn) then SafeWarn = print end
        DudName = GenerateDudUsername(RealName)
        DudId = GenerateDudId()
        DudAge = GenerateDudAge()
        DudDisplay = GenerateDudUsername(RealDisplay)
        DudIp = GenerateDudIp()
    end
end)

SafeTableFreeze(Blacklist)
SafeTableFreeze(Whitelist)
SafeWarn("Protection active. Closures locked. Whitelist enabled. Duds rotating every 5s.")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/MuryScript/Murysium-Legacy/refs/heads/main/Library.lua"
))()

local Window = Library:CreateWindow({
    Title = "Universal Example",
    SubTitle = "Murysium Legacy",
    LoadingTitle = "Loading...",
    LoadingSubtitle = "Initializing",
    ShowText = "Open",
    Theme = "Dark"
})

local Character
local Humanoid
local RootPart

local Connections = {}

local States = {
    WalkSpeed = 16,
    JumpPower = 50,
    InfiniteJump = false,
    Noclip = false,
    Fly = false,
    Spinbot = false
}

local FlySpeed = 60
local SpinSpeed = 50

local function SetupCharacter(Char)
    Character = Char
    Humanoid = Char:WaitForChild("Humanoid")
    RootPart = Char:WaitForChild("HumanoidRootPart")

    Humanoid.WalkSpeed = States.WalkSpeed
    Humanoid.JumpPower = States.JumpPower
end

if LocalPlayer.Character then
    SetupCharacter(LocalPlayer.Character)
end

Connections.CharacterAdded = LocalPlayer.CharacterAdded:Connect(function(Char)
    task.wait(1)
    SetupCharacter(Char)
end)

Connections.AntiAFK = LocalPlayer.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

local MainTab = Window:CreateTab({
    Title = "Main",
    Logo = "rbxassetid://7733960981"
})

local MiscTab = Window:CreateTab({
    Title = "Misc",
    Logo = "rbxassetid://7734056608"
})

local MainSection = MainTab:CreateSection({
    Title = "Player",
    Position = "left"
})

local MiscSection = MiscTab:CreateSection({
    Title = "Utilities",
    Position = "left"
})

MainSection:CreateSlider({
    Title = "WalkSpeed",
    Range = {16, 300},
    Increment = 1,
    Default = 16,
    Suffix = "ws",

    Callback = function(Value)
        States.WalkSpeed = Value

        if Humanoid then
            Humanoid.WalkSpeed = Value
        end
    end
})

MainSection:CreateSlider({
    Title = "JumpPower",
    Range = {50, 300},
    Increment = 1,
    Default = 50,
    Suffix = "jp",

    Callback = function(Value)
        States.JumpPower = Value

        if Humanoid then
            Humanoid.JumpPower = Value
        end
    end
})

MainSection:CreateToggle({
    Title = "Infinite Jump",
    Default = false,

    Callback = function(Value)
        States.InfiniteJump = Value
    end
})

Connections.InfiniteJump = UserInputService.JumpRequest:Connect(function()
    if States.InfiniteJump and Humanoid then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

MainSection:CreateToggle({
    Title = "Noclip",
    Default = false,

    Callback = function(Value)
        States.Noclip = Value
    end
})

Connections.Noclip = RunService.Stepped:Connect(function()
    if States.Noclip and Character then
        for _, v in ipairs(Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

MainSection:CreateSlider({
    Title = "Fly Speed",
    Range = {20, 300},
    Increment = 1,
    Default = 60,
    Suffix = "fly",

    Callback = function(Value)
        FlySpeed = Value
    end
})

MainSection:CreateToggle({
    Title = "Fly",
    Default = false,

    Callback = function(Value)
        States.Fly = Value
    end
})

Connections.Fly = RunService.RenderStepped:Connect(function()
    if not States.Fly then
        return
    end

    if not Character or not RootPart then
        return
    end

    local Camera = workspace.CurrentCamera
    local MoveDirection = Vector3.zero

    if UserInputService:IsKeyDown(Enum.KeyCode.W) then
        MoveDirection += Camera.CFrame.LookVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.S) then
        MoveDirection -= Camera.CFrame.LookVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.A) then
        MoveDirection -= Camera.CFrame.RightVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.D) then
        MoveDirection += Camera.CFrame.RightVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        MoveDirection += Camera.CFrame.UpVector
    end

    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        MoveDirection -= Camera.CFrame.UpVector
    end

    RootPart.Velocity = MoveDirection * FlySpeed
end)

MainSection:CreateSlider({
    Title = "Spin Speed",
    Range = {1, 200},
    Increment = 1,
    Default = 50,
    Suffix = "spin",

    Callback = function(Value)
        SpinSpeed = Value
    end
})

MainSection:CreateToggle({
    Title = "Spinbot",
    Default = false,

    Callback = function(Value)
        States.Spinbot = Value
    end
})

Connections.Spinbot = RunService.RenderStepped:Connect(function()
    if States.Spinbot and RootPart then
        RootPart.CFrame *= CFrame.Angles(0, math.rad(SpinSpeed), 0)
    end
end)

MiscSection:CreateButton({
    Title = "Reset Character",

    Callback = function()
        if Character then
            Character:BreakJoints()
        end
    end
})

MiscSection:CreateButton({
    Title = "FPS Boost",

    Callback = function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9

        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

        for _, v in ipairs(workspace:GetDescendants()) do
            pcall(function()

                if v:IsA("BasePart") then
                    v.Material = Enum.Material.Plastic
                    v.Reflectance = 0
                end

                if v:IsA("Decal") then
                    v.Transparency = 1
                end

                if v:IsA("ParticleEmitter")
                or v:IsA("Trail") then
                    v.Enabled = false
                end

            end)
        end
    end
})

MiscSection:CreateButton({
    Title = "FullBright",

    Callback = function()
        Lighting.Brightness = 5
        Lighting.ClockTime = 12
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
    end
})

MiscSection:CreateButton({
    Title = "Rejoin",

    Callback = function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
})

MiscSection:CreateButton({
    Title = "Server Hop",

    Callback = function()

        local Success, Response = pcall(function()
            return HttpService:JSONDecode(
                game:HttpGet(
                    "https://games.roblox.com/v1/games/" ..
                    game.PlaceId ..
                    "/servers/Public?sortOrder=Asc&limit=100"
                )
            )
        end)

        if Success and Response and Response.data then
            for _, Server in ipairs(Response.data) do
                if Server.playing < Server.maxPlayers then
                    TeleportService:TeleportToPlaceInstance(
                        game.PlaceId,
                        Server.id,
                        LocalPlayer
                    )

                    break
                end
            end
        end
    end
})

MiscSection:CreateButton({
    Title = "Copy JobId",

    Callback = function()
        if setclipboard then
            setclipboard(game.JobId)
        end
    end
})

MiscSection:CreateButton({
    Title = "Destroy GUI",

    Callback = function()
        for _, Connection in pairs(Connections) do
            pcall(function()
                Connection:Disconnect()
            end)
        end

        for _, v in ipairs(game.CoreGui:GetChildren()) do
            if v.Name:find("Murysium") then
                v:Destroy()
            end
        end
    end
})

MiscSection:CreateDropdown({
    Title = "Mode",
    Options = {"Legit", "Rage", "Blatant"},
    Selected = {"Legit"},
    Multi = false,

    Callback = function(Option)
        print(Option)
    end
})

print("Loaded.")
local Library = {}
Library.__index = Library

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")

local Themes = {
    Light = {
        BG           = Color3.fromRGB(242, 242, 247),
        HeaderBG     = Color3.fromRGB(249, 249, 251),
        SectionBG    = Color3.fromRGB(255, 255, 255),
        SectionTitle = Color3.fromRGB(108, 108, 112),
        Text         = Color3.fromRGB(0,   0,   0),
        SubText      = Color3.fromRGB(138, 138, 142),
        Separator    = Color3.fromRGB(200, 200, 204),
        Accent       = Color3.fromRGB(0,   122, 255),
        AccentDark   = Color3.fromRGB(0,   84,  196),
        ToggleOn     = Color3.fromRGB(48,  209, 88),
        ToggleOff    = Color3.fromRGB(230, 230, 235),
        SliderTrack  = Color3.fromRGB(230, 230, 235),
        SliderFill   = Color3.fromRGB(0,   122, 255),
        White        = Color3.fromRGB(255, 255, 255),
        PressHL      = Color3.fromRGB(216, 216, 220),
        TabActive    = Color3.fromRGB(0,   122, 255),
        TabInactive  = Color3.fromRGB(138, 138, 142),
        Handle       = Color3.fromRGB(210, 210, 214),
        DropHL       = Color3.fromRGB(242, 242, 247),
    },
    Dark = {
        BG           = Color3.fromRGB(28,  28,  30),
        HeaderBG     = Color3.fromRGB(44,  44,  46),
        SectionBG    = Color3.fromRGB(44,  44,  46),
        SectionTitle = Color3.fromRGB(152, 152, 158),
        Text         = Color3.fromRGB(255, 255, 255),
        SubText      = Color3.fromRGB(152, 152, 158),
        Separator    = Color3.fromRGB(58,  58,  62),
        Accent       = Color3.fromRGB(10,  132, 255),
        AccentDark   = Color3.fromRGB(32,  148, 255),
        ToggleOn     = Color3.fromRGB(48,  209, 88),
        ToggleOff    = Color3.fromRGB(72,  72,  74),
        SliderTrack  = Color3.fromRGB(72,  72,  74),
        SliderFill   = Color3.fromRGB(10,  132, 255),
        White        = Color3.fromRGB(255, 255, 255),
        PressHL      = Color3.fromRGB(60,  60,  64),
        TabActive    = Color3.fromRGB(10,  132, 255),
        TabInactive  = Color3.fromRGB(152, 152, 158),
        Handle       = Color3.fromRGB(88,  88,  92),
        DropHL       = Color3.fromRGB(38,  38,  40),
    },
    Midnight = {
        BG           = Color3.fromRGB(15,  15,  20),
        HeaderBG     = Color3.fromRGB(24,  24,  32),
        SectionBG    = Color3.fromRGB(24,  24,  32),
        SectionTitle = Color3.fromRGB(120, 110, 160),
        Text         = Color3.fromRGB(230, 225, 255),
        SubText      = Color3.fromRGB(120, 110, 160),
        Separator    = Color3.fromRGB(50,  44,  72),
        Accent       = Color3.fromRGB(148, 108, 255),
        AccentDark   = Color3.fromRGB(120, 80,  230),
        ToggleOn     = Color3.fromRGB(148, 108, 255),
        ToggleOff    = Color3.fromRGB(50,  44,  72),
        SliderTrack  = Color3.fromRGB(50,  44,  72),
        SliderFill   = Color3.fromRGB(148, 108, 255),
        White        = Color3.fromRGB(230, 225, 255),
        PressHL      = Color3.fromRGB(40,  34,  60),
        TabActive    = Color3.fromRGB(148, 108, 255),
        TabInactive  = Color3.fromRGB(100, 90,  140),
        Handle       = Color3.fromRGB(70,  62,  100),
        DropHL       = Color3.fromRGB(30,  26,  48),
    },
    Rose = {
        BG           = Color3.fromRGB(255, 245, 248),
        HeaderBG     = Color3.fromRGB(255, 250, 252),
        SectionBG    = Color3.fromRGB(255, 255, 255),
        SectionTitle = Color3.fromRGB(180, 100, 120),
        Text         = Color3.fromRGB(40,  20,  28),
        SubText      = Color3.fromRGB(180, 130, 145),
        Separator    = Color3.fromRGB(240, 210, 220),
        Accent       = Color3.fromRGB(220, 60,  100),
        AccentDark   = Color3.fromRGB(190, 40,  80),
        ToggleOn     = Color3.fromRGB(220, 60,  100),
        ToggleOff    = Color3.fromRGB(240, 210, 220),
        SliderTrack  = Color3.fromRGB(240, 210, 220),
        SliderFill   = Color3.fromRGB(220, 60,  100),
        White        = Color3.fromRGB(255, 255, 255),
        PressHL      = Color3.fromRGB(250, 225, 232),
        TabActive    = Color3.fromRGB(220, 60,  100),
        TabInactive  = Color3.fromRGB(180, 130, 145),
        Handle       = Color3.fromRGB(230, 190, 205),
        DropHL       = Color3.fromRGB(255, 240, 245),
    },
}

local T = Themes.Light

local ICONS = {
    home="⌂", settings="⚙", user="👤", search="🔍", star="★", heart="♥",
    bell="🔔", mail="✉", lock="🔒", unlock="🔓", check="✓", x="✕",
    plus="+", minus="−", trash="🗑", edit="✎", eye="👁", camera="📷",
    image="🖼", music="♪", play="▶", pause="⏸", stop="⏹", info="ℹ",
    alert="⚠", globe="🌐", map="🗺", bookmark="🔖", share="⎋",
    download="↓", upload="↑", folder="📁", file="📄", code="</>",
    terminal=">_", wifi="📶", battery="🔋", cpu="💻", monitor="🖥",
    phone="📱", message="💬", send="➤", menu="≡", grid="⊞", list="≡",
    layers="⧉", tag="🏷", flag="⚑", tool="🔧", zap="⚡", sun="☀",
    moon="🌙", cloud="☁", wind="💨",
    ["arrow-right"]="→", ["arrow-left"]="←", ["arrow-up"]="↑", ["arrow-down"]="↓",
    ["chevron-right"]="›", ["chevron-left"]="‹", ["chevron-up"]="‸", ["chevron-down"]="⌄",
    ["chevrons-right"]="»", ["chevrons-left"]="«",
    ["alert-circle"]="⊙", ["alert-triangle"]="⚠",
    ["check-circle"]="✅", ["check-square"]="☑",
    ["x-circle"]="⊗", ["x-square"]="⊠",
    ["plus-circle"]="⊕", ["plus-square"]="⊞",
    ["minus-circle"]="⊖", ["minus-square"]="⊟",
    ["more-horizontal"]="⋯", ["more-vertical"]="⋮",
    ["log-in"]="→", ["log-out"]="←",
    ["external-link"]="↗", ["eye-off"]="⊘",
    ["refresh-ccw"]="↺", ["refresh-cw"]="↻",
    ["bar-chart"]="▮", ["pie-chart"]="◔",
    ["map-pin"]="📍", ["git-branch"]="⎇",
    ["circle-user"]="👤", ["user-check"]="✓",
    ["volume-x"]="🔇", ["volume-2"]="🔊",
    ["calendar"]="📅", ["clock"]="🕐",
    ["trending-up"]="↗", ["trending-down"]="↘",
    ["message-circle"]="💬", ["message-square"]="🗨",
    ["shield"]="🛡", ["key"]="🔑", ["link"]="🔗",
    ["copy"]="⧉", ["clipboard"]="📋", ["save"]="💾",
    ["printer"]="▣", ["server"]="▣", ["database"]="🗄",
    ["code-2"]="</>", ["terminal-2"]=">_",
    ["zoom-in"]="⊕", ["zoom-out"]="⊖",
    ["maximize"]="⤢", ["minimize"]="⊟",
    ["rotate-cw"]="↻", ["rotate-ccw"]="↺",
    ["undo"]="↩", ["redo"]="↪",
    ["bold"]="B", ["italic"]="I", ["underline"]="_",
    ["hash"]="#", ["at-sign"]="@",
    ["cpu"]="💻", ["hard-drive"]="💾",
    ["wifi-off"]="⊘", ["bluetooth"]="◌",
    ["mic"]="🎤", ["mic-off"]="🔇",
    ["video"]="▣", ["video-off"]="⊘",
    ["headphones"]="🎧", ["speaker"]="🔊",
    ["battery-charging"]="⚡", ["battery-full"]="█",
    ["phone-call"]="📞", ["phone-off"]="⊘",
    ["mail-open"]="✉", ["mail-plus"]="✉",
    ["star-half"]="⯨", ["star-off"]="☆",
    ["gift"]="◈", ["award"]="◈",
    ["anchor"]="⚓", ["compass"]="◎",
    ["feather"]="✎", ["pen"]="✎",
    ["scissors"]="✂", ["crop"]="⊠",
    ["filter"]="⊟", ["sliders"]="⊟",
    ["toggle-left"]="◀", ["toggle-right"]="▶",
    ["activity"]="〜", ["pulse"]="〜",
    ["rss"]="▣", ["globe-2"]="🌍",
    ["flag-off"]="⊘", ["ban"]="⊘",
    ["loader"]="◌", ["loader-circle"]="◌",
    ["sparkles"]="✳", ["zap-off"]="⊘",
}

local function SafeTween(Obj, Props, Duration, Style, Direction)
    if not Obj or not Obj.Parent then return end
    local Ok, Err = pcall(function()
        TweenService:Create(
            Obj,
            TweenInfo.new(
                Duration  or 0.25,
                Style     or Enum.EasingStyle.Quint,
                Direction or Enum.EasingDirection.Out
            ),
            Props
        ):Play()
    end)
    if not Ok then
        warn("[Library] SafeTween error:", Err)
    end
end

local function Tween(Obj, Props, Duration, Style, Direction)
    SafeTween(Obj, Props, Duration or 0.25, Style or Enum.EasingStyle.Quint, Direction or Enum.EasingDirection.Out)
end

local function Spring(Obj, Props, Duration)
    SafeTween(Obj, Props, Duration or 0.40, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

local function Snap(Obj, Props, Duration)
    SafeTween(Obj, Props, Duration or 0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
end

local function FadeIn(Obj, Duration)
    if not Obj or not Obj.Parent then return end
    local D = Duration or 0.28
    local Props = {BackgroundTransparency = 0}
    if Obj:IsA("TextLabel") or Obj:IsA("TextButton") then
        Props.TextTransparency = 0
    end
    if Obj:IsA("ImageLabel") or Obj:IsA("ImageButton") then
        Props.ImageTransparency = 0
    end
    Tween(Obj, Props, D, Enum.EasingStyle.Quint)
end

local function FadeOut(Obj, Duration)
    if not Obj or not Obj.Parent then return end
    local D = Duration or 0.22
    local Props = {BackgroundTransparency = 1}
    if Obj:IsA("TextLabel") or Obj:IsA("TextButton") then
        Props.TextTransparency = 1
    end
    if Obj:IsA("ImageLabel") or Obj:IsA("ImageButton") then
        Props.ImageTransparency = 1
    end
    Tween(Obj, Props, D, Enum.EasingStyle.Quint)
end

local function Corner(Parent, Radius)
    local C = Instance.new("UICorner")
    C.CornerRadius = UDim.new(0, Radius or 10)
    C.Parent = Parent
    return C
end

local function Pad(Parent, Top, Right, Bottom, Left)
    local P = Instance.new("UIPadding")
    P.PaddingTop    = UDim.new(0, Top    or 0)
    P.PaddingRight  = UDim.new(0, Right  or 0)
    P.PaddingBottom = UDim.new(0, Bottom or 0)
    P.PaddingLeft   = UDim.new(0, Left   or 0)
    P.Parent = Parent
end

local function ResolveIcon(Icon)
    if not Icon then return nil, false end
    if type(Icon) == "number" then return "rbxassetid://" .. Icon, true end
    if type(Icon) == "string" then
        if Icon:match("^rbxassetid://") then return Icon, true end
        if Icon:match("^%d+$") then return "rbxassetid://" .. Icon, true end
        return ICONS[Icon:lower()] or Icon, false
    end
    return nil, false
end

function Library:CreateWindow(Cfg)
    Cfg = Cfg or {}
    local Title      = Cfg.Title           or "Settings"
    local SubTitle   = Cfg.SubTitle        or ""
    local LoadTitle  = Cfg.LoadingTitle    or "Loading"
    local LoadSub    = Cfg.LoadingSubtitle or "Please wait…"
    local LoadImage  = Cfg.LoadingImage
    local ShowText   = Cfg.ShowText        or "Open"
    local ThemeName  = Cfg.Theme           or "Light"

    T = Themes[ThemeName] or Themes.Light

    local Nodes = {}

    local function Reg(Obj, Prop, Key)
        if Obj and Prop and Key then
            table.insert(Nodes, {Obj = Obj, Prop = Prop, Key = Key})
        end
    end

    local function RegFn(Fn)
        if Fn then table.insert(Nodes, {Fn = Fn}) end
    end

    local Gui = Instance.new("ScreenGui")
    Gui.Name           = "iOSUILib"
    Gui.ResetOnSpawn   = false
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Gui.IgnoreGuiInset = true
    local GuiOk = pcall(function() Gui.Parent = gethui() end)
    if not GuiOk then
        local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui", 10)
        if PlayerGui then
            Gui.Parent = PlayerGui
        end
    end

    local function GetWinSize()
        local Sw = Gui.AbsoluteSize.X
        local Sh = Gui.AbsoluteSize.Y
        local W  = math.clamp(math.floor(Sw * 0.50), 200, 320)
        local H  = math.clamp(math.floor(Sh * 0.50), 240, 360)
        return W, H
    end

    local WinW, WinH = GetWinSize()
    local HeaderH    = 36
    local TabBarH    = 30

    local Win = Instance.new("Frame")
    Win.Name             = "Window"
    Win.BackgroundColor3 = T.BG
    Win.BorderSizePixel  = 0
    Win.Size             = UDim2.new(0, WinW, 0, WinH)
    Win.Position         = UDim2.new(0.5, -WinW / 2, 0.5, -WinH / 2)
    Win.ClipsDescendants = true
    Win.Visible          = false
    Win.BackgroundTransparency = 1
    Win.ZIndex           = 10
    Win.Parent           = Gui
    Corner(Win, 14)
    Reg(Win, "BackgroundColor3", "BG")

    local WinScale = Instance.new("UIScale")
    WinScale.Scale  = 0.88
    WinScale.Parent = Win

    local LoadPanel = Instance.new("Frame")
    LoadPanel.Name                   = "LoadPanel"
    LoadPanel.BackgroundColor3       = T.SectionBG
    LoadPanel.BackgroundTransparency = 1
    LoadPanel.BorderSizePixel        = 0
    LoadPanel.Size                   = UDim2.new(1, 0, 1, 0)
    LoadPanel.ClipsDescendants       = true
    LoadPanel.ZIndex                 = 200
    LoadPanel.Parent                 = Win
    Corner(LoadPanel, 14)

    local LoadStroke = Instance.new("UIStroke")
    LoadStroke.Color        = T.Separator
    LoadStroke.Thickness    = 0.5
    LoadStroke.Transparency = 1
    LoadStroke.Parent       = LoadPanel

    local LoadCenter = Instance.new("Frame")
    LoadCenter.BackgroundTransparency = 1
    LoadCenter.Size     = UDim2.new(0, WinW - 32, 0, WinH - 20)
    LoadCenter.Position = UDim2.new(0, 16, 0, 10)
    LoadCenter.ZIndex   = 201
    LoadCenter.Parent   = LoadPanel

    local LoadOff = 0
    if LoadImage then
        local IconVal, IsAsset = ResolveIcon(LoadImage)
        local IconSize = 44
        if IsAsset then
            local Img = Instance.new("ImageLabel")
            Img.BackgroundColor3       = T.BG
            Img.BorderSizePixel        = 0
            Img.BackgroundTransparency = 1
            Img.Size                   = UDim2.new(0, IconSize, 0, IconSize)
            Img.Position               = UDim2.new(0.5, -IconSize / 2, 0, 0)
            Img.Image                  = IconVal
            Img.ImageTransparency      = 1
            Img.ScaleType              = Enum.ScaleType.Fit
            Img.ZIndex                 = 202
            Img.Parent                 = LoadCenter
            Corner(Img, 12)
        else
            local Gl = Instance.new("TextLabel")
            Gl.BackgroundTransparency = 1
            Gl.Size                   = UDim2.new(0, IconSize, 0, IconSize)
            Gl.Position               = UDim2.new(0.5, -IconSize / 2, 0, 0)
            Gl.Text                   = IconVal or "⊙"
            Gl.TextSize               = 30
            Gl.TextTransparency       = 1
            Gl.Font                   = Enum.Font.Gotham
            Gl.TextColor3             = T.Accent
            Gl.ZIndex                 = 202
            Gl.Parent                 = LoadCenter
        end
        LoadOff = IconSize + 8
    end

    local function MakeLoadLabel(Text, OffsetY, Bold, Size)
        local L = Instance.new("TextLabel")
        L.BackgroundTransparency = 1
        L.Size             = UDim2.new(1, 0, 0, 20)
        L.Position         = UDim2.new(0, 0, 0, LoadOff + OffsetY)
        L.Text             = Text
        L.TextColor3       = Bold and T.Text or T.SubText
        L.TextTransparency = 1
        L.Font             = Bold and Enum.Font.GothamBold or Enum.Font.Gotham
        L.TextSize         = Size or (Bold and 13 or 11)
        L.TextXAlignment   = Enum.TextXAlignment.Center
        L.ZIndex           = 202
        L.Parent           = LoadCenter
        return L
    end
    local LoadTitleLbl = MakeLoadLabel(LoadTitle, 2,  true,  13)
    local LoadSubLbl   = MakeLoadLabel(LoadSub,   20, false, 10)

    local Spinner = Instance.new("Frame")
    Spinner.BackgroundTransparency = 1
    Spinner.Size     = UDim2.new(0, 22, 0, 22)
    Spinner.Position = UDim2.new(0.5, -11, 0, LoadOff + 46)
    Spinner.ZIndex   = 202
    Spinner.Parent   = LoadCenter

    for I = 1, 10 do
        local Dot = Instance.new("Frame")
        Dot.BackgroundColor3       = T.Accent
        Dot.BackgroundTransparency = 1 - ((I / 10) ^ 1.4)
        Dot.BorderSizePixel        = 0
        local DotSize = 2 + (I / 10) * 3
        Dot.Size        = UDim2.new(0, DotSize, 0, DotSize)
        Dot.AnchorPoint = Vector2.new(0.5, 0.5)
        local Ang = math.rad((I - 1) * 36)
        Dot.Position = UDim2.new(0.5, math.cos(Ang) * 9, 0.5, math.sin(Ang) * 9)
        Dot.ZIndex   = 203
        Dot.Parent   = Spinner
        Corner(Dot, math.ceil(DotSize / 2))
    end

    local SpinAngle = 0
    local SpinConn  = RunService.Heartbeat:Connect(function(Dt)
        SpinAngle = (SpinAngle + Dt * 320) % 360
        if Spinner and Spinner.Parent then
            Spinner.Rotation = SpinAngle
        end
    end)

    local DragHandle = Instance.new("Frame")
    DragHandle.BackgroundColor3 = T.Handle
    DragHandle.BorderSizePixel  = 0
    DragHandle.Size             = UDim2.new(0, 24, 0, 3)
    DragHandle.Position         = UDim2.new(0.5, -12, 0, 6)
    DragHandle.ZIndex           = 20
    DragHandle.Parent           = Win
    Corner(DragHandle, 2)
    Reg(DragHandle, "BackgroundColor3", "Handle")

    local Header = Instance.new("Frame")
    Header.Name             = "Header"
    Header.BackgroundColor3 = T.HeaderBG
    Header.BorderSizePixel  = 0
    Header.Size             = UDim2.new(1, 0, 0, HeaderH)
    Header.Position         = UDim2.new(0, 0, 0, 0)
    Header.ZIndex           = 12
    Header.Parent           = Win
    Reg(Header, "BackgroundColor3", "HeaderBG")

    local NavLine = Instance.new("Frame")
    NavLine.BackgroundColor3 = T.Separator
    NavLine.BorderSizePixel  = 0
    NavLine.Size     = UDim2.new(1, 0, 0, 1)
    NavLine.Position = UDim2.new(0, 0, 1, -1)
    NavLine.ZIndex   = 13
    NavLine.Parent   = Header
    Reg(NavLine, "BackgroundColor3", "Separator")

    local HasSub = SubTitle ~= ""

    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.AnchorPoint    = Vector2.new(0.5, 0.5)
    TitleLbl.Size           = UDim2.new(0, 180, 0, HasSub and 14 or 18)
    TitleLbl.Position       = UDim2.new(0.5, 0, 0.5, HasSub and -7 or 0)
    TitleLbl.Text           = Title
    TitleLbl.TextColor3     = T.Text
    TitleLbl.Font           = Enum.Font.GothamBold
    TitleLbl.TextSize       = 11
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Center
    TitleLbl.TextYAlignment = Enum.TextYAlignment.Center
    TitleLbl.ZIndex         = 13
    TitleLbl.Parent         = Header
    Reg(TitleLbl, "TextColor3", "Text")

    if HasSub then
        local SubLbl = Instance.new("TextLabel")
        SubLbl.BackgroundTransparency = 1
        SubLbl.AnchorPoint    = Vector2.new(0.5, 0.5)
        SubLbl.Size           = UDim2.new(0, 180, 0, 12)
        SubLbl.Position       = UDim2.new(0.5, 0, 0.5, 7)
        SubLbl.Text           = SubTitle
        SubLbl.TextColor3     = T.SubText
        SubLbl.Font           = Enum.Font.Gotham
        SubLbl.TextSize       = 9
        SubLbl.TextXAlignment = Enum.TextXAlignment.Center
        SubLbl.TextYAlignment = Enum.TextYAlignment.Center
        SubLbl.ZIndex         = 13
        SubLbl.Parent         = Header
        Reg(SubLbl, "TextColor3", "SubText")
    end

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.AnchorPoint  = Vector2.new(1, 0.5)
    CloseBtn.Size         = UDim2.new(0, 38, 0, 26)
    CloseBtn.Position     = UDim2.new(1, -6, 0.5, 0)
    CloseBtn.Text         = "Done"
    CloseBtn.TextColor3   = T.Accent
    CloseBtn.Font         = Enum.Font.GothamBold
    CloseBtn.TextSize     = 10
    CloseBtn.ZIndex       = 14
    CloseBtn.Parent       = Header
    Reg(CloseBtn, "TextColor3", "Accent")

    local CloseBtnScale = Instance.new("UIScale")
    CloseBtnScale.Scale  = 1
    CloseBtnScale.Parent = CloseBtn

    CloseBtn.MouseEnter:Connect(function()
        Snap(CloseBtn, {TextColor3 = T.AccentDark}, 0.12)
    end)
    CloseBtn.MouseLeave:Connect(function()
        Tween(CloseBtn, {TextColor3 = T.Accent}, 0.22)
    end)
    CloseBtn.MouseButton1Down:Connect(function()
        Snap(CloseBtnScale, {Scale = 0.88}, 0.10)
    end)
    CloseBtn.MouseButton1Up:Connect(function()
        Spring(CloseBtnScale, {Scale = 1}, 0.36)
    end)

    local TabBar = Instance.new("Frame")
    TabBar.Name             = "TabBar"
    TabBar.BackgroundColor3 = T.HeaderBG
    TabBar.BorderSizePixel  = 0
    TabBar.Size             = UDim2.new(1, 0, 0, TabBarH)
    TabBar.Position         = UDim2.new(0, 0, 0, HeaderH)
    TabBar.ZIndex           = 12
    TabBar.Parent           = Win
    Reg(TabBar, "BackgroundColor3", "HeaderBG")

    local TabBarBorder = Instance.new("Frame")
    TabBarBorder.BackgroundColor3 = T.Separator
    TabBarBorder.BorderSizePixel  = 0
    TabBarBorder.Size     = UDim2.new(1, 0, 0, 1)
    TabBarBorder.Position = UDim2.new(0, 0, 1, -1)
    TabBarBorder.ZIndex   = 13
    TabBarBorder.Parent   = TabBar
    Reg(TabBarBorder, "BackgroundColor3", "Separator")

    local TabScroll = Instance.new("ScrollingFrame")
    TabScroll.BackgroundTransparency = 1
    TabScroll.BorderSizePixel        = 0
    TabScroll.Size                   = UDim2.new(1, 0, 1, 0)
    TabScroll.CanvasSize             = UDim2.new(0, 0, 0, 0)
    TabScroll.ScrollBarThickness     = 0
    TabScroll.ScrollingDirection     = Enum.ScrollingDirection.X
    TabScroll.ZIndex                 = 13
    TabScroll.Parent                 = TabBar

    local TabLayout = Instance.new("UIListLayout")
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.SortOrder     = Enum.SortOrder.LayoutOrder
    TabLayout.Padding       = UDim.new(0, 0)
    TabLayout.Parent        = TabScroll

    local LastTabW = -1
    TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local W = TabLayout.AbsoluteContentSize.X
        if W == LastTabW then return end
        LastTabW = W
        TabScroll.CanvasSize = UDim2.new(0, W, 0, 0)
    end)

    local ContentArea = Instance.new("Frame")
    ContentArea.BackgroundTransparency = 1
    ContentArea.Size             = UDim2.new(1, 0, 1, -(HeaderH + TabBarH))
    ContentArea.Position         = UDim2.new(0, 0, 0, HeaderH + TabBarH)
    ContentArea.ClipsDescendants = true
    ContentArea.ZIndex           = 11
    ContentArea.Parent           = Win

    local TabFadeOverlay = Instance.new("Frame")
    TabFadeOverlay.BackgroundColor3       = T.BG
    TabFadeOverlay.BackgroundTransparency = 1
    TabFadeOverlay.BorderSizePixel        = 0
    TabFadeOverlay.Size                   = UDim2.new(1, 0, 1, 0)
    TabFadeOverlay.ZIndex                 = 50
    TabFadeOverlay.Parent                 = ContentArea
    Reg(TabFadeOverlay, "BackgroundColor3", "BG")

    local ShowBtn = Instance.new("TextButton")
    ShowBtn.BackgroundColor3 = T.Accent
    ShowBtn.Size             = UDim2.new(0, 72, 0, 28)
    ShowBtn.Position         = UDim2.new(0.5, -36, 0, 14)
    ShowBtn.Text             = ShowText
    ShowBtn.TextColor3       = T.White
    ShowBtn.Font             = Enum.Font.GothamBold
    ShowBtn.TextSize         = 10
    ShowBtn.Visible          = false
    ShowBtn.BackgroundTransparency = 1
    ShowBtn.ZIndex           = 100
    ShowBtn.Parent           = Gui
    Corner(ShowBtn, 14)
    Reg(ShowBtn, "BackgroundColor3", "Accent")
    Reg(ShowBtn, "TextColor3", "White")

    local ShowBtnScale = Instance.new("UIScale")
    ShowBtnScale.Scale  = 1
    ShowBtnScale.Parent = ShowBtn

    ShowBtn.MouseButton1Down:Connect(function()
        Snap(ShowBtnScale, {Scale = 0.94}, 0.10)
    end)
    ShowBtn.MouseButton1Up:Connect(function()
        Spring(ShowBtnScale, {Scale = 1}, 0.36)
    end)

    local IsDragging  = false
    local DragStart   = nil
    local StartWinPos = nil

    Header.InputBegan:Connect(function(Inp)
        if Inp.UserInputType == Enum.UserInputType.MouseButton1
        or Inp.UserInputType == Enum.UserInputType.Touch then
            IsDragging  = true
            DragStart   = Inp.Position
            StartWinPos = Win.Position
            Snap(DragHandle, {Size = UDim2.new(0, 18, 0, 3)}, 0.16)
        end
    end)

    UserInputService.InputChanged:Connect(function(Inp)
        if not IsDragging then return end
        if Inp.UserInputType ~= Enum.UserInputType.MouseMovement
        and Inp.UserInputType ~= Enum.UserInputType.Touch then return end
        if not DragStart or not StartWinPos then return end
        local D = Inp.Position - DragStart
        if Win and Win.Parent then
            Win.Position = UDim2.new(
                StartWinPos.X.Scale, StartWinPos.X.Offset + D.X,
                StartWinPos.Y.Scale, StartWinPos.Y.Offset + D.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(Inp)
        if Inp.UserInputType == Enum.UserInputType.MouseButton1
        or Inp.UserInputType == Enum.UserInputType.Touch then
            IsDragging = false
            Spring(DragHandle, {Size = UDim2.new(0, 24, 0, 3)}, 0.38)
        end
    end)

    local function HideWindow()
        if not Win.Visible then return end
        local Wp = Win.Position
        Snap(WinScale, {Scale = 0.92}, 0.20)
        Tween(Win, {
            BackgroundTransparency = 1,
            Position = UDim2.new(Wp.X.Scale, Wp.X.Offset, Wp.Y.Scale, Wp.Y.Offset + 20)
        }, 0.24, Enum.EasingStyle.Quint)
        for _, Desc in ipairs(Win:GetDescendants()) do
            if Desc:IsA("TextLabel") or Desc:IsA("TextButton") then
                Snap(Desc, {TextTransparency = 1}, 0.16)
            elseif Desc:IsA("ImageLabel") or Desc:IsA("ImageButton") then
                Snap(Desc, {ImageTransparency = 1}, 0.16)
            end
        end
        task.delay(0.26, function()
            if not Win.Parent then return end
            Win.Visible                = false
            Win.BackgroundTransparency = 0
            Win.Position               = Wp
            WinScale.Scale             = 1
            for _, Desc in ipairs(Win:GetDescendants()) do
                if Desc:IsA("TextLabel") or Desc:IsA("TextButton") then
                    Desc.TextTransparency = 0
                elseif Desc:IsA("ImageLabel") or Desc:IsA("ImageButton") then
                    Desc.ImageTransparency = 0
                end
            end
            ShowBtn.Visible                = true
            ShowBtn.BackgroundTransparency = 1
            ShowBtnScale.Scale             = 0.80
            Tween(ShowBtn, {BackgroundTransparency = 0}, 0.22, Enum.EasingStyle.Quint)
            Spring(ShowBtnScale, {Scale = 1}, 0.40)
        end)
    end

    local function ShowWindow()
        if Win.Visible then return end
        Snap(ShowBtn, {BackgroundTransparency = 1}, 0.14)
        Snap(ShowBtnScale, {Scale = 0.88}, 0.14)
        task.delay(0.16, function()
            if not ShowBtn.Parent then return end
            ShowBtn.Visible    = false
            ShowBtnScale.Scale = 1
            local Wp = Win.Position
            Win.Visible                = true
            Win.BackgroundTransparency = 1
            Win.Position = UDim2.new(Wp.X.Scale, Wp.X.Offset, Wp.Y.Scale, Wp.Y.Offset + 28)
            WinScale.Scale = 0.90
            Tween(Win, {
                BackgroundTransparency = 0,
                Position = UDim2.new(Wp.X.Scale, Wp.X.Offset, Wp.Y.Scale, Wp.Y.Offset)
            }, 0.38, Enum.EasingStyle.Quint)
            Spring(WinScale, {Scale = 1}, 0.44)
        end)
    end

    CloseBtn.MouseButton1Click:Connect(HideWindow)
    ShowBtn.MouseButton1Click:Connect(ShowWindow)

    task.spawn(function()
        task.wait(2.2)

        if not SpinConn then return end
        SpinConn:Disconnect()
        SpinConn = nil

        local Nw, Nh = GetWinSize()
        Win.Size     = UDim2.new(0, Nw, 0, Nh)
        Win.Position = UDim2.new(0.5, -Nw / 2, 0.5, -Nh / 2)
        Win.Visible                = true
        Win.BackgroundTransparency = 1
        WinScale.Scale             = 0.86

        Tween(Win, {BackgroundTransparency = 0}, 0.46, Enum.EasingStyle.Quint)
        Spring(WinScale, {Scale = 1}, 0.52)

        Tween(LoadPanel, {BackgroundTransparency = 1}, 0.34, Enum.EasingStyle.Quint)
        Tween(LoadStroke, {Transparency = 1}, 0.20, Enum.EasingStyle.Quint)
        for _, Desc in ipairs(LoadCenter:GetDescendants()) do
            if Desc:IsA("GuiObject") then
                local FadeProps = {BackgroundTransparency = 1}
                if Desc:IsA("TextLabel") then FadeProps.TextTransparency  = 1 end
                if Desc:IsA("ImageLabel") then FadeProps.ImageTransparency = 1 end
                Tween(Desc, FadeProps, 0.24, Enum.EasingStyle.Quint)
            end
        end

        task.wait(0.46)
        if LoadPanel and LoadPanel.Parent then
            LoadPanel:Destroy()
        end

        for _, Desc in ipairs(Win:GetDescendants()) do
            if Desc:IsA("TextLabel") or Desc:IsA("TextButton") then
                FadeIn(Desc, 0.28)
            elseif Desc:IsA("ImageLabel") or Desc:IsA("ImageButton") then
                FadeIn(Desc, 0.28)
            end
        end
    end)

    local WindowObj = {}
    local AllTabs   = {}
    local TabCount  = 0

    local function DeactivateAllTabs()
        for _, Td in ipairs(AllTabs) do
            Td.Content.Visible    = false
            Td.ActiveLine.Visible = false
            Td.ActiveLine.Size    = UDim2.new(0, 0, 0, 2)
            Snap(Td.Label, {TextColor3 = T.TabInactive}, 0.16)
            if Td.Icon then
                local Prop = Td.Icon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"
                Snap(Td.Icon, {[Prop] = T.TabInactive}, 0.16)
            end
            if Td.TabScale then
                Snap(Td.TabScale, {Scale = 1}, 0.16)
            end
        end
    end

    function WindowObj:SetTheme(Name)
        T = Themes[Name] or Themes.Light
        local Live = {}
        for _, N in ipairs(Nodes) do
            if N.Fn then
                pcall(N.Fn)
                Live[#Live + 1] = N
            elseif N.Obj and N.Obj.Parent then
                local Val = T[N.Key]
                if Val then
                    Tween(N.Obj, {[N.Prop] = Val}, 0.28, Enum.EasingStyle.Quint)
                end
                Live[#Live + 1] = N
            end
        end
        Nodes = Live
        for _, Td in ipairs(AllTabs) do
            local IsActive = Td.Content.Visible
            local Col = IsActive and T.TabActive or T.TabInactive
            Tween(Td.Label, {TextColor3 = Col}, 0.28, Enum.EasingStyle.Quint)
            Tween(Td.ActiveLine, {BackgroundColor3 = T.TabActive}, 0.28, Enum.EasingStyle.Quint)
            if Td.Icon then
                local Prop = Td.Icon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"
                Tween(Td.Icon, {[Prop] = Col}, 0.28, Enum.EasingStyle.Quint)
            end
        end
    end

    function WindowObj:CreateTab(TabCfg)
        TabCfg = TabCfg or {}
        local TabTitle = TabCfg.Title or "Tab"
        local TabLogo  = TabCfg.Logo

        TabCount = TabCount + 1
        local Idx  = TabCount
        local MinW = math.max(52, #TabTitle * 6 + 24)

        local TabBtn = Instance.new("TextButton")
        TabBtn.BackgroundTransparency = 1
        TabBtn.Size        = UDim2.new(0, MinW, 1, 0)
        TabBtn.Text        = ""
        TabBtn.ZIndex      = 14
        TabBtn.LayoutOrder = Idx
        TabBtn.Parent      = TabScroll

        local TabBtnScale = Instance.new("UIScale")
        TabBtnScale.Scale  = 1
        TabBtnScale.Parent = TabBtn

        local TabIconObj = nil
        local IconXOff   = 0

        if TabLogo then
            local IconVal, IsAsset = ResolveIcon(TabLogo)
            if IsAsset then
                TabIconObj = Instance.new("ImageLabel")
                TabIconObj.BackgroundTransparency = 1
                TabIconObj.AnchorPoint  = Vector2.new(0, 0.5)
                TabIconObj.Size         = UDim2.new(0, 10, 0, 10)
                TabIconObj.Position     = UDim2.new(0, 7, 0.5, 0)
                TabIconObj.Image        = IconVal
                TabIconObj.ImageColor3  = T.TabInactive
                TabIconObj.ZIndex       = 15
                TabIconObj.Parent       = TabBtn
                IconXOff = 14
            else
                TabIconObj = Instance.new("TextLabel")
                TabIconObj.BackgroundTransparency = 1
                TabIconObj.AnchorPoint    = Vector2.new(0, 0.5)
                TabIconObj.Size           = UDim2.new(0, 12, 0, 12)
                TabIconObj.Position       = UDim2.new(0, 6, 0.5, 0)
                TabIconObj.Text           = IconVal or ""
                TabIconObj.TextColor3     = T.TabInactive
                TabIconObj.Font           = Enum.Font.Gotham
                TabIconObj.TextSize       = 9
                TabIconObj.TextXAlignment = Enum.TextXAlignment.Center
                TabIconObj.TextYAlignment = Enum.TextYAlignment.Center
                TabIconObj.ZIndex         = 15
                TabIconObj.Parent         = TabBtn
                IconXOff = 14
            end
        end

        local TabLbl = Instance.new("TextLabel")
        TabLbl.BackgroundTransparency = 1
        TabLbl.AnchorPoint    = Vector2.new(0, 0.5)
        TabLbl.Size           = UDim2.new(1, -IconXOff - 6, 0, 12)
        TabLbl.Position       = UDim2.new(0, IconXOff + 4, 0.5, 0)
        TabLbl.Text           = TabTitle
        TabLbl.TextColor3     = T.TabInactive
        TabLbl.Font           = Enum.Font.GothamMedium
        TabLbl.TextSize       = 9
        TabLbl.TextXAlignment = Enum.TextXAlignment.Center
        TabLbl.TextYAlignment = Enum.TextYAlignment.Center
        TabLbl.ZIndex         = 15
        TabLbl.Parent         = TabBtn

        local ActiveLine = Instance.new("Frame")
        ActiveLine.BackgroundColor3 = T.TabActive
        ActiveLine.BorderSizePixel  = 0
        ActiveLine.AnchorPoint      = Vector2.new(0.5, 1)
        ActiveLine.Size             = UDim2.new(0, 0, 0, 2)
        ActiveLine.Position         = UDim2.new(0.5, 0, 1, 0)
        ActiveLine.ZIndex           = 16
        ActiveLine.Visible          = false
        ActiveLine.Parent           = TabBtn
        Corner(ActiveLine, 1)
        Reg(ActiveLine, "BackgroundColor3", "TabActive")

        local TabFrame = Instance.new("Frame")
        TabFrame.Name                   = "Tab_" .. Idx
        TabFrame.BackgroundTransparency = 1
        TabFrame.Size                   = UDim2.new(1, 0, 1, 0)
        TabFrame.Visible                = false
        TabFrame.ZIndex                 = 11
        TabFrame.Parent                 = ContentArea

        local ColPad = 5
        local ColGap = 5
        local ColTop = 8
        local ColBot = 12

        local LeftScroll = Instance.new("ScrollingFrame")
        LeftScroll.BackgroundTransparency = 1
        LeftScroll.BorderSizePixel        = 0
        LeftScroll.Size               = UDim2.new(0.5, -ColGap / 2 - ColPad, 1, 0)
        LeftScroll.Position           = UDim2.new(0, ColPad, 0, 0)
        LeftScroll.CanvasSize         = UDim2.new(0, 0, 0, 0)
        LeftScroll.ScrollBarThickness = 0
        LeftScroll.ScrollingDirection = Enum.ScrollingDirection.Y
        LeftScroll.ZIndex             = 11
        LeftScroll.Parent             = TabFrame

        local RightScroll = Instance.new("ScrollingFrame")
        RightScroll.BackgroundTransparency = 1
        RightScroll.BorderSizePixel        = 0
        RightScroll.Size               = UDim2.new(0.5, -ColGap / 2 - ColPad, 1, 0)
        RightScroll.Position           = UDim2.new(0.5, ColGap / 2, 0, 0)
        RightScroll.CanvasSize         = UDim2.new(0, 0, 0, 0)
        RightScroll.ScrollBarThickness = 0
        RightScroll.ScrollingDirection = Enum.ScrollingDirection.Y
        RightScroll.ZIndex             = 11
        RightScroll.Parent             = TabFrame

        local function MakeColInner(ScrollFrame)
            local Inner = Instance.new("Frame")
            Inner.BackgroundTransparency = 1
            Inner.Size          = UDim2.new(1, 0, 0, 0)
            Inner.AutomaticSize = Enum.AutomaticSize.Y
            Inner.ZIndex        = 12
            Inner.Parent        = ScrollFrame

            local Lay = Instance.new("UIListLayout")
            Lay.FillDirection = Enum.FillDirection.Vertical
            Lay.SortOrder     = Enum.SortOrder.LayoutOrder
            Lay.Padding       = UDim.new(0, 0)
            Lay.Parent        = Inner

            Pad(Inner, ColTop, 0, ColBot, 0)

            Lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                local H = Lay.AbsoluteContentSize.Y + ColTop + ColBot
                if ScrollFrame and ScrollFrame.Parent then
                    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, H)
                end
            end)

            return Inner, Lay
        end

        local LeftInner,  _ = MakeColInner(LeftScroll)
        local RightInner, _ = MakeColInner(RightScroll)

        local TabData = {
            Btn        = TabBtn,
            Content    = TabFrame,
            ActiveLine = ActiveLine,
            Label      = TabLbl,
            Icon       = TabIconObj,
            TabScale   = TabBtnScale,
        }
        table.insert(AllTabs, TabData)

        local function ActivateThis()
            DeactivateAllTabs()
            TabFadeOverlay.BackgroundTransparency = 0.60
            TabFadeOverlay.ZIndex = 50
            Tween(TabFadeOverlay, {BackgroundTransparency = 1}, 0.28, Enum.EasingStyle.Quint)

            TabFrame.Visible   = true
            ActiveLine.Visible = true
            ActiveLine.Size    = UDim2.new(0, 0, 0, 2)
            Spring(ActiveLine, {Size = UDim2.new(0.78, 0, 0, 2)}, 0.40)
            Snap(TabBtnScale, {Scale = 0.92}, 0.10)
            Spring(TabBtnScale, {Scale = 1}, 0.36)
            Snap(TabLbl, {TextColor3 = T.TabActive}, 0.14)
            if TabIconObj then
                local Prop = TabIconObj:IsA("ImageLabel") and "ImageColor3" or "TextColor3"
                Snap(TabIconObj, {[Prop] = T.TabActive}, 0.14)
            end
        end

        TabBtn.MouseButton1Click:Connect(ActivateThis)
        if Idx == 1 then ActivateThis() end

        local TabObj  = {}
        local SecCnt  = 0

        function TabObj:CreateSection(SecCfg)
            SecCfg = SecCfg or {}
            local SecTitle = SecCfg.Title    or "Section"
            local SecPos   = (SecCfg.Position or "left"):lower()

            SecCnt = SecCnt + 1
            local SecOrder  = SecCnt
            local ParentCol = SecPos == "right" and RightInner or LeftInner

            local SecWrap = Instance.new("Frame")
            SecWrap.BackgroundTransparency = 1
            SecWrap.Size          = UDim2.new(1, 0, 0, 0)
            SecWrap.AutomaticSize = Enum.AutomaticSize.Y
            SecWrap.LayoutOrder   = SecOrder
            SecWrap.ZIndex        = 13
            SecWrap.Parent        = ParentCol

            local SecWrapLayout = Instance.new("UIListLayout")
            SecWrapLayout.FillDirection = Enum.FillDirection.Vertical
            SecWrapLayout.SortOrder     = Enum.SortOrder.LayoutOrder
            SecWrapLayout.Padding       = UDim.new(0, 0)
            SecWrapLayout.Parent        = SecWrap

            local TopSpacer = Instance.new("Frame")
            TopSpacer.BackgroundTransparency = 1
            TopSpacer.Size        = UDim2.new(1, 0, 0, 7)
            TopSpacer.LayoutOrder = 0
            TopSpacer.ZIndex      = 13
            TopSpacer.Parent      = SecWrap

            local SecHeadWrap = Instance.new("Frame")
            SecHeadWrap.BackgroundTransparency = 1
            SecHeadWrap.Size        = UDim2.new(1, 0, 0, 14)
            SecHeadWrap.LayoutOrder = 1
            SecHeadWrap.ZIndex      = 13
            SecHeadWrap.Parent      = SecWrap
            Pad(SecHeadWrap, 0, 3, 0, 10)

            local SecHead = Instance.new("TextLabel")
            SecHead.BackgroundTransparency = 1
            SecHead.Size           = UDim2.new(1, 0, 1, 0)
            SecHead.Text           = SecTitle:upper()
            SecHead.TextColor3     = T.SectionTitle
            SecHead.Font           = Enum.Font.GothamMedium
            SecHead.TextSize       = 8
            SecHead.TextXAlignment = Enum.TextXAlignment.Left
            SecHead.TextYAlignment = Enum.TextYAlignment.Center
            SecHead.ZIndex         = 14
            SecHead.Parent         = SecHeadWrap
            Reg(SecHead, "TextColor3", "SectionTitle")

            local HeadSpacer = Instance.new("Frame")
            HeadSpacer.BackgroundTransparency = 1
            HeadSpacer.Size        = UDim2.new(1, 0, 0, 2)
            HeadSpacer.LayoutOrder = 2
            HeadSpacer.ZIndex      = 13
            HeadSpacer.Parent      = SecWrap

            local Card = Instance.new("Frame")
            Card.BackgroundColor3       = T.SectionBG
            Card.BackgroundTransparency = 1
            Card.BorderSizePixel        = 0
            Card.Size                   = UDim2.new(1, 0, 0, 0)
            Card.AutomaticSize          = Enum.AutomaticSize.Y
            Card.ClipsDescendants       = true
            Card.LayoutOrder            = 3
            Card.ZIndex                 = 13
            Card.Parent                 = SecWrap
            Corner(Card, 9)
            Reg(Card, "BackgroundColor3", "SectionBG")

            local CardStroke = Instance.new("UIStroke")
            CardStroke.Color        = T.Separator
            CardStroke.Thickness    = 0.5
            CardStroke.Transparency = 0
            CardStroke.Parent       = Card
            Reg(CardStroke, "Color", "Separator")

            local CardEntryScale = Instance.new("UIScale")
            CardEntryScale.Scale  = 0.94
            CardEntryScale.Parent = Card

            local StaggerDelay = (SecCnt - 1) * 0.048
            task.delay(StaggerDelay, function()
                if not Card.Parent then return end
                Tween(Card, {BackgroundTransparency = 0}, 0.28, Enum.EasingStyle.Quint)
                Spring(CardEntryScale, {Scale = 1}, 0.44)
            end)

            local CardLayout = Instance.new("UIListLayout")
            CardLayout.FillDirection = Enum.FillDirection.Vertical
            CardLayout.SortOrder     = Enum.SortOrder.LayoutOrder
            CardLayout.Padding       = UDim.new(0, 0)
            CardLayout.Parent        = Card

            local BottomSpacer = Instance.new("Frame")
            BottomSpacer.BackgroundTransparency = 1
            BottomSpacer.Size        = UDim2.new(1, 0, 0, 6)
            BottomSpacer.LayoutOrder = 4
            BottomSpacer.ZIndex      = 13
            BottomSpacer.Parent      = SecWrap

            local SecObj = {}
            SecObj._Card = Card
            SecObj._RowN = 0

            local function MakeRow(Height, AutoY)
                SecObj._RowN = SecObj._RowN + 1
                local N = SecObj._RowN

                if N > 1 then
                    local SepWrap = Instance.new("Frame")
                    SepWrap.BackgroundTransparency = 1
                    SepWrap.BorderSizePixel        = 0
                    SepWrap.Size        = UDim2.new(1, 0, 0, 1)
                    SepWrap.ZIndex      = 15
                    SepWrap.LayoutOrder = N * 10 - 5
                    SepWrap.Parent      = Card

                    local Sep = Instance.new("Frame")
                    Sep.BackgroundColor3 = T.Separator
                    Sep.BorderSizePixel  = 0
                    Sep.Size     = UDim2.new(1, -10, 1, 0)
                    Sep.Position = UDim2.new(0, 10, 0, 0)
                    Sep.ZIndex   = 15
                    Sep.Parent   = SepWrap
                    Reg(Sep, "BackgroundColor3", "Separator")
                end

                local Row = Instance.new("Frame")
                Row.BackgroundTransparency = 1
                Row.BorderSizePixel        = 0
                Row.ZIndex                 = 14
                Row.LayoutOrder            = N * 10
                Row.Parent                 = Card

                if AutoY then
                    Row.Size          = UDim2.new(1, 0, 0, 0)
                    Row.AutomaticSize = Enum.AutomaticSize.Y
                else
                    Row.Size = UDim2.new(1, 0, 0, Height or 34)
                end
                Pad(Row, 0, 10, 0, 10)
                return Row
            end

            function SecObj:CreateToggle(Cfg)
                Cfg = Cfg or {}
                local Ttl = Cfg.Title    or "Toggle"
                local Def = Cfg.Default  ~= nil and Cfg.Default or false
                local Cb  = Cfg.Callback or function() end

                local Row = MakeRow(34)

                local Lbl = Instance.new("TextLabel")
                Lbl.BackgroundTransparency = 1
                Lbl.AnchorPoint    = Vector2.new(0, 0.5)
                Lbl.Size           = UDim2.new(1, -46, 0, 14)
                Lbl.Position       = UDim2.new(0, 0, 0.5, 0)
                Lbl.Text           = Ttl
                Lbl.TextColor3     = T.Text
                Lbl.Font           = Enum.Font.Gotham
                Lbl.TextSize       = 11
                Lbl.TextXAlignment = Enum.TextXAlignment.Left
                Lbl.TextYAlignment = Enum.TextYAlignment.Center
                Lbl.ZIndex         = 15
                Lbl.Parent         = Row
                Reg(Lbl, "TextColor3", "Text")

                local Track = Instance.new("Frame")
                Track.BackgroundColor3 = Def and T.ToggleOn or T.ToggleOff
                Track.BorderSizePixel  = 0
                Track.AnchorPoint      = Vector2.new(1, 0.5)
                Track.Size             = UDim2.new(0, 33, 0, 20)
                Track.Position         = UDim2.new(1, 0, 0.5, 0)
                Track.ZIndex           = 15
                Track.Parent           = Row
                Corner(Track, 10)

                local Thumb = Instance.new("Frame")
                Thumb.BackgroundColor3 = T.White
                Thumb.BorderSizePixel  = 0
                Thumb.AnchorPoint      = Vector2.new(0, 0.5)
                Thumb.Size             = UDim2.new(0, 16, 0, 16)
                Thumb.Position         = Def
                    and UDim2.new(0, 15, 0.5, 0)
                    or  UDim2.new(0,  2, 0.5, 0)
                Thumb.ZIndex           = 16
                Thumb.Parent           = Track
                Corner(Thumb, 8)
                Reg(Thumb, "BackgroundColor3", "White")

                local ThumbStroke = Instance.new("UIStroke")
                ThumbStroke.Color        = Color3.fromRGB(0, 0, 0)
                ThumbStroke.Thickness    = 0.5
                ThumbStroke.Transparency = 0.82
                ThumbStroke.Parent       = Thumb

                local State = Def
                local Busy  = false

                local function DoSet(V, Anim)
                    if Busy then return end
                    Busy  = true
                    State = V
                    local ThumbTarget = V and UDim2.new(0, 15, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                    local Col         = V and T.ToggleOn or T.ToggleOff
                    if Anim then
                        Snap(Track, {BackgroundColor3 = Col}, 0.18)
                        Snap(Thumb, {Size = UDim2.new(0, 20, 0, 16)}, 0.12)
                        task.delay(0.12, function()
                            Spring(Thumb, {
                                Position = ThumbTarget,
                                Size     = UDim2.new(0, 16, 0, 16),
                            }, 0.34)
                        end)
                    else
                        if Track.Parent then Track.BackgroundColor3 = Col end
                        if Thumb.Parent then
                            Thumb.Position = ThumbTarget
                            Thumb.Size     = UDim2.new(0, 16, 0, 16)
                        end
                    end
                    task.delay(0.34, function() Busy = false end)
                end

                RegFn(function()
                    Snap(Track, {BackgroundColor3 = State and T.ToggleOn or T.ToggleOff}, 0.20)
                end)

                local Hit = Instance.new("TextButton")
                Hit.BackgroundTransparency = 1
                Hit.Size   = UDim2.new(1, 0, 1, 0)
                Hit.Text   = ""
                Hit.ZIndex = 17
                Hit.Parent = Row

                Hit.MouseButton1Click:Connect(function()
                    DoSet(not State, true)
                    pcall(Cb, State)
                end)
                Hit.MouseButton1Down:Connect(function()
                    Snap(Row, {BackgroundColor3 = T.PressHL}, 0.06)
                    Row.BackgroundTransparency = 0
                end)
                Hit.MouseButton1Up:Connect(function()
                    Tween(Row, {BackgroundColor3 = T.SectionBG}, 0.24, Enum.EasingStyle.Quint)
                    task.delay(0.24, function()
                        if Row.Parent then Row.BackgroundTransparency = 1 end
                    end)
                end)

                local Obj = {}
                Obj.Value    = { Set = function(_, V) DoSet(V, true); pcall(Cb, V) end }
                Obj.Name     = { Set = function(_, N) if Lbl.Parent then Lbl.Text = N end end }
                Obj.GetValue = function() return State end
                return Obj
            end

            function SecObj:CreateButton(Cfg)
                Cfg = Cfg or {}
                local Ttl = Cfg.Title    or "Button"
                local Cb  = Cfg.Callback or function() end

                local Row = MakeRow(34)

                local RowScale = Instance.new("UIScale")
                RowScale.Scale  = 1
                RowScale.Parent = Row

                local Lbl = Instance.new("TextLabel")
                Lbl.BackgroundTransparency = 1
                Lbl.AnchorPoint    = Vector2.new(0.5, 0.5)
                Lbl.Size           = UDim2.new(1, 0, 0, 14)
                Lbl.Position       = UDim2.new(0.5, 0, 0.5, 0)
                Lbl.Text           = Ttl
                Lbl.TextColor3     = T.Accent
                Lbl.Font           = Enum.Font.GothamMedium
                Lbl.TextSize       = 11
                Lbl.TextXAlignment = Enum.TextXAlignment.Center
                Lbl.TextYAlignment = Enum.TextYAlignment.Center
                Lbl.ZIndex         = 15
                Lbl.Parent         = Row
                Reg(Lbl, "TextColor3", "Accent")

                local Hit = Instance.new("TextButton")
                Hit.BackgroundTransparency = 1
                Hit.Size   = UDim2.new(1, 0, 1, 0)
                Hit.Text   = ""
                Hit.ZIndex = 16
                Hit.Parent = Row

                Hit.MouseButton1Down:Connect(function()
                    Snap(Row, {BackgroundColor3 = T.PressHL}, 0.06)
                    Row.BackgroundTransparency = 0
                    Snap(Lbl, {TextColor3 = T.AccentDark}, 0.06)
                    Snap(RowScale, {Scale = 0.96}, 0.10)
                end)
                Hit.MouseButton1Up:Connect(function()
                    Tween(Row, {BackgroundColor3 = T.SectionBG}, 0.24, Enum.EasingStyle.Quint)
                    task.delay(0.24, function()
                        if Row.Parent then Row.BackgroundTransparency = 1 end
                    end)
                    Tween(Lbl, {TextColor3 = T.Accent}, 0.20, Enum.EasingStyle.Quint)
                    Spring(RowScale, {Scale = 1}, 0.36)
                end)
                Hit.MouseButton1Click:Connect(function()
                    pcall(Cb)
                end)

                local Obj = {}
                Obj.Name = { Set = function(_, N) if Lbl.Parent then Lbl.Text = N end end }
                return Obj
            end

            function SecObj:CreateDropdown(Cfg)
                Cfg = Cfg or {}
                local Ttl     = Cfg.Title    or "Dropdown"
                local Opts    = Cfg.Options  or {}
                local InitSel = Cfg.Selected or {}
                local Multi   = Cfg.Multi    or false
                local Cb      = Cfg.Callback or function() end

                local SelMap = {}
                for _, V in ipairs(InitSel) do SelMap[V] = true end
                if not Multi and not next(SelMap) and #Opts > 0 then
                    SelMap[Opts[1]] = true
                end

                local function SelText()
                    local Parts = {}
                    for K, V in pairs(SelMap) do if V then Parts[#Parts + 1] = K end end
                    if #Parts == 0 then return "None" end
                    table.sort(Parts)
                    return table.concat(Parts, ", ")
                end

                local IsOpen  = false
                local CurOpts = {table.unpack(Opts)}

                local Row = MakeRow(34)

                local TtlLbl = Instance.new("TextLabel")
                TtlLbl.BackgroundTransparency = 1
                TtlLbl.AnchorPoint    = Vector2.new(0, 0.5)
                TtlLbl.Size           = UDim2.new(1, -60, 0, 14)
                TtlLbl.Position       = UDim2.new(0, 0, 0.5, 0)
                TtlLbl.Text           = Ttl
                TtlLbl.TextColor3     = T.Text
                TtlLbl.Font           = Enum.Font.Gotham
                TtlLbl.TextSize       = 11
                TtlLbl.TextXAlignment = Enum.TextXAlignment.Left
                TtlLbl.TextYAlignment = Enum.TextYAlignment.Center
                TtlLbl.ZIndex         = 15
                TtlLbl.Parent         = Row
                Reg(TtlLbl, "TextColor3", "Text")

                local SelLbl = Instance.new("TextLabel")
                SelLbl.BackgroundTransparency = 1
                SelLbl.AnchorPoint    = Vector2.new(1, 0.5)
                SelLbl.Size           = UDim2.new(0, 42, 0, 14)
                SelLbl.Position       = UDim2.new(1, -14, 0.5, 0)
                SelLbl.Text           = SelText()
                SelLbl.TextColor3     = T.SubText
                SelLbl.Font           = Enum.Font.Gotham
                SelLbl.TextSize       = 10
                SelLbl.TextXAlignment = Enum.TextXAlignment.Right
                SelLbl.TextYAlignment = Enum.TextYAlignment.Center
                SelLbl.TextTruncate   = Enum.TextTruncate.AtEnd
                SelLbl.ZIndex         = 15
                SelLbl.Parent         = Row
                Reg(SelLbl, "TextColor3", "SubText")

                local Chevron = Instance.new("TextLabel")
                Chevron.BackgroundTransparency = 1
                Chevron.AnchorPoint    = Vector2.new(1, 0.5)
                Chevron.Size           = UDim2.new(0, 12, 0, 14)
                Chevron.Position       = UDim2.new(1, 0, 0.5, 0)
                Chevron.Text           = "›"
                Chevron.TextColor3     = T.SubText
                Chevron.Font           = Enum.Font.GothamBold
                Chevron.TextSize       = 16
                Chevron.TextXAlignment = Enum.TextXAlignment.Center
                Chevron.TextYAlignment = Enum.TextYAlignment.Center
                Chevron.ZIndex         = 15
                Chevron.Parent         = Row
                Reg(Chevron, "TextColor3", "SubText")

                local Panel = Instance.new("Frame")
                Panel.BackgroundColor3 = T.SectionBG
                Panel.BorderSizePixel  = 0
                Panel.Size             = UDim2.new(1, 0, 0, 0)
                Panel.ClipsDescendants = true
                Panel.ZIndex           = 20
                Panel.Visible          = false
                Panel.LayoutOrder      = Row.LayoutOrder + 1
                Panel.Parent           = Card
                Reg(Panel, "BackgroundColor3", "SectionBG")

                local PanelList = Instance.new("UIListLayout")
                PanelList.FillDirection = Enum.FillDirection.Vertical
                PanelList.SortOrder     = Enum.SortOrder.LayoutOrder
                PanelList.Parent        = Panel

                local OptBtns = {}
                local PanelH  = 0

                local function RebuildOptions(NewOpts)
                    for _, B in ipairs(OptBtns) do
                        if B and B.Parent then B:Destroy() end
                    end
                    OptBtns = {}

                    for I, Opt in ipairs(NewOpts) do
                        if I > 1 then
                            local SepW = Instance.new("Frame")
                            SepW.BackgroundTransparency = 1
                            SepW.BorderSizePixel        = 0
                            SepW.Size        = UDim2.new(1, 0, 0, 1)
                            SepW.ZIndex      = 22
                            SepW.LayoutOrder = I * 10 - 5
                            SepW.Parent      = Panel
                            table.insert(OptBtns, SepW)

                            local SepLine = Instance.new("Frame")
                            SepLine.BackgroundColor3 = T.Separator
                            SepLine.BorderSizePixel  = 0
                            SepLine.Size     = UDim2.new(1, -10, 1, 0)
                            SepLine.Position = UDim2.new(0, 10, 0, 0)
                            SepLine.ZIndex   = 22
                            SepLine.Parent   = SepW
                            Reg(SepLine, "BackgroundColor3", "Separator")
                        end

                        local Ob = Instance.new("TextButton")
                        Ob.BackgroundTransparency = 1
                        Ob.Size        = UDim2.new(1, 0, 0, 32)
                        Ob.Text        = ""
                        Ob.ZIndex      = 22
                        Ob.LayoutOrder = I * 10
                        Ob.Parent      = Panel
                        table.insert(OptBtns, Ob)
                        Pad(Ob, 0, 10, 0, 10)

                        local Ol = Instance.new("TextLabel")
                        Ol.Name                   = "OptionLabel"
                        Ol.BackgroundTransparency = 1
                        Ol.AnchorPoint    = Vector2.new(0, 0.5)
                        Ol.Size           = UDim2.new(1, -20, 0, 14)
                        Ol.Position       = UDim2.new(0, 0, 0.5, 0)
                        Ol.Text           = Opt
                        Ol.TextColor3     = T.Text
                        Ol.Font           = Enum.Font.Gotham
                        Ol.TextSize       = 10
                        Ol.TextXAlignment = Enum.TextXAlignment.Left
                        Ol.TextYAlignment = Enum.TextYAlignment.Center
                        Ol.ZIndex         = 23
                        Ol.Parent         = Ob
                        Reg(Ol, "TextColor3", "Text")

                        local Ck = Instance.new("TextLabel")
                        Ck.Name                   = "Checkmark"
                        Ck.BackgroundTransparency = 1
                        Ck.AnchorPoint    = Vector2.new(1, 0.5)
                        Ck.Size           = UDim2.new(0, 14, 0, 14)
                        Ck.Position       = UDim2.new(1, 0, 0.5, 0)
                        Ck.Text           = SelMap[Opt] and "✓" or ""
                        Ck.TextColor3     = T.Accent
                        Ck.Font           = Enum.Font.GothamBold
                        Ck.TextSize       = 10
                        Ck.TextXAlignment = Enum.TextXAlignment.Center
                        Ck.TextYAlignment = Enum.TextYAlignment.Center
                        Ck.ZIndex         = 23
                        Ck.Parent         = Ob
                        Reg(Ck, "TextColor3", "Accent")

                        local ObScale = Instance.new("UIScale")
                        ObScale.Scale  = 1
                        ObScale.Parent = Ob

                        Ob.MouseButton1Down:Connect(function()
                            Snap(Ob, {BackgroundColor3 = T.PressHL}, 0.06)
                            Ob.BackgroundTransparency = 0
                            Snap(ObScale, {Scale = 0.97}, 0.08)
                        end)
                        Ob.MouseButton1Up:Connect(function()
                            Tween(Ob, {BackgroundColor3 = T.SectionBG}, 0.22, Enum.EasingStyle.Quint)
                            task.delay(0.22, function()
                                if Ob.Parent then Ob.BackgroundTransparency = 1 end
                            end)
                            Spring(ObScale, {Scale = 1}, 0.28)
                        end)

                        Ob.MouseButton1Click:Connect(function()
                            if Multi then
                                SelMap[Opt] = not SelMap[Opt]
                                Ck.Text = SelMap[Opt] and "✓" or ""
                            else
                                for _, O2 in ipairs(NewOpts) do SelMap[O2] = false end
                                SelMap[Opt] = true
                                for _, B2 in ipairs(OptBtns) do
                                    if B2 and B2:IsA("TextButton") then
                                        local CkLbl = B2:FindFirstChild("Checkmark")
                                        local OlLbl = B2:FindFirstChild("OptionLabel")
                                        if CkLbl and OlLbl then
                                            CkLbl.Text = selMap[OlLbl.Text] and "✓" or ""
                                        end
                                    end
                                end
                            end
                            if SelLbl.Parent then SelLbl.Text = SelText() end
                            local Result = {}
                            for K, V in pairs(SelMap) do if V then Result[#Result + 1] = K end end
                            pcall(Cb, Result)
                            if not Multi then
                                IsOpen = false
                                Tween(Panel, {Size = UDim2.new(1, 0, 0, 0)}, 0.22, Enum.EasingStyle.Quint)
                                task.delay(0.23, function()
                                    if Panel.Parent then Panel.Visible = false end
                                end)
                                Snap(Chevron, {Rotation = 0}, 0.18)
                            end
                        end)
                    end

                    PanelH = math.min(#NewOpts * 32, 160)
                    return PanelH
                end

                RebuildOptions(CurOpts)

                local Hit = Instance.new("TextButton")
                Hit.BackgroundTransparency = 1
                Hit.Size   = UDim2.new(1, 0, 1, 0)
                Hit.Text   = ""
                Hit.ZIndex = 16
                Hit.Parent = Row

                Hit.MouseButton1Down:Connect(function()
                    Snap(Row, {BackgroundColor3 = T.PressHL}, 0.06)
                    Row.BackgroundTransparency = 0
                end)
                Hit.MouseButton1Up:Connect(function()
                    Tween(Row, {BackgroundColor3 = T.SectionBG}, 0.22, Enum.EasingStyle.Quint)
                    task.delay(0.22, function()
                        if Row.Parent then Row.BackgroundTransparency = 1 end
                    end)
                end)

                Hit.MouseButton1Click:Connect(function()
                    IsOpen = not IsOpen
                    if IsOpen then
                        Panel.Visible = true
                        Panel.Size    = UDim2.new(1, 0, 0, 0)
                        Spring(Panel, {Size = UDim2.new(1, 0, 0, PanelH)}, 0.38)
                        Snap(Chevron, {Rotation = 90}, 0.20)
                    else
                        Tween(Panel, {Size = UDim2.new(1, 0, 0, 0)}, 0.22, Enum.EasingStyle.Quint)
                        task.delay(0.23, function()
                            if Panel.Parent then Panel.Visible = false end
                        end)
                        Snap(Chevron, {Rotation = 0}, 0.18)
                    end
                end)

                local Obj = {}
                Obj.Name = { Set = function(_, N) if TtlLbl.Parent then TtlLbl.Text = N end end }
                Obj.Options = {
                    Set = function(_, NewOpts)
                        CurOpts = NewOpts
                        SelMap  = {}
                        if not Multi and #NewOpts > 0 then SelMap[NewOpts[1]] = true end
                        RebuildOptions(NewOpts)
                        if SelLbl.Parent then SelLbl.Text = SelText() end
                    end
                }
                Obj.Value = {
                    Set = function(_, V)
                        SelMap = {}
                        if type(V) == "table" then
                            for _, S in ipairs(V) do SelMap[S] = true end
                        elseif type(V) == "string" then
                            SelMap[V] = true
                        end
                        if SelLbl.Parent then SelLbl.Text = SelText() end
                        RebuildOptions(CurOpts)
                    end
                }
                return Obj
            end

            function SecObj:CreateSlider(Cfg)
                Cfg = Cfg or {}
                local Ttl = Cfg.Title     or "Slider"
                local Rng = Cfg.Range     or {0, 100}
                local Mn  = Rng[1] or 0
                local Mx  = Rng[2] or 100
                local Def = math.clamp(Cfg.Default or Mn, Mn, Mx)
                local Inc = Cfg.Increment or 1
                local Suf = Cfg.Suffix    or ""
                local Cb  = Cfg.Callback  or function() end
                local Cur = Def

                local Row = MakeRow(46)

                local TtlLbl = Instance.new("TextLabel")
                TtlLbl.BackgroundTransparency = 1
                TtlLbl.AnchorPoint    = Vector2.new(0, 0)
                TtlLbl.Size           = UDim2.new(0.60, 0, 0, 16)
                TtlLbl.Position       = UDim2.new(0, 0, 0, 6)
                TtlLbl.Text           = Ttl
                TtlLbl.TextColor3     = T.Text
                TtlLbl.Font           = Enum.Font.Gotham
                TtlLbl.TextSize       = 11
                TtlLbl.TextXAlignment = Enum.TextXAlignment.Left
                TtlLbl.TextYAlignment = Enum.TextYAlignment.Center
                TtlLbl.ZIndex         = 15
                TtlLbl.Parent         = Row
                Reg(TtlLbl, "TextColor3", "Text")

                local ValLbl = Instance.new("TextLabel")
                ValLbl.BackgroundTransparency = 1
                ValLbl.AnchorPoint    = Vector2.new(1, 0)
                ValLbl.Size           = UDim2.new(0.40, 0, 0, 16)
                ValLbl.Position       = UDim2.new(1, 0, 0, 6)
                ValLbl.Text           = tostring(Cur) .. Suf
                ValLbl.TextColor3     = T.Accent
                ValLbl.Font           = Enum.Font.GothamMedium
                ValLbl.TextSize       = 10
                ValLbl.TextXAlignment = Enum.TextXAlignment.Right
                ValLbl.TextYAlignment = Enum.TextYAlignment.Center
                ValLbl.ZIndex         = 15
                ValLbl.Parent         = Row
                Reg(ValLbl, "TextColor3", "Accent")

                local TrackBg = Instance.new("Frame")
                TrackBg.BackgroundColor3 = T.SliderTrack
                TrackBg.BorderSizePixel  = 0
                TrackBg.AnchorPoint      = Vector2.new(0, 1)
                TrackBg.Size             = UDim2.new(1, 0, 0, 4)
                TrackBg.Position         = UDim2.new(0, 0, 1, -8)
                TrackBg.ZIndex           = 15
                TrackBg.Parent           = Row
                Corner(TrackBg, 2)
                Reg(TrackBg, "BackgroundColor3", "SliderTrack")

                local InitPct = (Cur - Mn) / math.max(Mx - Mn, 0.0001)

                local TrackFill = Instance.new("Frame")
                TrackFill.BackgroundColor3 = T.SliderFill
                TrackFill.BorderSizePixel  = 0
                TrackFill.Size             = UDim2.new(InitPct, 0, 1, 0)
                TrackFill.ZIndex           = 16
                TrackFill.Parent           = TrackBg
                Corner(TrackFill, 2)
                Reg(TrackFill, "BackgroundColor3", "SliderFill")

                local Thumb = Instance.new("Frame")
                Thumb.BackgroundColor3 = T.White
                Thumb.BorderSizePixel  = 0
                Thumb.AnchorPoint      = Vector2.new(0.5, 0.5)
                Thumb.Size             = UDim2.new(0, 14, 0, 14)
                Thumb.Position         = UDim2.new(InitPct, 0, 0.5, 0)
                Thumb.ZIndex           = 17
                Thumb.Parent           = TrackBg
                Corner(Thumb, 7)
                Reg(Thumb, "BackgroundColor3", "White")

                local ThumbStroke = Instance.new("UIStroke")
                ThumbStroke.Color        = Color3.fromRGB(0, 0, 0)
                ThumbStroke.Thickness    = 0.5
                ThumbStroke.Transparency = 0.82
                ThumbStroke.Parent       = Thumb

                local Sliding = false

                local function Calc(Pos)
                    if not TrackBg.Parent then return Cur end
                    local Ab  = TrackBg.AbsolutePosition
                    local Sz  = TrackBg.AbsoluteSize
                    if Sz.X == 0 then return Cur end
                    local Pct = math.clamp((Pos.X - Ab.X) / Sz.X, 0, 1)
                    local Snp = math.round((Mn + Pct * (Mx - Mn)) / Inc) * Inc
                    return math.clamp(Snp, Mn, Mx)
                end

                local function Apply(V, Anim)
                    Cur = V
                    local Pct = (V - Mn) / math.max(Mx - Mn, 0.0001)
                    if Anim then
                        Snap(TrackFill, {Size = UDim2.new(Pct, 0, 1, 0)}, 0.12)
                        Snap(Thumb, {Position = UDim2.new(Pct, 0, 0.5, 0)}, 0.12)
                    else
                        if TrackFill.Parent then TrackFill.Size  = UDim2.new(Pct, 0, 1, 0) end
                        if Thumb.Parent     then Thumb.Position  = UDim2.new(Pct, 0, 0.5, 0) end
                    end
                    if ValLbl.Parent then ValLbl.Text = tostring(V) .. Suf end
                end

                local Hit = Instance.new("TextButton")
                Hit.BackgroundTransparency = 1
                Hit.Size   = UDim2.new(1, 0, 1, 0)
                Hit.Text   = ""
                Hit.ZIndex = 18
                Hit.Parent = Row

                Hit.InputBegan:Connect(function(Inp)
                    if Inp.UserInputType == Enum.UserInputType.MouseButton1
                    or Inp.UserInputType == Enum.UserInputType.Touch then
                        Sliding = true
                        local V = Calc(Inp.Position)
                        Apply(V, false)
                        pcall(Cb, V)
                        local Pct = (V - Mn) / math.max(Mx - Mn, 0.0001)
                        Spring(Thumb, {
                            Size     = UDim2.new(0, 18, 0, 18),
                            Position = UDim2.new(Pct, 0, 0.5, 0)
                        }, 0.28)
                    end
                end)

                UserInputService.InputChanged:Connect(function(Inp)
                    if not Sliding then return end
                    if Inp.UserInputType ~= Enum.UserInputType.MouseMovement
                    and Inp.UserInputType ~= Enum.UserInputType.Touch then return end
                    local V = Calc(Inp.Position)
                    Apply(V, false)
                    pcall(Cb, V)
                end)

                UserInputService.InputEnded:Connect(function(Inp)
                    if not Sliding then return end
                    if Inp.UserInputType == Enum.UserInputType.MouseButton1
                    or Inp.UserInputType == Enum.UserInputType.Touch then
                        Sliding = false
                        local Pct = (Cur - Mn) / math.max(Mx - Mn, 0.0001)
                        Spring(Thumb, {
                            Size     = UDim2.new(0, 14, 0, 14),
                            Position = UDim2.new(Pct, 0, 0.5, 0)
                        }, 0.34)
                    end
                end)

                local Obj = {}
                Obj.Value = { Set = function(_, V) Apply(math.clamp(V, Mn, Mx), true); pcall(Cb, Cur) end }
                Obj.Name  = { Set = function(_, N) if TtlLbl.Parent then TtlLbl.Text = N end end }
                return Obj
            end

            function SecObj:CreateLabel(Content)
                Content = Content or ""
                local Row = MakeRow(30)

                local Lbl = Instance.new("TextLabel")
                Lbl.BackgroundTransparency = 1
                Lbl.AnchorPoint    = Vector2.new(0, 0.5)
                Lbl.Size           = UDim2.new(1, 0, 0, 14)
                Lbl.Position       = UDim2.new(0, 0, 0.5, 0)
                Lbl.Text           = Content
                Lbl.TextColor3     = T.SubText
                Lbl.Font           = Enum.Font.Gotham
                Lbl.TextSize       = 10
                Lbl.TextXAlignment = Enum.TextXAlignment.Left
                Lbl.TextYAlignment = Enum.TextYAlignment.Center
                Lbl.ZIndex         = 15
                Lbl.Parent         = Row
                Reg(Lbl, "TextColor3", "SubText")

                local Obj = {}
                Obj.Value = { Set = function(_, V) if Lbl.Parent then Lbl.Text = V end end }
                return Obj
            end

            function SecObj:CreateParagraph(Cfg)
                Cfg = Cfg or {}
                local Ptl = Cfg.Title   or ""
                local Pct = Cfg.Content or ""

                SecObj._RowN = SecObj._RowN + 1
                local N = SecObj._RowN

                if N > 1 then
                    local SepW = Instance.new("Frame")
                    SepW.BackgroundTransparency = 1
                    SepW.BorderSizePixel        = 0
                    SepW.Size        = UDim2.new(1, 0, 0, 1)
                    SepW.ZIndex      = 15
                    SepW.LayoutOrder = N * 10 - 5
                    SepW.Parent      = Card

                    local SepLine = Instance.new("Frame")
                    SepLine.BackgroundColor3 = T.Separator
                    SepLine.BorderSizePixel  = 0
                    SepLine.Size     = UDim2.new(1, -10, 1, 0)
                    SepLine.Position = UDim2.new(0, 10, 0, 0)
                    SepLine.ZIndex   = 15
                    SepLine.Parent   = SepW
                    Reg(SepLine, "BackgroundColor3", "Separator")
                end

                local Frame = Instance.new("Frame")
                Frame.BackgroundTransparency = 1
                Frame.Size          = UDim2.new(1, 0, 0, 0)
                Frame.AutomaticSize = Enum.AutomaticSize.Y
                Frame.ZIndex        = 14
                Frame.LayoutOrder   = N * 10
                Frame.Parent        = Card
                Pad(Frame, 7, 10, 7, 10)

                local Flay = Instance.new("UIListLayout")
                Flay.FillDirection = Enum.FillDirection.Vertical
                Flay.SortOrder     = Enum.SortOrder.LayoutOrder
                Flay.Padding       = UDim.new(0, 3)
                Flay.Parent        = Frame

                local TitleLblP = nil
                if Ptl ~= "" then
                    TitleLblP = Instance.new("TextLabel")
                    TitleLblP.BackgroundTransparency = 1
                    TitleLblP.Size           = UDim2.new(1, 0, 0, 0)
                    TitleLblP.AutomaticSize  = Enum.AutomaticSize.Y
                    TitleLblP.Text           = Ptl
                    TitleLblP.TextColor3     = T.Text
                    TitleLblP.Font           = Enum.Font.GothamMedium
                    TitleLblP.TextSize       = 10
                    TitleLblP.TextWrapped    = true
                    TitleLblP.TextXAlignment = Enum.TextXAlignment.Left
                    TitleLblP.LayoutOrder    = 1
                    TitleLblP.ZIndex         = 15
                    TitleLblP.Parent         = Frame
                    Reg(TitleLblP, "TextColor3", "Text")
                end

                local ContentLbl = Instance.new("TextLabel")
                ContentLbl.BackgroundTransparency = 1
                ContentLbl.Size           = UDim2.new(1, 0, 0, 0)
                ContentLbl.AutomaticSize  = Enum.AutomaticSize.Y
                ContentLbl.Text           = Pct
                ContentLbl.TextColor3     = T.SubText
                ContentLbl.Font           = Enum.Font.Gotham
                ContentLbl.TextSize       = 9
                ContentLbl.TextWrapped    = true
                ContentLbl.TextXAlignment = Enum.TextXAlignment.Left
                ContentLbl.LayoutOrder    = 2
                ContentLbl.ZIndex         = 15
                ContentLbl.Parent         = Frame
                Reg(ContentLbl, "TextColor3", "SubText")

                local Obj = {}
                Obj.Title   = { Set = function(_, V) if TitleLblP and TitleLblP.Parent then TitleLblP.Text = V end end }
                Obj.Content = { Set = function(_, V) if ContentLbl.Parent then ContentLbl.Text = V end end }
                return Obj
            end

            return SecObj
        end

        return TabObj
    end

    return WindowObj
end

return Library

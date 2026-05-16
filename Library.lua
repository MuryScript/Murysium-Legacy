local Library = {}
Library.__index = Library

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")

local Themes = {
    Onyx = {
        BG          = Color3.fromRGB(16,  16,  22),
        Sidebar     = Color3.fromRGB(22,  22,  30),
        HeaderBG    = Color3.fromRGB(22,  22,  30),
        SectionBG   = Color3.fromRGB(28,  28,  38),
        SecTitle    = Color3.fromRGB(80,  82, 115),
        Text        = Color3.fromRGB(228, 230, 245),
        SubText     = Color3.fromRGB(96,  98, 132),
        Separator   = Color3.fromRGB(40,  42,  58),
        Accent      = Color3.fromRGB(0,   152, 255),
        AccentDark  = Color3.fromRGB(0,   112, 210),
        ToggleOn    = Color3.fromRGB(0,   152, 255),
        ToggleOff   = Color3.fromRGB(40,  42,  58),
        SliderTrack = Color3.fromRGB(40,  42,  58),
        SliderFill  = Color3.fromRGB(0,   152, 255),
        White       = Color3.fromRGB(255, 255, 255),
        PressHL     = Color3.fromRGB(34,  34,  46),
        TabActive   = Color3.fromRGB(0,   152, 255),
        TabInactive = Color3.fromRGB(80,  82, 115),
        TabActiveBG = Color3.fromRGB(30,  32,  46),
        Handle      = Color3.fromRGB(52,  54,  74),
        DropHL      = Color3.fromRGB(28,  30,  42),
    },
    Phantom = {
        BG          = Color3.fromRGB(10,   8,  16),
        Sidebar     = Color3.fromRGB(16,  14,  24),
        HeaderBG    = Color3.fromRGB(16,  14,  24),
        SectionBG   = Color3.fromRGB(22,  18,  34),
        SecTitle    = Color3.fromRGB(110,  85, 160),
        Text        = Color3.fromRGB(225, 218, 248),
        SubText     = Color3.fromRGB(110,  85, 155),
        Separator   = Color3.fromRGB(38,  30,  58),
        Accent      = Color3.fromRGB(162, 102, 255),
        AccentDark  = Color3.fromRGB(122,  72, 218),
        ToggleOn    = Color3.fromRGB(162, 102, 255),
        ToggleOff   = Color3.fromRGB(42,  34,  64),
        SliderTrack = Color3.fromRGB(42,  34,  64),
        SliderFill  = Color3.fromRGB(162, 102, 255),
        White       = Color3.fromRGB(225, 218, 248),
        PressHL     = Color3.fromRGB(30,  24,  46),
        TabActive   = Color3.fromRGB(162, 102, 255),
        TabInactive = Color3.fromRGB(110,  85, 155),
        TabActiveBG = Color3.fromRGB(30,  22,  50),
        Handle      = Color3.fromRGB(60,  48,  92),
        DropHL      = Color3.fromRGB(26,  20,  40),
    },
    Arctic = {
        BG          = Color3.fromRGB(240, 244, 252),
        Sidebar     = Color3.fromRGB(228, 234, 248),
        HeaderBG    = Color3.fromRGB(228, 234, 248),
        SectionBG   = Color3.fromRGB(255, 255, 255),
        SecTitle    = Color3.fromRGB(110, 122, 168),
        Text        = Color3.fromRGB(18,  22,  44),
        SubText     = Color3.fromRGB(112, 124, 170),
        Separator   = Color3.fromRGB(204, 210, 232),
        Accent      = Color3.fromRGB(0,   112, 230),
        AccentDark  = Color3.fromRGB(0,   84,  196),
        ToggleOn    = Color3.fromRGB(0,   112, 230),
        ToggleOff   = Color3.fromRGB(204, 210, 232),
        SliderTrack = Color3.fromRGB(204, 210, 232),
        SliderFill  = Color3.fromRGB(0,   112, 230),
        White       = Color3.fromRGB(255, 255, 255),
        PressHL     = Color3.fromRGB(218, 224, 244),
        TabActive   = Color3.fromRGB(0,   112, 230),
        TabInactive = Color3.fromRGB(112, 124, 170),
        TabActiveBG = Color3.fromRGB(214, 224, 248),
        Handle      = Color3.fromRGB(182, 192, 222),
        DropHL      = Color3.fromRGB(232, 237, 252),
    },
    Ember = {
        BG          = Color3.fromRGB(14,  12,  10),
        Sidebar     = Color3.fromRGB(20,  17,  14),
        HeaderBG    = Color3.fromRGB(20,  17,  14),
        SectionBG   = Color3.fromRGB(26,  22,  18),
        SecTitle    = Color3.fromRGB(140, 108,  72),
        Text        = Color3.fromRGB(248, 238, 222),
        SubText     = Color3.fromRGB(142, 112,  78),
        Separator   = Color3.fromRGB(46,  38,  28),
        Accent      = Color3.fromRGB(255, 138,  24),
        AccentDark  = Color3.fromRGB(220, 108,   6),
        ToggleOn    = Color3.fromRGB(255, 138,  24),
        ToggleOff   = Color3.fromRGB(46,  38,  28),
        SliderTrack = Color3.fromRGB(46,  38,  28),
        SliderFill  = Color3.fromRGB(255, 138,  24),
        White       = Color3.fromRGB(248, 238, 222),
        PressHL     = Color3.fromRGB(36,  30,  22),
        TabActive   = Color3.fromRGB(255, 138,  24),
        TabInactive = Color3.fromRGB(142, 112,  78),
        TabActiveBG = Color3.fromRGB(34,  26,  16),
        Handle      = Color3.fromRGB(68,  54,  38),
        DropHL      = Color3.fromRGB(30,  24,  16),
    },
    Rose = {
        BG          = Color3.fromRGB(252, 242, 248),
        Sidebar     = Color3.fromRGB(244, 232, 242),
        HeaderBG    = Color3.fromRGB(244, 232, 242),
        SectionBG   = Color3.fromRGB(255, 255, 255),
        SecTitle    = Color3.fromRGB(190, 110, 145),
        Text        = Color3.fromRGB(38,  18,  30),
        SubText     = Color3.fromRGB(190, 130, 160),
        Separator   = Color3.fromRGB(234, 206, 222),
        Accent      = Color3.fromRGB(220,  56, 108),
        AccentDark  = Color3.fromRGB(188,  36,  84),
        ToggleOn    = Color3.fromRGB(220,  56, 108),
        ToggleOff   = Color3.fromRGB(234, 206, 222),
        SliderTrack = Color3.fromRGB(234, 206, 222),
        SliderFill  = Color3.fromRGB(220,  56, 108),
        White       = Color3.fromRGB(255, 255, 255),
        PressHL     = Color3.fromRGB(244, 220, 232),
        TabActive   = Color3.fromRGB(220,  56, 108),
        TabInactive = Color3.fromRGB(190, 130, 160),
        TabActiveBG = Color3.fromRGB(244, 220, 236),
        Handle      = Color3.fromRGB(224, 186, 208),
        DropHL      = Color3.fromRGB(250, 236, 246),
    },
}

local T = Themes.Onyx


local function Tw(o,p,t,s,d) TweenService:Create(o,TweenInfo.new(t or .24,s or Enum.EasingStyle.Quint,d or Enum.EasingDirection.Out),p):Play() end
local function TwB(o,p,t) TweenService:Create(o,TweenInfo.new(t or .38,Enum.EasingStyle.Back,Enum.EasingDirection.Out),p):Play() end
local function TwL(o,p,t) TweenService:Create(o,TweenInfo.new(t or .14,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),p):Play() end

local function Corner(p,r) local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,r or 8) c.Parent=p return c end
local function Stroke(p,c,th) local s=Instance.new("UIStroke") s.Color=c s.Thickness=th or 1 s.Parent=p return s end
local function Pad(p,t,r,b,l) local u=Instance.new("UIPadding") u.PaddingTop=UDim.new(0,t or 0) u.PaddingRight=UDim.new(0,r or 0) u.PaddingBottom=UDim.new(0,b or 0) u.PaddingLeft=UDim.new(0,l or 0) u.Parent=p end


function Library:CreateWindow(Cfg)
    Cfg = Cfg or {}
    local Title     = Cfg.Title           or "Menu"
    local Subtitle  = Cfg.SubTitle        or ""
    local LoadTitle = Cfg.LoadingTitle    or "Loading"
    local LoadSub   = Cfg.LoadingSubtitle or "Please wait…"
    local LoadImage = Cfg.LoadingImage
    local ButtonId  = Cfg.ButtonId
    local ThemeName = Cfg.Theme           or "Onyx"

    T = Themes[ThemeName] or Themes.Onyx

    local Nodes = {}
    local function Reg(o,p,k) if o and p and k then table.insert(Nodes,{o=o,p=p,k=k}) end end
    local function RegFn(fn) if fn then table.insert(Nodes,{fn=fn}) end end

    local Gui = Instance.new("ScreenGui")
    Gui.Name="PremiumUI" Gui.ResetOnSpawn=false Gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling Gui.IgnoreGuiInset=true
    local ok=pcall(function() Gui.Parent=gethui() end)
    if not ok then Gui.Parent=game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end

    local function GetWinSize()
        local sw=Gui.AbsoluteSize.X local sh=Gui.AbsoluteSize.Y
        local w=math.clamp(math.floor(sw*.66),272,450)
        local h=math.clamp(math.floor(sh*.62),290,432)
        return w,h
    end

    local LoadBG = Instance.new("Frame")
    LoadBG.BackgroundColor3=Color3.fromRGB(10,10,16) LoadBG.BorderSizePixel=0
    LoadBG.Size=UDim2.new(1,0,1,0) LoadBG.ZIndex=200 LoadBG.Parent=Gui

    local LoadGrad = Instance.new("UIGradient")
    LoadGrad.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(14,10,24)),ColorSequenceKeypoint.new(1,Color3.fromRGB(6,6,12))}
    LoadGrad.Rotation=135 LoadGrad.Parent=LoadBG

    local LoadCenter = Instance.new("Frame")
    LoadCenter.BackgroundTransparency=1 LoadCenter.Size=UDim2.new(0,240,0,200)
    LoadCenter.Position=UDim2.new(0.5,-120,0.5,-100) LoadCenter.ZIndex=201 LoadCenter.Parent=LoadBG

    local loadOff=0
    if LoadImage then
        local iv,isA=ResolveIcon(LoadImage)
        if isA then
            local img=Instance.new("ImageLabel")
            img.BackgroundColor3=Color3.fromRGB(22,22,32) img.BorderSizePixel=0
            img.Size=UDim2.new(0,72,0,72) img.Position=UDim2.new(0.5,-36,0,0)
            img.Image=iv img.ScaleType=Enum.ScaleType.Fit img.ZIndex=202 img.Parent=LoadCenter
            Corner(img,16) Stroke(img,Color3.fromRGB(50,50,80),1)
        end
        loadOff=86
    end

    local LTitle=Instance.new("TextLabel") LTitle.BackgroundTransparency=1
    LTitle.Size=UDim2.new(1,0,0,22) LTitle.Position=UDim2.new(0,0,0,loadOff+4)
    LTitle.Text=LoadTitle LTitle.TextColor3=Color3.fromRGB(230,230,250)
    LTitle.Font=Enum.Font.GothamBold LTitle.TextSize=13
    LTitle.TextXAlignment=Enum.TextXAlignment.Center LTitle.ZIndex=202 LTitle.Parent=LoadCenter

    local LSub=Instance.new("TextLabel") LSub.BackgroundTransparency=1
    LSub.Size=UDim2.new(1,0,0,16) LSub.Position=UDim2.new(0,0,0,loadOff+30)
    LSub.Text=LoadSub LSub.TextColor3=Color3.fromRGB(88,88,120)
    LSub.Font=Enum.Font.Gotham LSub.TextSize=9
    LSub.TextXAlignment=Enum.TextXAlignment.Center LSub.ZIndex=202 LSub.Parent=LoadCenter

    local BarBG=Instance.new("Frame") BarBG.BackgroundColor3=Color3.fromRGB(28,28,40)
    BarBG.BorderSizePixel=0 BarBG.Size=UDim2.new(0,160,0,3)
    BarBG.Position=UDim2.new(0.5,-80,0,loadOff+64) BarBG.ZIndex=202 BarBG.Parent=LoadCenter
    Corner(BarBG,2)
    local BarFill=Instance.new("Frame") BarFill.BackgroundColor3=T.Accent
    BarFill.BorderSizePixel=0 BarFill.Size=UDim2.new(0,0,1,0) BarFill.ZIndex=203 BarFill.Parent=BarBG
    Corner(BarFill,2)
    local BarGlow=Instance.new("UIGradient")
    BarGlow.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,T.Accent)}
    BarGlow.Parent=BarFill

    local barConn=RunService.Heartbeat:Connect(function(dt)
        local t=tick()%2/2
        BarFill.Size=UDim2.new(t,0,1,0)
    end)

    local winW,winH=GetWinSize()
    local SIDEBAR_W=88
    local HEADER_H=40

    local Win=Instance.new("Frame") Win.Name="Window"
    Win.BackgroundColor3=T.BG Win.BorderSizePixel=0
    Win.Size=UDim2.new(0,winW,0,winH)
    Win.Position=UDim2.new(0.5,-winW/2,0.5,-winH/2)
    Win.ClipsDescendants=true Win.Visible=false Win.ZIndex=10 Win.Parent=Gui
    Corner(Win,14)
    Reg(Win,"BackgroundColor3","BG")
    local WinScale=Instance.new("UIScale") WinScale.Scale=1 WinScale.Parent=Win
    local WinStroke=Stroke(Win,T.Separator,1)
    Reg(WinStroke,"Color","Separator")

    local Sidebar=Instance.new("Frame") Sidebar.Name="Sidebar"
    Sidebar.BackgroundColor3=T.Sidebar Sidebar.BorderSizePixel=0
    Sidebar.Size=UDim2.new(0,SIDEBAR_W,1,0) Sidebar.Position=UDim2.new(0,0,0,0)
    Sidebar.ZIndex=12 Sidebar.Parent=Win
    Reg(Sidebar,"BackgroundColor3","Sidebar")

    local SidebarLine=Instance.new("Frame") SidebarLine.BackgroundColor3=T.Separator
    SidebarLine.BorderSizePixel=0 SidebarLine.Size=UDim2.new(0,1,1,0)
    SidebarLine.Position=UDim2.new(1,-1,0,0) SidebarLine.ZIndex=13 SidebarLine.Parent=Sidebar
    Reg(SidebarLine,"BackgroundColor3","Separator")

    local SidebarTop=Instance.new("Frame") SidebarTop.BackgroundTransparency=1
    SidebarTop.Size=UDim2.new(1,0,0,HEADER_H) SidebarTop.ZIndex=13 SidebarTop.Parent=Sidebar
    Pad(SidebarTop,0,8,0,8)

    local SideLogoImg=nil
    if LoadImage then
        local iv,isA=ResolveIcon(LoadImage)
        if isA then
            SideLogoImg=Instance.new("ImageLabel")
            SideLogoImg.BackgroundTransparency=1 SideLogoImg.AnchorPoint=Vector2.new(0.5,0.5)
            SideLogoImg.Size=UDim2.new(0,22,0,22) SideLogoImg.Position=UDim2.new(0.5,0,0.5,0)
            SideLogoImg.Image=iv SideLogoImg.ScaleType=Enum.ScaleType.Fit
            SideLogoImg.ZIndex=14 SideLogoImg.Parent=SidebarTop
        end
    end

    if not SideLogoImg then
        local SideTitleLbl=Instance.new("TextLabel") SideTitleLbl.BackgroundTransparency=1
        SideTitleLbl.AnchorPoint=Vector2.new(0.5,0.5)
        SideTitleLbl.Size=UDim2.new(1,-4,0,20) SideTitleLbl.Position=UDim2.new(0.5,0,0.5,-4)
        SideTitleLbl.Text=Title SideTitleLbl.TextColor3=T.Text
        SideTitleLbl.Font=Enum.Font.GothamBold SideTitleLbl.TextSize=9
        SideTitleLbl.TextXAlignment=Enum.TextXAlignment.Center
        SideTitleLbl.TextTruncate=Enum.TextTruncate.AtEnd
        SideTitleLbl.ZIndex=14 SideTitleLbl.Parent=SidebarTop
        Reg(SideTitleLbl,"TextColor3","Text")
        if Subtitle~="" then
            local SideSubLbl=Instance.new("TextLabel") SideSubLbl.BackgroundTransparency=1
            SideSubLbl.AnchorPoint=Vector2.new(0.5,0.5)
            SideSubLbl.Size=UDim2.new(1,-4,0,12) SideSubLbl.Position=UDim2.new(0.5,0,0.5,10)
            SideSubLbl.Text=Subtitle SideSubLbl.TextColor3=T.SubText
            SideSubLbl.Font=Enum.Font.Gotham SideSubLbl.TextSize=8
            SideSubLbl.TextXAlignment=Enum.TextXAlignment.Center
            SideSubLbl.TextTruncate=Enum.TextTruncate.AtEnd
            SideSubLbl.ZIndex=14 SideSubLbl.Parent=SidebarTop
            Reg(SideSubLbl,"TextColor3","SubText")
        end
    end

    local SideTabLine=Instance.new("Frame") SideTabLine.BackgroundColor3=T.Separator
    SideTabLine.BorderSizePixel=0 SideTabLine.Size=UDim2.new(1,-16,0,1)
    SideTabLine.Position=UDim2.new(0,8,0,HEADER_H-1) SideTabLine.ZIndex=13 SideTabLine.Parent=Sidebar
    Reg(SideTabLine,"BackgroundColor3","Separator")

    -- Thin accent bar along the top edge of the sidebar
    local SideAccentBar=Instance.new("Frame") SideAccentBar.BackgroundColor3=T.Accent
    SideAccentBar.BorderSizePixel=0 SideAccentBar.Size=UDim2.new(0,28,0,2)
    SideAccentBar.AnchorPoint=Vector2.new(0.5,0) SideAccentBar.Position=UDim2.new(0.5,0,0,0)
    SideAccentBar.ZIndex=16 SideAccentBar.Parent=Sidebar
    Corner(SideAccentBar,1)
    Reg(SideAccentBar,"BackgroundColor3","Accent")

    local TabListScroll=Instance.new("ScrollingFrame")
    TabListScroll.BackgroundTransparency=1 TabListScroll.BorderSizePixel=0
    TabListScroll.Size=UDim2.new(1,0,1,-(HEADER_H+72)) TabListScroll.Position=UDim2.new(0,0,0,HEADER_H)
    TabListScroll.CanvasSize=UDim2.new(0,0,0,0) TabListScroll.ScrollBarThickness=0
    TabListScroll.ScrollingDirection=Enum.ScrollingDirection.Y
    TabListScroll.ZIndex=13 TabListScroll.Parent=Sidebar
    Pad(TabListScroll,6,0,6,0)

    local TabListLayout=Instance.new("UIListLayout")
    TabListLayout.FillDirection=Enum.FillDirection.Vertical
    TabListLayout.SortOrder=Enum.SortOrder.LayoutOrder
    TabListLayout.Padding=UDim.new(0,2)
    TabListLayout.Parent=TabListScroll

    TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabListScroll.CanvasSize=UDim2.new(0,0,0,TabListLayout.AbsoluteContentSize.Y+12)
    end)

    local SideBottom=Instance.new("Frame") SideBottom.BackgroundTransparency=1
    SideBottom.Size=UDim2.new(1,0,0,72) SideBottom.AnchorPoint=Vector2.new(0,1)
    SideBottom.Position=UDim2.new(0,0,1,0) SideBottom.ZIndex=13 SideBottom.Parent=Sidebar
    Pad(SideBottom,0,8,8,8)

    -- ── Theme picker: a row of colour dots ──
    local ThemeRow=Instance.new("Frame") ThemeRow.BackgroundTransparency=1
    ThemeRow.BorderSizePixel=0 ThemeRow.Size=UDim2.new(1,0,0,28)
    ThemeRow.Position=UDim2.new(0,0,0,0) ThemeRow.ZIndex=14 ThemeRow.Parent=SideBottom

    local ThemeRowLayout=Instance.new("UIListLayout")
    ThemeRowLayout.FillDirection=Enum.FillDirection.Horizontal
    ThemeRowLayout.HorizontalAlignment=Enum.HorizontalAlignment.Center
    ThemeRowLayout.VerticalAlignment=Enum.VerticalAlignment.Center
    ThemeRowLayout.Padding=UDim.new(0,5) ThemeRowLayout.Parent=ThemeRow

    local ThemeDotSize=14
    local ThemeAccents={
        Onyx    = Color3.fromRGB(0,   152, 255),
        Phantom = Color3.fromRGB(162, 102, 255),
        Arctic  = Color3.fromRGB(0,   112, 230),
        Ember   = Color3.fromRGB(255, 138,  24),
        Rose    = Color3.fromRGB(220,  56, 108),
    }
    local ThemeOrder={"Onyx","Phantom","Arctic","Ember","Rose"}
    local ActiveDot=nil

    for _,Name in ipairs(ThemeOrder) do
        local Dot=Instance.new("TextButton") Dot.BackgroundColor3=ThemeAccents[Name]
        Dot.BorderSizePixel=0 Dot.Size=UDim2.new(0,ThemeDotSize,0,ThemeDotSize)
        Dot.Text="" Dot.ZIndex=15 Dot.Parent=ThemeRow
        Corner(Dot,7)
        local DotScale=Instance.new("UIScale") DotScale.Scale=1 DotScale.Parent=Dot
        local DotRing=Stroke(Dot,Color3.fromRGB(255,255,255),1.5) DotRing.Transparency=1
        -- mark current theme
        if Name==(ThemeName or "Onyx") then
            ActiveDot=Dot DotRing.Transparency=0 TwB(DotScale,{Scale=1.22},.30)
        end
        Dot.MouseButton1Down:Connect(function() TwL(DotScale,{Scale=.84},.07) end)
        Dot.MouseButton1Up:Connect(function() TwB(DotScale,{Scale=ActiveDot==Dot and 1.22 or 1},.30) end)
        Dot.MouseButton1Click:Connect(function()
            if ActiveDot then
                local OldRing=ActiveDot:FindFirstChildOfClass("UIStroke")
                if OldRing then Tw(OldRing,{Transparency=1},.18) end
                local OldSc=ActiveDot:FindFirstChildOfClass("UIScale")
                if OldSc then TwB(OldSc,{Scale=1},.28) end
            end
            ActiveDot=Dot
            DotRing.Transparency=1
            Tw(DotRing,{Transparency=0},.18)
            TwB(DotScale,{Scale=1.22},.36)
            -- apply theme via WindowObj:SetTheme
            T=Themes[Name] or Themes.Onyx
            local Live={}
            for _,N in ipairs(Nodes) do
                if N.fn then N.fn() Live[#Live+1]=N
                elseif N.o and N.o.Parent then
                    local v=T[N.k] if v then Tw(N.o,{[N.p]=v},.26) end
                    Live[#Live+1]=N
                end
            end
            Nodes=Live
        end)
    end

    local ThemeSep=Instance.new("Frame") ThemeSep.BackgroundColor3=T.Separator
    ThemeSep.BorderSizePixel=0 ThemeSep.Size=UDim2.new(1,0,0,1)
    ThemeSep.Position=UDim2.new(0,0,0,30) ThemeSep.ZIndex=14 ThemeSep.Parent=SideBottom
    Reg(ThemeSep,"BackgroundColor3","Separator")

    local CloseBtn=Instance.new("TextButton") CloseBtn.BackgroundColor3=T.SectionBG
    CloseBtn.BorderSizePixel=0 CloseBtn.Size=UDim2.new(1,0,0,22)
    CloseBtn.Position=UDim2.new(0,0,0,34) CloseBtn.Text=""
    CloseBtn.ZIndex=14 CloseBtn.Parent=SideBottom
    Corner(CloseBtn,7)
    Reg(CloseBtn,"BackgroundColor3","SectionBG")
    local CloseBtnStroke=Stroke(CloseBtn,T.Separator,1)
    Reg(CloseBtnStroke,"Color","Separator")
    local CloseBtnLbl=Instance.new("TextLabel") CloseBtnLbl.BackgroundTransparency=1
    CloseBtnLbl.Size=UDim2.new(1,0,1,0) CloseBtnLbl.Text="✕  Close"
    CloseBtnLbl.TextColor3=T.SubText CloseBtnLbl.Font=Enum.Font.GothamMedium
    CloseBtnLbl.TextSize=9 CloseBtnLbl.ZIndex=15 CloseBtnLbl.Parent=CloseBtn
    Reg(CloseBtnLbl,"TextColor3","SubText")
    local CloseBtnScale=Instance.new("UIScale") CloseBtnScale.Scale=1 CloseBtnScale.Parent=CloseBtn
    CloseBtn.MouseEnter:Connect(function() Tw(CloseBtnLbl,{TextColor3=T.Text},.14) end)
    CloseBtn.MouseLeave:Connect(function() Tw(CloseBtnLbl,{TextColor3=T.SubText},.20) end)
    CloseBtn.MouseButton1Down:Connect(function() TwL(CloseBtnScale,{Scale=.94},.07) end)
    CloseBtn.MouseButton1Up:Connect(function() TwB(CloseBtnScale,{Scale=1},.36) end)

    local MainArea=Instance.new("Frame") MainArea.BackgroundTransparency=1
    MainArea.Size=UDim2.new(1,-SIDEBAR_W,1,0) MainArea.Position=UDim2.new(0,SIDEBAR_W,0,0)
    MainArea.ClipsDescendants=true MainArea.ZIndex=11 MainArea.Parent=Win

    local ContentArea=Instance.new("Frame") ContentArea.BackgroundTransparency=1
    ContentArea.Size=UDim2.new(1,0,1,0) ContentArea.ZIndex=11 ContentArea.Parent=MainArea
    ContentArea.ClipsDescendants=true

    local TabFadeOverlay=Instance.new("Frame") TabFadeOverlay.BackgroundColor3=T.BG
    TabFadeOverlay.BackgroundTransparency=1 TabFadeOverlay.BorderSizePixel=0
    TabFadeOverlay.Size=UDim2.new(1,0,1,0) TabFadeOverlay.ZIndex=50
    TabFadeOverlay.Parent=ContentArea
    Reg(TabFadeOverlay,"BackgroundColor3","BG")

    -- Overlay that slides in during close to mask children cleanly
    local CloseOverlay = Instance.new("Frame")
    CloseOverlay.BackgroundColor3        = T.BG
    CloseOverlay.BackgroundTransparency  = 1
    CloseOverlay.BorderSizePixel         = 0
    CloseOverlay.Size                    = UDim2.new(1,0,1,0)
    CloseOverlay.ZIndex                  = 200
    CloseOverlay.Parent                  = Win
    Corner(CloseOverlay, 14)
    Reg(CloseOverlay, "BackgroundColor3", "BG")

    local ImgId = ButtonId and tostring(ButtonId) or "85798284091961"
    local ShowBtn = Instance.new("ImageButton")
    ShowBtn.Image                  = "rbxassetid://" .. ImgId
    ShowBtn.ImageTransparency      = 1
    ShowBtn.BackgroundColor3       = T.Sidebar
    ShowBtn.BackgroundTransparency = 1
    ShowBtn.Size                   = UDim2.new(0, 48, 0, 48)
    -- ── top-center, mobile+PC friendly ──
    ShowBtn.AnchorPoint            = Vector2.new(0.5, 0)
    ShowBtn.Position               = UDim2.new(0.5, 0, 0, 14)
    ShowBtn.ZIndex                 = 100
    ShowBtn.Visible                = false
    ShowBtn.Parent                 = Gui
    Corner(ShowBtn, 14)
    -- Accent-coloured ring stroke instead of separator grey
    local ShowBtnStroke = Stroke(ShowBtn, T.Accent, 1.8)
    Reg(ShowBtnStroke, "Color", "Accent")
    Reg(ShowBtn, "BackgroundColor3", "Sidebar")
    local ShowBtnScale = Instance.new("UIScale") ShowBtnScale.Scale=1 ShowBtnScale.Parent=ShowBtn

    ShowBtn.MouseButton1Down:Connect(function()
        TweenService:Create(ShowBtnScale,TweenInfo.new(.10,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Scale=.84}):Play()
        TweenService:Create(ShowBtn,TweenInfo.new(.10,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency=.3}):Play()
    end)
    ShowBtn.MouseButton1Up:Connect(function()
        TweenService:Create(ShowBtnScale,TweenInfo.new(.44,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
        TweenService:Create(ShowBtn,TweenInfo.new(.22,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play()
    end)

    local isDragging=false local dragStart=nil local startWinPos=nil

    Sidebar.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            isDragging=true dragStart=inp.Position startWinPos=Win.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if not isDragging then return end
        if inp.UserInputType~=Enum.UserInputType.MouseMovement and inp.UserInputType~=Enum.UserInputType.Touch then return end
        local d=inp.Position-dragStart
        Win.Position=UDim2.new(startWinPos.X.Scale,startWinPos.X.Offset+d.X,startWinPos.Y.Scale,startWinPos.Y.Offset+d.Y)
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            isDragging=false
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        local wp = Win.Position
        Tw(CloseOverlay, {BackgroundTransparency=0}, .18, Enum.EasingStyle.Quint)
        TweenService:Create(WinScale, TweenInfo.new(.38, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Scale=.80}):Play()
        TweenService:Create(Win, TweenInfo.new(.38, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
            {Position=UDim2.new(wp.X.Scale, wp.X.Offset, wp.Y.Scale, wp.Y.Offset-22)}):Play()
        task.delay(.42, function()
            Win.Visible       = false
            CloseOverlay.BackgroundTransparency = 1
            Win.Position      = wp
            WinScale.Scale    = 1
            ShowBtn.Visible              = true
            ShowBtn.ImageTransparency    = 1
            ShowBtn.BackgroundTransparency = 1
            ShowBtnScale.Scale           = 0.46
            TweenService:Create(ShowBtn,      TweenInfo.new(.36, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {ImageTransparency=0, BackgroundTransparency=0}):Play()
            TweenService:Create(ShowBtnScale, TweenInfo.new(.60, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Scale=1}):Play()
        end)
    end)

    ShowBtn.MouseButton1Click:Connect(function()
        TweenService:Create(ShowBtnScale, TweenInfo.new(.14, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Scale=.70}):Play()
        TweenService:Create(ShowBtn,      TweenInfo.new(.20, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
            {ImageTransparency=1, BackgroundTransparency=1}):Play()
        task.delay(.22, function()
            ShowBtn.Visible    = false
            ShowBtnScale.Scale = 1
            local wp = Win.Position
            Win.Visible        = true
            Win.Position       = UDim2.new(wp.X.Scale, wp.X.Offset, wp.Y.Scale, wp.Y.Offset+46)
            WinScale.Scale     = .78
            TweenService:Create(Win,       TweenInfo.new(.54, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
                {Position=UDim2.new(wp.X.Scale, wp.X.Offset, wp.Y.Scale, wp.Y.Offset)}):Play()
            TweenService:Create(WinScale,  TweenInfo.new(.64, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
                {Scale=1}):Play()
        end)
    end)

    task.spawn(function()
        task.wait(2.4)
        barConn:Disconnect()
        Tw(LoadBG,{BackgroundTransparency=1},.36,Enum.EasingStyle.Quint)
        for _,d in ipairs(LoadBG:GetDescendants()) do
            if d:IsA("GuiObject") then
                local tp={BackgroundTransparency=1}
                if d:IsA("TextLabel") then tp.TextTransparency=1 end
                if d:IsA("ImageLabel") then tp.ImageTransparency=1 end
                Tw(d,tp,.28,Enum.EasingStyle.Quint)
            end
        end
        task.wait(.40) LoadBG:Destroy()
        local nw,nh=GetWinSize()
        Win.Visible=true Win.Position=UDim2.new(0.5,-nw/2,0.5,-nh/2+54) WinScale.Scale=.76
        TweenService:Create(Win,TweenInfo.new(.58,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
            {Position=UDim2.new(0.5,-nw/2,0.5,-nh/2)}):Play()
        TweenService:Create(WinScale,TweenInfo.new(.68,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
    end)

    local WindowObj={}
    local Tabs={}
    local TabCount=0

    local function DeactivateAllTabs()
        for _,td in ipairs(Tabs) do
            td.content.Visible=false
            Tw(td.label,{TextColor3=T.TabInactive},.18)
            Tw(td.pill,{BackgroundTransparency=1,Size=UDim2.new(0,3,0,20)},.22,Enum.EasingStyle.Quint)
            Tw(td.pillColor,{BackgroundColor3=T.TabActiveBG},.18)
            td.pillColor.BackgroundTransparency=1
            if td.icon then
                local pr=td.icon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"
                Tw(td.icon,{[pr]=T.TabInactive},.18)
            end
        end
    end

    function WindowObj:SetTheme(Name)
        T=Themes[Name] or Themes.Onyx
        local Live={}
        for _,N in ipairs(Nodes) do
            if N.fn then N.fn() Live[#Live+1]=N
            elseif N.o and N.o.Parent then
                local v=T[N.k] if v then Tw(N.o,{[N.p]=v},.26) end
                Live[#Live+1]=N
            end
        end
        Nodes=Live
        for _,td in ipairs(Tabs) do
            local isActive=td.content.Visible
            local col=isActive and T.TabActive or T.TabInactive
            Tw(td.label,{TextColor3=col},.26)
            if td.icon then
                local pr=td.icon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"
                Tw(td.icon,{[pr]=col},.26)
            end
        end
    end

    function WindowObj:CreateTab(TabCfg)
        TabCfg=TabCfg or {}
        local TabTitle=TabCfg.Title or "Tab"
        local TabLogo=TabCfg.Logo
        TabCount=TabCount+1
        local Idx=TabCount

        local TabBtn=Instance.new("TextButton") TabBtn.BackgroundTransparency=1
        TabBtn.Size=UDim2.new(1,0,0,26) TabBtn.Text=""
        TabBtn.ZIndex=14 TabBtn.LayoutOrder=Idx TabBtn.Parent=TabListScroll
        Pad(TabBtn,0,8,0,8)

        local PillBG=Instance.new("Frame") PillBG.BackgroundColor3=T.TabActiveBG
        PillBG.BackgroundTransparency=1 PillBG.BorderSizePixel=0
        PillBG.Size=UDim2.new(1,0,1,0) PillBG.ZIndex=13 PillBG.Parent=TabBtn
        Corner(PillBG,7)

        local Pill=Instance.new("Frame") Pill.BackgroundColor3=T.TabActive
        Pill.BorderSizePixel=0 Pill.AnchorPoint=Vector2.new(0,.5)
        Pill.Size=UDim2.new(0,2,0,16) Pill.Position=UDim2.new(0,0,.5,0)
        Pill.BackgroundTransparency=1 Pill.ZIndex=15 Pill.Parent=TabBtn
        Corner(Pill,2)
        Reg(Pill,"BackgroundColor3","TabActive")

        local TabIcon=nil

        local TabLbl=Instance.new("TextLabel") TabLbl.BackgroundTransparency=1
        TabLbl.AnchorPoint=Vector2.new(0,.5)
        TabLbl.Size=UDim2.new(1,-14,0,12) TabLbl.Position=UDim2.new(0,8,.5,0)
        TabLbl.Text=TabTitle TabLbl.TextColor3=T.TabInactive
        TabLbl.Font=Enum.Font.GothamMedium TabLbl.TextSize=9
        TabLbl.TextXAlignment=Enum.TextXAlignment.Left
        TabLbl.TextYAlignment=Enum.TextYAlignment.Center
        TabLbl.ZIndex=15 TabLbl.Parent=TabBtn

        local TabFrame=Instance.new("Frame") TabFrame.Name="Tab_"..Idx
        TabFrame.BackgroundTransparency=1 TabFrame.Size=UDim2.new(1,0,1,0)
        TabFrame.Visible=false TabFrame.ZIndex=11 TabFrame.Parent=ContentArea

        local COL_PAD=8 local COL_GAP=6 local COL_TOP=12 local COL_BOT=14

        local LeftScroll=Instance.new("ScrollingFrame") LeftScroll.BackgroundTransparency=1
        LeftScroll.BorderSizePixel=0 LeftScroll.Size=UDim2.new(.5,-COL_GAP/2-COL_PAD,1,0)
        LeftScroll.Position=UDim2.new(0,COL_PAD,0,0) LeftScroll.CanvasSize=UDim2.new(0,0,0,0)
        LeftScroll.ScrollBarThickness=0 LeftScroll.ScrollingDirection=Enum.ScrollingDirection.Y
        LeftScroll.ZIndex=11 LeftScroll.Parent=TabFrame

        local RightScroll=Instance.new("ScrollingFrame") RightScroll.BackgroundTransparency=1
        RightScroll.BorderSizePixel=0 RightScroll.Size=UDim2.new(.5,-COL_GAP/2-COL_PAD,1,0)
        RightScroll.Position=UDim2.new(.5,COL_GAP/2,0,0) RightScroll.CanvasSize=UDim2.new(0,0,0,0)
        RightScroll.ScrollBarThickness=0 RightScroll.ScrollingDirection=Enum.ScrollingDirection.Y
        RightScroll.ZIndex=11 RightScroll.Parent=TabFrame

        local function MakeColInner(SF)
            local I=Instance.new("Frame") I.BackgroundTransparency=1
            I.Size=UDim2.new(1,0,0,0) I.AutomaticSize=Enum.AutomaticSize.Y
            I.ZIndex=12 I.Parent=SF
            local L=Instance.new("UIListLayout") L.FillDirection=Enum.FillDirection.Vertical
            L.SortOrder=Enum.SortOrder.LayoutOrder L.Padding=UDim.new(0,0) L.Parent=I
            Pad(I,COL_TOP,0,COL_BOT,0)
            L:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SF.CanvasSize=UDim2.new(0,0,0,L.AbsoluteContentSize.Y+COL_TOP+COL_BOT)
            end)
            return I
        end

        local LeftInner=MakeColInner(LeftScroll)
        local RightInner=MakeColInner(RightScroll)

        local tabData={btn=TabBtn,content=TabFrame,label=TabLbl,icon=nil,pill=Pill,pillColor=PillBG}
        table.insert(Tabs,tabData)

        local function ActivateThis()
            DeactivateAllTabs()
            TabFadeOverlay.BackgroundTransparency=.55 TabFadeOverlay.ZIndex=50
            TweenService:Create(TabFadeOverlay,TweenInfo.new(.42,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play()
            TabFrame.Visible=true
            TabFrame.Position=UDim2.new(.05,0,0,0)
            TweenService:Create(TabFrame,TweenInfo.new(.34,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0)}):Play()
            TweenService:Create(TabLbl,TweenInfo.new(.20,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextColor3=T.TabActive}):Play()
            PillBG.BackgroundTransparency=1
            TweenService:Create(PillBG,TweenInfo.new(.28,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play()
            Pill.BackgroundTransparency=1 Pill.Size=UDim2.new(0,2,0,8)
            TweenService:Create(Pill,TweenInfo.new(.52,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{BackgroundTransparency=0,Size=UDim2.new(0,2,0,16)}):Play()
            if TabIcon then
                local pr=TabIcon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"
                TweenService:Create(TabIcon,TweenInfo.new(.20,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{[pr]=T.TabActive}):Play()
            end
        end

        TabBtn.MouseButton1Click:Connect(ActivateThis)
        TabBtn.MouseButton1Down:Connect(function()
            Tw(PillBG,{BackgroundTransparency=.5},.08)
        end)
        TabBtn.MouseButton1Up:Connect(function()
            if TabFrame.Visible then Tw(PillBG,{BackgroundTransparency=0},.16)
            else Tw(PillBG,{BackgroundTransparency=1},.16) end
        end)
        if Idx==1 then ActivateThis() end

        local TabObj={} local SecCnt=0

        function TabObj:CreateSection(SCfg)
            SCfg=SCfg or {}
            local SecTitle=SCfg.Title or "Section"
            local SecPos=(SCfg.Position or "left"):lower()
            SecCnt=SecCnt+1
            local SecOrder=SecCnt
            local ParentCol=SecPos=="right" and RightInner or LeftInner

            local SW=Instance.new("Frame") SW.BackgroundTransparency=1
            SW.Size=UDim2.new(1,0,0,0) SW.AutomaticSize=Enum.AutomaticSize.Y
            SW.LayoutOrder=SecOrder SW.ZIndex=13 SW.Parent=ParentCol
            local SWL=Instance.new("UIListLayout") SWL.FillDirection=Enum.FillDirection.Vertical
            SWL.SortOrder=Enum.SortOrder.LayoutOrder SWL.Padding=UDim.new(0,0) SWL.Parent=SW

            local TopSp=Instance.new("Frame") TopSp.BackgroundTransparency=1
            TopSp.Size=UDim2.new(1,0,0,10) TopSp.LayoutOrder=0 TopSp.ZIndex=13 TopSp.Parent=SW

            local SHW=Instance.new("Frame") SHW.BackgroundTransparency=1
            SHW.Size=UDim2.new(1,0,0,14) SHW.LayoutOrder=1 SHW.ZIndex=13 SHW.Parent=SW
            Pad(SHW,0,2,0,4)
            local SH=Instance.new("TextLabel") SH.BackgroundTransparency=1
            SH.Size=UDim2.new(1,0,1,0) SH.Text=SecTitle:upper()
            SH.TextColor3=T.SecTitle SH.Font=Enum.Font.GothamBold SH.TextSize=7
            SH.TextXAlignment=Enum.TextXAlignment.Left SH.TextYAlignment=Enum.TextYAlignment.Center
            SH.ZIndex=14 SH.Parent=SHW
            Reg(SH,"TextColor3","SecTitle")

            local HSp=Instance.new("Frame") HSp.BackgroundTransparency=1
            HSp.Size=UDim2.new(1,0,0,3) HSp.LayoutOrder=2 HSp.ZIndex=13 HSp.Parent=SW

            local Card=Instance.new("Frame") Card.BackgroundColor3=T.SectionBG
            Card.BorderSizePixel=0 Card.Size=UDim2.new(1,0,0,0)
            Card.AutomaticSize=Enum.AutomaticSize.Y Card.ClipsDescendants=true
            Card.LayoutOrder=3 Card.ZIndex=13 Card.Parent=SW
            Corner(Card,8) Reg(Card,"BackgroundColor3","SectionBG")
            local CardStroke=Stroke(Card,T.Separator,.6)
            Reg(CardStroke,"Color","Separator")

            local CEntryScale=Instance.new("UIScale") CEntryScale.Scale=.86 CEntryScale.Parent=Card
            Card.BackgroundTransparency=1
            task.delay((SecCnt-1)*.06,function()
                TweenService:Create(Card,TweenInfo.new(.30,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play()
                TweenService:Create(CEntryScale,TweenInfo.new(.52,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
            end)

            local CL=Instance.new("UIListLayout") CL.FillDirection=Enum.FillDirection.Vertical
            CL.SortOrder=Enum.SortOrder.LayoutOrder CL.Padding=UDim.new(0,0) CL.Parent=Card

            local BSp=Instance.new("Frame") BSp.BackgroundTransparency=1
            BSp.Size=UDim2.new(1,0,0,8) BSp.LayoutOrder=4 BSp.ZIndex=13 BSp.Parent=SW

            local SecObj={} SecObj._card=Card SecObj._rowN=0

            local function MkSep(N)
                local SW2=Instance.new("Frame") SW2.BackgroundTransparency=1
                SW2.BorderSizePixel=0 SW2.Size=UDim2.new(1,0,0,1)
                SW2.ZIndex=15 SW2.LayoutOrder=N*10-5 SW2.Parent=Card
                local S=Instance.new("Frame") S.BackgroundColor3=T.Separator
                S.BorderSizePixel=0 S.Size=UDim2.new(1,-16,1,0)
                S.Position=UDim2.new(0,13,0,0) S.ZIndex=15 S.Parent=SW2
                Reg(S,"BackgroundColor3","Separator")
            end

            local function MkRow(H,AY)
                SecObj._rowN=SecObj._rowN+1 local N=SecObj._rowN
                if N>1 then MkSep(N) end
                local Row=Instance.new("Frame") Row.BackgroundTransparency=1
                Row.BorderSizePixel=0 Row.ZIndex=14 Row.LayoutOrder=N*10 Row.Parent=Card
                if AY then Row.Size=UDim2.new(1,0,0,0) Row.AutomaticSize=Enum.AutomaticSize.Y
                else Row.Size=UDim2.new(1,0,0,H or 40) end
                Pad(Row,0,12,0,12)
                return Row
            end

            local function RowPress(Row) Tw(Row,{BackgroundColor3=T.PressHL},.06) Row.BackgroundTransparency=0 end
            local function RowRelease(Row) Tw(Row,{BackgroundColor3=T.SectionBG},.26,Enum.EasingStyle.Quint) task.delay(.26,function() Row.BackgroundTransparency=1 end) end

            function SecObj:CreateToggle(Cfg2)
                Cfg2=Cfg2 or {}
                local Ttl=Cfg2.Title or "Toggle"
                local Def=Cfg2.Default~=nil and Cfg2.Default or false
                local Cb=Cfg2.Callback or function() end
                local Row=MkRow(32)

                local Lbl=Instance.new("TextLabel") Lbl.BackgroundTransparency=1
                Lbl.AnchorPoint=Vector2.new(0,.5) Lbl.Size=UDim2.new(1,-40,0,12)
                Lbl.Position=UDim2.new(0,0,.5,0) Lbl.Text=Ttl
                Lbl.TextColor3=T.Text Lbl.Font=Enum.Font.Gotham Lbl.TextSize=12
                Lbl.TextXAlignment=Enum.TextXAlignment.Left
                Lbl.TextYAlignment=Enum.TextYAlignment.Center
                Lbl.ZIndex=15 Lbl.Parent=Row
                Reg(Lbl,"TextColor3","Text")

                local Track=Instance.new("Frame") Track.BackgroundColor3=Def and T.ToggleOn or T.ToggleOff
                Track.BorderSizePixel=0 Track.AnchorPoint=Vector2.new(1,.5)
                Track.Size=UDim2.new(0,30,0,18) Track.Position=UDim2.new(1,0,.5,0)
                Track.ZIndex=15 Track.Parent=Row Corner(Track,9)

                local Thumb=Instance.new("Frame") Thumb.BackgroundColor3=T.White
                Thumb.BorderSizePixel=0 Thumb.AnchorPoint=Vector2.new(0,.5)
                Thumb.Size=UDim2.new(0,14,0,14)
                Thumb.Position=Def and UDim2.new(0,14,.5,0) or UDim2.new(0,2,.5,0)
                Thumb.ZIndex=16 Thumb.Parent=Track Corner(Thumb,7)
                Reg(Thumb,"BackgroundColor3","White")
                local ThSt=Stroke(Thumb,Color3.fromRGB(0,0,0),.5) ThSt.Transparency=.84

                local State=Def local Busy=false
                local function DoSet(V,Anim)
                    if Busy then return end Busy=true State=V
                    local Tgt=V and UDim2.new(0,14,.5,0) or UDim2.new(0,2,.5,0)
                    local Col=V and T.ToggleOn or T.ToggleOff
                    if Anim then
                        TweenService:Create(Track,TweenInfo.new(.24,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundColor3=Col}):Play()
                        TweenService:Create(Thumb,TweenInfo.new(.08,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Size=UDim2.new(0,18,0,14)}):Play()
                        task.delay(.08,function()
                            TweenService:Create(Thumb,TweenInfo.new(.44,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=Tgt,Size=UDim2.new(0,14,0,14)}):Play()
                        end)
                    else
                        Track.BackgroundColor3=Col Thumb.Position=Tgt Thumb.Size=UDim2.new(0,14,0,14)
                    end
                    task.delay(.46,function() Busy=false end)
                end
                RegFn(function() Tw(Track,{BackgroundColor3=State and T.ToggleOn or T.ToggleOff},.22) end)

                local Hit=Instance.new("TextButton") Hit.BackgroundTransparency=1
                Hit.Size=UDim2.new(1,0,1,0) Hit.Text="" Hit.ZIndex=17 Hit.Parent=Row
                Hit.MouseButton1Click:Connect(function() DoSet(not State,true) Cb(State) end)
                Hit.MouseButton1Down:Connect(function() RowPress(Row) end)
                Hit.MouseButton1Up:Connect(function() RowRelease(Row) end)

                local Obj={} Obj.Value={Set=function(_,V) DoSet(V,true) Cb(V) end}
                Obj.Name={Set=function(_,N) Lbl.Text=N end} Obj.GetValue=function() return State end
                return Obj
            end

            function SecObj:CreateButton(Cfg2)
                Cfg2=Cfg2 or {}
                local Ttl=Cfg2.Title or "Button"
                local Cb=Cfg2.Callback or function() end
                local Row=MkRow(30)
                local RowScale=Instance.new("UIScale") RowScale.Scale=1 RowScale.Parent=Row

                local Lbl=Instance.new("TextLabel") Lbl.BackgroundTransparency=1
                Lbl.AnchorPoint=Vector2.new(.5,.5) Lbl.Size=UDim2.new(1,0,0,14)
                Lbl.Position=UDim2.new(.5,0,.5,0) Lbl.Text=Ttl
                Lbl.TextColor3=T.Accent Lbl.Font=Enum.Font.GothamMedium Lbl.TextSize=12
                Lbl.TextXAlignment=Enum.TextXAlignment.Center Lbl.TextYAlignment=Enum.TextYAlignment.Center
                Lbl.ZIndex=15 Lbl.Parent=Row
                Reg(Lbl,"TextColor3","Accent")

                local Hit=Instance.new("TextButton") Hit.BackgroundTransparency=1
                Hit.Size=UDim2.new(1,0,1,0) Hit.Text="" Hit.ZIndex=16 Hit.Parent=Row
                Hit.MouseButton1Down:Connect(function() RowPress(Row) Tw(Lbl,{TextColor3=T.AccentDark},.07) Tw(RowScale,{Scale=.94},.10,Enum.EasingStyle.Quint) end)
                Hit.MouseButton1Up:Connect(function() RowRelease(Row) Tw(Lbl,{TextColor3=T.Accent},.22) Tw(RowScale,{Scale=1},.34,Enum.EasingStyle.Quint) end)
                Hit.MouseButton1Click:Connect(Cb)

                local Obj={} Obj.Name={Set=function(_,N) Lbl.Text=N end}
                return Obj
            end

            function SecObj:CreateDropdown(Cfg2)
                Cfg2=Cfg2 or {}
                local Ttl=Cfg2.Title or "Dropdown"
                local Opts=Cfg2.Options or {}
                local InitSel=Cfg2.Selected or {}
                local Multi=Cfg2.Multi or false
                local Cb=Cfg2.Callback or function() end
                local SelMap={}
                for _,V in ipairs(InitSel) do SelMap[V]=true end
                if not Multi and not next(SelMap) and #Opts>0 then SelMap[Opts[1]]=true end
                local function SelTxt()
                    local t={} for K,V in pairs(SelMap) do if V then t[#t+1]=K end end
                    if #t==0 then return "None" end table.sort(t) return table.concat(t,", ")
                end
                local IsOpen=false local CurOpts={table.unpack(Opts)}
                local Row=MkRow(32)
                local TtlLbl=Instance.new("TextLabel") TtlLbl.BackgroundTransparency=1
                TtlLbl.AnchorPoint=Vector2.new(0,.5) TtlLbl.Size=UDim2.new(1,-76,0,14)
                TtlLbl.Position=UDim2.new(0,0,.5,0) TtlLbl.Text=Ttl
                TtlLbl.TextColor3=T.Text TtlLbl.Font=Enum.Font.Gotham TtlLbl.TextSize=10
                TtlLbl.TextXAlignment=Enum.TextXAlignment.Left TtlLbl.TextYAlignment=Enum.TextYAlignment.Center
                TtlLbl.ZIndex=15 TtlLbl.Parent=Row Reg(TtlLbl,"TextColor3","Text")
                local SelLbl=Instance.new("TextLabel") SelLbl.BackgroundTransparency=1
                SelLbl.AnchorPoint=Vector2.new(1,.5) SelLbl.Size=UDim2.new(0,54,0,14)
                SelLbl.Position=UDim2.new(1,-16,.5,0) SelLbl.Text=SelTxt()
                SelLbl.TextColor3=T.SubText SelLbl.Font=Enum.Font.Gotham SelLbl.TextSize=11
                SelLbl.TextXAlignment=Enum.TextXAlignment.Right SelLbl.TextYAlignment=Enum.TextYAlignment.Center
                SelLbl.TextTruncate=Enum.TextTruncate.AtEnd SelLbl.ZIndex=15 SelLbl.Parent=Row
                Reg(SelLbl,"TextColor3","SubText")
                local Chev=Instance.new("TextLabel") Chev.BackgroundTransparency=1
                Chev.AnchorPoint=Vector2.new(1,.5) Chev.Size=UDim2.new(0,14,0,14)
                Chev.Position=UDim2.new(1,0,.5,0) Chev.Text="›"
                Chev.TextColor3=T.SubText Chev.Font=Enum.Font.GothamBold Chev.TextSize=18
                Chev.TextXAlignment=Enum.TextXAlignment.Center Chev.TextYAlignment=Enum.TextYAlignment.Center
                Chev.ZIndex=15 Chev.Parent=Row Reg(Chev,"TextColor3","SubText")
                local Panel=Instance.new("Frame") Panel.BackgroundColor3=T.SectionBG
                Panel.BorderSizePixel=0 Panel.Size=UDim2.new(1,0,0,0)
                Panel.ClipsDescendants=true Panel.ZIndex=20 Panel.Visible=false
                Panel.LayoutOrder=Row.LayoutOrder+1 Panel.Parent=Card
                Reg(Panel,"BackgroundColor3","SectionBG")
                local PanelList=Instance.new("UIListLayout") PanelList.FillDirection=Enum.FillDirection.Vertical
                PanelList.SortOrder=Enum.SortOrder.LayoutOrder PanelList.Parent=Panel
                local OptBtns={} local PanelH=0
                local function Rebuild(NewOpts)
                    for _,B in ipairs(OptBtns) do B:Destroy() end OptBtns={}
                    for I,Opt in ipairs(NewOpts) do
                        if I>1 then
                            local Sw=Instance.new("Frame") Sw.BackgroundTransparency=1
                            Sw.BorderSizePixel=0 Sw.Size=UDim2.new(1,0,0,1)
                            Sw.ZIndex=22 Sw.LayoutOrder=I*10-5 Sw.Parent=Panel
                            table.insert(OptBtns,Sw)
                            local Sl=Instance.new("Frame") Sl.BackgroundColor3=T.Separator
                            Sl.BorderSizePixel=0 Sl.Size=UDim2.new(1,-13,1,0)
                            Sl.Position=UDim2.new(0,13,0,0) Sl.ZIndex=22 Sl.Parent=Sw
                            Reg(Sl,"BackgroundColor3","Separator")
                        end
                        local Ob=Instance.new("TextButton") Ob.BackgroundTransparency=1
                        Ob.Size=UDim2.new(1,0,0,30) Ob.Text="" Ob.ZIndex=22
                        Ob.LayoutOrder=I*10 Ob.Parent=Panel table.insert(OptBtns,Ob)
                        Pad(Ob,0,12,0,12)
                        local ObSc=Instance.new("UIScale") ObSc.Scale=1 ObSc.Parent=Ob
                        local Ol=Instance.new("TextLabel") Ol.Name="OptionLabel"
                        Ol.BackgroundTransparency=1 Ol.AnchorPoint=Vector2.new(0,.5)
                        Ol.Size=UDim2.new(1,-22,0,14) Ol.Position=UDim2.new(0,0,.5,0)
                        Ol.Text=Opt Ol.TextColor3=T.Text Ol.Font=Enum.Font.Gotham Ol.TextSize=12
                        Ol.TextXAlignment=Enum.TextXAlignment.Left Ol.TextYAlignment=Enum.TextYAlignment.Center
                        Ol.ZIndex=23 Ol.Parent=Ob Reg(Ol,"TextColor3","Text")
                        local Ck=Instance.new("TextLabel") Ck.Name="Checkmark"
                        Ck.BackgroundTransparency=1 Ck.AnchorPoint=Vector2.new(1,.5)
                        Ck.Size=UDim2.new(0,18,0,14) Ck.Position=UDim2.new(1,0,.5,0)
                        Ck.Text=SelMap[Opt] and "✓" or "" Ck.TextColor3=T.Accent
                        Ck.Font=Enum.Font.GothamBold Ck.TextSize=12
                        Ck.TextXAlignment=Enum.TextXAlignment.Center Ck.TextYAlignment=Enum.TextYAlignment.Center
                        Ck.ZIndex=23 Ck.Parent=Ob Reg(Ck,"TextColor3","Accent")
                        Ob.MouseButton1Down:Connect(function() TwL(Ob,{BackgroundColor3=T.PressHL},.06) Ob.BackgroundTransparency=0 TwL(ObSc,{Scale=.96},.07) end)
                        Ob.MouseButton1Up:Connect(function() Tw(Ob,{BackgroundColor3=T.SectionBG},.24) task.delay(.24,function() Ob.BackgroundTransparency=1 end) TwB(ObSc,{Scale=1},.32) end)
                        Ob.MouseButton1Click:Connect(function()
                            if Multi then SelMap[Opt]=not SelMap[Opt] Ck.Text=SelMap[Opt] and "✓" or ""
                            else
                                for _,O2 in ipairs(NewOpts) do SelMap[O2]=false end SelMap[Opt]=true
                                for _,B2 in ipairs(OptBtns) do
                                    if B2:IsA("TextButton") then
                                        local CkL=B2:FindFirstChild("Checkmark") local OlL=B2:FindFirstChild("OptionLabel")
                                        if CkL and OlL then CkL.Text=SelMap[OlL.Text] and "✓" or "" end
                                    end
                                end
                            end
                            SelLbl.Text=SelTxt()
                            local Res={} for K,V in pairs(SelMap) do if V then Res[#Res+1]=K end end Cb(Res)
                            if not Multi then
                                IsOpen=false Tw(Panel,{Size=UDim2.new(1,0,0,0)},.22,Enum.EasingStyle.Quint)
                                task.delay(.23,function() Panel.Visible=false end)
                                Tw(Chev,{Rotation=0},.18)
                            end
                        end)
                    end
                    PanelH=math.min(#NewOpts*30,144) return PanelH
                end
                Rebuild(CurOpts)
                local Hit=Instance.new("TextButton") Hit.BackgroundTransparency=1
                Hit.Size=UDim2.new(1,0,1,0) Hit.Text="" Hit.ZIndex=16 Hit.Parent=Row
                Hit.MouseButton1Down:Connect(function() RowPress(Row) end)
                Hit.MouseButton1Up:Connect(function() RowRelease(Row) end)
                Hit.MouseButton1Click:Connect(function()
                    IsOpen=not IsOpen
                    if IsOpen then
                        Panel.Visible=true Panel.Size=UDim2.new(1,0,0,0)
                        Tw(Panel,{Size=UDim2.new(1,0,0,PanelH)},.32,Enum.EasingStyle.Quint)
                        Tw(Chev,{Rotation=90},.20)
                    else
                        Tw(Panel,{Size=UDim2.new(1,0,0,0)},.22,Enum.EasingStyle.Quint)
                        task.delay(.23,function() Panel.Visible=false end)
                        Tw(Chev,{Rotation=0},.18)
                    end
                end)
                local Obj={} Obj.Name={Set=function(_,N) TtlLbl.Text=N end}
                Obj.Options={Set=function(_,NOs) CurOpts=NOs SelMap={} if not Multi and #NOs>0 then SelMap[NOs[1]]=true end Rebuild(NOs) SelLbl.Text=SelTxt() end}
                Obj.Value={Set=function(_,V) SelMap={} if type(V)=="table" then for _,S in ipairs(V) do SelMap[S]=true end elseif type(V)=="string" then SelMap[V]=true end SelLbl.Text=SelTxt() Rebuild(CurOpts) end}
                return Obj
            end

            function SecObj:CreateSlider(Cfg2)
                Cfg2=Cfg2 or {}
                local Ttl=Cfg2.Title or "Slider"
                local Rng=Cfg2.Range or {0,100}
                local Mn=Rng[1] or 0 local Mx=Rng[2] or 100
                local Def=math.clamp(Cfg2.Default or Mn,Mn,Mx)
                local Inc=Cfg2.Increment or 1
                local Suf=Cfg2.Suffix or ""
                local Cb=Cfg2.Callback or function() end
                local Cur=Def
                local Row=MkRow(43)
                local TtlLbl=Instance.new("TextLabel") TtlLbl.BackgroundTransparency=1
                TtlLbl.AnchorPoint=Vector2.new(0,0) TtlLbl.Size=UDim2.new(.6,0,0,16)
                TtlLbl.Position=UDim2.new(0,0,0,8) TtlLbl.Text=Ttl
                TtlLbl.TextColor3=T.Text TtlLbl.Font=Enum.Font.Gotham TtlLbl.TextSize=12
                TtlLbl.TextXAlignment=Enum.TextXAlignment.Left TtlLbl.TextYAlignment=Enum.TextYAlignment.Center
                TtlLbl.ZIndex=15 TtlLbl.Parent=Row Reg(TtlLbl,"TextColor3","Text")
                local ValLbl=Instance.new("TextLabel") ValLbl.BackgroundTransparency=1
                ValLbl.AnchorPoint=Vector2.new(1,0) ValLbl.Size=UDim2.new(.4,0,0,16)
                ValLbl.Position=UDim2.new(1,0,0,8) ValLbl.Text=tostring(Cur)..Suf
                ValLbl.TextColor3=T.Accent ValLbl.Font=Enum.Font.GothamMedium ValLbl.TextSize=10
                ValLbl.TextXAlignment=Enum.TextXAlignment.Right ValLbl.TextYAlignment=Enum.TextYAlignment.Center
                ValLbl.ZIndex=15 ValLbl.Parent=Row Reg(ValLbl,"TextColor3","Accent")
                local TBg=Instance.new("Frame") TBg.BackgroundColor3=T.SliderTrack
                TBg.BorderSizePixel=0 TBg.AnchorPoint=Vector2.new(0,1)
                TBg.Size=UDim2.new(1,0,0,3) TBg.Position=UDim2.new(0,0,1,-10)
                TBg.ZIndex=15 TBg.Parent=Row Corner(TBg,2) Reg(TBg,"BackgroundColor3","SliderTrack")
                local InitPct=(Cur-Mn)/math.max(Mx-Mn,.0001)
                local TFill=Instance.new("Frame") TFill.BackgroundColor3=T.SliderFill
                TFill.BorderSizePixel=0 TFill.Size=UDim2.new(InitPct,0,1,0)
                TFill.ZIndex=16 TFill.Parent=TBg Corner(TFill,2) Reg(TFill,"BackgroundColor3","SliderFill")
                local TGrad=Instance.new("UIGradient")
                TGrad.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(180,180,255))}
                TGrad.Transparency=NumberSequence.new{NumberSequenceKeypoint.new(0,.3),NumberSequenceKeypoint.new(1,0)}
                TGrad.Parent=TFill
                local ThumbSc=Instance.new("UIScale")
                local Thumb=Instance.new("Frame") Thumb.BackgroundColor3=T.White
                Thumb.BorderSizePixel=0 Thumb.AnchorPoint=Vector2.new(.5,.5)
                Thumb.Size=UDim2.new(0,12,0,12) Thumb.Position=UDim2.new(InitPct,0,.5,0)
                Thumb.ZIndex=17 Thumb.Parent=TBg Corner(Thumb,6) Reg(Thumb,"BackgroundColor3","White")
                ThumbSc.Scale=1 ThumbSc.Parent=Thumb
                local ThSt=Stroke(Thumb,T.Accent,1.5) Reg(ThSt,"Color","Accent")
                local Sliding=false
                local function Calc(Pos)
                    local Ab=TBg.AbsolutePosition local Sz=TBg.AbsoluteSize
                    local Pct=math.clamp((Pos.X-Ab.X)/Sz.X,0,1)
                    return math.clamp(math.round((Mn+Pct*(Mx-Mn))/Inc)*Inc,Mn,Mx)
                end
                local function Apply(V,Anim)
                    Cur=V local Pct=(V-Mn)/math.max(Mx-Mn,.0001)
                    if Anim then Tw(TFill,{Size=UDim2.new(Pct,0,1,0)},.12) Tw(Thumb,{Position=UDim2.new(Pct,0,.5,0)},.12)
                    else TFill.Size=UDim2.new(Pct,0,1,0) Thumb.Position=UDim2.new(Pct,0,.5,0) end
                    ValLbl.Text=tostring(V)..Suf
                end
                local Hit=Instance.new("TextButton") Hit.BackgroundTransparency=1
                Hit.Size=UDim2.new(1,0,1,0) Hit.Text="" Hit.ZIndex=18 Hit.Parent=Row
                Hit.InputBegan:Connect(function(Inp)
                    if Inp.UserInputType==Enum.UserInputType.MouseButton1 or Inp.UserInputType==Enum.UserInputType.Touch then
                        Sliding=true local V=Calc(Inp.Position) Apply(V,false) Cb(V)
                        Tw(ThumbSc,{Scale=1.3},.22,Enum.EasingStyle.Quint)
                    end
                end)
                UserInputService.InputChanged:Connect(function(Inp)
                    if not Sliding then return end
                    if Inp.UserInputType~=Enum.UserInputType.MouseMovement and Inp.UserInputType~=Enum.UserInputType.Touch then return end
                    local V=Calc(Inp.Position) Apply(V,false)
                    Thumb.Position=UDim2.new((V-Mn)/math.max(Mx-Mn,.0001),0,.5,0) Cb(V)
                end)
                UserInputService.InputEnded:Connect(function(Inp)
                    if not Sliding then return end
                    if Inp.UserInputType==Enum.UserInputType.MouseButton1 or Inp.UserInputType==Enum.UserInputType.Touch then
                        Sliding=false Tw(ThumbSc,{Scale=1},.28,Enum.EasingStyle.Quint)
                    end
                end)
                local Obj={} Obj.Value={Set=function(_,V) Apply(math.clamp(V,Mn,Mx),true) Cb(Cur) end}
                Obj.Name={Set=function(_,N) TtlLbl.Text=N end}
                return Obj
            end

            function SecObj:CreateLabel(Content)
                Content=Content or ""
                local Row=MkRow(26)
                local Lbl=Instance.new("TextLabel") Lbl.BackgroundTransparency=1
                Lbl.AnchorPoint=Vector2.new(0,.5) Lbl.Size=UDim2.new(1,0,0,12)
                Lbl.Position=UDim2.new(0,0,.5,0) Lbl.Text=Content
                Lbl.TextColor3=T.SubText Lbl.Font=Enum.Font.Gotham Lbl.TextSize=11
                Lbl.TextXAlignment=Enum.TextXAlignment.Left Lbl.TextYAlignment=Enum.TextYAlignment.Center
                Lbl.ZIndex=15 Lbl.Parent=Row Reg(Lbl,"TextColor3","SubText")
                local Obj={} Obj.Value={Set=function(_,V) Lbl.Text=V end}
                return Obj
            end

            function SecObj:CreateParagraph(Cfg2)
                Cfg2=Cfg2 or {}
                local Ptl=Cfg2.Title or "" local Pct=Cfg2.Content or ""
                SecObj._rowN=SecObj._rowN+1 local N=SecObj._rowN
                if N>1 then MkSep(N) end
                local Fr=Instance.new("Frame") Fr.BackgroundTransparency=1
                Fr.Size=UDim2.new(1,0,0,0) Fr.AutomaticSize=Enum.AutomaticSize.Y
                Fr.ZIndex=14 Fr.LayoutOrder=N*10 Fr.Parent=Card
                Pad(Fr,8,12,8,12)
                local FL=Instance.new("UIListLayout") FL.FillDirection=Enum.FillDirection.Vertical
                FL.SortOrder=Enum.SortOrder.LayoutOrder FL.Padding=UDim.new(0,4) FL.Parent=Fr
                local TLbl=nil
                if Ptl~="" then
                    TLbl=Instance.new("TextLabel") TLbl.BackgroundTransparency=1
                    TLbl.Size=UDim2.new(1,0,0,0) TLbl.AutomaticSize=Enum.AutomaticSize.Y
                    TLbl.Text=Ptl TLbl.TextColor3=T.Text TLbl.Font=Enum.Font.GothamMedium TLbl.TextSize=12
                    TLbl.TextWrapped=true TLbl.TextXAlignment=Enum.TextXAlignment.Left
                    TLbl.LayoutOrder=1 TLbl.ZIndex=15 TLbl.Parent=Fr
                    Reg(TLbl,"TextColor3","Text")
                end
                local CLbl=Instance.new("TextLabel") CLbl.BackgroundTransparency=1
                CLbl.Size=UDim2.new(1,0,0,0) CLbl.AutomaticSize=Enum.AutomaticSize.Y
                CLbl.Text=Pct CLbl.TextColor3=T.SubText CLbl.Font=Enum.Font.Gotham CLbl.TextSize=9
                CLbl.TextWrapped=true CLbl.TextXAlignment=Enum.TextXAlignment.Left
                CLbl.LayoutOrder=2 CLbl.ZIndex=15 CLbl.Parent=Fr
                Reg(CLbl,"TextColor3","SubText")
                local Obj={} Obj.Title={Set=function(_,V) if TLbl then TLbl.Text=V end end}
                Obj.Content={Set=function(_,V) CLbl.Text=V end}
                return Obj
            end

            return SecObj
        end
        return TabObj
    end
    return WindowObj
end

return Library

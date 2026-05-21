local Library = {}
Library.__index = Library

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local HttpService      = game:GetService("HttpService")

local function ResolveIcon(Id)
	if type(Id) == "number" then return "rbxassetid://" .. tostring(Id), true end
	if type(Id) == "string" then
		if Id:match("^%d+$") then return "rbxassetid://" .. Id, true end
		if Id:match("^rbxassetid://") then return Id, true end
	end
	return "", false
end

local function NewSignal()
	local Listeners = {}
	local Sig = {}
	function Sig:Fire(V)
		for I = #Listeners, 1, -1 do
			local L = Listeners[I]
			if L.Once then table.remove(Listeners, I) end
			task.spawn(L.Fn, V)
		end
	end
	function Sig:Connect(Fn)
		local L = {Fn = Fn, Once = false}
		table.insert(Listeners, L)
		return {Disconnect = function()
			for I, V in ipairs(Listeners) do if V == L then table.remove(Listeners, I) return end end
		end}
	end
	function Sig:Once(Fn) table.insert(Listeners, {Fn = Fn, Once = true}) end
	function Sig:Wait()
		local T = coroutine.running()
		Sig:Once(function(V) task.spawn(T, V) end)
		return coroutine.yield()
	end
	function Sig:Pipe(SetterFn) return Sig:Connect(function(V) SetterFn(nil, V) end) end
	return Sig
end

local function LerpColor(A, B, Alpha)
	return Color3.new(A.R + (B.R - A.R) * Alpha, A.G + (B.G - A.G) * Alpha, A.B + (B.B - A.B) * Alpha)
end

local function BlendThemes(ThemeA, ThemeB, Alpha)
	local Out = {}
	for K, V in pairs(ThemeA) do Out[K] = ThemeB[K] and LerpColor(V, ThemeB[K], Alpha) or V end
	return Out
end

local function GetKeyName(Key)
	if type(Key) ~= "userdata" then return "?" end
	local N = tostring(Key):match("%.([^%.]+)$") or tostring(Key)
	if N == "MouseButton1" then return "LMB" elseif N == "MouseButton2" then return "RMB" else return N end
end

local Themes = {
	Onyx = {
		BG = Color3.fromRGB(16,16,22), Sidebar = Color3.fromRGB(22,22,30), HeaderBG = Color3.fromRGB(22,22,30),
		SectionBG = Color3.fromRGB(28,28,38), SecTitle = Color3.fromRGB(80,82,115), Text = Color3.fromRGB(228,230,245),
		SubText = Color3.fromRGB(96,98,132), Separator = Color3.fromRGB(40,42,58), Accent = Color3.fromRGB(0,152,255),
		AccentDark = Color3.fromRGB(0,112,210), ToggleOn = Color3.fromRGB(0,152,255), ToggleOff = Color3.fromRGB(40,42,58),
		SliderTrack = Color3.fromRGB(40,42,58), SliderFill = Color3.fromRGB(0,152,255), White = Color3.fromRGB(255,255,255),
		PressHL = Color3.fromRGB(34,34,46), TabActive = Color3.fromRGB(0,152,255), TabInactive = Color3.fromRGB(80,82,115),
		TabActiveBG = Color3.fromRGB(30,32,46), Handle = Color3.fromRGB(52,54,74), DropHL = Color3.fromRGB(28,30,42),
	},
	Phantom = {
		BG = Color3.fromRGB(10,8,16), Sidebar = Color3.fromRGB(16,14,24), HeaderBG = Color3.fromRGB(16,14,24),
		SectionBG = Color3.fromRGB(22,18,34), SecTitle = Color3.fromRGB(110,85,160), Text = Color3.fromRGB(225,218,248),
		SubText = Color3.fromRGB(110,85,155), Separator = Color3.fromRGB(38,30,58), Accent = Color3.fromRGB(162,102,255),
		AccentDark = Color3.fromRGB(122,72,218), ToggleOn = Color3.fromRGB(162,102,255), ToggleOff = Color3.fromRGB(42,34,64),
		SliderTrack = Color3.fromRGB(42,34,64), SliderFill = Color3.fromRGB(162,102,255), White = Color3.fromRGB(225,218,248),
		PressHL = Color3.fromRGB(30,24,46), TabActive = Color3.fromRGB(162,102,255), TabInactive = Color3.fromRGB(110,85,155),
		TabActiveBG = Color3.fromRGB(30,22,50), Handle = Color3.fromRGB(60,48,92), DropHL = Color3.fromRGB(26,20,40),
	},
	Arctic = {
		BG = Color3.fromRGB(240,244,252), Sidebar = Color3.fromRGB(228,234,248), HeaderBG = Color3.fromRGB(228,234,248),
		SectionBG = Color3.fromRGB(255,255,255), SecTitle = Color3.fromRGB(110,122,168), Text = Color3.fromRGB(18,22,44),
		SubText = Color3.fromRGB(112,124,170), Separator = Color3.fromRGB(204,210,232), Accent = Color3.fromRGB(0,112,230),
		AccentDark = Color3.fromRGB(0,84,196), ToggleOn = Color3.fromRGB(0,112,230), ToggleOff = Color3.fromRGB(204,210,232),
		SliderTrack = Color3.fromRGB(204,210,232), SliderFill = Color3.fromRGB(0,112,230), White = Color3.fromRGB(255,255,255),
		PressHL = Color3.fromRGB(218,224,244), TabActive = Color3.fromRGB(0,112,230), TabInactive = Color3.fromRGB(112,124,170),
		TabActiveBG = Color3.fromRGB(214,224,248), Handle = Color3.fromRGB(182,192,222), DropHL = Color3.fromRGB(232,237,252),
	},
}

local T = Themes.Onyx

local function Tw(O, P, Time, Style, Dir) TweenService:Create(O, TweenInfo.new(Time or .26, Style or Enum.EasingStyle.Quint, Dir or Enum.EasingDirection.Out), P):Play() end
local function TwBack(O, P, Time) TweenService:Create(O, TweenInfo.new(Time or .40, Enum.EasingStyle.Back, Enum.EasingDirection.Out), P):Play() end
local function TwLinear(O, P, Time) TweenService:Create(O, TweenInfo.new(Time or .14, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), P):Play() end

local function Corner(Parent, R)
	local C = Instance.new("UICorner"); C.CornerRadius = UDim.new(0, R or 8); C.Parent = Parent; return C
end
local function Stroke(Parent, Color, Thick)
	local S = Instance.new("UIStroke"); S.Color = Color; S.Thickness = Thick or 1; S.Parent = Parent; return S
end
local function Pad(Parent, Top, Right, Bottom, Left)
	local P = Instance.new("UIPadding")
	P.PaddingTop = UDim.new(0, Top or 0); P.PaddingRight = UDim.new(0, Right or 0)
	P.PaddingBottom = UDim.new(0, Bottom or 0); P.PaddingLeft = UDim.new(0, Left or 0)
	P.Parent = Parent
end

function Library:CreateWindow(Config)
	Config = Config or {}
	local Title        = Config.Title           or "Menu"
	local Subtitle     = Config.SubTitle        or ""
	local LoadTitle    = Config.LoadingTitle    or "Loading"
	local LoadSub      = Config.LoadingSubtitle or "Please wait…"
	local LoadImage    = Config.LoadingImage
	local ThemeName    = Config.Theme           or "Onyx"
	local ShowBtnImage = Config.ShowBtnImage

	T = Themes[ThemeName] or Themes.Onyx

	local Nodes     = {}
	local Registry  = {}

	local function Register(O, P, K) if O and P and K then table.insert(Nodes, {O=O,P=P,K=K}) end end
	local function RegisterFn(Fn) if Fn then table.insert(Nodes, {Fn=Fn}) end end
	local function RegComp(Id, GetFn, SetFn) if Id then Registry[Id] = {Get=GetFn, Set=SetFn} end end

	local Gui = Instance.new("ScreenGui")
	Gui.Name = "NexusUI"; Gui.ResetOnSpawn = false
	Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling; Gui.IgnoreGuiInset = true
	if not pcall(function() Gui.Parent = gethui() end) then
		Gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
	end

	local function GetWinSize()
		local Sw, Sh = Gui.AbsoluteSize.X, Gui.AbsoluteSize.Y
		return math.clamp(math.floor(Sw*.66),272,450), math.clamp(math.floor(Sh*.62),290,432)
	end

	local LoadBG = Instance.new("Frame")
	LoadBG.BackgroundColor3 = Color3.fromRGB(10,10,16); LoadBG.BorderSizePixel = 0
	LoadBG.Size = UDim2.new(1,0,1,0); LoadBG.ZIndex = 200; LoadBG.Parent = Gui
	local LoadGrad = Instance.new("UIGradient")
	LoadGrad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(14,10,24)),ColorSequenceKeypoint.new(1,Color3.fromRGB(6,6,12))}
	LoadGrad.Rotation = 135; LoadGrad.Parent = LoadBG

	local LoadCenter = Instance.new("Frame")
	LoadCenter.BackgroundTransparency = 1; LoadCenter.Size = UDim2.new(0,240,0,200)
	LoadCenter.Position = UDim2.new(.5,-120,.5,-100); LoadCenter.ZIndex = 201; LoadCenter.Parent = LoadBG

	local LoadOffset = 0
	if LoadImage then
		local Img, Ok = ResolveIcon(LoadImage)
		if Ok then
			local IL = Instance.new("ImageLabel")
			IL.BackgroundColor3 = Color3.fromRGB(22,22,32); IL.BorderSizePixel = 0
			IL.Size = UDim2.new(0,72,0,72); IL.Position = UDim2.new(.5,-36,0,0)
			IL.Image = Img; IL.ScaleType = Enum.ScaleType.Fit; IL.ZIndex = 202; IL.Parent = LoadCenter
			Corner(IL,16); Stroke(IL,Color3.fromRGB(50,50,80),1)
		end
		LoadOffset = 86
	end

	local function MkLbl(Parent, Text, Color, Font, Size, XAlign, PosX, PosY, W, H, ZI, AutoY)
		local L = Instance.new("TextLabel")
		L.BackgroundTransparency = 1; L.Text = Text; L.TextColor3 = Color
		L.Font = Font; L.TextSize = Size; L.TextXAlignment = XAlign
		L.Size = UDim2.new(W or 1, 0, 0, H or 0); L.Position = UDim2.new(PosX or 0, 0, PosY or 0, 0)
		L.ZIndex = ZI or 1; if AutoY then L.AutomaticSize = Enum.AutomaticSize.Y end
		L.Parent = Parent; return L
	end

	MkLbl(LoadCenter, LoadTitle, Color3.fromRGB(230,230,250), Enum.Font.GothamBold, 13, Enum.TextXAlignment.Center, 0, 0, 1, 22, 202).Position = UDim2.new(0,0,0,LoadOffset+4)
	MkLbl(LoadCenter, LoadSub, Color3.fromRGB(88,88,120), Enum.Font.Gotham, 9, Enum.TextXAlignment.Center, 0, 0, 1, 16, 202).Position = UDim2.new(0,0,0,LoadOffset+30)

	local BarBG = Instance.new("Frame")
	BarBG.BackgroundColor3 = Color3.fromRGB(28,28,40); BarBG.BorderSizePixel = 0
	BarBG.Size = UDim2.new(0,160,0,3); BarBG.Position = UDim2.new(.5,-80,0,LoadOffset+64); BarBG.ZIndex = 202; BarBG.Parent = LoadCenter; Corner(BarBG,2)

	local BarFill = Instance.new("Frame")
	BarFill.BackgroundColor3 = T.Accent; BarFill.BorderSizePixel = 0
	BarFill.Size = UDim2.new(0,0,1,0); BarFill.ZIndex = 203; BarFill.Parent = BarBG; Corner(BarFill,2)
	local BG2 = Instance.new("UIGradient")
	BG2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,T.Accent)}; BG2.Parent = BarFill
	local BarConn = RunService.Heartbeat:Connect(function() BarFill.Size = UDim2.new(tick()%2/2,0,1,0) end)

	local WinW, WinH = GetWinSize()
	local SideW, HeadH = 88, 40

	local Win = Instance.new("Frame")
	Win.Name = "Window"; Win.BackgroundColor3 = T.BG; Win.BorderSizePixel = 0
	Win.Size = UDim2.new(0,WinW,0,WinH); Win.Position = UDim2.new(.5,-WinW/2,.5,-WinH/2)
	Win.ClipsDescendants = true; Win.Visible = false; Win.ZIndex = 10; Win.Parent = Gui
	Corner(Win,14); Register(Win,"BackgroundColor3","BG")
	local WinScale = Instance.new("UIScale"); WinScale.Scale = 1; WinScale.Parent = Win
	Register(Stroke(Win,T.Separator,1),"Color","Separator")

	local Sidebar = Instance.new("Frame")
	Sidebar.Name = "Sidebar"; Sidebar.BackgroundColor3 = T.Sidebar; Sidebar.BorderSizePixel = 0
	Sidebar.Size = UDim2.new(0,SideW,1,0); Sidebar.ZIndex = 12; Sidebar.Parent = Win
	Register(Sidebar,"BackgroundColor3","Sidebar")
	local SidebarLine = Instance.new("Frame")
	SidebarLine.BackgroundColor3 = T.Separator; SidebarLine.BorderSizePixel = 0
	SidebarLine.Size = UDim2.new(0,1,1,0); SidebarLine.Position = UDim2.new(1,-1,0,0); SidebarLine.ZIndex = 13; SidebarLine.Parent = Sidebar
	Register(SidebarLine,"BackgroundColor3","Separator")

	local SideTop = Instance.new("Frame")
	SideTop.BackgroundTransparency = 1; SideTop.Size = UDim2.new(1,0,0,HeadH); SideTop.ZIndex = 13; SideTop.Parent = Sidebar
	Pad(SideTop,0,8,0,8)

	local SideLogo = nil
	if LoadImage then
		local Img, Ok = ResolveIcon(LoadImage)
		if Ok then
			SideLogo = Instance.new("ImageLabel")
			SideLogo.BackgroundTransparency = 1; SideLogo.AnchorPoint = Vector2.new(.5,.5)
			SideLogo.Size = UDim2.new(0,22,0,22); SideLogo.Position = UDim2.new(.5,0,.5,0)
			SideLogo.Image = Img; SideLogo.ScaleType = Enum.ScaleType.Fit; SideLogo.ZIndex = 14; SideLogo.Parent = SideTop
		end
	end
	if not SideLogo then
		local ST = Instance.new("TextLabel")
		ST.BackgroundTransparency = 1; ST.AnchorPoint = Vector2.new(.5,.5)
		ST.Size = UDim2.new(1,-4,0,20); ST.Position = UDim2.new(.5,0,.5,Subtitle~="" and -4 or 0)
		ST.Text = Title; ST.TextColor3 = T.Text; ST.Font = Enum.Font.GothamBold; ST.TextSize = 9
		ST.TextXAlignment = Enum.TextXAlignment.Center; ST.TextTruncate = Enum.TextTruncate.AtEnd; ST.ZIndex = 14; ST.Parent = SideTop
		Register(ST,"TextColor3","Text")
		if Subtitle ~= "" then
			local SS = Instance.new("TextLabel")
			SS.BackgroundTransparency = 1; SS.AnchorPoint = Vector2.new(.5,.5)
			SS.Size = UDim2.new(1,-4,0,12); SS.Position = UDim2.new(.5,0,.5,10)
			SS.Text = Subtitle; SS.TextColor3 = T.SubText; SS.Font = Enum.Font.Gotham; SS.TextSize = 8
			SS.TextXAlignment = Enum.TextXAlignment.Center; SS.TextTruncate = Enum.TextTruncate.AtEnd; SS.ZIndex = 14; SS.Parent = SideTop
			Register(SS,"TextColor3","SubText")
		end
	end

	local SideTabLine = Instance.new("Frame")
	SideTabLine.BackgroundColor3 = T.Separator; SideTabLine.BorderSizePixel = 0
	SideTabLine.Size = UDim2.new(1,-16,0,1); SideTabLine.Position = UDim2.new(0,8,0,HeadH-1); SideTabLine.ZIndex = 13; SideTabLine.Parent = Sidebar
	Register(SideTabLine,"BackgroundColor3","Separator")

	local SideAccent = Instance.new("Frame")
	SideAccent.BackgroundColor3 = T.Accent; SideAccent.BorderSizePixel = 0
	SideAccent.Size = UDim2.new(0,28,0,2); SideAccent.AnchorPoint = Vector2.new(.5,0); SideAccent.Position = UDim2.new(.5,0,0,0)
	SideAccent.ZIndex = 16; SideAccent.Parent = Sidebar; Corner(SideAccent,1); Register(SideAccent,"BackgroundColor3","Accent")

	local TabScroll = Instance.new("ScrollingFrame")
	TabScroll.BackgroundTransparency = 1; TabScroll.BorderSizePixel = 0
	TabScroll.Size = UDim2.new(1,0,1,-HeadH); TabScroll.Position = UDim2.new(0,0,0,HeadH)
	TabScroll.CanvasSize = UDim2.new(0,0,0,0); TabScroll.ScrollBarThickness = 0
	TabScroll.ScrollingDirection = Enum.ScrollingDirection.Y; TabScroll.ZIndex = 13; TabScroll.Parent = Sidebar
	Pad(TabScroll,6,0,6,0)
	local TabLayout = Instance.new("UIListLayout")
	TabLayout.FillDirection = Enum.FillDirection.Vertical; TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
	TabLayout.Padding = UDim.new(0,2); TabLayout.Parent = TabScroll
	TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabScroll.CanvasSize = UDim2.new(0,0,0,TabLayout.AbsoluteContentSize.Y+12)
	end)

	local MainArea = Instance.new("Frame")
	MainArea.BackgroundTransparency = 1; MainArea.Size = UDim2.new(1,-SideW,1,0)
	MainArea.Position = UDim2.new(0,SideW,0,0); MainArea.ClipsDescendants = true; MainArea.ZIndex = 11; MainArea.Parent = Win

	local ContentArea = Instance.new("Frame")
	ContentArea.BackgroundTransparency = 1; ContentArea.Size = UDim2.new(1,0,1,0)
	ContentArea.ZIndex = 11; ContentArea.ClipsDescendants = true; ContentArea.Parent = MainArea

	local FadeOverlay = Instance.new("Frame")
	FadeOverlay.BackgroundColor3 = T.BG; FadeOverlay.BackgroundTransparency = 1; FadeOverlay.BorderSizePixel = 0
	FadeOverlay.Size = UDim2.new(1,0,1,0); FadeOverlay.ZIndex = 50; FadeOverlay.Parent = ContentArea
	Register(FadeOverlay,"BackgroundColor3","BG")

	local CloseOverlay = Instance.new("Frame")
	CloseOverlay.BackgroundColor3 = T.BG; CloseOverlay.BackgroundTransparency = 1; CloseOverlay.BorderSizePixel = 0
	CloseOverlay.Size = UDim2.new(1,0,1,0); CloseOverlay.ZIndex = 200; CloseOverlay.Parent = Win
	Corner(CloseOverlay,14); Register(CloseOverlay,"BackgroundColor3","BG")

	local NotifyCont = Instance.new("Frame")
	NotifyCont.BackgroundTransparency = 1; NotifyCont.AnchorPoint = Vector2.new(1,1)
	NotifyCont.Size = UDim2.new(0,240,1,0); NotifyCont.Position = UDim2.new(1,-10,1,0); NotifyCont.ZIndex = 600; NotifyCont.Parent = Gui
	local NotifyLayout = Instance.new("UIListLayout")
	NotifyLayout.FillDirection = Enum.FillDirection.Vertical; NotifyLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
	NotifyLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right; NotifyLayout.SortOrder = Enum.SortOrder.LayoutOrder
	NotifyLayout.Padding = UDim.new(0,6); NotifyLayout.Parent = NotifyCont
	Pad(NotifyCont,0,0,14,0)

	local BtnAsset = (function() local R, Ok = ResolveIcon(ShowBtnImage); return Ok and R or "rbxassetid://85798284091961" end)()
	local ShowBtn = Instance.new("ImageButton")
	ShowBtn.Image = BtnAsset; ShowBtn.ScaleType = Enum.ScaleType.Fit; ShowBtn.ImageColor3 = T.Accent
	ShowBtn.BackgroundColor3 = T.Sidebar; ShowBtn.BorderSizePixel = 0; ShowBtn.Size = UDim2.new(0,48,0,48)
	ShowBtn.AnchorPoint = Vector2.new(.5,0); ShowBtn.Position = UDim2.new(.5,0,0,14); ShowBtn.ZIndex = 100; ShowBtn.Visible = false; ShowBtn.Parent = Gui
	Corner(ShowBtn,14); Register(ShowBtn,"BackgroundColor3","Sidebar"); Register(ShowBtn,"ImageColor3","Accent")
	Register(Stroke(ShowBtn,T.Accent,1.8),"Color","Accent")
	local ShowBtnScale = Instance.new("UIScale"); ShowBtnScale.Scale = 1; ShowBtnScale.Parent = ShowBtn

	local WinShown = false

	local function DoShow()
		WinShown = true; local Wp = Win.Position
		Win.Visible = true; Win.Position = UDim2.new(Wp.X.Scale,Wp.X.Offset,Wp.Y.Scale,Wp.Y.Offset+32); WinScale.Scale = .82
		TweenService:Create(Win,TweenInfo.new(.64,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(Wp.X.Scale,Wp.X.Offset,Wp.Y.Scale,Wp.Y.Offset)}):Play()
		TweenService:Create(WinScale,TweenInfo.new(.80,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
	end
	local function DoHide()
		WinShown = false; local Wp = Win.Position
		Tw(CloseOverlay,{BackgroundTransparency=0},.22,Enum.EasingStyle.Quint)
		TweenService:Create(WinScale,TweenInfo.new(.50,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Scale=.86}):Play()
		TweenService:Create(Win,TweenInfo.new(.50,Enum.EasingStyle.Quint,Enum.EasingDirection.In),{Position=UDim2.new(Wp.X.Scale,Wp.X.Offset,Wp.Y.Scale,Wp.Y.Offset-14)}):Play()
		task.delay(.56,function() Win.Visible=false; CloseOverlay.BackgroundTransparency=1; Win.Position=Wp; WinScale.Scale=1 end)
	end

	ShowBtn.MouseButton1Down:Connect(function() TweenService:Create(ShowBtnScale,TweenInfo.new(.10,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Scale=.84}):Play() end)
	ShowBtn.MouseButton1Up:Connect(function() TweenService:Create(ShowBtnScale,TweenInfo.new(.48,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play() end)
	ShowBtn.MouseButton1Click:Connect(function() if WinShown then DoHide() else DoShow() end end)

	local IsDragging, DragStart, StartPos = false, nil, nil
	Sidebar.InputBegan:Connect(function(I)
		if I.UserInputType == Enum.UserInputType.MouseButton1 or I.UserInputType == Enum.UserInputType.Touch then
			IsDragging = true; DragStart = I.Position; StartPos = Win.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(I)
		if not IsDragging then return end
		if I.UserInputType ~= Enum.UserInputType.MouseMovement and I.UserInputType ~= Enum.UserInputType.Touch then return end
		local D = I.Position - DragStart
		Win.Position = UDim2.new(StartPos.X.Scale,StartPos.X.Offset+D.X,StartPos.Y.Scale,StartPos.Y.Offset+D.Y)
	end)
	UserInputService.InputEnded:Connect(function(I)
		if I.UserInputType == Enum.UserInputType.MouseButton1 or I.UserInputType == Enum.UserInputType.Touch then IsDragging = false end
	end)

	task.spawn(function()
		task.wait(2.4); BarConn:Disconnect()
		Tw(LoadBG,{BackgroundTransparency=1},.42,Enum.EasingStyle.Quint)
		for _,D in ipairs(LoadBG:GetDescendants()) do
			if D:IsA("GuiObject") then
				local P = {BackgroundTransparency=1}
				if D:IsA("TextLabel") then P.TextTransparency=1 end
				if D:IsA("ImageLabel") then P.ImageTransparency=1 end
				Tw(D,P,.32,Enum.EasingStyle.Quint)
			end
		end
		task.wait(.48); LoadBG:Destroy(); ShowBtn.Visible = true
		WinShown = true; local Nw,Nh = GetWinSize()
		Win.Visible = true; Win.Position = UDim2.new(.5,-Nw/2,.5,-Nh/2+32); WinScale.Scale = .82
		TweenService:Create(Win,TweenInfo.new(.72,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(.5,-Nw/2,.5,-Nh/2)}):Play()
		TweenService:Create(WinScale,TweenInfo.new(.88,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
	end)

	local WinObj   = {}
	local AllTabs  = {}
	local TabCount = 0
	local NotifyN  = 0

	local function FlushNodes()
		local Live = {}
		for _,N in ipairs(Nodes) do
			if N.Fn then N.Fn(); Live[#Live+1]=N
			elseif N.O and N.O.Parent then
				local V = T[N.K]; if V then Tw(N.O,{[N.P]=V},.28) end; Live[#Live+1]=N
			end
		end
		Nodes = Live
		for _,TD in ipairs(AllTabs) do
			local Col = TD.Content.Visible and T.TabActive or T.TabInactive
			Tw(TD.Label,{TextColor3=Col},.28)
			if TD.Icon then Tw(TD.Icon,{[TD.Icon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"]=Col},.28) end
		end
	end

	function WinObj:SetTheme(Name)
		T = Themes[Name] or Themes.Onyx; FlushNodes()
	end

	function WinObj:BlendTheme(A, B, Alpha)
		T = BlendThemes(Themes[A] or Themes.Onyx, Themes[B] or Themes.Onyx, math.clamp(Alpha or 0,0,1)); FlushNodes()
	end

	function WinObj:GetProfile()
		local D = {}
		for Id,E in pairs(Registry) do local Ok,V = pcall(E.Get); if Ok then D[Id]=V end end
		local Ok,Enc = pcall(HttpService.JSONEncode, HttpService, D)
		return Ok and Enc or "{}"
	end

	function WinObj:LoadProfile(Str)
		local Ok,D = pcall(HttpService.JSONDecode, HttpService, Str)
		if not Ok or type(D) ~= "table" then return end
		for Id,V in pairs(D) do if Registry[Id] then pcall(Registry[Id].Set, V) end end
	end

	function WinObj:Notify(Cfg)
		Cfg = Cfg or {}
		local NTitle = Cfg.Title or "Notification"; local NDesc = Cfg.Description or ""
		local NDur   = Cfg.Duration or 3; local NType = Cfg.Type or "Info"
		NotifyN = NotifyN + 1; local NIdx = NotifyN
		local TypeColors = {Info=T.Accent, Success=Color3.fromRGB(46,204,96), Warning=Color3.fromRGB(255,180,40), Error=Color3.fromRGB(230,50,72)}
		local AC = TypeColors[NType] or T.Accent

		local Card = Instance.new("Frame")
		Card.BackgroundColor3 = T.SectionBG; Card.BackgroundTransparency = 1; Card.BorderSizePixel = 0
		Card.Size = UDim2.new(1,0,0,0); Card.AutomaticSize = Enum.AutomaticSize.Y
		Card.LayoutOrder = NIdx; Card.ClipsDescendants = true; Card.ZIndex = 601; Card.Parent = NotifyCont
		Corner(Card,8); Stroke(Card,T.Separator,.8)

		local AB = Instance.new("Frame"); AB.BackgroundColor3 = AC; AB.BorderSizePixel = 0
		AB.Size = UDim2.new(0,3,1,0); AB.ZIndex = 602; AB.Parent = Card; Corner(AB,2)

		local Inner = Instance.new("Frame"); Inner.BackgroundTransparency = 1
		Inner.Size = UDim2.new(1,-14,0,0); Inner.AutomaticSize = Enum.AutomaticSize.Y
		Inner.Position = UDim2.new(0,14,0,0); Inner.ZIndex = 602; Inner.Parent = Card
		Pad(Inner,8,6,8,4)
		local IL = Instance.new("UIListLayout"); IL.FillDirection = Enum.FillDirection.Vertical; IL.SortOrder = Enum.SortOrder.LayoutOrder; IL.Padding = UDim.new(0,2); IL.Parent = Inner

		local TL = Instance.new("TextLabel"); TL.BackgroundTransparency=1; TL.Size=UDim2.new(1,0,0,14)
		TL.Text=NTitle; TL.TextColor3=T.Text; TL.Font=Enum.Font.GothamMedium; TL.TextSize=11
		TL.TextXAlignment=Enum.TextXAlignment.Left; TL.LayoutOrder=1; TL.ZIndex=603; TL.Parent=Inner

		if NDesc ~= "" then
			local DL = Instance.new("TextLabel"); DL.BackgroundTransparency=1; DL.Size=UDim2.new(1,0,0,0)
			DL.AutomaticSize=Enum.AutomaticSize.Y; DL.Text=NDesc; DL.TextColor3=T.SubText
			DL.Font=Enum.Font.Gotham; DL.TextSize=9; DL.TextWrapped=true
			DL.TextXAlignment=Enum.TextXAlignment.Left; DL.LayoutOrder=2; DL.ZIndex=603; DL.Parent=Inner
		end

		local PBG = Instance.new("Frame"); PBG.BackgroundColor3=T.Separator; PBG.BorderSizePixel=0
		PBG.Size=UDim2.new(1,0,0,2); PBG.Position=UDim2.new(0,0,1,-2); PBG.ZIndex=602; PBG.Parent=Card; Corner(PBG,1)
		local PF = Instance.new("Frame"); PF.BackgroundColor3=AC; PF.BorderSizePixel=0
		PF.Size=UDim2.new(1,0,1,0); PF.ZIndex=603; PF.Parent=PBG; Corner(PF,1)

		Card.Position = UDim2.new(1,16,0,0)
		TweenService:Create(Card,TweenInfo.new(.36,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0),BackgroundTransparency=0}):Play()
		TweenService:Create(PF,TweenInfo.new(NDur,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{Size=UDim2.new(0,0,1,0)}):Play()
		task.delay(NDur,function()
			if not Card.Parent then return end
			Tw(Card,{BackgroundTransparency=1,Position=UDim2.new(1,16,0,0)},.26,Enum.EasingStyle.Quint)
			task.delay(.30,function() if Card.Parent then Card:Destroy() end end)
		end)
	end

	local function DeactivateAll()
		for _,TD in ipairs(AllTabs) do
			TD.Content.Visible = false
			Tw(TD.Label,{TextColor3=T.TabInactive},.20)
			Tw(TD.Pill,{BackgroundTransparency=1,Size=UDim2.new(0,3,0,18)},.24,Enum.EasingStyle.Quint)
			Tw(TD.PillColor,{BackgroundColor3=T.TabActiveBG},.20)
			TD.PillColor.BackgroundTransparency = 1
			if TD.Icon then
				local Prop = TD.Icon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"
				Tw(TD.Icon,{[Prop]=T.TabInactive},.20)
			end
		end
	end

	function WinObj:CreateTab(TabCfg)
		TabCfg = TabCfg or {}
		local TabTitle = TabCfg.Title or "Tab"
		TabCount = TabCount + 1; local Idx = TabCount

		local TabBtn = Instance.new("TextButton")
		TabBtn.BackgroundTransparency=1; TabBtn.Size=UDim2.new(1,0,0,26); TabBtn.Text=""
		TabBtn.ZIndex=14; TabBtn.LayoutOrder=Idx; TabBtn.Parent=TabScroll; Pad(TabBtn,0,8,0,8)

		local PillBG = Instance.new("Frame")
		PillBG.BackgroundColor3=T.TabActiveBG; PillBG.BackgroundTransparency=1; PillBG.BorderSizePixel=0
		PillBG.Size=UDim2.new(1,0,1,0); PillBG.ZIndex=13; PillBG.Parent=TabBtn; Corner(PillBG,7)

		local Pill = Instance.new("Frame")
		Pill.BackgroundColor3=T.TabActive; Pill.BorderSizePixel=0; Pill.AnchorPoint=Vector2.new(0,.5)
		Pill.Size=UDim2.new(0,3,0,18); Pill.Position=UDim2.new(0,0,.5,0); Pill.BackgroundTransparency=1
		Pill.ZIndex=15; Pill.Parent=TabBtn; Corner(Pill,2); Register(Pill,"BackgroundColor3","TabActive")

		local TabLbl = Instance.new("TextLabel")
		TabLbl.BackgroundTransparency=1; TabLbl.AnchorPoint=Vector2.new(0,.5)
		TabLbl.Size=UDim2.new(1,-14,0,12); TabLbl.Position=UDim2.new(0,8,.5,0)
		TabLbl.Text=TabTitle; TabLbl.TextColor3=T.TabInactive; TabLbl.Font=Enum.Font.GothamMedium
		TabLbl.TextSize=9; TabLbl.TextXAlignment=Enum.TextXAlignment.Left; TabLbl.TextYAlignment=Enum.TextYAlignment.Center
		TabLbl.ZIndex=15; TabLbl.Parent=TabBtn

		local TabFrame = Instance.new("Frame")
		TabFrame.Name="Tab_"..Idx; TabFrame.BackgroundTransparency=1; TabFrame.Size=UDim2.new(1,0,1,0)
		TabFrame.Visible=false; TabFrame.ZIndex=11; TabFrame.Parent=ContentArea

		local ColPad,ColGap,ColTop,ColBot = 8,6,12,14

		local function MkScroll(ScaleX, OffX, PosX)
			local S = Instance.new("ScrollingFrame")
			S.BackgroundTransparency=1; S.BorderSizePixel=0
			S.Size=UDim2.new(ScaleX,-ColGap/2-ColPad,1,0); S.Position=UDim2.new(PosX,OffX,0,0)
			S.CanvasSize=UDim2.new(0,0,0,0); S.ScrollBarThickness=0
			S.ScrollingDirection=Enum.ScrollingDirection.Y; S.ZIndex=11; S.Parent=TabFrame
			local Inner = Instance.new("Frame"); Inner.BackgroundTransparency=1; Inner.Size=UDim2.new(1,0,0,0)
			Inner.AutomaticSize=Enum.AutomaticSize.Y; Inner.ZIndex=12; Inner.Parent=S
			local L = Instance.new("UIListLayout"); L.FillDirection=Enum.FillDirection.Vertical
			L.SortOrder=Enum.SortOrder.LayoutOrder; L.Padding=UDim.new(0,0); L.Parent=Inner
			Pad(Inner,ColTop,0,ColBot,0)
			L:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				S.CanvasSize=UDim2.new(0,0,0,L.AbsoluteContentSize.Y+ColTop+ColBot)
			end)
			return Inner
		end

		local LeftInner  = MkScroll(.5, ColPad, 0)
		local RightInner = MkScroll(.5, ColGap/2, .5)

		local TabData = {Btn=TabBtn, Content=TabFrame, Label=TabLbl, Icon=nil, Pill=Pill, PillColor=PillBG}
		table.insert(AllTabs, TabData)

		local function ActivateThis()
			DeactivateAll()
			FadeOverlay.BackgroundTransparency = .55; FadeOverlay.ZIndex = 50
			TweenService:Create(FadeOverlay,TweenInfo.new(.48,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency=1}):Play()
			TabFrame.Visible=true; TabFrame.Position=UDim2.new(.05,0,0,0)
			TweenService:Create(TabFrame,TweenInfo.new(.40,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Position=UDim2.new(0,0,0,0)}):Play()
			TweenService:Create(TabLbl,TweenInfo.new(.22,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextColor3=T.TabActive}):Play()
			PillBG.BackgroundTransparency=1
			TweenService:Create(PillBG,TweenInfo.new(.30,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play()
			Pill.BackgroundTransparency=1; Pill.Size=UDim2.new(0,3,0,8)
			TweenService:Create(Pill,TweenInfo.new(.56,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{BackgroundTransparency=0,Size=UDim2.new(0,3,0,18)}):Play()
		end

		TabBtn.MouseButton1Click:Connect(ActivateThis)
		TabBtn.MouseButton1Down:Connect(function() Tw(PillBG,{BackgroundTransparency=.5},.08) end)
		TabBtn.MouseButton1Up:Connect(function()
			Tw(PillBG,{BackgroundTransparency=TabFrame.Visible and 0 or 1},.18)
		end)
		if Idx == 1 then ActivateThis() end

		local TabObj       = {}
		local SectionCount = 0

		function TabObj:CreateSection(SecCfg)
			SecCfg = SecCfg or {}
			local SecTitle = SecCfg.Title    or "Section"
			local SecPos   = (SecCfg.Position or "left"):lower()
			SectionCount   = SectionCount + 1
			local SecOrder = SectionCount
			local ParentCol = SecPos=="right" and RightInner or LeftInner

			local Wrapper = Instance.new("Frame")
			Wrapper.BackgroundTransparency=1; Wrapper.Size=UDim2.new(1,0,0,0); Wrapper.AutomaticSize=Enum.AutomaticSize.Y
			Wrapper.LayoutOrder=SecOrder; Wrapper.ZIndex=13; Wrapper.Parent=ParentCol
			local WL = Instance.new("UIListLayout"); WL.FillDirection=Enum.FillDirection.Vertical; WL.SortOrder=Enum.SortOrder.LayoutOrder; WL.Padding=UDim.new(0,0); WL.Parent=Wrapper

			local TopSp = Instance.new("Frame"); TopSp.BackgroundTransparency=1; TopSp.Size=UDim2.new(1,0,0,10); TopSp.LayoutOrder=0; TopSp.ZIndex=13; TopSp.Parent=Wrapper

			local HeadWrap = Instance.new("Frame"); HeadWrap.BackgroundTransparency=1; HeadWrap.Size=UDim2.new(1,0,0,14); HeadWrap.LayoutOrder=1; HeadWrap.ZIndex=13; HeadWrap.Parent=Wrapper; Pad(HeadWrap,0,2,0,4)
			local HeadLbl = Instance.new("TextLabel"); HeadLbl.BackgroundTransparency=1; HeadLbl.Size=UDim2.new(1,0,1,0)
			HeadLbl.Text=SecTitle:upper(); HeadLbl.TextColor3=T.SecTitle; HeadLbl.Font=Enum.Font.GothamBold; HeadLbl.TextSize=7
			HeadLbl.TextXAlignment=Enum.TextXAlignment.Left; HeadLbl.TextYAlignment=Enum.TextYAlignment.Center; HeadLbl.ZIndex=14; HeadLbl.Parent=HeadWrap
			Register(HeadLbl,"TextColor3","SecTitle")

			local HeadSp = Instance.new("Frame"); HeadSp.BackgroundTransparency=1; HeadSp.Size=UDim2.new(1,0,0,3); HeadSp.LayoutOrder=2; HeadSp.ZIndex=13; HeadSp.Parent=Wrapper

			local Card = Instance.new("Frame")
			Card.BackgroundColor3=T.SectionBG; Card.BorderSizePixel=0; Card.Size=UDim2.new(1,0,0,0)
			Card.AutomaticSize=Enum.AutomaticSize.Y; Card.ClipsDescendants=true; Card.LayoutOrder=3; Card.ZIndex=13; Card.Parent=Wrapper
			Corner(Card,8); Register(Card,"BackgroundColor3","SectionBG"); Register(Stroke(Card,T.Separator,.6),"Color","Separator")
			local CardScale = Instance.new("UIScale"); CardScale.Scale=.84; CardScale.Parent=Card; Card.BackgroundTransparency=1
			task.delay((SectionCount-1)*.07,function()
				TweenService:Create(Card,TweenInfo.new(.38,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency=0}):Play()
				TweenService:Create(CardScale,TweenInfo.new(.64,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
			end)
			local CL = Instance.new("UIListLayout"); CL.FillDirection=Enum.FillDirection.Vertical; CL.SortOrder=Enum.SortOrder.LayoutOrder; CL.Padding=UDim.new(0,0); CL.Parent=Card

			local BotSp = Instance.new("Frame"); BotSp.BackgroundTransparency=1; BotSp.Size=UDim2.new(1,0,0,8); BotSp.LayoutOrder=4; BotSp.ZIndex=13; BotSp.Parent=Wrapper

			local SecObj = {}; SecObj._Card=Card; SecObj._RowN=0

			local function MkRow(H, AutoY)
				SecObj._RowN = SecObj._RowN + 1; local N = SecObj._RowN
				local Group = Instance.new("Frame"); Group.BackgroundTransparency=1; Group.BorderSizePixel=0
				Group.Size=UDim2.new(1,0,0,0); Group.AutomaticSize=Enum.AutomaticSize.Y; Group.ZIndex=14; Group.LayoutOrder=N*10; Group.Parent=Card
				local GL = Instance.new("UIListLayout"); GL.FillDirection=Enum.FillDirection.Vertical; GL.SortOrder=Enum.SortOrder.LayoutOrder; GL.Padding=UDim.new(0,0); GL.Parent=Group
				if N > 1 then
					local SW = Instance.new("Frame"); SW.BackgroundTransparency=1; SW.BorderSizePixel=0; SW.Size=UDim2.new(1,0,0,1); SW.ZIndex=15; SW.LayoutOrder=1; SW.Parent=Group
					local Sep = Instance.new("Frame"); Sep.BackgroundColor3=T.Separator; Sep.BorderSizePixel=0; Sep.Size=UDim2.new(1,-16,1,0); Sep.Position=UDim2.new(0,13,0,0); Sep.ZIndex=15; Sep.Parent=SW
					Register(Sep,"BackgroundColor3","Separator")
				end
				local Row = Instance.new("Frame"); Row.BackgroundTransparency=1; Row.BorderSizePixel=0; Row.ZIndex=14; Row.LayoutOrder=2; Row.Parent=Group
				if AutoY then Row.Size=UDim2.new(1,0,0,0); Row.AutomaticSize=Enum.AutomaticSize.Y else Row.Size=UDim2.new(1,0,0,H or 40) end
				Pad(Row,0,12,0,12)
				return Row, Group
			end

			local function RowPress(R) Tw(R,{BackgroundColor3=T.PressHL},.06); R.BackgroundTransparency=0 end
			local function RowRelease(R) Tw(R,{BackgroundColor3=T.SectionBG},.28,Enum.EasingStyle.Quint); task.delay(.28,function() R.BackgroundTransparency=1 end) end

			function SecObj:CreateToggle(Cfg)
				Cfg = Cfg or {}
				local Title2   = Cfg.Title    or "Toggle"
				local Default  = Cfg.Default ~= nil and Cfg.Default or false
				local Callback = Cfg.Callback or function() end
				local Row, Grp = MkRow(32)
				local Changed  = NewSignal()
				local State    = Default
				local Busy     = false

				local Lbl = Instance.new("TextLabel"); Lbl.BackgroundTransparency=1; Lbl.AnchorPoint=Vector2.new(0,.5)
				Lbl.Size=UDim2.new(1,-40,0,12); Lbl.Position=UDim2.new(0,0,.5,0); Lbl.Text=Title2
				Lbl.TextColor3=T.Text; Lbl.Font=Enum.Font.Gotham; Lbl.TextSize=12
				Lbl.TextXAlignment=Enum.TextXAlignment.Left; Lbl.TextYAlignment=Enum.TextYAlignment.Center; Lbl.ZIndex=15; Lbl.Parent=Row
				Register(Lbl,"TextColor3","Text")

				local Track = Instance.new("Frame"); Track.BackgroundColor3=Default and T.ToggleOn or T.ToggleOff
				Track.BorderSizePixel=0; Track.AnchorPoint=Vector2.new(1,.5); Track.Size=UDim2.new(0,30,0,18)
				Track.Position=UDim2.new(1,0,.5,0); Track.ZIndex=15; Track.Parent=Row; Corner(Track,9)

				local Thumb = Instance.new("Frame"); Thumb.BackgroundColor3=T.White; Thumb.BorderSizePixel=0
				Thumb.AnchorPoint=Vector2.new(0,.5); Thumb.Size=UDim2.new(0,14,0,14)
				Thumb.Position=Default and UDim2.new(0,14,.5,0) or UDim2.new(0,2,.5,0); Thumb.ZIndex=16; Thumb.Parent=Track; Corner(Thumb,7)
				Register(Thumb,"BackgroundColor3","White")
				local TS = Stroke(Thumb,Color3.fromRGB(0,0,0),.5); TS.Transparency=.84

				local function SetState(V, Anim)
					if Busy then return end; Busy=true; State=V
					local Tgt = V and UDim2.new(0,14,.5,0) or UDim2.new(0,2,.5,0)
					local Col = V and T.ToggleOn or T.ToggleOff
					if Anim then
						TweenService:Create(Track,TweenInfo.new(.26,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundColor3=Col}):Play()
						TweenService:Create(Thumb,TweenInfo.new(.08,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Size=UDim2.new(0,18,0,14)}):Play()
						task.delay(.08,function() TweenService:Create(Thumb,TweenInfo.new(.52,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Position=Tgt,Size=UDim2.new(0,14,0,14)}):Play() end)
					else Track.BackgroundColor3=Col; Thumb.Position=Tgt; Thumb.Size=UDim2.new(0,14,0,14) end
					task.delay(.54,function() Busy=false end)
				end
				RegisterFn(function() Tw(Track,{BackgroundColor3=State and T.ToggleOn or T.ToggleOff},.24) end)

				local Hit = Instance.new("TextButton"); Hit.BackgroundTransparency=1; Hit.Size=UDim2.new(1,0,1,0); Hit.Text=""; Hit.ZIndex=17; Hit.Parent=Row
				Hit.MouseButton1Click:Connect(function() SetState(not State,true); Callback(State); Changed:Fire(State) end)
				Hit.MouseButton1Down:Connect(function() RowPress(Row) end)
				Hit.MouseButton1Up:Connect(function() RowRelease(Row) end)

				RegComp(Title2.."_toggle", function() return State end,
					function(V) SetState(V==true or V=="true",true); Callback(State); Changed:Fire(State) end)

				local Obj = {}
				Obj.Value   = {Set=function(_,V) SetState(V,true); Callback(V); Changed:Fire(V) end}
				Obj.Name    = {Set=function(_,N) Lbl.Text=N end}
				Obj.GetValue = function() return State end
				Obj.Changed = Changed
				Obj.BindTo  = function(_,Sig,Pred) Sig:Connect(function(V) Grp.Visible=Pred(V) end) end
				return Obj
			end

			function SecObj:CreateButton(Cfg)
				Cfg = Cfg or {}
				local Title2   = Cfg.Title    or "Button"
				local Callback = Cfg.Callback or function() end
				local Row, Grp = MkRow(30)
				local Scale    = Instance.new("UIScale"); Scale.Scale=1; Scale.Parent=Row
				local Pressed  = NewSignal()

				local Lbl = Instance.new("TextLabel"); Lbl.BackgroundTransparency=1; Lbl.AnchorPoint=Vector2.new(.5,.5)
				Lbl.Size=UDim2.new(1,0,0,14); Lbl.Position=UDim2.new(.5,0,.5,0); Lbl.Text=Title2
				Lbl.TextColor3=T.Accent; Lbl.Font=Enum.Font.GothamMedium; Lbl.TextSize=12
				Lbl.TextXAlignment=Enum.TextXAlignment.Center; Lbl.TextYAlignment=Enum.TextYAlignment.Center; Lbl.ZIndex=15; Lbl.Parent=Row
				Register(Lbl,"TextColor3","Accent")

				local Hit = Instance.new("TextButton"); Hit.BackgroundTransparency=1; Hit.Size=UDim2.new(1,0,1,0); Hit.Text=""; Hit.ZIndex=16; Hit.Parent=Row
				Hit.MouseButton1Down:Connect(function() RowPress(Row); Tw(Lbl,{TextColor3=T.AccentDark},.07); TwLinear(Scale,{Scale=.94},.10) end)
				Hit.MouseButton1Up:Connect(function() RowRelease(Row); Tw(Lbl,{TextColor3=T.Accent},.24); TwBack(Scale,{Scale=1},.38) end)
				Hit.MouseButton1Click:Connect(function() Callback(); Pressed:Fire() end)

				local Obj = {}
				Obj.Name    = {Set=function(_,N) Lbl.Text=N end}
				Obj.Pressed = Pressed
				Obj.BindTo  = function(_,Sig,Pred) Sig:Connect(function(V) Grp.Visible=Pred(V) end) end
				return Obj
			end

			function SecObj:CreateDropdown(Cfg)
				Cfg = Cfg or {}
				local Title2   = Cfg.Title    or "Dropdown"
				local Options  = Cfg.Options  or {}
				local InitSel  = Cfg.Selected or {}
				local Multi    = Cfg.Multi    or false
				local Callback = Cfg.Callback or function() end
				local SelMap   = {}

				for _,V in ipairs(InitSel) do SelMap[V]=true end
				if not Multi and not next(SelMap) and #Options>0 then SelMap[Options[1]]=true end

				local function GetSelText()
					local Parts={}; for K,V in pairs(SelMap) do if V then Parts[#Parts+1]=K end end
					if #Parts==0 then return "None" end; table.sort(Parts); return table.concat(Parts,", ")
				end

				local IsOpen    = false
				local CurOpts   = {table.unpack(Options)}
				local Row, Grp  = MkRow(32)
				local Changed   = NewSignal()

				local TLbl = Instance.new("TextLabel"); TLbl.BackgroundTransparency=1; TLbl.AnchorPoint=Vector2.new(0,.5)
				TLbl.Size=UDim2.new(1,-76,0,14); TLbl.Position=UDim2.new(0,0,.5,0); TLbl.Text=Title2
				TLbl.TextColor3=T.Text; TLbl.Font=Enum.Font.Gotham; TLbl.TextSize=10
				TLbl.TextXAlignment=Enum.TextXAlignment.Left; TLbl.TextYAlignment=Enum.TextYAlignment.Center; TLbl.ZIndex=15; TLbl.Parent=Row
				Register(TLbl,"TextColor3","Text")

				local SLbl = Instance.new("TextLabel"); SLbl.BackgroundTransparency=1; SLbl.AnchorPoint=Vector2.new(1,.5)
				SLbl.Size=UDim2.new(0,54,0,14); SLbl.Position=UDim2.new(1,-16,.5,0); SLbl.Text=GetSelText()
				SLbl.TextColor3=T.SubText; SLbl.Font=Enum.Font.Gotham; SLbl.TextSize=11
				SLbl.TextXAlignment=Enum.TextXAlignment.Right; SLbl.TextYAlignment=Enum.TextYAlignment.Center
				SLbl.TextTruncate=Enum.TextTruncate.AtEnd; SLbl.ZIndex=15; SLbl.Parent=Row
				Register(SLbl,"TextColor3","SubText")

				local Chev = Instance.new("TextLabel"); Chev.BackgroundTransparency=1; Chev.AnchorPoint=Vector2.new(1,.5)
				Chev.Size=UDim2.new(0,14,0,14); Chev.Position=UDim2.new(1,0,.5,0); Chev.Text="›"
				Chev.TextColor3=T.SubText; Chev.Font=Enum.Font.GothamBold; Chev.TextSize=18
				Chev.TextXAlignment=Enum.TextXAlignment.Center; Chev.TextYAlignment=Enum.TextYAlignment.Center; Chev.ZIndex=15; Chev.Parent=Row
				Register(Chev,"TextColor3","SubText")

				local Panel = Instance.new("Frame"); Panel.BackgroundColor3=T.SectionBG; Panel.BorderSizePixel=0
				Panel.Size=UDim2.new(1,0,0,0); Panel.ClipsDescendants=true; Panel.ZIndex=20; Panel.Visible=false; Panel.LayoutOrder=3; Panel.Parent=Grp
				Register(Panel,"BackgroundColor3","SectionBG")
				local PScroll = Instance.new("ScrollingFrame"); PScroll.BackgroundTransparency=1; PScroll.BorderSizePixel=0
				PScroll.Size=UDim2.new(1,0,1,0); PScroll.CanvasSize=UDim2.new(0,0,0,0); PScroll.ScrollBarThickness=3
				PScroll.ScrollBarImageColor3=T.Accent; PScroll.ScrollingDirection=Enum.ScrollingDirection.Y; PScroll.ZIndex=21; PScroll.Parent=Panel
				Register(PScroll,"ScrollBarImageColor3","Accent")
				local PList = Instance.new("UIListLayout"); PList.FillDirection=Enum.FillDirection.Vertical; PList.SortOrder=Enum.SortOrder.LayoutOrder; PList.Parent=PScroll
				PList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() PScroll.CanvasSize=UDim2.new(0,0,0,PList.AbsoluteContentSize.Y) end)

				local OptBtns={} ; local PanelH=0

				local function RebuildOpts(Opts)
					for _,B in ipairs(OptBtns) do B:Destroy() end; OptBtns={}
					for I,Opt in ipairs(Opts) do
						if I>1 then
							local SW=Instance.new("Frame"); SW.BackgroundTransparency=1; SW.BorderSizePixel=0; SW.Size=UDim2.new(1,0,0,1); SW.ZIndex=22; SW.LayoutOrder=I*10-5; SW.Parent=PScroll; table.insert(OptBtns,SW)
							local SL=Instance.new("Frame"); SL.BackgroundColor3=T.Separator; SL.BorderSizePixel=0; SL.Size=UDim2.new(1,-16,1,0); SL.Position=UDim2.new(0,13,0,0); SL.ZIndex=22; SL.Parent=SW; Register(SL,"BackgroundColor3","Separator")
						end
						local OB=Instance.new("TextButton"); OB.BackgroundTransparency=1; OB.Size=UDim2.new(1,0,0,30); OB.Text=""; OB.ZIndex=22; OB.LayoutOrder=I*10; OB.Parent=PScroll; table.insert(OptBtns,OB); Pad(OB,0,12,0,12)
						local OS=Instance.new("UIScale"); OS.Scale=1; OS.Parent=OB
						local OL=Instance.new("TextLabel"); OL.Name="OptionLabel"; OL.BackgroundTransparency=1; OL.AnchorPoint=Vector2.new(0,.5); OL.Size=UDim2.new(1,-22,0,14); OL.Position=UDim2.new(0,0,.5,0); OL.Text=Opt; OL.TextColor3=T.Text; OL.Font=Enum.Font.Gotham; OL.TextSize=12; OL.TextXAlignment=Enum.TextXAlignment.Left; OL.TextYAlignment=Enum.TextYAlignment.Center; OL.ZIndex=23; OL.Parent=OB; Register(OL,"TextColor3","Text")
						local CK=Instance.new("TextLabel"); CK.Name="Checkmark"; CK.BackgroundTransparency=1; CK.AnchorPoint=Vector2.new(1,.5); CK.Size=UDim2.new(0,18,0,14); CK.Position=UDim2.new(1,0,.5,0); CK.Text=SelMap[Opt] and "✓" or ""; CK.TextColor3=T.Accent; CK.Font=Enum.Font.GothamBold; CK.TextSize=12; CK.TextXAlignment=Enum.TextXAlignment.Center; CK.TextYAlignment=Enum.TextYAlignment.Center; CK.ZIndex=23; CK.Parent=OB; Register(CK,"TextColor3","Accent")
						OB.BackgroundTransparency=1; OL.TextTransparency=1; OL.Position=UDim2.new(.06,0,.5,0)
						task.delay((I-1)*.04,function() if OB.Parent then TweenService:Create(OL,TweenInfo.new(.22,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{TextTransparency=0,Position=UDim2.new(0,0,.5,0)}):Play() end end)
						OB.MouseButton1Down:Connect(function() TwLinear(OB,{BackgroundColor3=T.PressHL},.06); OB.BackgroundTransparency=0; TwLinear(OS,{Scale=.96},.07) end)
						OB.MouseButton1Up:Connect(function() Tw(OB,{BackgroundColor3=T.SectionBG},.26); task.delay(.26,function() OB.BackgroundTransparency=1 end); TwBack(OS,{Scale=1},.34) end)
						OB.MouseButton1Click:Connect(function()
							if Multi then SelMap[Opt]=not SelMap[Opt]; CK.Text=SelMap[Opt] and "✓" or ""
							else
								for _,O2 in ipairs(Opts) do SelMap[O2]=false end; SelMap[Opt]=true
								for _,B2 in ipairs(OptBtns) do if B2:IsA("TextButton") then local Ck=B2:FindFirstChild("Checkmark"); local Ol=B2:FindFirstChild("OptionLabel"); if Ck and Ol then Ck.Text=SelMap[Ol.Text] and "✓" or "" end end end
							end
							SLbl.Text=GetSelText(); local Res={}; for K,V in pairs(SelMap) do if V then Res[#Res+1]=K end end
							Callback(Res); Changed:Fire(Res)
							if not Multi then IsOpen=false; Tw(Panel,{Size=UDim2.new(1,0,0,0)},.24,Enum.EasingStyle.Quint); task.delay(.25,function() Panel.Visible=false end); TwBack(Chev,{Rotation=0},.30) end
						end)
					end
					PanelH = math.min(#Opts*30+(#Opts>1 and #Opts-1 or 0),150)
					return PanelH
				end
				RebuildOpts(CurOpts)

				local Hit=Instance.new("TextButton"); Hit.BackgroundTransparency=1; Hit.Size=UDim2.new(1,0,1,0); Hit.Text=""; Hit.ZIndex=16; Hit.Parent=Row
				Hit.MouseButton1Down:Connect(function() RowPress(Row) end)
				Hit.MouseButton1Up:Connect(function() RowRelease(Row) end)
				Hit.MouseButton1Click:Connect(function()
					IsOpen=not IsOpen
					if IsOpen then Panel.Visible=true; Panel.Size=UDim2.new(1,0,0,0); Tw(Panel,{Size=UDim2.new(1,0,0,PanelH)},.38,Enum.EasingStyle.Quint); TwBack(Chev,{Rotation=90},.34)
					else Tw(Panel,{Size=UDim2.new(1,0,0,0)},.24,Enum.EasingStyle.Quint); task.delay(.25,function() Panel.Visible=false end); TwBack(Chev,{Rotation=0},.30) end
				end)

				local function GetSelArray() local R={}; for K,V in pairs(SelMap) do if V then R[#R+1]=K end end; return R end
				RegComp(Title2.."_dropdown", GetSelArray, function(V) SelMap={}; if type(V)=="table" then for _,S in ipairs(V) do SelMap[S]=true end end; SLbl.Text=GetSelText(); RebuildOpts(CurOpts) end)

				local Obj={}
				Obj.Name    = {Set=function(_,N) TLbl.Text=N end}
				Obj.Options = {Set=function(_,NewOpts) CurOpts=NewOpts; SelMap={}; if not Multi and #NewOpts>0 then SelMap[NewOpts[1]]=true end; RebuildOpts(NewOpts); SLbl.Text=GetSelText() end}
				Obj.Value   = {Set=function(_,V) SelMap={}; if type(V)=="table" then for _,S in ipairs(V) do SelMap[S]=true end elseif type(V)=="string" then SelMap[V]=true end; SLbl.Text=GetSelText(); RebuildOpts(CurOpts) end}
				Obj.GetValue = GetSelArray; Obj.Changed=Changed
				Obj.BindTo  = function(_,Sig,Pred) Sig:Connect(function(V) local Show=Pred(V); Grp.Visible=Show; if not Show then IsOpen=false; Panel.Visible=false; Chev.Rotation=0 end end) end
				return Obj
			end

			function SecObj:CreateSlider(Cfg)
				Cfg = Cfg or {}
				local Title2   = Cfg.Title     or "Slider"
				local Range    = Cfg.Range     or {0,100}
				local Min,Max  = Range[1] or 0, Range[2] or 100
				local Default  = math.clamp(Cfg.Default or Min, Min, Max)
				local Incr     = Cfg.Increment or 1
				local Suffix   = Cfg.Suffix    or ""
				local Callback = Cfg.Callback  or function() end
				local Current  = Default
				local Row,Grp  = MkRow(43)
				local Changed  = NewSignal()

				local TLbl = Instance.new("TextLabel"); TLbl.BackgroundTransparency=1; TLbl.AnchorPoint=Vector2.new(0,0); TLbl.Size=UDim2.new(.6,0,0,16); TLbl.Position=UDim2.new(0,0,0,8); TLbl.Text=Title2; TLbl.TextColor3=T.Text; TLbl.Font=Enum.Font.Gotham; TLbl.TextSize=12; TLbl.TextXAlignment=Enum.TextXAlignment.Left; TLbl.TextYAlignment=Enum.TextYAlignment.Center; TLbl.ZIndex=15; TLbl.Parent=Row; Register(TLbl,"TextColor3","Text")
				local VLbl = Instance.new("TextLabel"); VLbl.BackgroundTransparency=1; VLbl.AnchorPoint=Vector2.new(1,0); VLbl.Size=UDim2.new(.4,0,0,16); VLbl.Position=UDim2.new(1,0,0,8); VLbl.Text=tostring(Current)..Suffix; VLbl.TextColor3=T.Accent; VLbl.Font=Enum.Font.GothamMedium; VLbl.TextSize=10; VLbl.TextXAlignment=Enum.TextXAlignment.Right; VLbl.TextYAlignment=Enum.TextYAlignment.Center; VLbl.ZIndex=15; VLbl.Parent=Row; Register(VLbl,"TextColor3","Accent")

				local TBG = Instance.new("Frame"); TBG.BackgroundColor3=T.SliderTrack; TBG.BorderSizePixel=0; TBG.AnchorPoint=Vector2.new(0,1); TBG.Size=UDim2.new(1,0,0,3); TBG.Position=UDim2.new(0,0,1,-10); TBG.ZIndex=15; TBG.Parent=Row; Corner(TBG,2); Register(TBG,"BackgroundColor3","SliderTrack")
				local InitPct = (Current-Min)/math.max(Max-Min,.0001)
				local TFill = Instance.new("Frame"); TFill.BackgroundColor3=T.SliderFill; TFill.BorderSizePixel=0; TFill.Size=UDim2.new(InitPct,0,1,0); TFill.ZIndex=16; TFill.Parent=TBG; Corner(TFill,2); Register(TFill,"BackgroundColor3","SliderFill")
				local TGrad = Instance.new("UIGradient"); TGrad.Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(180,180,255))}; TGrad.Transparency=NumberSequence.new{NumberSequenceKeypoint.new(0,.3),NumberSequenceKeypoint.new(1,0)}; TGrad.Parent=TFill
				local ThScale = Instance.new("UIScale"); local Thumb = Instance.new("Frame"); Thumb.BackgroundColor3=T.White; Thumb.BorderSizePixel=0; Thumb.AnchorPoint=Vector2.new(.5,.5); Thumb.Size=UDim2.new(0,12,0,12); Thumb.Position=UDim2.new(InitPct,0,.5,0); Thumb.ZIndex=17; Thumb.Parent=TBG; Corner(Thumb,6); Register(Thumb,"BackgroundColor3","White"); ThScale.Scale=1; ThScale.Parent=Thumb; Register(Stroke(Thumb,T.Accent,1.5),"Color","Accent")

				local Sliding = false
				local function CalcVal(Pos)
					local Ab,Sz = TBG.AbsolutePosition, TBG.AbsoluteSize
					local Pct = math.clamp((Pos.X-Ab.X)/Sz.X,0,1)
					return math.clamp(math.round((Min+Pct*(Max-Min))/Incr)*Incr,Min,Max)
				end
				local function ApplyVal(V, Anim)
					Current=V; local Pct=(V-Min)/math.max(Max-Min,.0001)
					if Anim then Tw(TFill,{Size=UDim2.new(Pct,0,1,0)},.14); Tw(Thumb,{Position=UDim2.new(Pct,0,.5,0)},.14)
					else TFill.Size=UDim2.new(Pct,0,1,0); Thumb.Position=UDim2.new(Pct,0,.5,0) end
					VLbl.Text=tostring(V)..Suffix
				end

				local Hit=Instance.new("TextButton"); Hit.BackgroundTransparency=1; Hit.Size=UDim2.new(1,0,1,0); Hit.Text=""; Hit.ZIndex=18; Hit.Parent=Row
				Hit.InputBegan:Connect(function(I)
					if I.UserInputType==Enum.UserInputType.MouseButton1 or I.UserInputType==Enum.UserInputType.Touch then
						Sliding=true; local V=CalcVal(I.Position); ApplyVal(V,false); Callback(V); Changed:Fire(V); TwBack(ThScale,{Scale=1.32},.28)
					end
				end)
				UserInputService.InputChanged:Connect(function(I)
					if not Sliding then return end
					if I.UserInputType~=Enum.UserInputType.MouseMovement and I.UserInputType~=Enum.UserInputType.Touch then return end
					local V=CalcVal(I.Position); ApplyVal(V,false); Callback(V); Changed:Fire(V)
				end)
				UserInputService.InputEnded:Connect(function(I)
					if not Sliding then return end
					if I.UserInputType==Enum.UserInputType.MouseButton1 or I.UserInputType==Enum.UserInputType.Touch then Sliding=false; TwBack(ThScale,{Scale=1},.36) end
				end)

				RegComp(Title2.."_slider", function() return Current end,
					function(V) local N=tonumber(V); if N then local C=math.clamp(N,Min,Max); ApplyVal(C,true); Callback(C); Changed:Fire(C) end end)

				local Obj={}
				Obj.Value    = {Set=function(_,V) ApplyVal(math.clamp(V,Min,Max),true); Callback(Current); Changed:Fire(Current) end}
				Obj.Name     = {Set=function(_,N) TLbl.Text=N end}
				Obj.GetValue = function() return Current end
				Obj.Changed  = Changed
				Obj.BindTo   = function(_,Sig,Pred) Sig:Connect(function(V) Grp.Visible=Pred(V) end) end
				return Obj
			end

			function SecObj:CreateKeybind(Cfg)
				Cfg = Cfg or {}
				local Title2   = Cfg.Title    or "Keybind"
				local Default  = Cfg.Default  or Enum.KeyCode.Unknown
				local Callback = Cfg.Callback or function() end
				local Row, Grp = MkRow(32)
				local Current  = Default; local Listening = false; local ListenConn = nil
				local Changed  = NewSignal()

				local TLbl = Instance.new("TextLabel"); TLbl.BackgroundTransparency=1; TLbl.AnchorPoint=Vector2.new(0,.5); TLbl.Size=UDim2.new(1,-68,0,12); TLbl.Position=UDim2.new(0,0,.5,0); TLbl.Text=Title2; TLbl.TextColor3=T.Text; TLbl.Font=Enum.Font.Gotham; TLbl.TextSize=12; TLbl.TextXAlignment=Enum.TextXAlignment.Left; TLbl.TextYAlignment=Enum.TextYAlignment.Center; TLbl.ZIndex=15; TLbl.Parent=Row; Register(TLbl,"TextColor3","Text")
				local Badge = Instance.new("Frame"); Badge.BackgroundColor3=T.SliderTrack; Badge.BorderSizePixel=0; Badge.AnchorPoint=Vector2.new(1,.5); Badge.Size=UDim2.new(0,58,0,20); Badge.Position=UDim2.new(1,0,.5,0); Badge.ZIndex=15; Badge.Parent=Row; Corner(Badge,4); Stroke(Badge,T.Separator,1); Register(Badge,"BackgroundColor3","SliderTrack")
				local BLbl = Instance.new("TextLabel"); BLbl.BackgroundTransparency=1; BLbl.Size=UDim2.new(1,0,1,0); BLbl.Text=GetKeyName(Current); BLbl.TextColor3=T.Accent; BLbl.Font=Enum.Font.GothamMedium; BLbl.TextSize=9; BLbl.TextXAlignment=Enum.TextXAlignment.Center; BLbl.ZIndex=16; BLbl.Parent=Badge; Register(BLbl,"TextColor3","Accent")

				local function CommitKey(I)
					if ListenConn then ListenConn:Disconnect() end; Listening=false
					Current = I.KeyCode~=Enum.KeyCode.Unknown and I.KeyCode or I.UserInputType
					BLbl.Text=GetKeyName(Current); Tw(Badge,{BackgroundColor3=T.SliderTrack},.24); Tw(BLbl,{TextColor3=T.Accent},.24)
					Callback(Current); Changed:Fire(Current)
				end
				local function StartListen()
					Listening=true; BLbl.Text="..."; Tw(Badge,{BackgroundColor3=T.Accent},.14); Tw(BLbl,{TextColor3=T.BG},.14)
					ListenConn = UserInputService.InputBegan:Connect(function(I,_)
						if not Listening then return end
						if I.KeyCode==Enum.KeyCode.Escape then if ListenConn then ListenConn:Disconnect() end; Listening=false; BLbl.Text=GetKeyName(Current); Tw(Badge,{BackgroundColor3=T.SliderTrack},.24); Tw(BLbl,{TextColor3=T.Accent},.24); return end
						if I.KeyCode==Enum.KeyCode.Unknown then if I.UserInputType==Enum.UserInputType.MouseButton1 or I.UserInputType==Enum.UserInputType.MouseButton2 then CommitKey(I) end; return end
						CommitKey(I)
					end)
				end

				local Hit=Instance.new("TextButton"); Hit.BackgroundTransparency=1; Hit.Size=UDim2.new(1,0,1,0); Hit.Text=""; Hit.ZIndex=17; Hit.Parent=Row
				Hit.MouseButton1Click:Connect(function()
					if not Listening then StartListen() else if ListenConn then ListenConn:Disconnect() end; Listening=false; BLbl.Text=GetKeyName(Current); Tw(Badge,{BackgroundColor3=T.SliderTrack},.24); Tw(BLbl,{TextColor3=T.Accent},.24) end
					RowPress(Row)
				end)
				Hit.MouseButton1Up:Connect(function() RowRelease(Row) end)

				local Obj={}
				Obj.Value    = {Set=function(_,V) Current=V; BLbl.Text=GetKeyName(Current) end}
				Obj.Name     = {Set=function(_,N) TLbl.Text=N end}
				Obj.GetValue = function() return Current end
				Obj.Changed  = Changed
				Obj.BindTo   = function(_,Sig,Pred) Sig:Connect(function(V) Grp.Visible=Pred(V) end) end
				return Obj
			end

			function SecObj:CreateLabel(Content)
				Content = Content or ""; local Row,_ = MkRow(26)
				local Lbl=Instance.new("TextLabel"); Lbl.BackgroundTransparency=1; Lbl.AnchorPoint=Vector2.new(0,.5); Lbl.Size=UDim2.new(1,0,0,12); Lbl.Position=UDim2.new(0,0,.5,0); Lbl.Text=Content; Lbl.TextColor3=T.SubText; Lbl.Font=Enum.Font.Gotham; Lbl.TextSize=11; Lbl.TextXAlignment=Enum.TextXAlignment.Left; Lbl.TextYAlignment=Enum.TextYAlignment.Center; Lbl.ZIndex=15; Lbl.Parent=Row
				Register(Lbl,"TextColor3","SubText")
				local Obj={}; Obj.Value={Set=function(_,V) Lbl.Text=V end}; return Obj
			end

			function SecObj:CreateParagraph(Cfg)
				Cfg = Cfg or {}
				local PTitle   = Cfg.Title   or ""
				local PContent = Cfg.Content or ""
				SecObj._RowN   = SecObj._RowN + 1; local N = SecObj._RowN
				if N>1 then
					local SW=Instance.new("Frame"); SW.BackgroundTransparency=1; SW.BorderSizePixel=0; SW.Size=UDim2.new(1,0,0,1); SW.ZIndex=15; SW.LayoutOrder=N*10-5; SW.Parent=Card
					local Sep=Instance.new("Frame"); Sep.BackgroundColor3=T.Separator; Sep.BorderSizePixel=0; Sep.Size=UDim2.new(1,-16,1,0); Sep.Position=UDim2.new(0,13,0,0); Sep.ZIndex=15; Sep.Parent=SW; Register(Sep,"BackgroundColor3","Separator")
				end
				local Cont=Instance.new("Frame"); Cont.BackgroundTransparency=1; Cont.Size=UDim2.new(1,0,0,0); Cont.AutomaticSize=Enum.AutomaticSize.Y; Cont.ZIndex=14; Cont.LayoutOrder=N*10; Cont.Parent=Card; Pad(Cont,8,12,8,12)
				local ContL=Instance.new("UIListLayout"); ContL.FillDirection=Enum.FillDirection.Vertical; ContL.SortOrder=Enum.SortOrder.LayoutOrder; ContL.Padding=UDim.new(0,4); ContL.Parent=Cont
				local TitleLbl=nil
				if PTitle~="" then
					TitleLbl=Instance.new("TextLabel"); TitleLbl.BackgroundTransparency=1; TitleLbl.Size=UDim2.new(1,0,0,0); TitleLbl.AutomaticSize=Enum.AutomaticSize.Y; TitleLbl.Text=PTitle; TitleLbl.TextColor3=T.Text; TitleLbl.Font=Enum.Font.GothamMedium; TitleLbl.TextSize=12; TitleLbl.TextWrapped=true; TitleLbl.TextXAlignment=Enum.TextXAlignment.Left; TitleLbl.LayoutOrder=1; TitleLbl.ZIndex=15; TitleLbl.Parent=Cont; Register(TitleLbl,"TextColor3","Text")
				end
				local CLbl=Instance.new("TextLabel"); CLbl.BackgroundTransparency=1; CLbl.Size=UDim2.new(1,0,0,0); CLbl.AutomaticSize=Enum.AutomaticSize.Y; CLbl.Text=PContent; CLbl.TextColor3=T.SubText; CLbl.Font=Enum.Font.Gotham; CLbl.TextSize=9; CLbl.TextWrapped=true; CLbl.TextXAlignment=Enum.TextXAlignment.Left; CLbl.LayoutOrder=2; CLbl.ZIndex=15; CLbl.Parent=Cont; Register(CLbl,"TextColor3","SubText")
				local Obj={}; Obj.Title={Set=function(_,V) if TitleLbl then TitleLbl.Text=V end end}; Obj.Content={Set=function(_,V) CLbl.Text=V end}; return Obj
			end

			return SecObj
		end
		return TabObj
	end
	return WinObj
end

return Library

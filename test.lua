-- =============================================================================
-- MURYSIUM ENHANCED v2.0 — Patched below. All original API preserved 100%.
-- NEW APIs (safe fallbacks mean old scripts never break):
--   Library.Flags                    → global value registry
--   Library.Version                  → "2.0.0"
--   Window:Notify({Title,Content,Duration,Type})
--   Window:SaveConfig(slot?)         → writefile JSON
--   Window:LoadConfig(slot?)         → readfile JSON
--   Window:OpenCommandPalette()      → Ctrl+K spotlight search
--   Section:CreateColorPicker(cfg)   → HSV + hex picker
--   Section:CreateKeybind(cfg)       → key recorder
--   Section:CreateInput(cfg)         → text input + validation
--   All elements: .Changed signal, :SetEnabled(bool), Name→Flags auto-reg
-- =============================================================================

-- Augment the returned Library table AFTER the original module is loaded.
-- The trick: wrap the original return value and bolt the new systems on.

-- ── Signal ────────────────────────────────────────────────────────────────────
Library.Flags   = Library.Flags   or {}
Library.Version = "2.0.0"

local _Signal = {}
_Signal.__index = _Signal
function _Signal.new()
    return setmetatable({_fns={},_seq=0}, _Signal)
end
function _Signal:Connect(fn)
    self._seq = self._seq + 1
    local id = self._seq
    self._fns[id] = fn
    return {Disconnect=function() self._fns[id]=nil end}
end
function _Signal:Fire(...)
    for _,fn in pairs(self._fns) do task.spawn(fn,...) end
end
Library._Signal = _Signal

-- ── Color helpers ─────────────────────────────────────────────────────────────
local function _C3ToHex(c)
    return ("%02X%02X%02X"):format(
        math.clamp(math.floor(c.R*255+.5),0,255),
        math.clamp(math.floor(c.G*255+.5),0,255),
        math.clamp(math.floor(c.B*255+.5),0,255))
end
local function _HexToC3(h)
    h=h:gsub("[^%x]","")
    if #h~=6 then return nil end
    return Color3.fromRGB(tonumber(h:sub(1,2),16),tonumber(h:sub(3,4),16),tonumber(h:sub(5,6),16))
end
Library._C3ToHex = _C3ToHex
Library._HexToC3 = _HexToC3

-- ── Wrap CreateWindow to inject new features ──────────────────────────────────
local _OrigCreateWindow = Library.CreateWindow
function Library:CreateWindow(Config)
    Config = Config or {}
    local Win = _OrigCreateWindow(self, Config)
    if not Win then return Win end   -- safety

    local TweenService = game:GetService("TweenService")
    local UIS          = game:GetService("UserInputService")
    local HttpService; pcall(function() HttpService=game:GetService("HttpService") end)
    local ConfigSlot   = Config.ConfigSlot or "default"
    local AutoSave     = Config.AutoSave   or false

    -- Find or make the ScreenGui
    local Gui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("MurysiumLegacy")
        or (pcall(function() return gethui():FindFirstChild("MurysiumLegacy") end) and gethui():FindFirstChild("MurysiumLegacy"))

    -- ── Notification container ────────────────────────────────────────────────
    local NotifHost = Instance.new("ScreenGui")
    NotifHost.Name         = "MurysiumNotifs"
    NotifHost.ResetOnSpawn = false
    NotifHost.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    NotifHost.IgnoreGuiInset = true
    local _ok = pcall(function() NotifHost.Parent = gethui() end)
    if not _ok then NotifHost.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end

    local NContainer = Instance.new("Frame")
    NContainer.BackgroundTransparency = 1
    NContainer.AnchorPoint           = Vector2.new(1,1)
    NContainer.Size                  = UDim2.new(0,260,1,-12)
    NContainer.Position              = UDim2.new(1,-10,1,0)
    NContainer.ZIndex                = 9000
    NContainer.Parent                = NotifHost
    local NLayout = Instance.new("UIListLayout")
    NLayout.FillDirection     = Enum.FillDirection.Vertical
    NLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    NLayout.SortOrder         = Enum.SortOrder.LayoutOrder
    NLayout.Padding           = UDim.new(0,5)
    NLayout.Parent            = NContainer

    local _nIdx = 0

    -- colours
    local _NC = {
        info    = Color3.fromRGB(0,152,255),
        success = Color3.fromRGB(46,204,96),
        warning = Color3.fromRGB(255,192,40),
        error   = Color3.fromRGB(230,50,72),
    }

    function Win:Notify(Cfg)
        Cfg = Cfg or {}
        local title   = Cfg.Title    or "Notification"
        local body    = Cfg.Content  or ""
        local dur     = Cfg.Duration or 4
        local ntype   = (Cfg.Type    or "info"):lower()
        local ac      = _NC[ntype] or _NC.info

        _nIdx = _nIdx+1
        local card = Instance.new("Frame")
        card.BackgroundColor3       = Color3.fromRGB(22,22,30)
        card.BackgroundTransparency = 1
        card.BorderSizePixel        = 0
        card.AutomaticSize          = Enum.AutomaticSize.Y
        card.Size                   = UDim2.new(1,0,0,0)
        card.ClipsDescendants       = false
        card.LayoutOrder            = _nIdx
        card.ZIndex                 = 9001
        card.Parent                 = NContainer
        local cc = Instance.new("UICorner"); cc.CornerRadius=UDim.new(0,8); cc.Parent=card
        local cs = Instance.new("UIStroke"); cs.Color=Color3.fromRGB(40,42,58); cs.Thickness=.8; cs.Parent=card

        -- accent bar
        local bar = Instance.new("Frame")
        bar.BackgroundColor3 = ac
        bar.BorderSizePixel  = 0
        bar.Size             = UDim2.new(0,3,1,-6)
        bar.AnchorPoint      = Vector2.new(0,.5)
        bar.Position         = UDim2.new(0,3,.5,0)
        bar.ZIndex           = 9002
        bar.Parent           = card
        local bc=Instance.new("UICorner");bc.CornerRadius=UDim.new(0,2);bc.Parent=bar

        local il = Instance.new("UIListLayout")
        il.FillDirection=Enum.FillDirection.Vertical
        il.SortOrder=Enum.SortOrder.LayoutOrder
        il.Padding=UDim.new(0,2)
        il.Parent=card
        local ip=Instance.new("UIPadding")
        ip.PaddingTop=UDim.new(0,8);ip.PaddingBottom=UDim.new(0,8)
        ip.PaddingLeft=UDim.new(0,14);ip.PaddingRight=UDim.new(0,10)
        ip.Parent=card

        local tl=Instance.new("TextLabel")
        tl.BackgroundTransparency=1;tl.Size=UDim2.new(1,0,0,0)
        tl.AutomaticSize=Enum.AutomaticSize.Y;tl.Text=title
        tl.TextColor3=Color3.fromRGB(228,230,245);tl.Font=Enum.Font.GothamBold
        tl.TextSize=11;tl.TextXAlignment=Enum.TextXAlignment.Left
        tl.TextWrapped=true;tl.LayoutOrder=1;tl.ZIndex=9002;tl.Parent=card

        if body~="" then
            local bl=Instance.new("TextLabel")
            bl.BackgroundTransparency=1;bl.Size=UDim2.new(1,0,0,0)
            bl.AutomaticSize=Enum.AutomaticSize.Y;bl.Text=body
            bl.TextColor3=Color3.fromRGB(96,98,132);bl.Font=Enum.Font.Gotham
            bl.TextSize=9;bl.TextXAlignment=Enum.TextXAlignment.Left
            bl.TextWrapped=true;bl.LayoutOrder=2;bl.ZIndex=9002;bl.Parent=card
        end

        -- progress drain
        local pb=Instance.new("Frame")
        pb.BackgroundColor3=Color3.fromRGB(40,42,58);pb.BorderSizePixel=0
        pb.Size=UDim2.new(1,0,0,2);pb.LayoutOrder=3;pb.ZIndex=9002;pb.Parent=card
        local pbc=Instance.new("UICorner");pbc.CornerRadius=UDim.new(0,1);pbc.Parent=pb
        local pf=Instance.new("Frame")
        pf.BackgroundColor3=ac;pf.BorderSizePixel=0
        pf.Size=UDim2.new(1,0,1,0);pf.ZIndex=9003;pf.Parent=pb
        local pfc=Instance.new("UICorner");pfc.CornerRadius=UDim.new(0,1);pfc.Parent=pf

        -- animate in
        card.Position=UDim2.new(1.1,0,0,0)
        TweenService:Create(card,TweenInfo.new(.28,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
            {BackgroundTransparency=0,Position=UDim2.new(0,0,0,0)}):Play()
        TweenService:Create(pf,TweenInfo.new(dur,Enum.EasingStyle.Linear),
            {Size=UDim2.new(0,0,1,0)}):Play()

        task.delay(dur,function()
            if not card.Parent then return end
            TweenService:Create(card,TweenInfo.new(.24,Enum.EasingStyle.Quint,Enum.EasingDirection.In),
                {BackgroundTransparency=1,Position=UDim2.new(1.1,0,0,0)}):Play()
            task.delay(.26,function() pcall(function() card:Destroy() end) end)
        end)
    end

    -- ── Config save / load ────────────────────────────────────────────────────
    local function _path(slot) return "murysium_"..(slot or ConfigSlot)..".json" end

    function Win:SaveConfig(slot)
        local data={}
        for name,flag in pairs(Library.Flags) do
            if flag and flag.Get then
                local ok,v=pcall(flag.Get)
                if ok then
                    if type(v)=="boolean" or type(v)=="number" or type(v)=="string" then
                        data[name]=v
                    elseif typeof(v)=="Color3" then
                        data[name]={_t="Color3",R=v.R,G=v.G,B=v.B}
                    end
                end
            end
        end
        local ok,json
        if HttpService then ok,json=pcall(function() return HttpService:JSONEncode(data) end) end
        if ok and json then pcall(writefile,_path(slot),json) end
    end

    function Win:LoadConfig(slot)
        local ok,content=pcall(readfile,_path(slot))
        if not ok or not content or content=="" then return end
        local ok2,data
        if HttpService then ok2,data=pcall(function() return HttpService:JSONDecode(content) end) end
        if not ok2 or not data then return end
        for name,val in pairs(data) do
            local flag=Library.Flags[name]
            if flag and flag.Set then
                if type(val)=="table" and val._t=="Color3" then
                    pcall(flag.Set,Color3.new(val.R,val.G,val.B))
                else
                    pcall(flag.Set,val)
                end
            end
        end
    end

    -- ── Command Palette ───────────────────────────────────────────────────────
    local _PaletteOpen  = false
    local _PaletteBuilt = false
    local _PaletteOverlay, _PaletteBox, _PaletteResults, _PaletteLayout

    local function _BuildPalette()
        if _PaletteBuilt then return end
        _PaletteBuilt = true

        local PGui = Instance.new("ScreenGui")
        PGui.Name="MurysiumPalette";PGui.ResetOnSpawn=false
        PGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;PGui.IgnoreGuiInset=true
        local _p2=pcall(function() PGui.Parent=gethui() end)
        if not _p2 then PGui.Parent=game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end

        _PaletteOverlay=Instance.new("Frame")
        _PaletteOverlay.BackgroundColor3=Color3.fromRGB(0,0,0)
        _PaletteOverlay.BackgroundTransparency=.55
        _PaletteOverlay.BorderSizePixel=0
        _PaletteOverlay.Size=UDim2.new(1,0,1,0)
        _PaletteOverlay.ZIndex=8000
        _PaletteOverlay.Visible=false
        _PaletteOverlay.Parent=PGui

        local Panel=Instance.new("Frame")
        Panel.BackgroundColor3=Color3.fromRGB(28,28,38)
        Panel.BorderSizePixel=0
        Panel.AnchorPoint=Vector2.new(.5,0)
        Panel.Size=UDim2.new(0,340,0,310)
        Panel.Position=UDim2.new(.5,0,0,68)
        Panel.ZIndex=8001
        Panel.ClipsDescendants=true
        Panel.Parent=_PaletteOverlay
        local pc=Instance.new("UICorner");pc.CornerRadius=UDim.new(0,12);pc.Parent=Panel
        local ps=Instance.new("UIStroke");ps.Color=Color3.fromRGB(40,42,58);ps.Thickness=1;ps.Parent=Panel

        -- searchbar
        local SBRow=Instance.new("Frame")
        SBRow.BackgroundTransparency=1;SBRow.Size=UDim2.new(1,0,0,46)
        SBRow.ZIndex=8002;SBRow.Parent=Panel
        local spp=Instance.new("UIPadding")
        spp.PaddingLeft=UDim.new(0,14);spp.PaddingRight=UDim.new(0,14);spp.Parent=SBRow

        local icon=Instance.new("TextLabel")
        icon.BackgroundTransparency=1;icon.AnchorPoint=Vector2.new(0,.5)
        icon.Size=UDim2.new(0,16,0,16);icon.Position=UDim2.new(0,0,.5,0)
        icon.Text="⌕";icon.TextColor3=Color3.fromRGB(96,98,132)
        icon.Font=Enum.Font.GothamBold;icon.TextSize=15;icon.ZIndex=8003;icon.Parent=SBRow

        _PaletteBox=Instance.new("TextBox")
        _PaletteBox.BackgroundTransparency=1;_PaletteBox.AnchorPoint=Vector2.new(0,.5)
        _PaletteBox.Size=UDim2.new(1,-22,0,24);_PaletteBox.Position=UDim2.new(0,22,.5,0)
        _PaletteBox.Text="";_PaletteBox.PlaceholderText="Search elements…"
        _PaletteBox.TextColor3=Color3.fromRGB(228,230,245)
        _PaletteBox.PlaceholderColor3=Color3.fromRGB(96,98,132)
        _PaletteBox.Font=Enum.Font.Gotham;_PaletteBox.TextSize=12
        _PaletteBox.TextXAlignment=Enum.TextXAlignment.Left
        _PaletteBox.ClearTextOnFocus=false;_PaletteBox.ZIndex=8003;_PaletteBox.Parent=SBRow

        local div=Instance.new("Frame")
        div.BackgroundColor3=Color3.fromRGB(40,42,58);div.BorderSizePixel=0
        div.Size=UDim2.new(1,-16,0,1);div.Position=UDim2.new(0,8,0,46)
        div.ZIndex=8002;div.Parent=Panel

        _PaletteResults=Instance.new("ScrollingFrame")
        _PaletteResults.BackgroundTransparency=1;_PaletteResults.BorderSizePixel=0
        _PaletteResults.Size=UDim2.new(1,0,1,-48);_PaletteResults.Position=UDim2.new(0,0,0,48)
        _PaletteResults.CanvasSize=UDim2.new(0,0,0,0)
        _PaletteResults.ScrollBarThickness=2
        _PaletteResults.ScrollBarImageColor3=Color3.fromRGB(0,152,255)
        _PaletteResults.ScrollingDirection=Enum.ScrollingDirection.Y
        _PaletteResults.ZIndex=8002;_PaletteResults.Parent=Panel
        local rp=Instance.new("UIPadding")
        rp.PaddingTop=UDim.new(0,4);rp.PaddingBottom=UDim.new(0,6)
        rp.PaddingLeft=UDim.new(0,8);rp.PaddingRight=UDim.new(0,8);rp.Parent=_PaletteResults

        _PaletteLayout=Instance.new("UIListLayout")
        _PaletteLayout.FillDirection=Enum.FillDirection.Vertical
        _PaletteLayout.SortOrder=Enum.SortOrder.LayoutOrder
        _PaletteLayout.Padding=UDim.new(0,2)
        _PaletteLayout.Parent=_PaletteResults
        _PaletteLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            _PaletteResults.CanvasSize=UDim2.new(0,0,0,_PaletteLayout.AbsoluteContentSize.Y+10)
        end)

        -- backdrop close
        local backdrop=Instance.new("TextButton")
        backdrop.BackgroundTransparency=1;backdrop.Size=UDim2.new(1,0,1,0)
        backdrop.Text="";backdrop.ZIndex=7999;backdrop.Parent=_PaletteOverlay
        backdrop.MouseButton1Click:Connect(function() Win:CloseCommandPalette() end)
        Panel.ZIndex=8001  -- re-assert above backdrop

        _PaletteBox:GetPropertyChangedSignal("Text"):Connect(function()
            Win:_RebuildPalette(_PaletteBox.Text)
        end)
    end

    Win._PaletteRegistry = {}

    function Win:_RebuildPalette(query)
        for _,c in ipairs(_PaletteResults:GetChildren()) do
            if c:IsA("TextButton") or c:IsA("Frame") then c:Destroy() end
        end
        query=(query or ""):lower()
        local TypeCols={
            Toggle=Color3.fromRGB(88,168,255), Slider=Color3.fromRGB(46,204,96),
            Dropdown=Color3.fromRGB(220,178,40), Button=Color3.fromRGB(230,50,72),
            ColorPicker=Color3.fromRGB(220,100,200), Keybind=Color3.fromRGB(162,102,255),
            Input=Color3.fromRGB(0,210,230),
        }
        local ord=0
        for _,e in ipairs(self._PaletteRegistry) do
            if query=="" or e.Name:lower():find(query,1,true) then
                ord=ord+1
                local row=Instance.new("TextButton")
                row.BackgroundColor3=Color3.fromRGB(28,28,38)
                row.BackgroundTransparency=1;row.BorderSizePixel=0
                row.Size=UDim2.new(1,0,0,40);row.Text=""
                row.ZIndex=8003;row.LayoutOrder=ord;row.Parent=_PaletteResults
                local rc=Instance.new("UICorner");rc.CornerRadius=UDim.new(0,6);rc.Parent=row

                local dot=Instance.new("Frame")
                dot.BackgroundColor3=TypeCols[e.Type] or Color3.fromRGB(0,152,255)
                dot.BorderSizePixel=0;dot.AnchorPoint=Vector2.new(0,.5)
                dot.Size=UDim2.new(0,4,0,4);dot.Position=UDim2.new(0,8,.5,-6)
                dot.ZIndex=8004;dot.Parent=row
                local dc=Instance.new("UICorner");dc.CornerRadius=UDim.new(0,2);dc.Parent=dot

                local nl=Instance.new("TextLabel")
                nl.BackgroundTransparency=1;nl.AnchorPoint=Vector2.new(0,.5)
                nl.Size=UDim2.new(.6,-18,0,14);nl.Position=UDim2.new(0,18,.5,-7)
                nl.Text=e.Name;nl.TextColor3=Color3.fromRGB(228,230,245)
                nl.Font=Enum.Font.GothamMedium;nl.TextSize=11
                nl.TextXAlignment=Enum.TextXAlignment.Left;nl.ZIndex=8004;nl.Parent=row

                local tl=Instance.new("TextLabel")
                tl.BackgroundTransparency=1;tl.AnchorPoint=Vector2.new(1,.5)
                tl.Size=UDim2.new(.4,-4,0,12);tl.Position=UDim2.new(1,-8,.5,-7)
                tl.Text=e.Type;tl.TextColor3=TypeCols[e.Type] or Color3.fromRGB(0,152,255)
                tl.Font=Enum.Font.Gotham;tl.TextSize=9
                tl.TextXAlignment=Enum.TextXAlignment.Right;tl.ZIndex=8004;tl.Parent=row

                local vl=Instance.new("TextLabel")
                vl.BackgroundTransparency=1;vl.AnchorPoint=Vector2.new(0,1)
                vl.Size=UDim2.new(1,-18,0,11);vl.Position=UDim2.new(0,18,1,-4)
                vl.Text=e.GetDisplay and tostring(pcall(e.GetDisplay) and e.GetDisplay() or "") or ""
                vl.TextColor3=Color3.fromRGB(96,98,132);vl.Font=Enum.Font.Gotham
                vl.TextSize=9;vl.TextXAlignment=Enum.TextXAlignment.Left
                vl.ZIndex=8004;vl.Parent=row

                row.MouseEnter:Connect(function()
                    TweenService:Create(row,TweenInfo.new(.08,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
                        {BackgroundTransparency=0,BackgroundColor3=Color3.fromRGB(34,34,46)}):Play()
                end)
                row.MouseLeave:Connect(function()
                    TweenService:Create(row,TweenInfo.new(.14,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
                        {BackgroundTransparency=1}):Play()
                end)
                row.MouseButton1Click:Connect(function()
                    if e.Interact then pcall(e.Interact) end
                end)
            end
        end
    end

    function Win:OpenCommandPalette()
        _BuildPalette()
        _PaletteOpen=true
        _PaletteOverlay.Visible=true
        _PaletteBox.Text=""
        self:_RebuildPalette("")
        task.defer(function() pcall(function() _PaletteBox:CaptureFocus() end) end)
    end

    function Win:CloseCommandPalette()
        _PaletteOpen=false
        if _PaletteOverlay then _PaletteOverlay.Visible=false end
    end

    UIS.InputBegan:Connect(function(inp, processed)
        if processed then return end
        local ctrlK = inp.KeyCode==Enum.KeyCode.K and UIS:IsKeyDown(Enum.KeyCode.LeftControl)
        local ralt  = inp.KeyCode==Enum.KeyCode.RightAlt
        if ctrlK or ralt then
            if _PaletteOpen then Win:CloseCommandPalette() else Win:OpenCommandPalette() end
        end
        if inp.KeyCode==Enum.KeyCode.Escape and _PaletteOpen then Win:CloseCommandPalette() end
    end)

    -- ── Patch CreateTab → CreateSection → inject new element creators ─────────
    local _OrigCT = Win.CreateTab
    function Win:CreateTab(TabCfg)
        local Tab = _OrigCT(self, TabCfg)
        if not Tab then return Tab end

        local _OrigCS = Tab.CreateSection
        function Tab:CreateSection(SecCfg)
            local Sec = _OrigCS(self, SecCfg)
            if not Sec then return Sec end

            -- shared helpers: disable overlay, signal
            local function _makeSignal() return _Signal.new() end

            -- ─── SetEnabled patcher on existing elements ─────────────────────
            -- Wrap the 4 original creators to add .Changed and :SetEnabled
            local _origCreators = {
                CreateToggle  = Sec.CreateToggle,
                CreateButton  = Sec.CreateButton,
                CreateDropdown= Sec.CreateDropdown,
                CreateSlider  = Sec.CreateSlider,
                CreateLabel   = Sec.CreateLabel,
                CreateParagraph=Sec.CreateParagraph,
            }

            for mname, orig in pairs(_origCreators) do
                Sec[mname] = function(s2, cfg2)
                    local obj = orig(s2, cfg2)
                    if not obj then return obj end
                    -- Attach Changed signal if not already present
                    if not obj.Changed then obj.Changed = _makeSignal() end
                    -- Attach SetEnabled if not present (no-op fallback)
                    if not obj.SetEnabled then obj.SetEnabled = function() end end
                    -- Auto-register in Library.Flags
                    local flagName = cfg2 and (cfg2.Name or cfg2.Title)
                    if flagName and not Library.Flags[flagName] then
                        Library.Flags[flagName] = {
                            Get     = obj.GetValue or function() return nil end,
                            Set     = obj.Value and function(v) obj.Value:Set(v) end or function() end,
                            Changed = obj.Changed,
                        }
                    end
                    -- Register in command palette
                    local etype = mname:gsub("Create","")
                    table.insert(Win._PaletteRegistry, {
                        Name       = (cfg2 and (cfg2.Title or cfg2.Name)) or mname,
                        Type       = etype,
                        GetDisplay = obj.GetValue or function() return "—" end,
                        Interact   = obj.Value and function() end or function() end,
                    })
                    return obj
                end
            end

            -- ─── NEW: CreateColorPicker ──────────────────────────────────────
            function Sec:CreateColorPicker(Cfg)
                Cfg = Cfg or {}
                local cTitle    = Cfg.Title    or "Color"
                local cDefault  = Cfg.Default  or Color3.fromRGB(255,255,255)
                local cCallback = Cfg.Callback or function() end
                local cName     = Cfg.Name

                local TweenService2 = game:GetService("TweenService")
                local Changed       = _makeSignal()
                local currentColor  = cDefault

                -- Row button that shows a color swatch + opens picker
                -- We borrow CreateButton from the section to build the row
                local swatchHolder = Instance.new("Frame")
                swatchHolder.BackgroundTransparency = 1
                swatchHolder.Size = UDim2.new(1,0,0,0)
                swatchHolder.AutomaticSize = Enum.AutomaticSize.Y
                swatchHolder.ZIndex = 14

                Sec._RowNumber = Sec._RowNumber + 1
                local N = Sec._RowNumber
                swatchHolder.LayoutOrder = N * 10
                swatchHolder.Parent = Sec._Card

                local Row = Instance.new("Frame")
                Row.BackgroundTransparency = 1
                Row.BorderSizePixel = 0
                Row.ZIndex = 14
                Row.Size = UDim2.new(1,0,0,36)
                Row.LayoutOrder = N * 10
                Row.Parent = Sec._Card
                local rp2 = Instance.new("UIPadding")
                rp2.PaddingLeft=UDim.new(0,12);rp2.PaddingRight=UDim.new(0,12);rp2.Parent=Row

                local TLbl = Instance.new("TextLabel")
                TLbl.BackgroundTransparency=1;TLbl.AnchorPoint=Vector2.new(0,.5)
                TLbl.Size=UDim2.new(1,-54,0,12);TLbl.Position=UDim2.new(0,0,.5,0)
                TLbl.Text=cTitle;TLbl.TextColor3=Color3.fromRGB(228,230,245)
                TLbl.Font=Enum.Font.Gotham;TLbl.TextSize=12
                TLbl.TextXAlignment=Enum.TextXAlignment.Left;TLbl.ZIndex=15;TLbl.Parent=Row

                local Swatch = Instance.new("Frame")
                Swatch.BackgroundColor3=cDefault;Swatch.BorderSizePixel=0
                Swatch.AnchorPoint=Vector2.new(1,.5);Swatch.Size=UDim2.new(0,30,0,18)
                Swatch.Position=UDim2.new(1,-18,.5,0);Swatch.ZIndex=15;Swatch.Parent=Row
                local sc=Instance.new("UICorner");sc.CornerRadius=UDim.new(0,5);sc.Parent=Swatch
                local ss=Instance.new("UIStroke");ss.Color=Color3.fromRGB(40,42,58);ss.Thickness=.8;ss.Parent=Swatch

                local HexLbl = Instance.new("TextLabel")
                HexLbl.BackgroundTransparency=1;HexLbl.AnchorPoint=Vector2.new(1,.5)
                HexLbl.Size=UDim2.new(0,14,0,12);HexLbl.Position=UDim2.new(1,0,.5,0)
                HexLbl.Text="#";HexLbl.TextColor3=Color3.fromRGB(96,98,132)
                HexLbl.Font=Enum.Font.Gotham;HexLbl.TextSize=9;HexLbl.ZIndex=15;HexLbl.Parent=Row

                -- Simple picker popup (hex input + H/S/V sliders)
                local PickerOpen = false
                local PickerPanel = Instance.new("Frame")
                PickerPanel.BackgroundColor3=Color3.fromRGB(22,22,30)
                PickerPanel.BorderSizePixel=0;PickerPanel.ZIndex=30
                PickerPanel.Size=UDim2.new(1,0,0,0);PickerPanel.AutomaticSize=Enum.AutomaticSize.Y
                PickerPanel.ClipsDescendants=true
                PickerPanel.LayoutOrder=N*10+1;PickerPanel.Visible=false;PickerPanel.Parent=Sec._Card
                local ppc=Instance.new("UICorner");ppc.CornerRadius=UDim.new(0,8);ppc.Parent=PickerPanel
                local ppl=Instance.new("UIListLayout")
                ppl.FillDirection=Enum.FillDirection.Vertical;ppl.Padding=UDim.new(0,6)
                ppl.SortOrder=Enum.SortOrder.LayoutOrder;ppl.Parent=PickerPanel
                local ppp=Instance.new("UIPadding")
                ppp.PaddingTop=UDim.new(0,8);ppp.PaddingBottom=UDim.new(0,10)
                ppp.PaddingLeft=UDim.new(0,10);ppp.PaddingRight=UDim.new(0,10);ppp.Parent=PickerPanel

                -- Hex input
                local hexRow=Instance.new("Frame");hexRow.BackgroundTransparency=1
                hexRow.Size=UDim2.new(1,0,0,24);hexRow.LayoutOrder=1;hexRow.ZIndex=31;hexRow.Parent=PickerPanel
                local hexPfx=Instance.new("TextLabel");hexPfx.BackgroundTransparency=1
                hexPfx.Size=UDim2.new(0,16,1,0);hexPfx.Text="#"
                hexPfx.TextColor3=Color3.fromRGB(96,98,132);hexPfx.Font=Enum.Font.GothamBold
                hexPfx.TextSize=11;hexPfx.ZIndex=32;hexPfx.Parent=hexRow
                local hexBox=Instance.new("TextBox")
                hexBox.BackgroundColor3=Color3.fromRGB(16,16,22);hexBox.BorderSizePixel=0
                hexBox.AnchorPoint=Vector2.new(0,.5);hexBox.Size=UDim2.new(1,-20,1,0)
                hexBox.Position=UDim2.new(0,18,.5,0);hexBox.Text=_C3ToHex(cDefault)
                hexBox.TextColor3=Color3.fromRGB(228,230,245);hexBox.Font=Enum.Font.GothamMedium
                hexBox.TextSize=11;hexBox.MaxVisibleGraphemes=6;hexBox.ClearTextOnFocus=false
                hexBox.ZIndex=32;hexBox.Parent=hexRow
                local hbc=Instance.new("UICorner");hbc.CornerRadius=UDim.new(0,5);hbc.Parent=hexBox

                local function applyColor(c3, fromHex)
                    currentColor=c3;Swatch.BackgroundColor3=c3
                    if not fromHex then hexBox.Text=_C3ToHex(c3) end
                    cCallback(c3);Changed:Fire(c3)
                    if AutoSave and cName then pcall(function() Win:SaveConfig() end) end
                end

                hexBox.FocusLost:Connect(function()
                    local c=_HexToC3(hexBox.Text)
                    if c then applyColor(c,true) end
                    hexBox.Text=_C3ToHex(currentColor)
                end)

                -- HSV sliders (H, S, V)
                local function makeHSVSlider(label, lo, hi, startVal, order, onChanged)
                    local slRow=Instance.new("Frame");slRow.BackgroundTransparency=1
                    slRow.Size=UDim2.new(1,0,0,28);slRow.LayoutOrder=order;slRow.ZIndex=31;slRow.Parent=PickerPanel
                    local slLbl=Instance.new("TextLabel");slLbl.BackgroundTransparency=1
                    slLbl.AnchorPoint=Vector2.new(0,.5);slLbl.Size=UDim2.new(0,10,0,12)
                    slLbl.Position=UDim2.new(0,0,.5,0);slLbl.Text=label
                    slLbl.TextColor3=Color3.fromRGB(96,98,132);slLbl.Font=Enum.Font.GothamBold
                    slLbl.TextSize=8;slLbl.ZIndex=32;slLbl.Parent=slRow
                    local trackBG=Instance.new("Frame");trackBG.BackgroundColor3=Color3.fromRGB(40,42,58)
                    trackBG.BorderSizePixel=0;trackBG.AnchorPoint=Vector2.new(0,.5)
                    trackBG.Size=UDim2.new(1,-28,.4,0);trackBG.Position=UDim2.new(0,14,.5,0)
                    trackBG.ZIndex=32;trackBG.Parent=slRow
                    local tc2=Instance.new("UICorner");tc2.CornerRadius=UDim.new(0,2);tc2.Parent=trackBG
                    local pct=(startVal-lo)/math.max(hi-lo,.0001)
                    local fill=Instance.new("Frame");fill.BackgroundColor3=Color3.fromRGB(0,152,255)
                    fill.BorderSizePixel=0;fill.Size=UDim2.new(pct,0,1,0);fill.ZIndex=33;fill.Parent=trackBG
                    local fc=Instance.new("UICorner");fc.CornerRadius=UDim.new(0,2);fc.Parent=fill
                    local valLbl=Instance.new("TextLabel");valLbl.BackgroundTransparency=1
                    valLbl.AnchorPoint=Vector2.new(1,.5);valLbl.Size=UDim2.new(0,12,0,12)
                    valLbl.Position=UDim2.new(1,0,.5,0)
                    valLbl.Text=tostring(math.floor(startVal*100+.5))
                    valLbl.TextColor3=Color3.fromRGB(96,98,132);valLbl.Font=Enum.Font.Gotham
                    valLbl.TextSize=8;valLbl.ZIndex=32;valLbl.Parent=slRow
                    local curV=startVal
                    local function calc(pos)
                        local ab=trackBG.AbsolutePosition;local sz=trackBG.AbsoluteSize
                        local p=math.clamp((pos.X-ab.X)/sz.X,0,1)
                        curV=lo+p*(hi-lo)
                        fill.Size=UDim2.new(p,0,1,0)
                        valLbl.Text=tostring(math.floor(curV*100+.5))
                        onChanged(curV)
                    end
                    local sliding2=false
                    local hitBtn=Instance.new("TextButton")
                    hitBtn.BackgroundTransparency=1;hitBtn.Size=UDim2.new(1,0,1,0)
                    hitBtn.Text="";hitBtn.ZIndex=34;hitBtn.Parent=slRow
                    hitBtn.InputBegan:Connect(function(inp)
                        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
                            sliding2=true;calc(inp.Position)
                        end
                    end)
                    game:GetService("UserInputService").InputChanged:Connect(function(inp)
                        if not sliding2 then return end
                        if inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch then
                            calc(inp.Position)
                        end
                    end)
                    game:GetService("UserInputService").InputEnded:Connect(function(inp)
                        if inp.UserInputType==Enum.UserInputType.MouseButton1 then sliding2=false end
                    end)
                    return function() return curV end
                end

                local H,S,V=cDefault:ToHSV()
                local getH,getS,getV
                local function onHSVChange()
                    local c=Color3.fromHSV(getH(),getS(),getV())
                    applyColor(c,false)
                end
                getH=makeHSVSlider("H",0,1,H,2,function(v) H=v onHSVChange() end)
                getS=makeHSVSlider("S",0,1,S,3,function(v) S=v onHSVChange() end)
                getV=makeHSVSlider("V",0,1,V,4,function(v) V=v onHSVChange() end)

                -- toggle picker open/close
                local Hit2=Instance.new("TextButton")
                Hit2.BackgroundTransparency=1;Hit2.Size=UDim2.new(1,0,1,0)
                Hit2.Text="";Hit2.ZIndex=16;Hit2.Parent=Row
                Hit2.MouseButton1Click:Connect(function()
                    PickerOpen=not PickerOpen
                    if PickerOpen then
                        PickerPanel.Visible=true
                        TweenService2:Create(PickerPanel,TweenInfo.new(.30,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
                            {BackgroundTransparency=0}):Play()
                    else
                        TweenService2:Create(PickerPanel,TweenInfo.new(.22,Enum.EasingStyle.Quint,Enum.EasingDirection.In),
                            {BackgroundTransparency=1}):Play()
                        task.delay(.24,function() PickerPanel.Visible=false end)
                    end
                end)

                if cName then
                    Library.Flags[cName]={
                        Get=function() return currentColor end,
                        Set=function(v) applyColor(v,false) end,
                        Changed=Changed,
                    }
                end

                table.insert(Win._PaletteRegistry,{
                    Name=cTitle,Type="ColorPicker",
                    GetDisplay=function() return "#".._C3ToHex(currentColor) end,
                    Interact=function()
                        PickerOpen=true;PickerPanel.Visible=true
                    end,
                })

                local obj={}
                obj.Value={Set=function(_,v) applyColor(v,false) end}
                obj.Name={Set=function(_,n) TLbl.Text=n end}
                obj.GetValue=function() return currentColor end
                obj.Changed=Changed
                obj.SetEnabled=function(_,en)
                    Hit2.Visible=en==true and true or false
                    TLbl.TextTransparency=en and 0 or .45
                end
                return obj
            end

            -- ─── NEW: CreateKeybind ──────────────────────────────────────────
            function Sec:CreateKeybind(Cfg)
                Cfg=Cfg or {}
                local kTitle    = Cfg.Title    or "Keybind"
                local kDefault  = Cfg.Default  or Enum.KeyCode.Unknown
                local kCallback = Cfg.Callback or function() end
                local kName     = Cfg.Name
                local Changed   = _makeSignal()
                local currentKey= kDefault
                local listening = false

                Sec._RowNumber=Sec._RowNumber+1
                local N=Sec._RowNumber
                local Row=Instance.new("Frame");Row.BackgroundTransparency=1
                Row.BorderSizePixel=0;Row.ZIndex=14;Row.LayoutOrder=N*10
                Row.Size=UDim2.new(1,0,0,32);Row.Parent=Sec._Card
                local rkp=Instance.new("UIPadding")
                rkp.PaddingLeft=UDim.new(0,12);rkp.PaddingRight=UDim.new(0,12);rkp.Parent=Row

                local kLbl=Instance.new("TextLabel");kLbl.BackgroundTransparency=1
                kLbl.AnchorPoint=Vector2.new(0,.5);kLbl.Size=UDim2.new(1,-80,0,12)
                kLbl.Position=UDim2.new(0,0,.5,0);kLbl.Text=kTitle
                kLbl.TextColor3=Color3.fromRGB(228,230,245);kLbl.Font=Enum.Font.Gotham
                kLbl.TextSize=12;kLbl.TextXAlignment=Enum.TextXAlignment.Left
                kLbl.ZIndex=15;kLbl.Parent=Row

                local kBtn=Instance.new("TextButton")
                kBtn.BackgroundColor3=Color3.fromRGB(40,42,58);kBtn.BorderSizePixel=0
                kBtn.AnchorPoint=Vector2.new(1,.5);kBtn.Size=UDim2.new(0,72,0,20)
                kBtn.Position=UDim2.new(1,0,.5,0)
                local kname=tostring(kDefault):gsub("Enum.KeyCode.","")
                kBtn.Text=kname=="Unknown" and "[ None ]" or "[ "..kname.." ]"
                kBtn.TextColor3=Color3.fromRGB(0,152,255);kBtn.Font=Enum.Font.GothamMedium
                kBtn.TextSize=10;kBtn.ZIndex=15;kBtn.Parent=Row
                local kbc=Instance.new("UICorner");kbc.CornerRadius=UDim.new(0,6);kbc.Parent=kBtn

                local DisOverlay2=Instance.new("Frame");DisOverlay2.BackgroundColor3=Color3.fromRGB(28,28,38)
                DisOverlay2.BackgroundTransparency=.45;DisOverlay2.BorderSizePixel=0
                DisOverlay2.Size=UDim2.new(1,0,1,0);DisOverlay2.ZIndex=20;DisOverlay2.Visible=false;DisOverlay2.Parent=Row

                local function setKey(k,fire)
                    currentKey=k;listening=false
                    local ks=tostring(k):gsub("Enum.KeyCode.","")
                    kBtn.Text=ks=="Unknown" and "[ None ]" or "[ "..ks.." ]"
                    kBtn.TextColor3=Color3.fromRGB(0,152,255)
                    if fire then kCallback(k);Changed:Fire(k) end
                    if AutoSave and kName then pcall(function() Win:SaveConfig() end) end
                end

                kBtn.MouseButton1Click:Connect(function()
                    if DisOverlay2.Visible then return end
                    listening=true
                    kBtn.Text="[ ... ]";kBtn.TextColor3=Color3.fromRGB(255,192,40)
                end)

                UIS.InputBegan:Connect(function(inp, proc)
                    if not listening then return end
                    if proc and inp.UserInputType~=Enum.UserInputType.Keyboard then return end
                    if inp.UserInputType==Enum.UserInputType.Keyboard then
                        setKey(inp.KeyCode, true)
                    end
                end)

                -- Trigger callback when bound key is pressed during gameplay
                UIS.InputBegan:Connect(function(inp, proc)
                    if proc then return end
                    if inp.UserInputType==Enum.UserInputType.Keyboard and inp.KeyCode==currentKey then
                        kCallback(currentKey)
                    end
                end)

                if kName then
                    Library.Flags[kName]={
                        Get=function() return currentKey end,
                        Set=function(v) setKey(v,false) end,
                        Changed=Changed,
                    }
                end

                table.insert(Win._PaletteRegistry,{
                    Name=kTitle,Type="Keybind",
                    GetDisplay=function() return tostring(currentKey):gsub("Enum.KeyCode.","") end,
                    Interact=function()
                        if not DisOverlay2.Visible then
                            listening=true;kBtn.Text="[ ... ]";kBtn.TextColor3=Color3.fromRGB(255,192,40)
                        end
                    end,
                })

                local obj={}
                obj.Value={Set=function(_,v) setKey(v,false) end}
                obj.Name={Set=function(_,n) kLbl.Text=n end}
                obj.GetValue=function() return currentKey end
                obj.Changed=Changed
                obj.SetEnabled=function(_,en) DisOverlay2.Visible=not en end
                return obj
            end

            -- ─── NEW: CreateInput ────────────────────────────────────────────
            function Sec:CreateInput(Cfg)
                Cfg=Cfg or {}
                local iTitle    = Cfg.Title       or "Input"
                local iDefault  = Cfg.Default      or ""
                local iPlaceholder = Cfg.Placeholder or "Type here…"
                local iCallback = Cfg.Callback     or function() end
                local iValidate = Cfg.Validate      -- optional fn(str)->bool,msg
                local iName     = Cfg.Name
                local Changed   = _makeSignal()
                local curVal    = iDefault

                Sec._RowNumber=Sec._RowNumber+1
                local N=Sec._RowNumber
                local Row=Instance.new("Frame");Row.BackgroundTransparency=1
                Row.BorderSizePixel=0;Row.ZIndex=14;Row.LayoutOrder=N*10
                Row.AutomaticSize=Enum.AutomaticSize.Y;Row.Size=UDim2.new(1,0,0,0)
                Row.Parent=Sec._Card
                local irl=Instance.new("UIListLayout")
                irl.FillDirection=Enum.FillDirection.Vertical;irl.Padding=UDim.new(0,4)
                irl.SortOrder=Enum.SortOrder.LayoutOrder;irl.Parent=Row
                local irp=Instance.new("UIPadding")
                irp.PaddingTop=UDim.new(0,8);irp.PaddingBottom=UDim.new(0,8)
                irp.PaddingLeft=UDim.new(0,12);irp.PaddingRight=UDim.new(0,12);irp.Parent=Row

                local iLbl=Instance.new("TextLabel");iLbl.BackgroundTransparency=1
                iLbl.Size=UDim2.new(1,0,0,12);iLbl.LayoutOrder=1
                iLbl.Text=iTitle;iLbl.TextColor3=Color3.fromRGB(228,230,245)
                iLbl.Font=Enum.Font.Gotham;iLbl.TextSize=12
                iLbl.TextXAlignment=Enum.TextXAlignment.Left;iLbl.ZIndex=15;iLbl.Parent=Row

                local iBoxBG=Instance.new("Frame");iBoxBG.BackgroundColor3=Color3.fromRGB(16,16,22)
                iBoxBG.BorderSizePixel=0;iBoxBG.Size=UDim2.new(1,0,0,28);iBoxBG.LayoutOrder=2
                iBoxBG.ZIndex=15;iBoxBG.Parent=Row
                local ibgc=Instance.new("UICorner");ibgc.CornerRadius=UDim.new(0,6);ibgc.Parent=iBoxBG
                local ibgs=Instance.new("UIStroke");ibgs.Color=Color3.fromRGB(40,42,58)
                ibgs.Thickness=.8;ibgs.Parent=iBoxBG

                local iBox=Instance.new("TextBox");iBox.BackgroundTransparency=1
                iBox.AnchorPoint=Vector2.new(0,.5);iBox.Size=UDim2.new(1,-16,1,0)
                iBox.Position=UDim2.new(0,8,.5,0);iBox.Text=iDefault
                iBox.PlaceholderText=iPlaceholder
                iBox.TextColor3=Color3.fromRGB(228,230,245)
                iBox.PlaceholderColor3=Color3.fromRGB(96,98,132)
                iBox.Font=Enum.Font.Gotham;iBox.TextSize=11
                iBox.TextXAlignment=Enum.TextXAlignment.Left;iBox.ClearTextOnFocus=false
                iBox.ZIndex=16;iBox.Parent=iBoxBG

                local errLbl=Instance.new("TextLabel");errLbl.BackgroundTransparency=1
                errLbl.Size=UDim2.new(1,0,0,10);errLbl.LayoutOrder=3;errLbl.Text=""
                errLbl.TextColor3=Color3.fromRGB(230,50,72);errLbl.Font=Enum.Font.Gotham
                errLbl.TextSize=8;errLbl.TextXAlignment=Enum.TextXAlignment.Left
                errLbl.ZIndex=15;errLbl.Parent=Row

                -- focus glow
                iBox.Focused:Connect(function()
                    TweenService:Create(ibgs,TweenInfo.new(.18,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
                        {Color=Color3.fromRGB(0,152,255),Thickness=1.2}):Play()
                end)
                iBox.FocusLost:Connect(function()
                    TweenService:Create(ibgs,TweenInfo.new(.22,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
                        {Color=Color3.fromRGB(40,42,58),Thickness=.8}):Play()
                    local txt=iBox.Text
                    if iValidate then
                        local ok2,msg=iValidate(txt)
                        if not ok2 then
                            errLbl.Text=msg or "Invalid input"
                            TweenService:Create(ibgs,TweenInfo.new(.14),{Color=Color3.fromRGB(230,50,72)}):Play()
                            return
                        end
                    end
                    errLbl.Text=""
                    curVal=txt
                    iCallback(txt);Changed:Fire(txt)
                    if AutoSave and iName then pcall(function() Win:SaveConfig() end) end
                end)

                if iName then
                    Library.Flags[iName]={
                        Get=function() return curVal end,
                        Set=function(v) iBox.Text=tostring(v);curVal=tostring(v) end,
                        Changed=Changed,
                    }
                end

                table.insert(Win._PaletteRegistry,{
                    Name=iTitle,Type="Input",
                    GetDisplay=function() return curVal end,
                    Interact=function()
                        pcall(function() iBox:CaptureFocus() end)
                    end,
                })

                local obj={}
                obj.Value={Set=function(_,v) iBox.Text=tostring(v);curVal=tostring(v) end}
                obj.Name={Set=function(_,n) iLbl.Text=n end}
                obj.GetValue=function() return curVal end
                obj.Changed=Changed
                obj.SetEnabled=function(_,en)
                    iBox.TextEditable=en;iBox.TextTransparency=en and 0 or .45
                end
                return obj
            end

            return Sec
        end  -- CreateSection end

        return Tab
    end  -- CreateTab end

    return Win
end  -- CreateWindow end

return Library

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
    ["arrow-up-right"]="↗", ["arrow-up-left"]="↖", ["arrow-down-right"]="↘", ["arrow-down-left"]="↙",
    ["arrow-big-up"]="⇑", ["arrow-big-down"]="⇓", ["arrow-big-left"]="⇐", ["arrow-big-right"]="⇒",
    ["arrow-right-circle"]="→", ["arrow-left-circle"]="←", ["arrow-up-circle"]="↑", ["arrow-down-circle"]="↓",
    ["arrow-right-square"]="→", ["arrow-left-square"]="←",
    ["arrow-right-from-line"]="→", ["arrow-left-from-line"]="←",
    ["arrow-right-to-line"]="→", ["arrow-left-to-line"]="←",
    ["chevron-right"]="›", ["chevron-left"]="‹", ["chevron-up"]="‸", ["chevron-down"]="⌄",
    ["chevrons-right"]="»", ["chevrons-left"]="«", ["chevrons-up"]="⇑", ["chevrons-down"]="⇓",
    ["chevron-right-circle"]="›", ["chevron-left-circle"]="‹", ["chevron-up-circle"]="‸", ["chevron-down-circle"]="⌄",
    ["chevron-first"]="⟪", ["chevron-last"]="⟫",
    activity="〜", airplay="⊡",
    ["alert-circle"]="⊙", ["alert-octagon"]="⊛", ["alert-triangle"]="⚠",
    ["align-center"]="≡", ["align-justify"]="≣", ["align-left"]="≡", ["align-right"]="≡",
    ["align-horizontal-distribute-center"]="⊟", ["align-vertical-distribute-center"]="⊟",
    ["align-horizontal-justify-center"]="⊟", ["align-vertical-justify-center"]="⊟",
    ["align-horizontal-justify-start"]="⊟", ["align-horizontal-justify-end"]="⊟",
    ["align-horizontal-space-around"]="⊟", ["align-horizontal-space-between"]="⊟",
    ["align-vertical-justify-end"]="⊟", ["align-vertical-justify-start"]="⊟",
    anchor="⚓", aperture="◎", archive="◫", ["at-sign"]="@", award="◈",
    ["archive-restore"]="◫", ["archive-x"]="◫",
    baby="◉", backpack="◫", badge="⬡", ban="⊘", banknote="▣",
    ["bar-chart"]="▮", ["bar-chart-2"]="▮▮", ["bar-chart-3"]="▮▮▮", ["bar-chart-4"]="▮▮▮▮",
    ["bar-chart-horizontal"]="▮", ["bar-chart-horizontal-big"]="▮",
    ["battery-charging"]="⚡", ["battery-full"]="█", ["battery-low"]="▒",
    ["battery-medium"]="▓", ["battery-warning"]="⚠", beaker="⚗", bed="▬",
    ["bed-double"]="▬", ["bed-single"]="▬",
    ["bell-minus"]="🔔", ["bell-off"]="🔕", ["bell-plus"]="🔔", ["bell-ring"]="🔔",
    ["bell-dot"]="🔔", ["bell-electric"]="🔔",
    bike="◎", bold="B", bomb="◉", bone="—",
    book="📖", ["book-open"]="📖", ["book-marked"]="🔖", ["book-copy"]="📖",
    ["book-open-check"]="✓", ["book-open-text"]="📖", ["book-text"]="📖",
    ["book-up"]="📖", ["book-up-2"]="📖", ["book-key"]="📖", ["book-minus"]="📖",
    ["book-plus"]="📖", ["book-x"]="📖", ["book-dashed"]="📖", ["book-heart"]="📖",
    ["book-headphones"]="📖", ["book-lock"]="📖", ["book-user"]="📖",
    bot="◻", box="📦", boxes="⊡",
    brain="◌", briefcase="💼", brush="✏",
    ["briefcase-business"]="💼", ["briefcase-medical"]="💼",
    bug="◌", building="▣", ["building-2"]="▤", bus="▣", calculator="▣", calendar="📅",
    ["calendar-check"]="📅", ["calendar-check-2"]="📅", ["calendar-clock"]="📅",
    ["calendar-days"]="📅", ["calendar-fold"]="📅", ["calendar-heart"]="📅",
    ["calendar-minus"]="📅", ["calendar-minus-2"]="📅", ["calendar-off"]="📅",
    ["calendar-plus"]="📅", ["calendar-plus-2"]="📅", ["calendar-range"]="📅",
    ["calendar-search"]="📅", ["calendar-sync"]="📅", ["calendar-x"]="📅",
    ["calendar-x-2"]="📅", ["calendar-1"]="📅", ["calendar-2"]="📅",
    ["camera-off"]="⊘", car="▣", cast="⊹",
    ["car-front"]="▣", ["car-taxi-front"]="▣", ["cable"]="⛓",
    ["cable-car"]="⛓", ["chart-area"]="◔", ["chart-bar"]="▮",
    ["chart-bar-big"]="▮", ["chart-bar-decreasing"]="▮", ["chart-bar-increasing"]="▮",
    ["chart-bar-stacked"]="▮", ["chart-candlestick"]="▮", ["chart-column-big"]="▮",
    ["chart-column-decreasing"]="▮", ["chart-column-increasing"]="▮",
    ["chart-column-stacked"]="▮", ["chart-gantt"]="▮", ["chart-line"]="〜",
    ["chart-network"]="⊞", ["chart-no-axes-column"]="▮",
    ["chart-no-axes-column-decreasing"]="▮", ["chart-no-axes-column-increasing"]="▮",
    ["chart-no-axes-combined"]="〜", ["chart-no-axes-gantt"]="▮",
    ["chart-pie"]="◔", ["chart-scatter"]="⊡", ["chart-spline"]="〜",
    ["check-circle"]="✅", ["check-circle-2"]="☑", ["check-square"]="☑",
    ["check-square-2"]="☑", circle="○", ["circle-dashed"]="◌", ["circle-dot"]="⊙",
    ["circle-slash"]="⊘", ["circle-off"]="⊘", ["circle-equal"]="⊜",
    ["circle-ellipsis"]="⊙", ["circle-arrow-up"]="↑", ["circle-arrow-down"]="↓",
    ["circle-arrow-left"]="←", ["circle-arrow-right"]="→",
    ["circle-arrow-out-down-left"]="↙", ["circle-arrow-out-down-right"]="↘",
    ["circle-arrow-out-up-left"]="↖", ["circle-arrow-out-up-right"]="↗",
    ["circle-check"]="✓", ["circle-check-big"]="✓", ["circle-chevron-down"]="⌄",
    ["circle-chevron-left"]="‹", ["circle-chevron-right"]="›", ["circle-chevron-up"]="‸",
    ["circle-divide"]="÷", ["circle-dollar-sign"]="$", ["circle-fading-plus"]="⊕",
    ["circle-gauge"]="◎", ["circle-help"]="?", ["circle-minus"]="⊖",
    ["circle-parking"]="P", ["circle-parking-off"]="⊘", ["circle-pause"]="⏸",
    ["circle-percent"]="◌", ["circle-play"]="▶", ["circle-plus"]="⊕",
    ["circle-power"]="⏻", ["circle-stop"]="⏹", ["circle-user"]="👤",
    ["circle-user-round"]="👤", ["circle-x"]="⊗",
    clipboard="📋", ["clipboard-check"]="✅", ["clipboard-list"]="📋",
    ["clipboard-copy"]="⧉", ["clipboard-edit"]="✎", ["clipboard-paste"]="📋",
    ["clipboard-x"]="✕", ["clipboard-minus"]="📋", ["clipboard-pen"]="✎",
    ["clipboard-pen-line"]="✎", ["clipboard-plus"]="📋", ["clipboard-signature"]="✎",
    ["clipboard-type"]="📋",
    clock="🕐", ["clock-1"]="🕐", ["clock-2"]="🕐", ["clock-3"]="🕐",
    ["clock-4"]="🕐", ["clock-5"]="🕐", ["clock-6"]="🕐", ["clock-7"]="🕐",
    ["clock-8"]="🕐", ["clock-9"]="🕐", ["clock-10"]="🕐", ["clock-11"]="🕐",
    ["clock-12"]="🕐", ["clock-alert"]="⚠", ["clock-arrow-down"]="↓",
    ["clock-arrow-up"]="↑", ["clock-fading"]="🕐",
    ["cloud-download"]="↓", ["cloud-upload"]="↑", ["cloud-drizzle"]="☁",
    ["cloud-lightning"]="⚡", ["cloud-off"]="⊘", ["cloud-rain"]="☁",
    ["cloud-snow"]="☁", ["cloud-sun"]="☀", ["cloud-sun-rain"]="☁",
    ["cloud-fog"]="☁", ["cloud-hail"]="☁", ["cloud-moon"]="🌙",
    ["cloud-moon-rain"]="☁",
    cloudy="☁", coffee="☕", cog="⚙", columns="⊟", command="⌘",
    compass="◎", component="⊞", copy="⧉",
    ["combine"]="⊞", ["cone"]="△", ["construction"]="⚠",
    ["contact"]="👤", ["contact-round"]="👤",
    ["corner-down-left"]="↩", ["corner-down-right"]="↪", ["corner-left-down"]="↵",
    ["corner-left-up"]="↑", ["corner-right-down"]="↳", ["corner-right-up"]="↑",
    ["corner-up-left"]="↖", ["corner-up-right"]="↗",
    crosshair="⊕", crown="♛", ["credit-card"]="💳", crop="⊠", database="🗄",
    delete="⌫", diamond="◆", disc="◎", ["disc-2"]="◉", ["disc-3"]="◉",
    divide="÷", ["dollar-sign"]="$", donut="◎", droplet="💧", droplets="💧",
    dumbbell="▬", ear="◌", ["ear-off"]="⊘", egg="○", ["egg-fried"]="○",
    ["egg-off"]="⊘", eraser="✏", euro="€", expand="⤢",
    ["external-link"]="↗", ["eye-off"]="⊘", fan="◎", ["fast-forward"]="⏭",
    feather="✎", filter="⊟", flame="▲", ["flame-kindling"]="▲",
    ["flashlight"]="💡", ["flashlight-off"]="⊘",
    ["folder-open"]="📂", ["folder-plus"]="📁", ["folder-minus"]="📁",
    ["folder-check"]="📁", ["folder-closed"]="📁", ["folder-clock"]="📁",
    ["folder-code"]="📁", ["folder-cog"]="📁", ["folder-dot"]="📁",
    ["folder-git"]="📁", ["folder-git-2"]="📁", ["folder-heart"]="📁",
    ["folder-input"]="📁", ["folder-kanban"]="📁", ["folder-key"]="📁",
    ["folder-lock"]="📁", ["folder-output"]="📁", ["folder-pen"]="📁",
    ["folder-root"]="📁", ["folder-search"]="📁", ["folder-search-2"]="📁",
    ["folder-symlink"]="📁", ["folder-sync"]="📁", ["folder-tree"]="📁",
    ["folder-up"]="📁", ["folder-x"]="📁", frown="☹", gift="◈",
    ["gift-2"]="◈", ["git-branch"]="⎇", ["git-branch-plus"]="⎇",
    ["git-branch-minus"]="⎇", ["git-commit"]="⊙", ["git-commit-vertical"]="⊙",
    ["git-commit-horizontal"]="⊙", ["git-compare"]="⊙", ["git-compare-arrows"]="⇌",
    ["git-fork"]="⎇", ["git-graph"]="⊞", ["git-merge"]="⋔",
    ["git-pull-request"]="⤴", ["git-pull-request-arrow"]="⤴",
    ["git-pull-request-closed"]="⊘", ["git-pull-request-create"]="⤴",
    ["git-pull-request-create-arrow"]="⤴", ["git-pull-request-draft"]="⤴",
    github="⊛", gitlab="◈", ["globe-2"]="🌍", ["globe-lock"]="🌐",
    ["graduation-cap"]="◈", ["grip"]="⊞", ["grip-horizontal"]="⊞",
    ["grip-vertical"]="⊞", ["group"]="⊞", ["guitar"]="♪",
    ["hand"]="✋", ["hand-coins"]="✋", ["hand-heart"]="✋",
    ["hand-helping"]="✋", ["hand-metal"]="✋", ["hand-platter"]="✋",
    ["handshake"]="✋", ["hard-drive"]="💾", ["hard-drive-download"]="💾",
    ["hard-drive-upload"]="💾", ["hard-hat"]="◈", hash="#", headphones="🎧",
    ["headphones-2"]="🎧", ["headset"]="🎧",
    ["help-circle"]="?", hexagon="⬡", ["highlighter"]="✎",
    ["history"]="↺", ["house"]="⌂", ["house-plus"]="⌂", ["hourglass"]="⌛",
    inbox="▣", italic="I", key="🔑", ["key-round"]="🔑",
    ["key-square"]="🔑", keyboard="⌨", ["keyboard-music"]="⌨",
    ["keyboard-off"]="⊘", ["lamp"]="💡", ["lamp-ceiling"]="💡",
    ["lamp-desk"]="💡", ["lamp-floor"]="💡", ["lamp-wall-down"]="💡",
    ["lamp-wall-up"]="💡",
    layout="▤", ["layout-grid"]="⊞", ["layout-dashboard"]="▤",
    ["layout-list"]="▤", ["layout-panel-left"]="▤", ["layout-panel-top"]="▤",
    ["layout-template"]="▤",
    laptop="💻", ["laptop-2"]="💻", ["laptop-minimal"]="💻",
    ["laptop-minimal-check"]="💻",
    leaf="◌", ["leafy-green"]="◌", ["library"]="📖", ["library-big"]="📖",
    ["life-buoy"]="⊙", link="🔗", ["link-2"]="⛓", ["link-2-off"]="⊘",
    ["linkedin"]="ℒ", loader="◌", ["loader-2"]="◌", ["loader-circle"]="◌",
    ["loader-pinwheel"]="◌",
    ["log-in"]="→", ["log-out"]="←",
    ["mail-open"]="✉", ["mail-plus"]="✉", ["mail-check"]="✓",
    ["mail-minus"]="✉", ["mail-question"]="✉", ["mail-search"]="✉",
    ["mail-warning"]="✉", ["mail-x"]="✉",
    ["map-pin"]="📍", ["map-pin-check"]="📍", ["map-pin-check-inside"]="📍",
    ["map-pin-house"]="📍", ["map-pin-minus"]="📍", ["map-pin-minus-inside"]="📍",
    ["map-pin-off"]="📍", ["map-pin-plus"]="📍", ["map-pin-plus-inside"]="📍",
    ["map-pin-x"]="📍", ["map-pin-x-inside"]="📍",
    maximize="⊡", ["maximize-2"]="⤢", medal="◈", meh="○",
    ["merge"]="⋔", ["message-circle"]="💬", ["message-circle-code"]="💬",
    ["message-circle-dashes"]="💬", ["message-circle-heart"]="💬",
    ["message-circle-more"]="💬", ["message-circle-off"]="⊘",
    ["message-circle-plus"]="💬", ["message-circle-question"]="💬",
    ["message-circle-reply"]="💬", ["message-circle-warning"]="💬",
    ["message-circle-x"]="💬",
    ["message-square"]="🗨", ["message-square-code"]="🗨",
    ["message-square-dashes"]="🗨", ["message-square-diff"]="🗨",
    ["message-square-dot"]="🗨", ["message-square-heart"]="🗨",
    ["message-square-lock"]="🗨", ["message-square-more"]="🗨",
    ["message-square-off"]="⊘", ["message-square-plus"]="🗨",
    ["message-square-quote"]="🗨", ["message-square-reply"]="🗨",
    ["message-square-share"]="🗨", ["message-square-text"]="🗨",
    ["message-square-warning"]="🗨", ["message-square-x"]="🗨",
    ["messages-square"]="💬",
    mic="🎤", ["mic-2"]="🎤", ["mic-off"]="🔇", ["mic-vocal"]="🎤",
    minimize="⊟", ["minimize-2"]="⊟",
    ["minus-circle"]="⊖", ["minus-square"]="⊟",
    ["monitor-check"]="🖥", ["monitor-cog"]="🖥", ["monitor-dot"]="🖥",
    ["monitor-down"]="🖥", ["monitor-off"]="⊘", ["monitor-pause"]="🖥",
    ["monitor-play"]="🖥", ["monitor-smartphone"]="🖥", ["monitor-speaker"]="🖥",
    ["monitor-stop"]="🖥", ["monitor-up"]="🖥", ["monitor-x"]="🖥",
    ["more-horizontal"]="⋯", ["more-vertical"]="⋮",
    ["mouse"]="◌", ["mouse-pointer"]="↖", ["mouse-pointer-2"]="↖",
    ["mouse-pointer-ban"]="⊘", ["mouse-pointer-click"]="↖",
    ["mouse-off"]="⊘", move="⤢", ["move-3d"]="⤢", ["move-diagonal"]="↗",
    ["move-diagonal-2"]="↙", ["move-down"]="↓", ["move-down-left"]="↙",
    ["move-down-right"]="↘", ["move-horizontal"]="↔", ["move-left"]="←",
    ["move-right"]="→", ["move-up"]="↑", ["move-up-left"]="↖",
    ["move-up-right"]="↗", ["move-vertical"]="↕",
    navigation="▲", ["navigation-2"]="◂", ["navigation-2-off"]="⊘",
    ["navigation-off"]="⊘",
    network="⊞", ["newspaper"]="📄", ["notebook"]="📓",
    ["notebook-pen"]="📓", ["notebook-tabs"]="📓", ["notebook-text"]="📓",
    octagon="⬡", ["octagon-alert"]="⊛", ["octagon-minus"]="⊖",
    ["octagon-pause"]="⏸", ["octagon-x"]="⊗",
    package="📦", ["package-2"]="📦", ["package-check"]="📦",
    ["package-minus"]="📦", ["package-open"]="📦", ["package-plus"]="📦",
    ["package-search"]="📦", ["package-x"]="📦",
    paintbrush="✏", ["paintbrush-2"]="✏", ["paintbrush-vertical"]="✏",
    ["paint-bucket"]="◈", ["paint-roller"]="✏",
    paperclip="📎", ["paperclip-2"]="📎",
    ["pause-circle"]="⏸", pencil="✏", ["pencil-line"]="✎",
    ["pencil-off"]="⊘", ["pencil-ruler"]="✏",
    percent="%", ["pi"]="π",
    ["phone-call"]="📞", ["phone-off"]="⊘", ["phone-forwarded"]="📞",
    ["phone-incoming"]="📞", ["phone-missed"]="📞", ["phone-outgoing"]="📞",
    ["pie-chart"]="◔", pin="📍", ["pin-off"]="📍", plane="✈",
    ["plane-landing"]="✈", ["plane-takeoff"]="✈",
    ["play-circle"]="▶", ["plug"]="⏻", ["plug-2"]="⏻", ["plug-zap"]="⚡",
    ["plug-zap-2"]="⚡",
    ["plus-circle"]="⊕", ["plus-square"]="⊞", pocket="◫",
    ["pocket-knife"]="✂", power="⏻", ["power-circle"]="⏻",
    ["power-off"]="⏻", ["power-square"]="⏻",
    printer="▣", ["printer-check"]="▣", puzzle="◌",
    radio="📻", ["radio-receiver"]="📻", ["radio-tower"]="📻",
    ["receipt"]="📄", ["receipt-cent"]="📄", ["receipt-euro"]="📄",
    ["receipt-indian-rupee"]="📄", ["receipt-japanese-yen"]="📄",
    ["receipt-pound-sterling"]="📄", ["receipt-russian-ruble"]="📄",
    ["receipt-swiss-franc"]="📄", ["receipt-text"]="📄",
    ["refresh-ccw"]="↺", ["refresh-cw"]="↻", ["refresh-ccw-dot"]="↺",
    ["refresh-cw-off"]="⊘",
    ["repeat"]="↺", ["repeat-1"]="↻", ["repeat-2"]="↺",
    rewind="⏮", rocket="▲", ["rotate-ccw"]="↺", ["rotate-cw"]="↻",
    ["rotate-ccw-square"]="↺", ["rotate-cw-square"]="↻",
    rss="▣", ruler="▬", save="💾", ["save-all"]="💾", ["save-off"]="⊘",
    scissors="✂", ["scissors-line-dashed"]="✂",
    scan="⊡", ["scan-barcode"]="⊡", ["scan-eye"]="⊡",
    ["scan-face"]="⊡", ["scan-heart"]="⊡", ["scan-line"]="⊡",
    ["scan-qr-code"]="⊡", ["scan-search"]="⊡", ["scan-text"]="⊡",
    server="▣", ["server-cog"]="▣", ["server-crash"]="▣",
    ["server-off"]="⊘",
    ["settings-2"]="⚙", shield="🛡", ["shield-alert"]="⚠",
    ["shield-ban"]="⊘", ["shield-check"]="✅", ["shield-ellipsis"]="🛡",
    ["shield-half"]="🛡", ["shield-minus"]="🛡", ["shield-off"]="⊘",
    ["shield-plus"]="🛡", ["shield-question"]="🛡", ["shield-user"]="🛡",
    ["shield-x"]="⊗", ["ship"]="▣", ["ship-wheel"]="◎",
    ["shirt"]="◌", ["shopping-bag"]="◫", ["shopping-basket"]="◫",
    ["shopping-cart"]="▣",
    shuffle="⇌", sidebar="▤", ["sidebar-close"]="▤", ["sidebar-open"]="▤",
    ["signal"]="📶", ["signal-high"]="📶", ["signal-low"]="📶",
    ["signal-medium"]="📶", ["signal-zero"]="📶",
    ["skip-back"]="⏮", ["skip-forward"]="⏭",
    slack="⊞", slash="∕", ["sliders"]="⊟", ["sliders-horizontal"]="⊟",
    smartphone="📱", ["smartphone-charging"]="📱", ["smartphone-nfc"]="📱",
    smile="☺", ["smile-plus"]="☺", snowflake="❄",
    speaker="🔊", ["speaker-off"]="🔇",
    ["spline"]="〜", ["split"]="⊟", ["split-square-horizontal"]="⊟",
    ["split-square-vertical"]="⊟",
    square="□", ["square-activity"]="〜", ["square-arrow-down"]="↓",
    ["square-arrow-down-left"]="↙", ["square-arrow-down-right"]="↘",
    ["square-arrow-left"]="←", ["square-arrow-out-down-left"]="↙",
    ["square-arrow-out-down-right"]="↘", ["square-arrow-out-up-left"]="↖",
    ["square-arrow-out-up-right"]="↗", ["square-arrow-right"]="→",
    ["square-arrow-up"]="↑", ["square-arrow-up-left"]="↖",
    ["square-arrow-up-right"]="↗", ["square-asterisk"]="✳",
    ["square-bottom-dashed-scissors"]="✂", ["square-check"]="☑",
    ["square-check-big"]="☑", ["square-chevron-down"]="⌄",
    ["square-chevron-left"]="‹", ["square-chevron-right"]="›",
    ["square-chevron-up"]="‸", ["square-code"]="</>",
    ["square-dashed"]="□", ["square-dashed-bottom"]="□",
    ["square-dashed-bottom-code"]="</>", ["square-dashed-kanban"]="□",
    ["square-dashed-mouse-pointer"]="↖", ["square-divide"]="÷",
    ["square-dot"]="□", ["square-equal"]="=", ["square-function"]="◌",
    ["square-gantt"]="▮", ["square-kanban"]="□", ["square-library"]="📖",
    ["square-m"]="M", ["square-menu"]="≡", ["square-minus"]="⊟",
    ["square-mouse-pointer"]="↖", ["square-parking"]="P",
    ["square-parking-off"]="⊘", ["square-pen"]="✎", ["square-percent"]="◌",
    ["square-pi"]="π", ["square-play"]="▶", ["square-plus"]="⊞",
    ["square-power"]="⏻", ["square-radical"]="√", ["square-scissors"]="✂",
    ["square-sigma"]="Σ", ["square-slash"]="∕", ["square-split-horizontal"]="⊟",
    ["square-split-vertical"]="⊟", ["square-stack"]="⧉",
    ["square-terminal"]="▣", ["square-user"]="👤",
    ["square-user-round"]="👤", ["square-x"]="⊠",
    ["squares-diagonal"]="⊠", ["squares-union"]="⊞",
    ["star-half"]="⯨", ["star-off"]="☆",
    ["step-back"]="⏮", ["step-forward"]="⏭",
    ["stethoscope"]="◎", ["stethoscope-off"]="⊘",
    ["sticky-note"]="📝",
    ["stop-circle"]="⏹", sunrise="🌅", sunset="🌇",
    ["superscript"]="x²", swords="✕", ["sword"]="✕",
    table="⊟", ["table-2"]="⊟", ["table-cells-merge"]="⊟",
    ["table-cells-split"]="⊟", ["table-columns-split"]="⊟",
    ["table-of-contents"]="☰", ["table-properties"]="⊟",
    ["table-rows-split"]="⊟",
    tablet="▣", ["tablet-smartphone"]="📱",
    target="◎", thermometer="▮", ["thermometer-snowflake"]="❄",
    ["thermometer-sun"]="☀",
    ["thumbs-down"]="▼", ["thumbs-up"]="▲",
    ticket="▣", ["ticket-check"]="▣", ["ticket-minus"]="▣",
    ["ticket-percent"]="▣", ["ticket-plus"]="▣", ["ticket-slash"]="▣",
    ["ticket-x"]="▣",
    timer="◎", ["timer-off"]="⊘", ["timer-reset"]="◎",
    ["toggle-left"]="◀", ["toggle-right"]="▶",
    tornado="◌", ["torus"]="◎",
    trash2="🗑", ["trash-2"]="🗑",
    ["trending-down"]="↘", ["trending-up"]="↗", ["trending-up-down"]="↕",
    triangle="△", ["triangle-alert"]="⚠", ["triangle-dashed"]="△",
    ["triangle-right"]="▶",
    truck="▣", ["truck-electric"]="▣", tv="📺", ["tv-2"]="🖥",
    ["tv-minimal"]="📺", ["tv-minimal-play"]="📺",
    type="T", umbrella="☂", ["umbrella-off"]="⊘",
    underline="_", ["undo"]="↩", ["undo-2"]="↩", ["undo-dot"]="↩",
    ["unfold-horizontal"]="↔", ["unfold-vertical"]="↕",
    ["ungroup"]="⊟", ["university"]="▣",
    ["upload-cloud"]="↑", ["user-check"]="✓", ["user-minus"]="−",
    ["user-plus"]="+", ["user-x"]="✕", users="👥", ["users-2"]="👥",
    ["user-cog"]="👤", ["user-lock"]="👤", ["user-pen"]="👤",
    ["user-round"]="👤", ["user-round-check"]="👤", ["user-round-cog"]="👤",
    ["user-round-minus"]="−", ["user-round-pen"]="👤", ["user-round-plus"]="+",
    ["user-round-search"]="👤", ["user-round-x"]="✕",
    ["user-search"]="👤", ["users-round"]="👥",
    verified="✅", video="▣", ["video-off"]="⊘",
    ["video-2"]="▣", ["video-2-off"]="⊘",
    voicemail="▬", volume="🔈", ["volume-1"]="🔉", ["volume-2"]="🔊",
    ["volume-x"]="🔇", ["volume-off"]="🔇",
    wallet="◫", ["wallet-cards"]="💳", ["wallet-minimal"]="◫",
    watch="⌚", ["webhook"]="⊙", ["webhook-off"]="⊘",
    ["wifi-off"]="⊘", ["wifi-high"]="📶", ["wifi-low"]="📶",
    ["wifi-zero"]="📶",
    ["x-circle"]="⊗", ["x-octagon"]="⊘", ["x-square"]="⊠",
    youtube="▶", ["zap-off"]="⊘", ["zoom-in"]="⊕", ["zoom-out"]="⊖",
    ["align-end-horizontal"]="⊟", ["align-end-vertical"]="⊟",
    ["align-start-horizontal"]="⊟", ["align-start-vertical"]="⊟",
    ["anvil"]="▬", ["apple"]="◉", ["armchair"]="◫",
    ["arrow-down-0-1"]="↓", ["arrow-down-1-0"]="↓",
    ["arrow-down-a-z"]="↓", ["arrow-down-z-a"]="↓",
    ["arrow-down-narrow-wide"]="↓", ["arrow-down-wide-narrow"]="↓",
    ["arrow-up-0-1"]="↑", ["arrow-up-1-0"]="↑",
    ["arrow-up-a-z"]="↑", ["arrow-up-z-a"]="↑",
    ["arrow-up-narrow-wide"]="↑", ["arrow-up-wide-narrow"]="↑",
    ["asterisk"]="✳", ["at"]="@", ["audio-lines"]="〜",
    ["audio-waveform"]="〜", ["badge-alert"]="⬡", ["badge-cent"]="⬡",
    ["badge-check"]="⬡", ["badge-dollar-sign"]="⬡", ["badge-euro"]="⬡",
    ["badge-help"]="⬡", ["badge-indian-rupee"]="⬡", ["badge-info"]="⬡",
    ["badge-japanese-yen"]="⬡", ["badge-minus"]="⬡",
    ["badge-percent"]="⬡", ["badge-plus"]="⬡",
    ["badge-pound-sterling"]="⬡", ["badge-russian-ruble"]="⬡",
    ["badge-swiss-franc"]="⬡", ["badge-x"]="⬡",
    ["baseline"]="▬", ["bath"]="◌", ["between-horizontal-end"]="⊟",
    ["between-horizontal-start"]="⊟", ["between-vertical-end"]="⊟",
    ["between-vertical-start"]="⊟",
    ["bitcoin"]="₿", ["blend"]="◎", ["blocks"]="⊞",
    ["bluetooth"]="◌", ["bluetooth-connected"]="◌",
    ["bluetooth-off"]="⊘", ["bluetooth-searching"]="◌",
    ["bookmark-check"]="🔖", ["bookmark-minus"]="🔖", ["bookmark-plus"]="🔖",
    ["bookmark-x"]="🔖",
    ["bot-message-square"]="💬", ["bot-off"]="⊘",
    ["brackets"]="[]", ["braces"]="{}",
    ["brain-circuit"]="◌", ["bring-to-front"]="⧉", ["send-to-back"]="⧉",
    ["bus-front"]="▣", ["camera-off"]="⊘",
    ["cell-signal-full"]="📶", ["cell-signal-high"]="📶",
    ["cell-signal-low"]="📶", ["cell-signal-medium"]="📶",
    ["cell-signal-none"]="📶", ["cell-signal-off"]="⊘",
    ["clapperboard"]="◌", ["cloud-cog"]="⚙", ["code-2"]="</>",
    ["code-xml"]="</>", ["codepen"]="◉", ["codesandbox"]="◉",
    ["coffee-2"]="☕", ["coins"]="₿", ["contrast"]="◐",
    ["cookie"]="○", ["copy-check"]="⧉", ["copy-minus"]="⧉",
    ["copy-plus"]="⧉", ["copy-slash"]="⧉", ["copy-x"]="⧉",
    ["copyright"]="©", ["cpu"]="💻", ["creative-commons"]="◉",
    ["crisp"]="◎", ["cross"]="✕", ["crown-2"]="♛",
    ["cylinder"]="○", ["datacloud"]="☁",
    ["diff"]="⊟", ["dog"]="◌", ["drama"]="◌", ["dribbble"]="◎",
    ["dropzone"]="↓", ["dvd"]="◎", ["earth"]="🌍",
    ["earth-lock"]="🌍", ["eclipse"]="◐", ["ellipsis"]="⋯",
    ["ellipsis-vertical"]="⋮", ["employee-2"]="👤",
    ["eraser"]="✏", ["ethernet-port"]="⛓", ["file-archive"]="📄",
    ["file-audio"]="📄", ["file-audio-2"]="📄", ["file-axis-3d"]="📄",
    ["file-badge"]="📄", ["file-badge-2"]="📄", ["file-bar-chart"]="📄",
    ["file-bar-chart-2"]="📄", ["file-box"]="📄", ["file-chart-column"]="📄",
    ["file-chart-column-increasing"]="📄", ["file-chart-line"]="📄",
    ["file-chart-pie"]="📄", ["file-check"]="📄", ["file-check-2"]="📄",
    ["file-clock"]="📄", ["file-code"]="📄", ["file-code-2"]="📄",
    ["file-cog"]="📄", ["file-diff"]="📄", ["file-digit"]="📄",
    ["file-down"]="📄", ["file-heart"]="📄", ["file-image"]="📄",
    ["file-input"]="📄", ["file-json"]="📄", ["file-json-2"]="📄",
    ["file-key"]="📄", ["file-key-2"]="📄", ["file-line-chart"]="📄",
    ["file-lock"]="📄", ["file-lock-2"]="📄", ["file-minus"]="📄",
    ["file-minus-2"]="📄", ["file-music"]="📄", ["file-output"]="📄",
    ["file-pen"]="📄", ["file-pen-line"]="📄", ["file-pie-chart"]="📄",
    ["file-plus"]="📄", ["file-plus-2"]="📄", ["file-question"]="📄",
    ["file-scan"]="📄", ["file-search"]="📄", ["file-search-2"]="📄",
    ["file-sliders"]="📄", ["file-spreadsheet"]="📄",
    ["file-stack"]="📄", ["file-symlink"]="📄", ["file-terminal"]="📄",
    ["file-text"]="📄", ["file-type"]="📄", ["file-type-2"]="📄",
    ["file-up"]="📄", ["file-user"]="📄", ["file-video"]="📄",
    ["file-video-2"]="📄", ["file-volume"]="📄", ["file-volume-2"]="📄",
    ["file-warning"]="📄", ["file-x"]="📄", ["file-x-2"]="📄",
    ["figma"]="◎", ["filter-x"]="⊟", ["fingerprint"]="◌",
    ["fish"]="◌", ["fish-off"]="⊘", ["fish-symbol"]="◌",
    ["flag-off"]="⊘", ["flag-triangle-left"]="⚑", ["flag-triangle-right"]="⚑",
    ["flask-conical"]="⚗", ["flask-conical-off"]="⊘", ["flask-round"]="⚗",
    ["focus"]="◎", ["fold-horizontal"]="↔", ["fold-vertical"]="↕",
    ["footprints"]="◌", ["forklift"]="▣", ["frame"]="□",
    ["framer"]="◎", ["frown-2"]="☹", ["fuel"]="◌",
    ["fullscreen"]="⤢", ["function-square"]="◌",
    ["gallery-horizontal"]="▣", ["gallery-horizontal-end"]="▣",
    ["gallery-thumbnails"]="▣", ["gallery-vertical"]="▣",
    ["gallery-vertical-end"]="▣", ["gamepad"]="◌", ["gamepad-2"]="◌",
    ["gauge"]="◎", ["gauge-circle"]="◎", ["gavel"]="▬",
    ["gem"]="◆", ["ghost"]="◌", ["glasses"]="◎", ["globe-lock"]="🌐",
    ["goal"]="◎", ["go-kart"]="▣",
    ["hammer"]="▬", ["hand-coins"]="✋", ["hand-heart"]="✋",
    ["hands-clapping"]="✋", ["hard-drive-2"]="💾",
    ["heading"]="H", ["heading-1"]="H1", ["heading-2"]="H2",
    ["heading-3"]="H3", ["heading-4"]="H4", ["heading-5"]="H5",
    ["heading-6"]="H6",
    ["heart-crack"]="♥", ["heart-handshake"]="♥", ["heart-off"]="⊘",
    ["heart-pulse"]="♥", ["heater"]="◌", ["helmet"]="◈",
    ["help-circle"]="?", ["haze"]="◌", ["house-2"]="⌂",
    ["ice-cream"]="◌", ["ice-cream-2"]="◌", ["image-down"]="🖼",
    ["image-minus"]="🖼", ["image-off"]="⊘", ["image-play"]="🖼",
    ["image-plus"]="🖼", ["image-up"]="🖼", ["image-upscale"]="🖼",
    ["images"]="🖼", ["import"]="↓",
    ["indent-decrease"]="≡", ["indent-increase"]="≡",
    ["infinity"]="∞", ["inspection-panel"]="□",
    ["instagram"]="◉", ["italic"]="I",
    ["japanese-yen"]="¥", ["joystick"]="◌",
    ["kanban"]="□", ["key-2"]="🔑",
    ["language"]="◌", ["lasso"]="◌", ["lasso-select"]="◌",
    ["layers-2"]="⧉", ["layers-3"]="⧉",
    ["layout-bottom"]="▤", ["layout-top"]="▤",
    ["letter-text"]="T", ["lightbulb"]="💡", ["lightbulb-off"]="⊘",
    ["line-chart"]="〜", ["linkedin"]="ℒ", ["list-checks"]="☑",
    ["list-collapse"]="≡", ["list-end"]="≡", ["list-filter"]="⊟",
    ["list-minus"]="≡", ["list-music"]="♪", ["list-ordered"]="≡",
    ["list-plus"]="≡", ["list-restart"]="↺", ["list-start"]="≡",
    ["list-todo"]="☑", ["list-tree"]="≡", ["list-video"]="▣",
    ["list-x"]="✕", ["locate"]="◎", ["locate-fixed"]="◎",
    ["locate-off"]="⊘", ["log"]="📄",
    ["luggage"]="◫", ["magnet"]="◌",
    ["mail-warning"]="✉", ["map-pinned"]="📍",
    ["martini"]="◌", ["maximize-2"]="⤢",
    ["megaphone"]="◌", ["megaphone-off"]="⊘",
    ["memory-stick"]="💾", ["merge"]="⋔",
    ["microchip"]="◌", ["microscope"]="◌",
    ["milestone"]="◌", ["milk"]="◌", ["milk-off"]="⊘",
    ["minimize-2"]="⊟",
    ["monitor-pause"]="🖥", ["moon-star"]="🌙",
    ["mountain"]="▲", ["mountain-snow"]="▲",
    ["mouse-2"]="◌", ["music-2"]="♪", ["music-3"]="♪",
    ["music-4"]="♪",
    ["navigation-off"]="⊘", ["network-2"]="⊞",
    ["nfc"]="◌", ["no-smoking"]="⊘",
    ["nut"]="◌", ["nut-off"]="⊘",
    ["omega"]="Ω", ["option"]="⌥",
    ["orbit"]="◎", ["origami"]="◌",
    ["package-2"]="📦", ["paintbrush-2"]="✏",
    ["palette"]="◈", ["panel-bottom"]="▤", ["panel-bottom-close"]="▤",
    ["panel-bottom-dashed"]="▤", ["panel-bottom-open"]="▤",
    ["panel-left"]="▤", ["panel-left-close"]="▤",
    ["panel-left-dashed"]="▤", ["panel-left-open"]="▤",
    ["panel-right"]="▤", ["panel-right-close"]="▤",
    ["panel-right-dashed"]="▤", ["panel-right-open"]="▤",
    ["panel-top"]="▤", ["panel-top-close"]="▤",
    ["panel-top-dashed"]="▤", ["panel-top-open"]="▤",
    ["panels-left-bottom"]="▤", ["panels-right-bottom"]="▤",
    ["panels-top-left"]="▤",
    ["parentheses"]="()", ["party-popper"]="◈",
    ["pause-octagon"]="⏸", ["paw-print"]="◌",
    ["penny"]="◌", ["person-standing"]="◌",
    ["phone-2"]="📞",
    ["picture-in-picture"]="▣", ["picture-in-picture-2"]="▣",
    ["piggy-bank"]="◌", ["pilcrow"]="¶", ["pill"]="◌",
    ["pill-bottle"]="◌", ["pin-2"]="📍",
    ["pipette"]="◌", ["pizza"]="◌",
    ["planet"]="◎", ["play-2"]="▶",
    ["podcast"]="◌", ["pointer"]="↖",
    ["pointer-off"]="⊘", ["projector"]="◌",
    ["proportions"]="◎", ["qr-code"]="⊡",
    ["quote"]="❝", ["rabbit"]="◌",
    ["radar"]="◎", ["radiation"]="◌",
    ["rainbow"]="◌", ["rat"]="◌",
    ["rectangle-ellipsis"]="□", ["rectangle-horizontal"]="□",
    ["rectangle-vertical"]="□",
    ["recycle"]="↺", ["redo"]="↪", ["redo-2"]="↪", ["redo-dot"]="↪",
    ["regex"]=".*", ["remove-formatting"]="✕",
    ["replace"]="↺", ["replace-all"]="↺",
    ["rewind-2"]="⏮", ["ribbon"]="◌",
    ["rotate-3d"]="↺", ["route"]="◌", ["route-off"]="⊘",
    ["row-selection"]="⊟", ["rows-2"]="⊟", ["rows-3"]="⊟",
    ["rows-4"]="⊟", ["rss"]="▣",
    ["sailboat"]="◌", ["sandwich"]="◌", ["satellite"]="◎",
    ["satellite-dish"]="◎",
    ["scale"]="▬", ["scale-3d"]="▬",
    ["scaling"]="⤢", ["school"]="▣", ["school-2"]="▣",
    ["scroll"]="◌", ["scroll-text"]="◌",
    ["search-check"]="🔍", ["search-code"]="🔍", ["search-slash"]="🔍",
    ["search-x"]="🔍",
    ["section"]="§", ["send-horizontal"]="➤", ["send-2"]="➤",
    ["separator-horizontal"]="▬", ["separator-vertical"]="▮",
    ["shapes"]="◎", ["share-2"]="⎋",
    ["signpost"]="◌", ["signpost-big"]="◌",
    ["skeleton"]="◌", ["skull"]="◌", ["skull-crossbones"]="✕",
    ["slack-2"]="⊞", ["slash-circle"]="⊘",
    ["sliders-2"]="⊟",
    ["snail"]="◌", ["snowflake-2"]="❄",
    ["social"]="◉", ["sofa"]="◫",
    ["sort-asc"]="↑", ["sort-desc"]="↓",
    ["space"]="□", ["spade"]="◌",
    ["sparkle"]="✳", ["sparkles"]="✳", ["speech-speech"]="💬",
    ["spell-check"]="✓", ["spell-check-2"]="✓",
    ["sprout"]="◌", ["squircle"]="□",
    ["stamp"]="◌", ["star-2"]="★",
    ["sticker"]="◌", ["strikethrough"]="S̶",
    ["subscript"]="x₂", ["sun-dim"]="☀", ["sun-medium"]="☀",
    ["sun-moon"]="☀", ["sun-snow"]="☀", ["sun-high"]="☀",
    ["swatch-book"]="◈", ["swiss-franc"]="₣",
    ["symbol"]="◌", ["syringe"]="◌",
    ["tabs"]="▤", ["tally-1"]="▮", ["tally-2"]="▮▮",
    ["tally-3"]="▮▮▮", ["tally-4"]="▮▮▮▮", ["tally-5"]="▮▮▮▮▮",
    ["tangent"]="〜", ["tape"]="▬", ["test-tube"]="⚗",
    ["test-tube-2"]="⚗", ["test-tubes"]="⚗",
    ["text"]="T", ["text-cursor"]="▮", ["text-cursor-input"]="▮",
    ["text-quote"]="❝", ["text-search"]="🔍", ["text-select"]="T",
    ["threads"]="◉", ["thumbs-up-2"]="▲",
    ["tic-tac-toe"]="⊠", ["token"]="◌",
    ["tractor"]="▣", ["traffic-cone"]="▲",
    ["train-front"]="▣", ["train-track"]="▬",
    ["tram-front"]="▣", ["tree-deciduous"]="◌",
    ["tree-palm"]="◌", ["tree-pine"]="◌",
    ["trending-down-2"]="↘", ["trending-up-2"]="↗",
    ["trophy"]="◈", ["turtle"]="◌",
    ["twitch"]="◉", ["twitter"]="◉",
    ["undo-dot"]="↩", ["unlink"]="🔗", ["unlink-2"]="⛓",
    ["usb"]="◌", ["user-2"]="👤", ["utensils"]="◌",
    ["utensils-crossed"]="✕", ["utility-pole"]="◌",
    ["variable"]="◌", ["vault"]="▣",
    ["venetian-mask"]="◌", ["vibrate"]="◌", ["vibrate-off"]="⊘",
    ["view"]="👁", ["vihara"]="▣", ["voicemail-2"]="▬",
    ["waypoints"]="◎", ["weight"]="▬",
    ["wheat"]="◌", ["wheat-off"]="⊘",
    ["whole-word"]="T", ["wind-2"]="💨",
    ["wine"]="◌", ["wine-off"]="⊘",
    ["worm"]="◌", ["wrap-text"]="T",
    ["x-2"]="✕", ["zero"]="0", ["zap-2"]="⚡",
}

local function Tween(obj, props, t, style, dir)
    TweenService:Create(obj, TweenInfo.new(
        t     or 0.25,
        style or Enum.EasingStyle.Quint,
        dir   or Enum.EasingDirection.Out
    ), props):Play()
end

local function Spring(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(
        t or 0.40,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.Out
    ), props):Play()
end

local function Snap(obj, props, t)
    TweenService:Create(obj, TweenInfo.new(
        t or 0.18,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    ), props):Play()
end

local function Corner(parent, r)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, r or 10)
    c.Parent = parent
    return c
end

local function Pad(parent, top, right, bottom, left)
    local p = Instance.new("UIPadding")
    p.PaddingTop    = UDim.new(0, top    or 0)
    p.PaddingRight  = UDim.new(0, right  or 0)
    p.PaddingBottom = UDim.new(0, bottom or 0)
    p.PaddingLeft   = UDim.new(0, left   or 0)
    p.Parent = parent
end

local function ResolveIcon(icon)
    if not icon then return nil, false end
    if type(icon) == "number" then return "rbxassetid://" .. icon, true end
    if type(icon) == "string" then
        if icon:match("^rbxassetid://") then return icon, true end
        if icon:match("^%d+$") then return "rbxassetid://" .. icon, true end
        return ICONS[icon:lower()] or icon, false
    end
    return nil, false
end

function Library:CreateWindow(cfg)
    cfg = cfg or {}
    local title      = cfg.Title           or "Settings"
    local subtitle   = cfg.SubTitle        or ""
    local loadTitle  = cfg.LoadingTitle    or "Loading"
    local loadSub    = cfg.LoadingSubtitle or "Please wait…"
    local loadImage  = cfg.LoadingImage
    local showText   = cfg.ShowText        or "Open"
    local themeName  = cfg.Theme           or "Light"

    T = Themes[themeName] or Themes.Light

    local _nodes = {}

    local function Reg(obj, prop, key)
        if obj and prop and key then
            table.insert(_nodes, {obj = obj, prop = prop, key = key})
        end
    end

    local function RegFn(fn)
        if fn then table.insert(_nodes, {fn = fn}) end
    end

    local Gui = Instance.new("ScreenGui")
    Gui.Name            = "iOSUILib"
    Gui.ResetOnSpawn    = false
    Gui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
    Gui.IgnoreGuiInset  = true
    local ok = pcall(function() Gui.Parent = gethui() end)
    if not ok then
        Gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    end

    local function GetWinSize()
        local sw = Gui.AbsoluteSize.X
        local sh = Gui.AbsoluteSize.Y
        local w  = math.clamp(math.floor(sw * 0.92), 320, 580)
        local h  = math.clamp(math.floor(sh * 0.80), 400, 620)
        return w, h
    end

    local LoadScreen = Instance.new("Frame")
    LoadScreen.Name             = "LoadScreen"
    LoadScreen.BackgroundColor3 = T.HeaderBG
    LoadScreen.BorderSizePixel  = 0
    LoadScreen.Size             = UDim2.new(1, 0, 1, 0)
    LoadScreen.ZIndex           = 200
    LoadScreen.Parent           = Gui

    local LoadCenter = Instance.new("Frame")
    LoadCenter.BackgroundTransparency = 1
    LoadCenter.Size     = UDim2.new(0, 280, 0, 240)
    LoadCenter.Position = UDim2.new(0.5, -140, 0.5, -120)
    LoadCenter.ZIndex   = 201
    LoadCenter.Parent   = LoadScreen

    local loadOff = 0
    if loadImage then
        local iconVal, isAsset = ResolveIcon(loadImage)
        local iconSize = 80
        if isAsset then
            local img = Instance.new("ImageLabel")
            img.BackgroundColor3 = T.BG
            img.BorderSizePixel  = 0
            img.Size             = UDim2.new(0, iconSize, 0, iconSize)
            img.Position         = UDim2.new(0.5, -iconSize/2, 0, 0)
            img.Image            = iconVal
            img.ScaleType        = Enum.ScaleType.Fit
            img.ZIndex           = 202
            img.Parent           = LoadCenter
            Corner(img, 20)
        else
            local gl = Instance.new("TextLabel")
            gl.BackgroundTransparency = 1
            gl.Size       = UDim2.new(0, iconSize, 0, iconSize)
            gl.Position   = UDim2.new(0.5, -iconSize/2, 0, 0)
            gl.Text       = iconVal or "⊙"
            gl.TextSize   = 52
            gl.Font       = Enum.Font.Gotham
            gl.TextColor3 = T.Accent
            gl.ZIndex     = 202
            gl.Parent     = LoadCenter
        end
        loadOff = iconSize + 14
    end

    local function MkLoadLbl(text, y, bold, size)
        local l = Instance.new("TextLabel")
        l.BackgroundTransparency = 1
        l.Size     = UDim2.new(1, 0, 0, 28)
        l.Position = UDim2.new(0, 0, 0, loadOff + y)
        l.Text     = text
        l.TextColor3     = bold and T.Text or T.SubText
        l.Font           = bold and Enum.Font.GothamBold or Enum.Font.Gotham
        l.TextSize       = size or (bold and 20 or 14)
        l.TextXAlignment = Enum.TextXAlignment.Center
        l.ZIndex   = 202
        l.Parent   = LoadCenter
        return l
    end
    MkLoadLbl(loadTitle, 4,  true,  20)
    MkLoadLbl(loadSub,   32, false, 14)

    local Spinner = Instance.new("Frame")
    Spinner.BackgroundTransparency = 1
    Spinner.Size     = UDim2.new(0, 36, 0, 36)
    Spinner.Position = UDim2.new(0.5, -18, 0, loadOff + 76)
    Spinner.ZIndex   = 202
    Spinner.Parent   = LoadCenter

    for i = 1, 10 do
        local dot = Instance.new("Frame")
        dot.BackgroundColor3       = T.Accent
        dot.BackgroundTransparency = 1 - ((i / 10) ^ 1.4)
        dot.BorderSizePixel        = 0
        local dotSize = 3 + (i / 10) * 5
        dot.Size        = UDim2.new(0, dotSize, 0, dotSize)
        dot.AnchorPoint = Vector2.new(0.5, 0.5)
        local ang = math.rad((i - 1) * 36)
        dot.Position = UDim2.new(0.5, math.cos(ang) * 15, 0.5, math.sin(ang) * 15)
        dot.ZIndex   = 203
        dot.Parent   = Spinner
        Corner(dot, math.ceil(dotSize / 2))
    end

    local spinAngle = 0
    local spinConn  = RunService.Heartbeat:Connect(function(dt)
        spinAngle = (spinAngle + dt * 320) % 360
        Spinner.Rotation = spinAngle
    end)

    local winW, winH = GetWinSize()
    local HEADER_H   = 58
    local TABBAR_H   = 50

    local Win = Instance.new("Frame")
    Win.Name             = "Window"
    Win.BackgroundColor3 = T.BG
    Win.BorderSizePixel  = 0
    Win.Size             = UDim2.new(0, winW, 0, winH)
    Win.Position         = UDim2.new(0.5, -winW/2, 0.5, -winH/2)
    Win.ClipsDescendants = true
    Win.Visible          = false
    Win.ZIndex           = 10
    Win.Parent           = Gui
    Corner(Win, 20)
    Reg(Win, "BackgroundColor3", "BG")

    local DragHandle = Instance.new("Frame")
    DragHandle.BackgroundColor3 = T.Handle
    DragHandle.BorderSizePixel  = 0
    DragHandle.Size             = UDim2.new(0, 36, 0, 4)
    DragHandle.Position         = UDim2.new(0.5, -18, 0, 9)
    DragHandle.ZIndex           = 20
    DragHandle.Parent           = Win
    Corner(DragHandle, 2)
    Reg(DragHandle, "BackgroundColor3", "Handle")

    local Header = Instance.new("Frame")
    Header.Name             = "Header"
    Header.BackgroundColor3 = T.HeaderBG
    Header.BorderSizePixel  = 0
    Header.Size             = UDim2.new(1, 0, 0, HEADER_H)
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

    local hasSub = subtitle ~= ""

    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.AnchorPoint     = Vector2.new(0.5, 0.5)
    TitleLbl.Size            = UDim2.new(0, 260, 0, hasSub and 20 or 26)
    TitleLbl.Position        = UDim2.new(0.5, 0, 0.5, hasSub and -11 or 0)
    TitleLbl.Text            = title
    TitleLbl.TextColor3      = T.Text
    TitleLbl.Font            = Enum.Font.GothamBold
    TitleLbl.TextSize        = 17
    TitleLbl.TextXAlignment  = Enum.TextXAlignment.Center
    TitleLbl.TextYAlignment  = Enum.TextYAlignment.Center
    TitleLbl.ZIndex          = 13
    TitleLbl.Parent          = Header
    Reg(TitleLbl, "TextColor3", "Text")

    if hasSub then
        local SubLbl = Instance.new("TextLabel")
        SubLbl.BackgroundTransparency = 1
        SubLbl.AnchorPoint     = Vector2.new(0.5, 0.5)
        SubLbl.Size            = UDim2.new(0, 260, 0, 16)
        SubLbl.Position        = UDim2.new(0.5, 0, 0.5, 10)
        SubLbl.Text            = subtitle
        SubLbl.TextColor3      = T.SubText
        SubLbl.Font            = Enum.Font.Gotham
        SubLbl.TextSize        = 12
        SubLbl.TextXAlignment  = Enum.TextXAlignment.Center
        SubLbl.TextYAlignment  = Enum.TextYAlignment.Center
        SubLbl.ZIndex          = 13
        SubLbl.Parent          = Header
        Reg(SubLbl, "TextColor3", "SubText")
    end

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.AnchorPoint     = Vector2.new(1, 0.5)
    CloseBtn.Size            = UDim2.new(0, 52, 0, 36)
    CloseBtn.Position        = UDim2.new(1, -8, 0.5, 0)
    CloseBtn.Text            = "Done"
    CloseBtn.TextColor3      = T.Accent
    CloseBtn.Font            = Enum.Font.GothamBold
    CloseBtn.TextSize        = 16
    CloseBtn.ZIndex          = 14
    CloseBtn.Parent          = Header
    Reg(CloseBtn, "TextColor3", "Accent")

    local closeBtnScale = Instance.new("UIScale")
    closeBtnScale.Scale  = 1
    closeBtnScale.Parent = CloseBtn

    CloseBtn.MouseEnter:Connect(function()
        Snap(CloseBtn, {TextColor3 = T.AccentDark}, 0.12)
    end)
    CloseBtn.MouseLeave:Connect(function()
        Tween(CloseBtn, {TextColor3 = T.Accent}, 0.22)
    end)
    CloseBtn.MouseButton1Down:Connect(function()
        Snap(closeBtnScale, {Scale = 0.88}, 0.10)
    end)
    CloseBtn.MouseButton1Up:Connect(function()
        Spring(closeBtnScale, {Scale = 1}, 0.36)
    end)

    local TabBar = Instance.new("Frame")
    TabBar.Name             = "TabBar"
    TabBar.BackgroundColor3 = T.HeaderBG
    TabBar.BorderSizePixel  = 0
    TabBar.Size             = UDim2.new(1, 0, 0, TABBAR_H)
    TabBar.Position         = UDim2.new(0, 0, 0, HEADER_H)
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

    local lastTabW = -1
    TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        local w = TabLayout.AbsoluteContentSize.X
        if w == lastTabW then return end
        lastTabW = w
        TabScroll.CanvasSize = UDim2.new(0, w, 0, 0)
    end)

    local ContentArea = Instance.new("Frame")
    ContentArea.BackgroundTransparency = 1
    ContentArea.Size             = UDim2.new(1, 0, 1, -(HEADER_H + TABBAR_H))
    ContentArea.Position         = UDim2.new(0, 0, 0, HEADER_H + TABBAR_H)
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
    ShowBtn.Size             = UDim2.new(0, 108, 0, 42)
    ShowBtn.Position         = UDim2.new(0.5, -54, 0, 18)
    ShowBtn.Text             = showText
    ShowBtn.TextColor3       = T.White
    ShowBtn.Font             = Enum.Font.GothamBold
    ShowBtn.TextSize         = 15
    ShowBtn.Visible          = false
    ShowBtn.ZIndex           = 100
    ShowBtn.Parent           = Gui
    Corner(ShowBtn, 21)
    Reg(ShowBtn, "BackgroundColor3", "Accent")
    Reg(ShowBtn, "TextColor3", "White")

    local showBtnScale = Instance.new("UIScale")
    showBtnScale.Scale  = 1
    showBtnScale.Parent = ShowBtn
    ShowBtn.MouseButton1Down:Connect(function()
        Snap(showBtnScale, {Scale = 0.94}, 0.10)
    end)
    ShowBtn.MouseButton1Up:Connect(function()
        Spring(showBtnScale, {Scale = 1}, 0.36)
    end)

    local isDragging  = false
    local dragStart   = nil
    local startWinPos = nil

    Header.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            isDragging  = true
            dragStart   = inp.Position
            startWinPos = Win.Position
            Snap(DragHandle, {Size = UDim2.new(0, 28, 0, 4)}, 0.16)
        end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if not isDragging then return end
        if inp.UserInputType ~= Enum.UserInputType.MouseMovement
        and inp.UserInputType ~= Enum.UserInputType.Touch then return end
        local d = inp.Position - dragStart
        Win.Position = UDim2.new(
            startWinPos.X.Scale, startWinPos.X.Offset + d.X,
            startWinPos.Y.Scale, startWinPos.Y.Offset + d.Y
        )
    end)

    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1
        or inp.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
            Spring(DragHandle, {Size = UDim2.new(0, 36, 0, 4)}, 0.38)
        end
    end)

    local winScale = nil

    CloseBtn.MouseButton1Click:Connect(function()
        local wp = Win.Position
        if winScale then Snap(winScale, {Scale = 0.94}, 0.22) end
        Tween(Win, {
            BackgroundTransparency = 1,
            Position = UDim2.new(wp.X.Scale, wp.X.Offset, wp.Y.Scale, wp.Y.Offset + 32)
        }, 0.28, Enum.EasingStyle.Quint)
        for _, d in ipairs(Win:GetDescendants()) do
            if d:IsA("TextLabel") or d:IsA("TextButton") then
                Snap(d, {TextTransparency = 1}, 0.18)
            end
        end
        task.delay(0.30, function()
            Win.Visible                = false
            Win.BackgroundTransparency = 0
            Win.Position               = wp
            if winScale then winScale.Scale = 1 end
            for _, d in ipairs(Win:GetDescendants()) do
                if d:IsA("TextLabel") or d:IsA("TextButton") then
                    d.TextTransparency = 0
                end
            end
            ShowBtn.Visible                = true
            ShowBtn.BackgroundTransparency = 1
            ShowBtn.Size = UDim2.new(0, 80, 0, 36)
            showBtnScale.Scale = 0.82
            Tween(ShowBtn, {BackgroundTransparency = 0, Size = UDim2.new(0, 108, 0, 42)},
                0.28, Enum.EasingStyle.Quint)
            Spring(showBtnScale, {Scale = 1}, 0.44)
        end)
    end)

    ShowBtn.MouseButton1Click:Connect(function()
        Snap(ShowBtn, {BackgroundTransparency = 1}, 0.16)
        Snap(showBtnScale, {Scale = 0.88}, 0.16)
        task.delay(0.18, function()
            ShowBtn.Visible = false
            ShowBtn.Size    = UDim2.new(0, 108, 0, 42)
            showBtnScale.Scale = 1
            local wp = Win.Position
            Win.Visible                = true
            Win.BackgroundTransparency = 1
            Win.Position = UDim2.new(wp.X.Scale, wp.X.Offset, wp.Y.Scale, wp.Y.Offset + 44)
            if winScale then winScale.Scale = 0.90 end
            Tween(Win, {
                BackgroundTransparency = 0,
                Position = UDim2.new(wp.X.Scale, wp.X.Offset, wp.Y.Scale, wp.Y.Offset)
            }, 0.46, Enum.EasingStyle.Quint)
            if winScale then Spring(winScale, {Scale = 1}, 0.50) end
        end)
    end)

    task.spawn(function()
        task.wait(2.4)
        spinConn:Disconnect()

        Tween(LoadScreen, {BackgroundTransparency = 1}, 0.38, Enum.EasingStyle.Quint)
        for _, d in ipairs(LoadScreen:GetDescendants()) do
            if d:IsA("GuiObject") then
                local tp = {BackgroundTransparency = 1}
                if d:IsA("TextLabel")  then tp.TextTransparency  = 1 end
                if d:IsA("ImageLabel") then tp.ImageTransparency = 1 end
                Tween(d, tp, 0.34, Enum.EasingStyle.Quint)
            end
        end
        task.wait(0.42)
        LoadScreen:Destroy()

        local nw, nh = GetWinSize()
        Win.Visible                = true
        Win.BackgroundTransparency = 1
        Win.Position = UDim2.new(0.5, -nw/2, 0.5, -nh/2 + 52)

        winScale = Instance.new("UIScale")
        winScale.Scale  = 0.86
        winScale.Parent = Win

        Tween(Win, {
            BackgroundTransparency = 0,
            Position = UDim2.new(0.5, -nw/2, 0.5, -nh/2)
        }, 0.50, Enum.EasingStyle.Quint)
        Spring(winScale, {Scale = 1}, 0.52)
    end)

    local WindowObj = {}
    local _tabs     = {}
    local _tabCount = 0

    local function DeactivateAllTabs()
        for _, td in ipairs(_tabs) do
            td.content.Visible    = false
            td.activeLine.Visible = false
            td.activeLine.Size    = UDim2.new(0, 0, 0, 3)
            Snap(td.label, {TextColor3 = T.TabInactive}, 0.16)
            if td.icon then
                local prop = td.icon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"
                Snap(td.icon, {[prop] = T.TabInactive}, 0.16)
            end
            if td.tabScale then
                Snap(td.tabScale, {Scale = 1}, 0.16)
            end
        end
    end

    function WindowObj:SetTheme(name)
        T = Themes[name] or Themes.Light
        local live = {}
        for _, n in ipairs(_nodes) do
            if n.fn then
                n.fn()
                live[#live + 1] = n
            elseif n.obj and n.obj.Parent then
                local val = T[n.key]
                if val then
                    Tween(n.obj, {[n.prop] = val}, 0.28, Enum.EasingStyle.Quint)
                end
                live[#live + 1] = n
            end
        end
        _nodes = live
        for _, td in ipairs(_tabs) do
            local isActive = td.content.Visible
            local col = isActive and T.TabActive or T.TabInactive
            Tween(td.label, {TextColor3 = col}, 0.28, Enum.EasingStyle.Quint)
            Tween(td.activeLine, {BackgroundColor3 = T.TabActive}, 0.28, Enum.EasingStyle.Quint)
            if td.icon then
                local prop = td.icon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"
                Tween(td.icon, {[prop] = col}, 0.28, Enum.EasingStyle.Quint)
            end
        end
        if TabFadeOverlay then
            Reg(TabFadeOverlay, "BackgroundColor3", "BG")
        end
    end

    function WindowObj:CreateTab(tabCfg)
        tabCfg = tabCfg or {}
        local tabTitle = tabCfg.Title or "Tab"
        local tabLogo  = tabCfg.Logo

        _tabCount = _tabCount + 1
        local idx  = _tabCount
        local minW = math.max(78, #tabTitle * 8 + 36)

        local TabBtn = Instance.new("TextButton")
        TabBtn.BackgroundTransparency = 1
        TabBtn.Size        = UDim2.new(0, minW, 1, 0)
        TabBtn.Text        = ""
        TabBtn.ZIndex      = 14
        TabBtn.LayoutOrder = idx
        TabBtn.Parent      = TabScroll

        local tabScale = Instance.new("UIScale")
        tabScale.Scale  = 1
        tabScale.Parent = TabBtn

        local tabIcon  = nil
        local iconXOff = 0

        if tabLogo then
            local iconVal, isAsset = ResolveIcon(tabLogo)
            if isAsset then
                tabIcon = Instance.new("ImageLabel")
                tabIcon.BackgroundTransparency = 1
                tabIcon.AnchorPoint  = Vector2.new(0, 0.5)
                tabIcon.Size         = UDim2.new(0, 15, 0, 15)
                tabIcon.Position     = UDim2.new(0, 10, 0.5, 0)
                tabIcon.Image        = iconVal
                tabIcon.ImageColor3  = T.TabInactive
                tabIcon.ZIndex       = 15
                tabIcon.Parent       = TabBtn
                iconXOff = 20
            else
                tabIcon = Instance.new("TextLabel")
                tabIcon.BackgroundTransparency = 1
                tabIcon.AnchorPoint    = Vector2.new(0, 0.5)
                tabIcon.Size           = UDim2.new(0, 16, 0, 16)
                tabIcon.Position       = UDim2.new(0, 8, 0.5, 0)
                tabIcon.Text           = iconVal or ""
                tabIcon.TextColor3     = T.TabInactive
                tabIcon.Font           = Enum.Font.Gotham
                tabIcon.TextSize       = 13
                tabIcon.TextXAlignment = Enum.TextXAlignment.Center
                tabIcon.TextYAlignment = Enum.TextYAlignment.Center
                tabIcon.ZIndex         = 15
                tabIcon.Parent         = TabBtn
                iconXOff = 20
            end
        end

        local TabLbl = Instance.new("TextLabel")
        TabLbl.BackgroundTransparency = 1
        TabLbl.AnchorPoint     = Vector2.new(0, 0.5)
        TabLbl.Size            = UDim2.new(1, -iconXOff - 8, 0, 17)
        TabLbl.Position        = UDim2.new(0, iconXOff + 6, 0.5, 0)
        TabLbl.Text            = tabTitle
        TabLbl.TextColor3      = T.TabInactive
        TabLbl.Font            = Enum.Font.GothamMedium
        TabLbl.TextSize        = 12
        TabLbl.TextXAlignment  = Enum.TextXAlignment.Center
        TabLbl.TextYAlignment  = Enum.TextYAlignment.Center
        TabLbl.ZIndex          = 15
        TabLbl.Parent          = TabBtn

        local ActiveLine = Instance.new("Frame")
        ActiveLine.BackgroundColor3 = T.TabActive
        ActiveLine.BorderSizePixel  = 0
        ActiveLine.AnchorPoint      = Vector2.new(0.5, 1)
        ActiveLine.Size             = UDim2.new(0, 0, 0, 3)
        ActiveLine.Position         = UDim2.new(0.5, 0, 1, 0)
        ActiveLine.ZIndex           = 16
        ActiveLine.Visible          = false
        ActiveLine.Parent           = TabBtn
        Corner(ActiveLine, 2)
        Reg(ActiveLine, "BackgroundColor3", "TabActive")

        local TabFrame = Instance.new("Frame")
        TabFrame.Name                   = "Tab_" .. idx
        TabFrame.BackgroundTransparency = 1
        TabFrame.Size                   = UDim2.new(1, 0, 1, 0)
        TabFrame.Visible                = false
        TabFrame.ZIndex                 = 11
        TabFrame.Parent                 = ContentArea

        local COL_PAD = 8
        local COL_GAP = 8
        local COL_TOP = 14
        local COL_BOT = 18

        local LeftScroll = Instance.new("ScrollingFrame")
        LeftScroll.BackgroundTransparency = 1
        LeftScroll.BorderSizePixel        = 0
        LeftScroll.Size               = UDim2.new(0.5, -COL_GAP/2 - COL_PAD, 1, 0)
        LeftScroll.Position           = UDim2.new(0, COL_PAD, 0, 0)
        LeftScroll.CanvasSize         = UDim2.new(0, 0, 0, 0)
        LeftScroll.ScrollBarThickness = 0
        LeftScroll.ScrollingDirection = Enum.ScrollingDirection.Y
        LeftScroll.ZIndex             = 11
        LeftScroll.Parent             = TabFrame

        local RightScroll = Instance.new("ScrollingFrame")
        RightScroll.BackgroundTransparency = 1
        RightScroll.BorderSizePixel        = 0
        RightScroll.Size               = UDim2.new(0.5, -COL_GAP/2 - COL_PAD, 1, 0)
        RightScroll.Position           = UDim2.new(0.5, COL_GAP/2, 0, 0)
        RightScroll.CanvasSize         = UDim2.new(0, 0, 0, 0)
        RightScroll.ScrollBarThickness = 0
        RightScroll.ScrollingDirection = Enum.ScrollingDirection.Y
        RightScroll.ZIndex             = 11
        RightScroll.Parent             = TabFrame

        local function MakeColInner(scrollFrame)
            local inner = Instance.new("Frame")
            inner.BackgroundTransparency = 1
            inner.Size          = UDim2.new(1, 0, 0, 0)
            inner.AutomaticSize = Enum.AutomaticSize.Y
            inner.ZIndex        = 12
            inner.Parent        = scrollFrame

            local lay = Instance.new("UIListLayout")
            lay.FillDirection = Enum.FillDirection.Vertical
            lay.SortOrder     = Enum.SortOrder.LayoutOrder
            lay.Padding       = UDim.new(0, 0)
            lay.Parent        = inner

            Pad(inner, COL_TOP, 0, COL_BOT, 0)

            lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                local h = lay.AbsoluteContentSize.Y + COL_TOP + COL_BOT
                scrollFrame.CanvasSize = UDim2.new(0, 0, 0, h)
            end)

            return inner, lay
        end

        local LeftInner,  _LeftLay  = MakeColInner(LeftScroll)
        local RightInner, _RightLay = MakeColInner(RightScroll)

        local tabData = {
            btn        = TabBtn,
            content    = TabFrame,
            activeLine = ActiveLine,
            label      = TabLbl,
            icon       = tabIcon,
            tabScale   = tabScale,
        }
        table.insert(_tabs, tabData)

        local function ActivateThis()
            DeactivateAllTabs()
            TabFadeOverlay.BackgroundTransparency = 0.55
            TabFadeOverlay.ZIndex = 50
            Tween(TabFadeOverlay, {BackgroundTransparency = 1}, 0.32, Enum.EasingStyle.Quint)

            TabFrame.Visible   = true
            ActiveLine.Visible = true
            ActiveLine.Size    = UDim2.new(0, 0, 0, 3)
            Spring(ActiveLine, {Size = UDim2.new(0.78, 0, 0, 3)}, 0.42)
            Snap(tabScale, {Scale = 0.92}, 0.10)
            Spring(tabScale, {Scale = 1}, 0.38)
            Snap(TabLbl, {TextColor3 = T.TabActive}, 0.14)
            if tabIcon then
                local prop = tabIcon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"
                Snap(tabIcon, {[prop] = T.TabActive}, 0.14)
            end
        end

        TabBtn.MouseButton1Click:Connect(ActivateThis)
        if idx == 1 then ActivateThis() end

        local TabObj  = {}
        local _secCnt = 0

        function TabObj:CreateSection(secCfg)
            secCfg = secCfg or {}
            local secTitle = secCfg.Title    or "Section"
            local secPos   = (secCfg.Position or "left"):lower()

            _secCnt = _secCnt + 1
            local secOrder  = _secCnt
            local parentCol = secPos == "right" and RightInner or LeftInner

            local SecWrap = Instance.new("Frame")
            SecWrap.BackgroundTransparency = 1
            SecWrap.Size          = UDim2.new(1, 0, 0, 0)
            SecWrap.AutomaticSize = Enum.AutomaticSize.Y
            SecWrap.LayoutOrder   = secOrder
            SecWrap.ZIndex        = 13
            SecWrap.Parent        = parentCol

            local SecWrapLayout = Instance.new("UIListLayout")
            SecWrapLayout.FillDirection = Enum.FillDirection.Vertical
            SecWrapLayout.SortOrder     = Enum.SortOrder.LayoutOrder
            SecWrapLayout.Padding       = UDim.new(0, 0)
            SecWrapLayout.Parent        = SecWrap

            local TopSpacer = Instance.new("Frame")
            TopSpacer.BackgroundTransparency = 1
            TopSpacer.Size        = UDim2.new(1, 0, 0, 12)
            TopSpacer.LayoutOrder = 0
            TopSpacer.ZIndex      = 13
            TopSpacer.Parent      = SecWrap

            local SecHeadWrap = Instance.new("Frame")
            SecHeadWrap.BackgroundTransparency = 1
            SecHeadWrap.Size        = UDim2.new(1, 0, 0, 20)
            SecHeadWrap.LayoutOrder = 1
            SecHeadWrap.ZIndex      = 13
            SecHeadWrap.Parent      = SecWrap
            Pad(SecHeadWrap, 0, 4, 0, 14)

            local SecHead = Instance.new("TextLabel")
            SecHead.BackgroundTransparency = 1
            SecHead.Size           = UDim2.new(1, 0, 1, 0)
            SecHead.Text           = secTitle:upper()
            SecHead.TextColor3     = T.SectionTitle
            SecHead.Font           = Enum.Font.GothamMedium
            SecHead.TextSize       = 11
            SecHead.TextXAlignment = Enum.TextXAlignment.Left
            SecHead.TextYAlignment = Enum.TextYAlignment.Center
            SecHead.ZIndex         = 14
            SecHead.Parent         = SecHeadWrap
            Reg(SecHead, "TextColor3", "SectionTitle")

            local HeadSpacer = Instance.new("Frame")
            HeadSpacer.BackgroundTransparency = 1
            HeadSpacer.Size        = UDim2.new(1, 0, 0, 4)
            HeadSpacer.LayoutOrder = 2
            HeadSpacer.ZIndex      = 13
            HeadSpacer.Parent      = SecWrap

            local Card = Instance.new("Frame")
            Card.BackgroundColor3 = T.SectionBG
            Card.BorderSizePixel  = 0
            Card.Size             = UDim2.new(1, 0, 0, 0)
            Card.AutomaticSize    = Enum.AutomaticSize.Y
            Card.ClipsDescendants = true
            Card.LayoutOrder      = 3
            Card.ZIndex           = 13
            Card.Parent           = SecWrap
            Corner(Card, 12)
            Reg(Card, "BackgroundColor3", "SectionBG")

            local CardStroke = Instance.new("UIStroke")
            CardStroke.Color        = T.Separator
            CardStroke.Thickness    = 0.5
            CardStroke.Transparency = 0
            CardStroke.Parent       = Card
            Reg(CardStroke, "Color", "Separator")

            local cardStagger = (_secCnt - 1) * 0.055
            local cardEntryScale = Instance.new("UIScale")
            cardEntryScale.Scale  = 0.92
            cardEntryScale.Parent = Card
            Card.BackgroundTransparency = 1
            task.delay(cardStagger, function()
                Tween(Card, {BackgroundTransparency = 0}, 0.28, Enum.EasingStyle.Quint)
                Spring(cardEntryScale, {Scale = 1}, 0.46)
            end)

            local CardLayout = Instance.new("UIListLayout")
            CardLayout.FillDirection = Enum.FillDirection.Vertical
            CardLayout.SortOrder     = Enum.SortOrder.LayoutOrder
            CardLayout.Padding       = UDim.new(0, 0)
            CardLayout.Parent        = Card

            local BottomSpacer = Instance.new("Frame")
            BottomSpacer.BackgroundTransparency = 1
            BottomSpacer.Size        = UDim2.new(1, 0, 0, 10)
            BottomSpacer.LayoutOrder = 4
            BottomSpacer.ZIndex      = 13
            BottomSpacer.Parent      = SecWrap

            local SecObj = {}
            SecObj._card = Card
            SecObj._rowN = 0

            local function MakeRow(h, autoY)
                SecObj._rowN = SecObj._rowN + 1
                local n = SecObj._rowN

                if n > 1 then
                    local sepWrap = Instance.new("Frame")
                    sepWrap.BackgroundTransparency = 1
                    sepWrap.BorderSizePixel        = 0
                    sepWrap.Size        = UDim2.new(1, 0, 0, 1)
                    sepWrap.ZIndex      = 15
                    sepWrap.LayoutOrder = n * 10 - 5
                    sepWrap.Parent      = Card

                    local sep = Instance.new("Frame")
                    sep.BackgroundColor3 = T.Separator
                    sep.BorderSizePixel  = 0
                    sep.Size     = UDim2.new(1, -16, 1, 0)
                    sep.Position = UDim2.new(0, 16, 0, 0)
                    sep.ZIndex   = 15
                    sep.Parent   = sepWrap
                    Reg(sep, "BackgroundColor3", "Separator")
                end

                local row = Instance.new("Frame")
                row.BackgroundTransparency = 1
                row.BorderSizePixel        = 0
                row.ZIndex                 = 14
                row.LayoutOrder            = n * 10
                row.Parent                 = Card

                if autoY then
                    row.Size          = UDim2.new(1, 0, 0, 0)
                    row.AutomaticSize = Enum.AutomaticSize.Y
                else
                    row.Size = UDim2.new(1, 0, 0, h or 48)
                end
                Pad(row, 0, 16, 0, 16)
                return row
            end

            function SecObj:CreateToggle(cfg)
                cfg = cfg or {}
                local ttl = cfg.Title    or "Toggle"
                local def = cfg.Default  ~= nil and cfg.Default or false
                local cb  = cfg.Callback or function() end

                local row = MakeRow(50)

                local lbl = Instance.new("TextLabel")
                lbl.BackgroundTransparency = 1
                lbl.AnchorPoint    = Vector2.new(0, 0.5)
                lbl.Size           = UDim2.new(1, -66, 0, 20)
                lbl.Position       = UDim2.new(0, 0, 0.5, 0)
                lbl.Text           = ttl
                lbl.TextColor3     = T.Text
                lbl.Font           = Enum.Font.Gotham
                lbl.TextSize       = 16
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.TextYAlignment = Enum.TextYAlignment.Center
                lbl.ZIndex         = 15
                lbl.Parent         = row
                Reg(lbl, "TextColor3", "Text")

                local track = Instance.new("Frame")
                track.BackgroundColor3 = def and T.ToggleOn or T.ToggleOff
                track.BorderSizePixel  = 0
                track.AnchorPoint      = Vector2.new(1, 0.5)
                track.Size             = UDim2.new(0, 51, 0, 31)
                track.Position         = UDim2.new(1, 0, 0.5, 0)
                track.ZIndex           = 15
                track.Parent           = row
                Corner(track, 16)

                local thumb = Instance.new("Frame")
                thumb.BackgroundColor3 = T.White
                thumb.BorderSizePixel  = 0
                thumb.AnchorPoint      = Vector2.new(0, 0.5)
                thumb.Size             = UDim2.new(0, 27, 0, 27)
                thumb.Position         = def
                    and UDim2.new(0, 22, 0.5, 0)
                    or  UDim2.new(0,  2, 0.5, 0)
                thumb.ZIndex           = 16
                thumb.Parent           = track
                Corner(thumb, 14)
                Reg(thumb, "BackgroundColor3", "White")

                local thumbStroke = Instance.new("UIStroke")
                thumbStroke.Color        = Color3.fromRGB(0, 0, 0)
                thumbStroke.Thickness    = 0.5
                thumbStroke.Transparency = 0.82
                thumbStroke.Parent       = thumb

                local state = def
                local busy  = false

                local function DoSet(v, anim)
                    if busy then return end
                    busy  = true
                    state = v
                    local thumbTarget = v and UDim2.new(0, 22, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
                    local color       = v and T.ToggleOn or T.ToggleOff
                    if anim then
                        Snap(track, {BackgroundColor3 = color}, 0.18)
                        Snap(thumb, {
                            Size     = UDim2.new(0, 31, 0, 27),
                        }, 0.12)
                        task.delay(0.12, function()
                            Spring(thumb, {
                                Position = thumbTarget,
                                Size     = UDim2.new(0, 27, 0, 27),
                            }, 0.36)
                        end)
                    else
                        track.BackgroundColor3 = color
                        thumb.Position         = thumbTarget
                        thumb.Size             = UDim2.new(0, 27, 0, 27)
                    end
                    task.delay(0.36, function() busy = false end)
                end

                RegFn(function()
                    Snap(track, {BackgroundColor3 = state and T.ToggleOn or T.ToggleOff}, 0.20)
                end)

                local hit = Instance.new("TextButton")
                hit.BackgroundTransparency = 1
                hit.Size   = UDim2.new(1, 0, 1, 0)
                hit.Text   = ""
                hit.ZIndex = 17
                hit.Parent = row

                hit.MouseButton1Click:Connect(function()
                    DoSet(not state, true)
                    cb(state)
                end)
                hit.MouseButton1Down:Connect(function()
                    Snap(row, {BackgroundColor3 = T.PressHL}, 0.06)
                    row.BackgroundTransparency = 0
                end)
                hit.MouseButton1Up:Connect(function()
                    Tween(row, {BackgroundColor3 = T.SectionBG}, 0.28, Enum.EasingStyle.Quint)
                    task.delay(0.28, function() row.BackgroundTransparency = 1 end)
                end)

                local obj = {}
                obj.Value    = { Set = function(_, v) DoSet(v, true); cb(v) end }
                obj.Name     = { Set = function(_, n) lbl.Text = n end }
                obj.GetValue = function() return state end
                return obj
            end

            function SecObj:CreateButton(cfg)
                cfg = cfg or {}
                local ttl = cfg.Title    or "Button"
                local cb  = cfg.Callback or function() end

                local row = MakeRow(48)

                local rowScale = Instance.new("UIScale")
                rowScale.Scale  = 1
                rowScale.Parent = row

                local lbl = Instance.new("TextLabel")
                lbl.BackgroundTransparency = 1
                lbl.AnchorPoint    = Vector2.new(0.5, 0.5)
                lbl.Size           = UDim2.new(1, 0, 0, 20)
                lbl.Position       = UDim2.new(0.5, 0, 0.5, 0)
                lbl.Text           = ttl
                lbl.TextColor3     = T.Accent
                lbl.Font           = Enum.Font.GothamMedium
                lbl.TextSize       = 16
                lbl.TextXAlignment = Enum.TextXAlignment.Center
                lbl.TextYAlignment = Enum.TextYAlignment.Center
                lbl.ZIndex         = 15
                lbl.Parent         = row
                Reg(lbl, "TextColor3", "Accent")

                local hit = Instance.new("TextButton")
                hit.BackgroundTransparency = 1
                hit.Size   = UDim2.new(1, 0, 1, 0)
                hit.Text   = ""
                hit.ZIndex = 16
                hit.Parent = row

                hit.MouseButton1Down:Connect(function()
                    Snap(row, {BackgroundColor3 = T.PressHL}, 0.06)
                    row.BackgroundTransparency = 0
                    Snap(lbl, {TextColor3 = T.AccentDark}, 0.06)
                    Snap(rowScale, {Scale = 0.95}, 0.10)
                end)
                hit.MouseButton1Up:Connect(function()
                    Tween(row, {BackgroundColor3 = T.SectionBG}, 0.28, Enum.EasingStyle.Quint)
                    task.delay(0.28, function() row.BackgroundTransparency = 1 end)
                    Tween(lbl, {TextColor3 = T.Accent}, 0.22, Enum.EasingStyle.Quint)
                    Spring(rowScale, {Scale = 1}, 0.38)
                end)
                hit.MouseButton1Click:Connect(cb)

                local obj = {}
                obj.Name = { Set = function(_, n) lbl.Text = n end }
                return obj
            end

            function SecObj:CreateDropdown(cfg)
                cfg = cfg or {}
                local ttl     = cfg.Title    or "Dropdown"
                local opts    = cfg.Options  or {}
                local initSel = cfg.Selected or {}
                local multi   = cfg.Multi    or false
                local cb      = cfg.Callback or function() end

                local selMap = {}
                for _, v in ipairs(initSel) do selMap[v] = true end
                if not multi and not next(selMap) and #opts > 0 then
                    selMap[opts[1]] = true
                end

                local function SelText()
                    local t = {}
                    for k, v in pairs(selMap) do if v then t[#t+1] = k end end
                    if #t == 0 then return "None" end
                    table.sort(t)
                    return table.concat(t, ", ")
                end

                local isOpen  = false
                local curOpts = {table.unpack(opts)}

                local row = MakeRow(48)

                local ttlLbl = Instance.new("TextLabel")
                ttlLbl.BackgroundTransparency = 1
                ttlLbl.AnchorPoint    = Vector2.new(0, 0.5)
                ttlLbl.Size           = UDim2.new(1, -86, 0, 20)
                ttlLbl.Position       = UDim2.new(0, 0, 0.5, 0)
                ttlLbl.Text           = ttl
                ttlLbl.TextColor3     = T.Text
                ttlLbl.Font           = Enum.Font.Gotham
                ttlLbl.TextSize       = 16
                ttlLbl.TextXAlignment = Enum.TextXAlignment.Left
                ttlLbl.TextYAlignment = Enum.TextYAlignment.Center
                ttlLbl.ZIndex         = 15
                ttlLbl.Parent         = row
                Reg(ttlLbl, "TextColor3", "Text")

                local selLbl = Instance.new("TextLabel")
                selLbl.BackgroundTransparency = 1
                selLbl.AnchorPoint    = Vector2.new(1, 0.5)
                selLbl.Size           = UDim2.new(0, 60, 0, 20)
                selLbl.Position       = UDim2.new(1, -20, 0.5, 0)
                selLbl.Text           = SelText()
                selLbl.TextColor3     = T.SubText
                selLbl.Font           = Enum.Font.Gotham
                selLbl.TextSize       = 14
                selLbl.TextXAlignment = Enum.TextXAlignment.Right
                selLbl.TextYAlignment = Enum.TextYAlignment.Center
                selLbl.TextTruncate   = Enum.TextTruncate.AtEnd
                selLbl.ZIndex         = 15
                selLbl.Parent         = row
                Reg(selLbl, "TextColor3", "SubText")

                local chevron = Instance.new("TextLabel")
                chevron.BackgroundTransparency = 1
                chevron.AnchorPoint    = Vector2.new(1, 0.5)
                chevron.Size           = UDim2.new(0, 16, 0, 20)
                chevron.Position       = UDim2.new(1, 0, 0.5, 0)
                chevron.Text           = "›"
                chevron.TextColor3     = T.SubText
                chevron.Font           = Enum.Font.GothamBold
                chevron.TextSize       = 22
                chevron.TextXAlignment = Enum.TextXAlignment.Center
                chevron.TextYAlignment = Enum.TextYAlignment.Center
                chevron.ZIndex         = 15
                chevron.Parent         = row
                Reg(chevron, "TextColor3", "SubText")

                local panel = Instance.new("Frame")
                panel.BackgroundColor3 = T.SectionBG
                panel.BorderSizePixel  = 0
                panel.Size             = UDim2.new(1, 0, 0, 0)
                panel.ClipsDescendants = true
                panel.ZIndex           = 20
                panel.Visible          = false
                panel.LayoutOrder      = row.LayoutOrder + 1
                panel.Parent           = Card
                Reg(panel, "BackgroundColor3", "SectionBG")

                local panelList = Instance.new("UIListLayout")
                panelList.FillDirection = Enum.FillDirection.Vertical
                panelList.SortOrder     = Enum.SortOrder.LayoutOrder
                panelList.Parent        = panel

                local optBtns  = {}
                local panelH   = 0

                local function RebuildOptions(newOpts)
                    for _, b in ipairs(optBtns) do b:Destroy() end
                    optBtns = {}

                    for i, opt in ipairs(newOpts) do
                        if i > 1 then
                            local sepW = Instance.new("Frame")
                            sepW.BackgroundTransparency = 1
                            sepW.BorderSizePixel        = 0
                            sepW.Size        = UDim2.new(1, 0, 0, 1)
                            sepW.ZIndex      = 22
                            sepW.LayoutOrder = i * 10 - 5
                            sepW.Parent      = panel
                            table.insert(optBtns, sepW)

                            local sepLine = Instance.new("Frame")
                            sepLine.BackgroundColor3 = T.Separator
                            sepLine.BorderSizePixel  = 0
                            sepLine.Size     = UDim2.new(1, -16, 1, 0)
                            sepLine.Position = UDim2.new(0, 16, 0, 0)
                            sepLine.ZIndex   = 22
                            sepLine.Parent   = sepW
                            Reg(sepLine, "BackgroundColor3", "Separator")
                        end

                        local ob = Instance.new("TextButton")
                        ob.BackgroundTransparency = 1
                        ob.Size        = UDim2.new(1, 0, 0, 46)
                        ob.Text        = ""
                        ob.ZIndex      = 22
                        ob.LayoutOrder = i * 10
                        ob.Parent      = panel
                        table.insert(optBtns, ob)
                        Pad(ob, 0, 16, 0, 16)

                        local ol = Instance.new("TextLabel")
                        ol.Name       = "OptionLabel"
                        ol.BackgroundTransparency = 1
                        ol.AnchorPoint    = Vector2.new(0, 0.5)
                        ol.Size           = UDim2.new(1, -28, 0, 20)
                        ol.Position       = UDim2.new(0, 0, 0.5, 0)
                        ol.Text           = opt
                        ol.TextColor3     = T.Text
                        ol.Font           = Enum.Font.Gotham
                        ol.TextSize       = 15
                        ol.TextXAlignment = Enum.TextXAlignment.Left
                        ol.TextYAlignment = Enum.TextYAlignment.Center
                        ol.ZIndex         = 23
                        ol.Parent         = ob
                        Reg(ol, "TextColor3", "Text")

                        local ck = Instance.new("TextLabel")
                        ck.Name       = "Checkmark"
                        ck.BackgroundTransparency = 1
                        ck.AnchorPoint    = Vector2.new(1, 0.5)
                        ck.Size           = UDim2.new(0, 20, 0, 20)
                        ck.Position       = UDim2.new(1, 0, 0.5, 0)
                        ck.Text           = selMap[opt] and "✓" or ""
                        ck.TextColor3     = T.Accent
                        ck.Font           = Enum.Font.GothamBold
                        ck.TextSize       = 15
                        ck.TextXAlignment = Enum.TextXAlignment.Center
                        ck.TextYAlignment = Enum.TextYAlignment.Center
                        ck.ZIndex         = 23
                        ck.Parent         = ob
                        Reg(ck, "TextColor3", "Accent")

                        local obScale = Instance.new("UIScale")
                        obScale.Scale  = 1
                        obScale.Parent = ob

                        ob.MouseButton1Down:Connect(function()
                            Snap(ob, {BackgroundColor3 = T.PressHL}, 0.06)
                            ob.BackgroundTransparency = 0
                            Snap(obScale, {Scale = 0.97}, 0.08)
                        end)
                        ob.MouseButton1Up:Connect(function()
                            Tween(ob, {BackgroundColor3 = T.SectionBG}, 0.24, Enum.EasingStyle.Quint)
                            task.delay(0.24, function() ob.BackgroundTransparency = 1 end)
                            Spring(obScale, {Scale = 1}, 0.30)
                        end)

                        ob.MouseButton1Click:Connect(function()
                            if multi then
                                selMap[opt] = not selMap[opt]
                                ck.Text = selMap[opt] and "✓" or ""
                            else
                                for _, o2 in ipairs(newOpts) do selMap[o2] = false end
                                selMap[opt] = true
                                for _, b2 in ipairs(optBtns) do
                                    if b2:IsA("TextButton") then
                                        local ckLbl = b2:FindFirstChild("Checkmark")
                                        local olLbl = b2:FindFirstChild("OptionLabel")
                                        if ckLbl and olLbl then
                                            ckLbl.Text = selMap[olLbl.Text] and "✓" or ""
                                        end
                                    end
                                end
                            end
                            selLbl.Text = SelText()
                            local result = {}
                            for k, v in pairs(selMap) do if v then result[#result+1] = k end end
                            cb(result)
                            if not multi then
                                isOpen = false
                                Tween(panel, {Size = UDim2.new(1, 0, 0, 0)}, 0.24, Enum.EasingStyle.Quint)
                                task.delay(0.25, function() panel.Visible = false end)
                                Snap(chevron, {Rotation = 0}, 0.20)
                            end
                        end)
                    end

                    panelH = math.min(#newOpts * 46, 196)
                    return panelH
                end

                RebuildOptions(curOpts)

                local hit = Instance.new("TextButton")
                hit.BackgroundTransparency = 1
                hit.Size   = UDim2.new(1, 0, 1, 0)
                hit.Text   = ""
                hit.ZIndex = 16
                hit.Parent = row

                hit.MouseButton1Down:Connect(function()
                    Snap(row, {BackgroundColor3 = T.PressHL}, 0.06)
                    row.BackgroundTransparency = 0
                end)
                hit.MouseButton1Up:Connect(function()
                    Tween(row, {BackgroundColor3 = T.SectionBG}, 0.24, Enum.EasingStyle.Quint)
                    task.delay(0.24, function() row.BackgroundTransparency = 1 end)
                end)

                hit.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    if isOpen then
                        panel.Visible = true
                        panel.Size    = UDim2.new(1, 0, 0, 0)
                        Spring(panel, {Size = UDim2.new(1, 0, 0, panelH)}, 0.40)
                        Snap(chevron, {Rotation = 90}, 0.22)
                    else
                        Tween(panel, {Size = UDim2.new(1, 0, 0, 0)}, 0.24, Enum.EasingStyle.Quint)
                        task.delay(0.25, function() panel.Visible = false end)
                        Snap(chevron, {Rotation = 0}, 0.20)
                    end
                end)

                local obj = {}
                obj.Name    = { Set = function(_, n) ttlLbl.Text = n end }
                obj.Options = {
                    Set = function(_, newOpts)
                        curOpts = newOpts
                        selMap  = {}
                        if not multi and #newOpts > 0 then selMap[newOpts[1]] = true end
                        RebuildOptions(newOpts)
                        selLbl.Text = SelText()
                    end
                }
                obj.Value = {
                    Set = function(_, v)
                        selMap = {}
                        if type(v) == "table" then
                            for _, s in ipairs(v) do selMap[s] = true end
                        elseif type(v) == "string" then
                            selMap[v] = true
                        end
                        selLbl.Text = SelText()
                        RebuildOptions(curOpts)
                    end
                }
                return obj
            end

            function SecObj:CreateSlider(cfg)
                cfg = cfg or {}
                local ttl = cfg.Title     or "Slider"
                local rng = cfg.Range     or {0, 100}
                local mn  = rng[1] or 0
                local mx  = rng[2] or 100
                local def = math.clamp(cfg.Default or mn, mn, mx)
                local inc = cfg.Increment or 1
                local suf = cfg.Suffix    or ""
                local cb  = cfg.Callback  or function() end
                local cur = def

                local row = MakeRow(66)

                local ttlLbl = Instance.new("TextLabel")
                ttlLbl.BackgroundTransparency = 1
                ttlLbl.AnchorPoint    = Vector2.new(0, 0)
                ttlLbl.Size           = UDim2.new(0.60, 0, 0, 22)
                ttlLbl.Position       = UDim2.new(0, 0, 0, 10)
                ttlLbl.Text           = ttl
                ttlLbl.TextColor3     = T.Text
                ttlLbl.Font           = Enum.Font.Gotham
                ttlLbl.TextSize       = 16
                ttlLbl.TextXAlignment = Enum.TextXAlignment.Left
                ttlLbl.TextYAlignment = Enum.TextYAlignment.Center
                ttlLbl.ZIndex         = 15
                ttlLbl.Parent         = row
                Reg(ttlLbl, "TextColor3", "Text")

                local valLbl = Instance.new("TextLabel")
                valLbl.BackgroundTransparency = 1
                valLbl.AnchorPoint    = Vector2.new(1, 0)
                valLbl.Size           = UDim2.new(0.40, 0, 0, 22)
                valLbl.Position       = UDim2.new(1, 0, 0, 10)
                valLbl.Text           = tostring(cur) .. suf
                valLbl.TextColor3     = T.Accent
                valLbl.Font           = Enum.Font.GothamMedium
                valLbl.TextSize       = 15
                valLbl.TextXAlignment = Enum.TextXAlignment.Right
                valLbl.TextYAlignment = Enum.TextYAlignment.Center
                valLbl.ZIndex         = 15
                valLbl.Parent         = row
                Reg(valLbl, "TextColor3", "Accent")

                local trackBg = Instance.new("Frame")
                trackBg.BackgroundColor3 = T.SliderTrack
                trackBg.BorderSizePixel  = 0
                trackBg.AnchorPoint      = Vector2.new(0, 1)
                trackBg.Size             = UDim2.new(1, 0, 0, 5)
                trackBg.Position         = UDim2.new(0, 0, 1, -12)
                trackBg.ZIndex           = 15
                trackBg.Parent           = row
                Corner(trackBg, 3)
                Reg(trackBg, "BackgroundColor3", "SliderTrack")

                local initPct = (cur - mn) / math.max(mx - mn, 0.0001)

                local trackFill = Instance.new("Frame")
                trackFill.BackgroundColor3 = T.SliderFill
                trackFill.BorderSizePixel  = 0
                trackFill.Size             = UDim2.new(initPct, 0, 1, 0)
                trackFill.ZIndex           = 16
                trackFill.Parent           = trackBg
                Corner(trackFill, 3)
                Reg(trackFill, "BackgroundColor3", "SliderFill")

                local thumb = Instance.new("Frame")
                thumb.BackgroundColor3 = T.White
                thumb.BorderSizePixel  = 0
                thumb.AnchorPoint      = Vector2.new(0.5, 0.5)
                thumb.Size             = UDim2.new(0, 22, 0, 22)
                thumb.Position         = UDim2.new(initPct, 0, 0.5, 0)
                thumb.ZIndex           = 17
                thumb.Parent           = trackBg
                Corner(thumb, 11)
                Reg(thumb, "BackgroundColor3", "White")

                local sThumbStroke = Instance.new("UIStroke")
                sThumbStroke.Color        = Color3.fromRGB(0, 0, 0)
                sThumbStroke.Thickness    = 0.5
                sThumbStroke.Transparency = 0.82
                sThumbStroke.Parent       = thumb

                local sliding = false

                local function Calc(pos)
                    local ab  = trackBg.AbsolutePosition
                    local sz  = trackBg.AbsoluteSize
                    local pct = math.clamp((pos.X - ab.X) / sz.X, 0, 1)
                    local snp = math.round((mn + pct * (mx - mn)) / inc) * inc
                    return math.clamp(snp, mn, mx)
                end

                local function Apply(v, anim)
                    cur = v
                    local pct = (v - mn) / math.max(mx - mn, 0.0001)
                    if anim then
                        Snap(trackFill, {Size = UDim2.new(pct, 0, 1, 0)}, 0.14)
                        Snap(thumb, {Position = UDim2.new(pct, 0, 0.5, 0)}, 0.14)
                    else
                        trackFill.Size  = UDim2.new(pct, 0, 1, 0)
                        thumb.Position  = UDim2.new(pct, 0, 0.5, 0)
                    end
                    valLbl.Text = tostring(v) .. suf
                end

                local hit = Instance.new("TextButton")
                hit.BackgroundTransparency = 1
                hit.Size   = UDim2.new(1, 0, 1, 0)
                hit.Text   = ""
                hit.ZIndex = 18
                hit.Parent = row

                hit.InputBegan:Connect(function(inp)
                    if inp.UserInputType == Enum.UserInputType.MouseButton1
                    or inp.UserInputType == Enum.UserInputType.Touch then
                        sliding = true
                        local v = Calc(inp.Position)
                        Apply(v, false)
                        cb(v)
                        local pct = (v - mn) / math.max(mx - mn, 0.0001)
                        Spring(thumb, {
                            Size     = UDim2.new(0, 28, 0, 28),
                            Position = UDim2.new(pct, 0, 0.5, 0)
                        }, 0.30)
                    end
                end)

                UserInputService.InputChanged:Connect(function(inp)
                    if not sliding then return end
                    if inp.UserInputType ~= Enum.UserInputType.MouseMovement
                    and inp.UserInputType ~= Enum.UserInputType.Touch then return end
                    local v = Calc(inp.Position)
                    Apply(v, false)
                    local pct = (v - mn) / math.max(mx - mn, 0.0001)
                    thumb.Position = UDim2.new(pct, 0, 0.5, 0)
                    cb(v)
                end)

                UserInputService.InputEnded:Connect(function(inp)
                    if not sliding then return end
                    if inp.UserInputType == Enum.UserInputType.MouseButton1
                    or inp.UserInputType == Enum.UserInputType.Touch then
                        sliding = false
                        local pct = (cur - mn) / math.max(mx - mn, 0.0001)
                        Spring(thumb, {
                            Size     = UDim2.new(0, 22, 0, 22),
                            Position = UDim2.new(pct, 0, 0.5, 0)
                        }, 0.36)
                    end
                end)

                local obj = {}
                obj.Value = { Set = function(_, v) Apply(math.clamp(v, mn, mx), true); cb(cur) end }
                obj.Name  = { Set = function(_, n) ttlLbl.Text = n end }
                return obj
            end

            function SecObj:CreateLabel(content)
                content = content or ""
                local row = MakeRow(44)

                local lbl = Instance.new("TextLabel")
                lbl.BackgroundTransparency = 1
                lbl.AnchorPoint    = Vector2.new(0, 0.5)
                lbl.Size           = UDim2.new(1, 0, 0, 20)
                lbl.Position       = UDim2.new(0, 0, 0.5, 0)
                lbl.Text           = content
                lbl.TextColor3     = T.SubText
                lbl.Font           = Enum.Font.Gotham
                lbl.TextSize       = 15
                lbl.TextXAlignment = Enum.TextXAlignment.Left
                lbl.TextYAlignment = Enum.TextYAlignment.Center
                lbl.ZIndex         = 15
                lbl.Parent         = row
                Reg(lbl, "TextColor3", "SubText")

                local obj = {}
                obj.Value = { Set = function(_, v) lbl.Text = v end }
                return obj
            end

            function SecObj:CreateParagraph(cfg)
                cfg = cfg or {}
                local ptl = cfg.Title   or ""
                local pct = cfg.Content or ""

                SecObj._rowN = SecObj._rowN + 1
                local n = SecObj._rowN

                if n > 1 then
                    local sepW = Instance.new("Frame")
                    sepW.BackgroundTransparency = 1
                    sepW.BorderSizePixel        = 0
                    sepW.Size        = UDim2.new(1, 0, 0, 1)
                    sepW.ZIndex      = 15
                    sepW.LayoutOrder = n * 10 - 5
                    sepW.Parent      = Card

                    local sepLine = Instance.new("Frame")
                    sepLine.BackgroundColor3 = T.Separator
                    sepLine.BorderSizePixel  = 0
                    sepLine.Size     = UDim2.new(1, -16, 1, 0)
                    sepLine.Position = UDim2.new(0, 16, 0, 0)
                    sepLine.ZIndex   = 15
                    sepLine.Parent   = sepW
                    Reg(sepLine, "BackgroundColor3", "Separator")
                end

                local frame = Instance.new("Frame")
                frame.BackgroundTransparency = 1
                frame.Size          = UDim2.new(1, 0, 0, 0)
                frame.AutomaticSize = Enum.AutomaticSize.Y
                frame.ZIndex        = 14
                frame.LayoutOrder   = n * 10
                frame.Parent        = Card
                Pad(frame, 10, 16, 10, 16)

                local flay = Instance.new("UIListLayout")
                flay.FillDirection = Enum.FillDirection.Vertical
                flay.SortOrder     = Enum.SortOrder.LayoutOrder
                flay.Padding       = UDim.new(0, 4)
                flay.Parent        = frame

                local titleLbl = nil
                if ptl ~= "" then
                    titleLbl = Instance.new("TextLabel")
                    titleLbl.BackgroundTransparency = 1
                    titleLbl.Size           = UDim2.new(1, 0, 0, 0)
                    titleLbl.AutomaticSize  = Enum.AutomaticSize.Y
                    titleLbl.Text           = ptl
                    titleLbl.TextColor3     = T.Text
                    titleLbl.Font           = Enum.Font.GothamMedium
                    titleLbl.TextSize       = 15
                    titleLbl.TextWrapped    = true
                    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
                    titleLbl.LayoutOrder    = 1
                    titleLbl.ZIndex         = 15
                    titleLbl.Parent         = frame
                    Reg(titleLbl, "TextColor3", "Text")
                end

                local contentLbl = Instance.new("TextLabel")
                contentLbl.BackgroundTransparency = 1
                contentLbl.Size           = UDim2.new(1, 0, 0, 0)
                contentLbl.AutomaticSize  = Enum.AutomaticSize.Y
                contentLbl.Text           = pct
                contentLbl.TextColor3     = T.SubText
                contentLbl.Font           = Enum.Font.Gotham
                contentLbl.TextSize       = 14
                contentLbl.TextWrapped    = true
                contentLbl.TextXAlignment = Enum.TextXAlignment.Left
                contentLbl.LayoutOrder    = 2
                contentLbl.ZIndex         = 15
                contentLbl.Parent         = frame
                Reg(contentLbl, "TextColor3", "SubText")

                local obj = {}
                obj.Title   = { Set = function(_, v) if titleLbl then titleLbl.Text = v end end }
                obj.Content = { Set = function(_, v) contentLbl.Text = v end }
                return obj
            end

            return SecObj
        end

        return TabObj
    end

    return WindowObj
end

return Library

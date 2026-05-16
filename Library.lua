local Library = {}
Library.__index = Library

local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")

local function ResolveIcon(Id)
	if type(Id) == "number" then
		return "rbxassetid://" .. tostring(Id), true
	elseif type(Id) == "string" then
		if Id:match("^%d+$") then return "rbxassetid://" .. Id, true end
		if Id:match("rbxassetid://") then return Id, true end
	end
	return Id, false
end

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
	Midnight = {
		BG          = Color3.fromRGB(8,   10,  20),
		Sidebar     = Color3.fromRGB(12,  15,  28),
		HeaderBG    = Color3.fromRGB(12,  15,  28),
		SectionBG   = Color3.fromRGB(18,  22,  38),
		SecTitle    = Color3.fromRGB(70,  95, 160),
		Text        = Color3.fromRGB(215, 225, 255),
		SubText     = Color3.fromRGB(70,  90, 148),
		Separator   = Color3.fromRGB(28,  36,  62),
		Accent      = Color3.fromRGB(88,  168, 255),
		AccentDark  = Color3.fromRGB(58,  128, 220),
		ToggleOn    = Color3.fromRGB(88,  168, 255),
		ToggleOff   = Color3.fromRGB(28,  36,  62),
		SliderTrack = Color3.fromRGB(28,  36,  62),
		SliderFill  = Color3.fromRGB(88,  168, 255),
		White       = Color3.fromRGB(215, 225, 255),
		PressHL     = Color3.fromRGB(22,  28,  50),
		TabActive   = Color3.fromRGB(88,  168, 255),
		TabInactive = Color3.fromRGB(70,  90,  148),
		TabActiveBG = Color3.fromRGB(20,  28,  54),
		Handle      = Color3.fromRGB(44,  56,  100),
		DropHL      = Color3.fromRGB(18,  24,  44),
	},
	Forest = {
		BG          = Color3.fromRGB(8,   14,  10),
		Sidebar     = Color3.fromRGB(12,  20,  14),
		HeaderBG    = Color3.fromRGB(12,  20,  14),
		SectionBG   = Color3.fromRGB(16,  28,  18),
		SecTitle    = Color3.fromRGB(60,  120,  72),
		Text        = Color3.fromRGB(210, 240, 218),
		SubText     = Color3.fromRGB(64,  118,  76),
		Separator   = Color3.fromRGB(26,  48,  30),
		Accent      = Color3.fromRGB(46,  204,  96),
		AccentDark  = Color3.fromRGB(28,  170,  72),
		ToggleOn    = Color3.fromRGB(46,  204,  96),
		ToggleOff   = Color3.fromRGB(26,  48,  30),
		SliderTrack = Color3.fromRGB(26,  48,  30),
		SliderFill  = Color3.fromRGB(46,  204,  96),
		White       = Color3.fromRGB(210, 240, 218),
		PressHL     = Color3.fromRGB(18,  38,  22),
		TabActive   = Color3.fromRGB(46,  204,  96),
		TabInactive = Color3.fromRGB(64,  118,  76),
		TabActiveBG = Color3.fromRGB(14,  38,  20),
		Handle      = Color3.fromRGB(38,  80,  46),
		DropHL      = Color3.fromRGB(12,  30,  16),
	},
	Crimson = {
		BG          = Color3.fromRGB(16,   8,  10),
		Sidebar     = Color3.fromRGB(22,  12,  14),
		HeaderBG    = Color3.fromRGB(22,  12,  14),
		SectionBG   = Color3.fromRGB(30,  16,  18),
		SecTitle    = Color3.fromRGB(140,  60,  70),
		Text        = Color3.fromRGB(248, 220, 222),
		SubText     = Color3.fromRGB(140,  76,  84),
		Separator   = Color3.fromRGB(52,  24,  28),
		Accent      = Color3.fromRGB(230,  50,  72),
		AccentDark  = Color3.fromRGB(190,  28,  50),
		ToggleOn    = Color3.fromRGB(230,  50,  72),
		ToggleOff   = Color3.fromRGB(52,  24,  28),
		SliderTrack = Color3.fromRGB(52,  24,  28),
		SliderFill  = Color3.fromRGB(230,  50,  72),
		White       = Color3.fromRGB(248, 220, 222),
		PressHL     = Color3.fromRGB(38,  18,  20),
		TabActive   = Color3.fromRGB(230,  50,  72),
		TabInactive = Color3.fromRGB(140,  76,  84),
		TabActiveBG = Color3.fromRGB(34,  14,  18),
		Handle      = Color3.fromRGB(78,  34,  40),
		DropHL      = Color3.fromRGB(26,  12,  14),
	},
	Slate = {
		BG          = Color3.fromRGB(18,  20,  26),
		Sidebar     = Color3.fromRGB(24,  26,  34),
		HeaderBG    = Color3.fromRGB(24,  26,  34),
		SectionBG   = Color3.fromRGB(30,  32,  42),
		SecTitle    = Color3.fromRGB(96,  106, 148),
		Text        = Color3.fromRGB(218, 222, 240),
		SubText     = Color3.fromRGB(98,  108, 150),
		Separator   = Color3.fromRGB(44,  48,  66),
		Accent      = Color3.fromRGB(120, 152, 220),
		AccentDark  = Color3.fromRGB(88,  118, 188),
		ToggleOn    = Color3.fromRGB(120, 152, 220),
		ToggleOff   = Color3.fromRGB(44,  48,  66),
		SliderTrack = Color3.fromRGB(44,  48,  66),
		SliderFill  = Color3.fromRGB(120, 152, 220),
		White       = Color3.fromRGB(218, 222, 240),
		PressHL     = Color3.fromRGB(34,  38,  52),
		TabActive   = Color3.fromRGB(120, 152, 220),
		TabInactive = Color3.fromRGB(98,  108, 150),
		TabActiveBG = Color3.fromRGB(32,  36,  52),
		Handle      = Color3.fromRGB(60,  66,  96),
		DropHL      = Color3.fromRGB(26,  30,  42),
	},
	Cyber = {
		BG          = Color3.fromRGB(6,   10,   8),
		Sidebar     = Color3.fromRGB(9,   14,  11),
		HeaderBG    = Color3.fromRGB(9,   14,  11),
		SectionBG   = Color3.fromRGB(12,  20,  15),
		SecTitle    = Color3.fromRGB(30,  140,  72),
		Text        = Color3.fromRGB(200, 255, 218),
		SubText     = Color3.fromRGB(38,  130,  68),
		Separator   = Color3.fromRGB(18,  40,  26),
		Accent      = Color3.fromRGB(0,   230, 100),
		AccentDark  = Color3.fromRGB(0,   185,  76),
		ToggleOn    = Color3.fromRGB(0,   230, 100),
		ToggleOff   = Color3.fromRGB(18,  40,  26),
		SliderTrack = Color3.fromRGB(18,  40,  26),
		SliderFill  = Color3.fromRGB(0,   230, 100),
		White       = Color3.fromRGB(200, 255, 218),
		PressHL     = Color3.fromRGB(12,  28,  18),
		TabActive   = Color3.fromRGB(0,   230, 100),
		TabInactive = Color3.fromRGB(38,  130,  68),
		TabActiveBG = Color3.fromRGB(8,   28,  16),
		Handle      = Color3.fromRGB(22,  68,  38),
		DropHL      = Color3.fromRGB(8,   22,  13),
	},
	Aqua = {
		BG          = Color3.fromRGB(8,   16,  20),
		Sidebar     = Color3.fromRGB(10,  22,  28),
		HeaderBG    = Color3.fromRGB(10,  22,  28),
		SectionBG   = Color3.fromRGB(14,  30,  38),
		SecTitle    = Color3.fromRGB(40,  120, 148),
		Text        = Color3.fromRGB(200, 240, 250),
		SubText     = Color3.fromRGB(44,  122, 148),
		Separator   = Color3.fromRGB(20,  48,  62),
		Accent      = Color3.fromRGB(0,   210, 230),
		AccentDark  = Color3.fromRGB(0,   165, 185),
		ToggleOn    = Color3.fromRGB(0,   210, 230),
		ToggleOff   = Color3.fromRGB(20,  48,  62),
		SliderTrack = Color3.fromRGB(20,  48,  62),
		SliderFill  = Color3.fromRGB(0,   210, 230),
		White       = Color3.fromRGB(200, 240, 250),
		PressHL     = Color3.fromRGB(12,  34,  46),
		TabActive   = Color3.fromRGB(0,   210, 230),
		TabInactive = Color3.fromRGB(44,  122, 148),
		TabActiveBG = Color3.fromRGB(10,  34,  48),
		Handle      = Color3.fromRGB(24,  74,  98),
		DropHL      = Color3.fromRGB(8,   26,  36),
	},
	Gold = {
		BG          = Color3.fromRGB(14,  11,   7),
		Sidebar     = Color3.fromRGB(20,  16,  10),
		HeaderBG    = Color3.fromRGB(20,  16,  10),
		SectionBG   = Color3.fromRGB(26,  21,  13),
		SecTitle    = Color3.fromRGB(148, 116,  48),
		Text        = Color3.fromRGB(255, 240, 200),
		SubText     = Color3.fromRGB(150, 118,  52),
		Separator   = Color3.fromRGB(46,  36,  18),
		Accent      = Color3.fromRGB(220, 178,  40),
		AccentDark  = Color3.fromRGB(180, 140,  20),
		ToggleOn    = Color3.fromRGB(220, 178,  40),
		ToggleOff   = Color3.fromRGB(46,  36,  18),
		SliderTrack = Color3.fromRGB(46,  36,  18),
		SliderFill  = Color3.fromRGB(220, 178,  40),
		White       = Color3.fromRGB(255, 240, 200),
		PressHL     = Color3.fromRGB(34,  26,  12),
		TabActive   = Color3.fromRGB(220, 178,  40),
		TabInactive = Color3.fromRGB(150, 118,  52),
		TabActiveBG = Color3.fromRGB(28,  22,  10),
		Handle      = Color3.fromRGB(70,  54,  22),
		DropHL      = Color3.fromRGB(22,  17,   8),
	},
	Cocoa = {
		BG          = Color3.fromRGB(20,  14,  11),
		Sidebar     = Color3.fromRGB(28,  19,  15),
		HeaderBG    = Color3.fromRGB(28,  19,  15),
		SectionBG   = Color3.fromRGB(36,  24,  18),
		SecTitle    = Color3.fromRGB(148,  92,  60),
		Text        = Color3.fromRGB(248, 228, 210),
		SubText     = Color3.fromRGB(148,  96,  68),
		Separator   = Color3.fromRGB(56,  36,  26),
		Accent      = Color3.fromRGB(210, 128,  70),
		AccentDark  = Color3.fromRGB(170,  96,  44),
		ToggleOn    = Color3.fromRGB(210, 128,  70),
		ToggleOff   = Color3.fromRGB(56,  36,  26),
		SliderTrack = Color3.fromRGB(56,  36,  26),
		SliderFill  = Color3.fromRGB(210, 128,  70),
		White       = Color3.fromRGB(248, 228, 210),
		PressHL     = Color3.fromRGB(42,  26,  18),
		TabActive   = Color3.fromRGB(210, 128,  70),
		TabInactive = Color3.fromRGB(148,  96,  68),
		TabActiveBG = Color3.fromRGB(36,  24,  16),
		Handle      = Color3.fromRGB(80,  50,  34),
		DropHL      = Color3.fromRGB(28,  18,  12),
	},
	Neon = {
		BG          = Color3.fromRGB(6,    6,  10),
		Sidebar     = Color3.fromRGB(10,  10,  16),
		HeaderBG    = Color3.fromRGB(10,  10,  16),
		SectionBG   = Color3.fromRGB(14,  14,  22),
		SecTitle    = Color3.fromRGB(160,  40, 200),
		Text        = Color3.fromRGB(240, 220, 255),
		SubText     = Color3.fromRGB(140,  60, 180),
		Separator   = Color3.fromRGB(32,  20,  48),
		Accent      = Color3.fromRGB(230,  40, 255),
		AccentDark  = Color3.fromRGB(180,  10, 210),
		ToggleOn    = Color3.fromRGB(230,  40, 255),
		ToggleOff   = Color3.fromRGB(32,  20,  48),
		SliderTrack = Color3.fromRGB(32,  20,  48),
		SliderFill  = Color3.fromRGB(230,  40, 255),
		White       = Color3.fromRGB(240, 220, 255),
		PressHL     = Color3.fromRGB(22,  12,  36),
		TabActive   = Color3.fromRGB(230,  40, 255),
		TabInactive = Color3.fromRGB(140,  60, 180),
		TabActiveBG = Color3.fromRGB(24,  10,  40),
		Handle      = Color3.fromRGB(64,  24,  90),
		DropHL      = Color3.fromRGB(18,   8,  28),
	},
	Sakura = {
		BG          = Color3.fromRGB(255, 248, 252),
		Sidebar     = Color3.fromRGB(252, 238, 248),
		HeaderBG    = Color3.fromRGB(252, 238, 248),
		SectionBG   = Color3.fromRGB(255, 255, 255),
		SecTitle    = Color3.fromRGB(220, 140, 170),
		Text        = Color3.fromRGB(48,  20,  36),
		SubText     = Color3.fromRGB(210, 150, 175),
		Separator   = Color3.fromRGB(248, 218, 234),
		Accent      = Color3.fromRGB(240, 100, 150),
		AccentDark  = Color3.fromRGB(200,  68, 118),
		ToggleOn    = Color3.fromRGB(240, 100, 150),
		ToggleOff   = Color3.fromRGB(248, 218, 234),
		SliderTrack = Color3.fromRGB(248, 218, 234),
		SliderFill  = Color3.fromRGB(240, 100, 150),
		White       = Color3.fromRGB(255, 255, 255),
		PressHL     = Color3.fromRGB(252, 230, 242),
		TabActive   = Color3.fromRGB(240, 100, 150),
		TabInactive = Color3.fromRGB(210, 150, 175),
		TabActiveBG = Color3.fromRGB(252, 224, 238),
		Handle      = Color3.fromRGB(236, 190, 212),
		DropHL      = Color3.fromRGB(255, 240, 250),
	},
	Obsidian = {
		BG          = Color3.fromRGB(4,    4,   6),
		Sidebar     = Color3.fromRGB(7,    7,  11),
		HeaderBG    = Color3.fromRGB(7,    7,  11),
		SectionBG   = Color3.fromRGB(10,  10,  16),
		SecTitle    = Color3.fromRGB(30,  90, 160),
		Text        = Color3.fromRGB(210, 220, 250),
		SubText     = Color3.fromRGB(38,  88, 148),
		Separator   = Color3.fromRGB(18,  18,  30),
		Accent      = Color3.fromRGB(0,   180, 255),
		AccentDark  = Color3.fromRGB(0,   130, 210),
		ToggleOn    = Color3.fromRGB(0,   180, 255),
		ToggleOff   = Color3.fromRGB(18,  18,  30),
		SliderTrack = Color3.fromRGB(18,  18,  30),
		SliderFill  = Color3.fromRGB(0,   180, 255),
		White       = Color3.fromRGB(210, 220, 250),
		PressHL     = Color3.fromRGB(12,  12,  22),
		TabActive   = Color3.fromRGB(0,   180, 255),
		TabInactive = Color3.fromRGB(38,  88, 148),
		TabActiveBG = Color3.fromRGB(8,   16,  32),
		Handle      = Color3.fromRGB(20,  50,  90),
		DropHL      = Color3.fromRGB(8,   10,  18),
	},
	Lavender = {
		BG          = Color3.fromRGB(248, 246, 255),
		Sidebar     = Color3.fromRGB(238, 234, 252),
		HeaderBG    = Color3.fromRGB(238, 234, 252),
		SectionBG   = Color3.fromRGB(255, 255, 255),
		SecTitle    = Color3.fromRGB(148, 124, 210),
		Text        = Color3.fromRGB(28,  20,  52),
		SubText     = Color3.fromRGB(155, 135, 200),
		Separator   = Color3.fromRGB(220, 212, 244),
		Accent      = Color3.fromRGB(138,  90, 230),
		AccentDark  = Color3.fromRGB(102,  58, 196),
		ToggleOn    = Color3.fromRGB(138,  90, 230),
		ToggleOff   = Color3.fromRGB(220, 212, 244),
		SliderTrack = Color3.fromRGB(220, 212, 244),
		SliderFill  = Color3.fromRGB(138,  90, 230),
		White       = Color3.fromRGB(255, 255, 255),
		PressHL     = Color3.fromRGB(232, 226, 250),
		TabActive   = Color3.fromRGB(138,  90, 230),
		TabInactive = Color3.fromRGB(155, 135, 200),
		TabActiveBG = Color3.fromRGB(228, 218, 250),
		Handle      = Color3.fromRGB(196, 180, 238),
		DropHL      = Color3.fromRGB(244, 240, 255),
	},
	Mint = {
		BG          = Color3.fromRGB(8,   16,  14),
		Sidebar     = Color3.fromRGB(10,  22,  19),
		HeaderBG    = Color3.fromRGB(10,  22,  19),
		SectionBG   = Color3.fromRGB(14,  30,  26),
		SecTitle    = Color3.fromRGB(40,  140, 110),
		Text        = Color3.fromRGB(200, 248, 236),
		SubText     = Color3.fromRGB(48,  132, 104),
		Separator   = Color3.fromRGB(22,  52,  44),
		Accent      = Color3.fromRGB(60,  220, 170),
		AccentDark  = Color3.fromRGB(30,  178, 132),
		ToggleOn    = Color3.fromRGB(60,  220, 170),
		ToggleOff   = Color3.fromRGB(22,  52,  44),
		SliderTrack = Color3.fromRGB(22,  52,  44),
		SliderFill  = Color3.fromRGB(60,  220, 170),
		White       = Color3.fromRGB(200, 248, 236),
		PressHL     = Color3.fromRGB(14,  38,  32),
		TabActive   = Color3.fromRGB(60,  220, 170),
		TabInactive = Color3.fromRGB(48,  132, 104),
		TabActiveBG = Color3.fromRGB(10,  36,  30),
		Handle      = Color3.fromRGB(28,  88,  68),
		DropHL      = Color3.fromRGB(10,  28,  22),
	},
	Solar = {
		BG          = Color3.fromRGB(12,   8,   4),
		Sidebar     = Color3.fromRGB(18,  12,   6),
		HeaderBG    = Color3.fromRGB(18,  12,   6),
		SectionBG   = Color3.fromRGB(24,  16,   8),
		SecTitle    = Color3.fromRGB(180,  90,  30),
		Text        = Color3.fromRGB(255, 240, 210),
		SubText     = Color3.fromRGB(175,  95,  40),
		Separator   = Color3.fromRGB(48,  28,  12),
		Accent      = Color3.fromRGB(255, 160,  30),
		AccentDark  = Color3.fromRGB(220, 120,  10),
		ToggleOn    = Color3.fromRGB(255, 160,  30),
		ToggleOff   = Color3.fromRGB(48,  28,  12),
		SliderTrack = Color3.fromRGB(48,  28,  12),
		SliderFill  = Color3.fromRGB(255, 160,  30),
		White       = Color3.fromRGB(255, 240, 210),
		PressHL     = Color3.fromRGB(36,  20,   8),
		TabActive   = Color3.fromRGB(255, 160,  30),
		TabInactive = Color3.fromRGB(175,  95,  40),
		TabActiveBG = Color3.fromRGB(32,  18,   6),
		Handle      = Color3.fromRGB(80,  44,  14),
		DropHL      = Color3.fromRGB(24,  14,   4),
	},
	Glacier = {
		BG          = Color3.fromRGB(234, 244, 252),
		Sidebar     = Color3.fromRGB(218, 236, 250),
		HeaderBG    = Color3.fromRGB(218, 236, 250),
		SectionBG   = Color3.fromRGB(255, 255, 255),
		SecTitle    = Color3.fromRGB(80,  148, 200),
		Text        = Color3.fromRGB(12,  34,  58),
		SubText     = Color3.fromRGB(88,  148, 192),
		Separator   = Color3.fromRGB(196, 220, 240),
		Accent      = Color3.fromRGB(40,  160, 230),
		AccentDark  = Color3.fromRGB(20,  120, 195),
		ToggleOn    = Color3.fromRGB(40,  160, 230),
		ToggleOff   = Color3.fromRGB(196, 220, 240),
		SliderTrack = Color3.fromRGB(196, 220, 240),
		SliderFill  = Color3.fromRGB(40,  160, 230),
		White       = Color3.fromRGB(255, 255, 255),
		PressHL     = Color3.fromRGB(210, 230, 246),
		TabActive   = Color3.fromRGB(40,  160, 230),
		TabInactive = Color3.fromRGB(88,  148, 192),
		TabActiveBG = Color3.fromRGB(206, 228, 248),
		Handle      = Color3.fromRGB(168, 204, 232),
		DropHL      = Color3.fromRGB(226, 240, 252),
	},
	Dusk = {
		BG          = Color3.fromRGB(14,   8,  18),
		Sidebar     = Color3.fromRGB(20,  12,  26),
		HeaderBG    = Color3.fromRGB(20,  12,  26),
		SectionBG   = Color3.fromRGB(28,  16,  36),
		SecTitle    = Color3.fromRGB(160,  80, 120),
		Text        = Color3.fromRGB(248, 228, 255),
		SubText     = Color3.fromRGB(148,  82, 120),
		Separator   = Color3.fromRGB(50,  26,  62),
		Accent      = Color3.fromRGB(220, 100, 200),
		AccentDark  = Color3.fromRGB(180,  70, 165),
		ToggleOn    = Color3.fromRGB(220, 100, 200),
		ToggleOff   = Color3.fromRGB(50,  26,  62),
		SliderTrack = Color3.fromRGB(50,  26,  62),
		SliderFill  = Color3.fromRGB(220, 100, 200),
		White       = Color3.fromRGB(248, 228, 255),
		PressHL     = Color3.fromRGB(36,  18,  46),
		TabActive   = Color3.fromRGB(220, 100, 200),
		TabInactive = Color3.fromRGB(148,  82, 120),
		TabActiveBG = Color3.fromRGB(34,  14,  48),
		Handle      = Color3.fromRGB(80,  38,  96),
		DropHL      = Color3.fromRGB(24,  10,  32),
	},
	Storm = {
		BG          = Color3.fromRGB(12,  14,  18),
		Sidebar     = Color3.fromRGB(16,  20,  26),
		HeaderBG    = Color3.fromRGB(16,  20,  26),
		SectionBG   = Color3.fromRGB(22,  26,  34),
		SecTitle    = Color3.fromRGB(80,  110, 155),
		Text        = Color3.fromRGB(210, 218, 235),
		SubText     = Color3.fromRGB(82,  108, 148),
		Separator   = Color3.fromRGB(36,  44,  58),
		Accent      = Color3.fromRGB(100, 180, 255),
		AccentDark  = Color3.fromRGB(68,  140, 220),
		ToggleOn    = Color3.fromRGB(100, 180, 255),
		ToggleOff   = Color3.fromRGB(36,  44,  58),
		SliderTrack = Color3.fromRGB(36,  44,  58),
		SliderFill  = Color3.fromRGB(100, 180, 255),
		White       = Color3.fromRGB(210, 218, 235),
		PressHL     = Color3.fromRGB(26,  32,  44),
		TabActive   = Color3.fromRGB(100, 180, 255),
		TabInactive = Color3.fromRGB(82,  108, 148),
		TabActiveBG = Color3.fromRGB(24,  32,  50),
		Handle      = Color3.fromRGB(48,  68,  104),
		DropHL      = Color3.fromRGB(18,  24,  34),
	},
	Candy = {
		BG          = Color3.fromRGB(255, 245, 252),
		Sidebar     = Color3.fromRGB(252, 234, 248),
		HeaderBG    = Color3.fromRGB(252, 234, 248),
		SectionBG   = Color3.fromRGB(255, 255, 255),
		SecTitle    = Color3.fromRGB(230, 130, 200),
		Text        = Color3.fromRGB(50,  18,  42),
		SubText     = Color3.fromRGB(210, 140, 190),
		Separator   = Color3.fromRGB(248, 210, 238),
		Accent      = Color3.fromRGB(255,  80, 180),
		AccentDark  = Color3.fromRGB(220,  44, 148),
		ToggleOn    = Color3.fromRGB(255,  80, 180),
		ToggleOff   = Color3.fromRGB(248, 210, 238),
		SliderTrack = Color3.fromRGB(248, 210, 238),
		SliderFill  = Color3.fromRGB(255,  80, 180),
		White       = Color3.fromRGB(255, 255, 255),
		PressHL     = Color3.fromRGB(252, 224, 244),
		TabActive   = Color3.fromRGB(255,  80, 180),
		TabInactive = Color3.fromRGB(210, 140, 190),
		TabActiveBG = Color3.fromRGB(252, 218, 242),
		Handle      = Color3.fromRGB(240, 182, 220),
		DropHL      = Color3.fromRGB(255, 242, 252),
	},
	Void = {
		BG          = Color3.fromRGB(2,    2,   4),
		Sidebar     = Color3.fromRGB(4,    4,   8),
		HeaderBG    = Color3.fromRGB(4,    4,   8),
		SectionBG   = Color3.fromRGB(6,    6,  12),
		SecTitle    = Color3.fromRGB(60,  40, 120),
		Text        = Color3.fromRGB(200, 195, 230),
		SubText     = Color3.fromRGB(58,  42, 110),
		Separator   = Color3.fromRGB(16,  12,  30),
		Accent      = Color3.fromRGB(120,  80, 255),
		AccentDark  = Color3.fromRGB(80,  44, 210),
		ToggleOn    = Color3.fromRGB(120,  80, 255),
		ToggleOff   = Color3.fromRGB(16,  12,  30),
		SliderTrack = Color3.fromRGB(16,  12,  30),
		SliderFill  = Color3.fromRGB(120,  80, 255),
		White       = Color3.fromRGB(200, 195, 230),
		PressHL     = Color3.fromRGB(10,   8,  20),
		TabActive   = Color3.fromRGB(120,  80, 255),
		TabInactive = Color3.fromRGB(58,  42, 110),
		TabActiveBG = Color3.fromRGB(10,   6,  24),
		Handle      = Color3.fromRGB(38,  24,  80),
		DropHL      = Color3.fromRGB(6,    4,  14),
	},
}

local T = Themes.Onyx

local function Tween(Object, Props, Time, Style, Dir)
	TweenService:Create(Object, TweenInfo.new(Time or .26, Style or Enum.EasingStyle.Quint, Dir or Enum.EasingDirection.Out), Props):Play()
end

local function TweenBack(Object, Props, Time)
	TweenService:Create(Object, TweenInfo.new(Time or .40, Enum.EasingStyle.Back, Enum.EasingDirection.Out), Props):Play()
end

local function TweenLinear(Object, Props, Time)
	TweenService:Create(Object, TweenInfo.new(Time or .14, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), Props):Play()
end

local function Corner(Parent, Radius)
	local C = Instance.new("UICorner")
	C.CornerRadius = UDim.new(0, Radius or 8)
	C.Parent = Parent
	return C
end

local function Stroke(Parent, Color, Thickness)
	local S = Instance.new("UIStroke")
	S.Color = Color
	S.Thickness = Thickness or 1
	S.Parent = Parent
	return S
end

local function ApplyPadding(Parent, Top, Right, Bottom, Left)
	local P = Instance.new("UIPadding")
	P.PaddingTop    = UDim.new(0, Top    or 0)
	P.PaddingRight  = UDim.new(0, Right  or 0)
	P.PaddingBottom = UDim.new(0, Bottom or 0)
	P.PaddingLeft   = UDim.new(0, Left   or 0)
	P.Parent = Parent
end

function Library:CreateWindow(Config)
	Config = Config or {}
	local Title         = Config.Title           or "Menu"
	local Subtitle      = Config.SubTitle        or ""
	local LoadTitle     = Config.LoadingTitle    or "Loading"
	local LoadSub       = Config.LoadingSubtitle or "Please wait…"
	local LoadImage     = Config.LoadingImage
	local ButtonId      = Config.ButtonId
	local ThemeName     = Config.Theme           or "Onyx"

	T = Themes[ThemeName] or Themes.Onyx

	local Nodes = {}
	local function Register(Object, Prop, Key)
		if Object and Prop and Key then
			table.insert(Nodes, {O = Object, P = Prop, K = Key})
		end
	end
	local function RegisterFn(Fn)
		if Fn then table.insert(Nodes, {Fn = Fn}) end
	end

	local Gui = Instance.new("ScreenGui")
	Gui.Name = "PremiumUI"
	Gui.ResetOnSpawn = false
	Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Gui.IgnoreGuiInset = true
	local Ok = pcall(function() Gui.Parent = gethui() end)
	if not Ok then Gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui") end

	local function GetWindowSize()
		local Sw = Gui.AbsoluteSize.X
		local Sh = Gui.AbsoluteSize.Y
		local W  = math.clamp(math.floor(Sw * .66), 272, 450)
		local H  = math.clamp(math.floor(Sh * .62), 290, 432)
		return W, H
	end

	local LoadBG = Instance.new("Frame")
	LoadBG.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
	LoadBG.BorderSizePixel  = 0
	LoadBG.Size             = UDim2.new(1, 0, 1, 0)
	LoadBG.ZIndex           = 200
	LoadBG.Parent           = Gui

	local LoadGrad = Instance.new("UIGradient")
	LoadGrad.Color    = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(14, 10, 24)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(6,  6,  12)),
	}
	LoadGrad.Rotation = 135
	LoadGrad.Parent   = LoadBG

	local LoadCenter = Instance.new("Frame")
	LoadCenter.BackgroundTransparency = 1
	LoadCenter.Size                   = UDim2.new(0, 240, 0, 200)
	LoadCenter.Position               = UDim2.new(0.5, -120, 0.5, -100)
	LoadCenter.ZIndex                 = 201
	LoadCenter.Parent                 = LoadBG

	local LoadOffset = 0
	if LoadImage then
		local ImageValue, IsAsset = ResolveIcon(LoadImage)
		if IsAsset then
			local Img = Instance.new("ImageLabel")
			Img.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
			Img.BorderSizePixel  = 0
			Img.Size             = UDim2.new(0, 72, 0, 72)
			Img.Position         = UDim2.new(0.5, -36, 0, 0)
			Img.Image            = ImageValue
			Img.ScaleType        = Enum.ScaleType.Fit
			Img.ZIndex           = 202
			Img.Parent           = LoadCenter
			Corner(Img, 16)
			Stroke(Img, Color3.fromRGB(50, 50, 80), 1)
		end
		LoadOffset = 86
	end

	local LoadTitleLbl = Instance.new("TextLabel")
	LoadTitleLbl.BackgroundTransparency = 1
	LoadTitleLbl.Size                   = UDim2.new(1, 0, 0, 22)
	LoadTitleLbl.Position               = UDim2.new(0, 0, 0, LoadOffset + 4)
	LoadTitleLbl.Text                   = LoadTitle
	LoadTitleLbl.TextColor3             = Color3.fromRGB(230, 230, 250)
	LoadTitleLbl.Font                   = Enum.Font.GothamBold
	LoadTitleLbl.TextSize               = 13
	LoadTitleLbl.TextXAlignment         = Enum.TextXAlignment.Center
	LoadTitleLbl.ZIndex                 = 202
	LoadTitleLbl.Parent                 = LoadCenter

	local LoadSubLbl = Instance.new("TextLabel")
	LoadSubLbl.BackgroundTransparency = 1
	LoadSubLbl.Size                   = UDim2.new(1, 0, 0, 16)
	LoadSubLbl.Position               = UDim2.new(0, 0, 0, LoadOffset + 30)
	LoadSubLbl.Text                   = LoadSub
	LoadSubLbl.TextColor3             = Color3.fromRGB(88, 88, 120)
	LoadSubLbl.Font                   = Enum.Font.Gotham
	LoadSubLbl.TextSize               = 9
	LoadSubLbl.TextXAlignment         = Enum.TextXAlignment.Center
	LoadSubLbl.ZIndex                 = 202
	LoadSubLbl.Parent                 = LoadCenter

	local BarBG = Instance.new("Frame")
	BarBG.BackgroundColor3 = Color3.fromRGB(28, 28, 40)
	BarBG.BorderSizePixel  = 0
	BarBG.Size             = UDim2.new(0, 160, 0, 3)
	BarBG.Position         = UDim2.new(0.5, -80, 0, LoadOffset + 64)
	BarBG.ZIndex           = 202
	BarBG.Parent           = LoadCenter
	Corner(BarBG, 2)

	local BarFill = Instance.new("Frame")
	BarFill.BackgroundColor3 = T.Accent
	BarFill.BorderSizePixel  = 0
	BarFill.Size             = UDim2.new(0, 0, 1, 0)
	BarFill.ZIndex           = 203
	BarFill.Parent           = BarBG
	Corner(BarFill, 2)

	local BarGlow = Instance.new("UIGradient")
	BarGlow.Color  = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, T.Accent),
	}
	BarGlow.Parent = BarFill

	local BarConn = RunService.Heartbeat:Connect(function()
		BarFill.Size = UDim2.new(tick() % 2 / 2, 0, 1, 0)
	end)

	local WinW, WinH  = GetWindowSize()
	local SidebarWidth = 88
	local HeaderHeight = 40

	local Win = Instance.new("Frame")
	Win.Name              = "Window"
	Win.BackgroundColor3  = T.BG
	Win.BorderSizePixel   = 0
	Win.Size              = UDim2.new(0, WinW, 0, WinH)
	Win.Position          = UDim2.new(0.5, -WinW / 2, 0.5, -WinH / 2)
	Win.ClipsDescendants  = true
	Win.Visible           = false
	Win.ZIndex            = 10
	Win.Parent            = Gui
	Corner(Win, 14)
	Register(Win, "BackgroundColor3", "BG")

	local WinScale = Instance.new("UIScale")
	WinScale.Scale  = 1
	WinScale.Parent = Win

	local WinStroke = Stroke(Win, T.Separator, 1)
	Register(WinStroke, "Color", "Separator")

	local Sidebar = Instance.new("Frame")
	Sidebar.Name             = "Sidebar"
	Sidebar.BackgroundColor3 = T.Sidebar
	Sidebar.BorderSizePixel  = 0
	Sidebar.Size             = UDim2.new(0, SidebarWidth, 1, 0)
	Sidebar.Position         = UDim2.new(0, 0, 0, 0)
	Sidebar.ZIndex           = 12
	Sidebar.Parent           = Win
	Register(Sidebar, "BackgroundColor3", "Sidebar")

	local SidebarLine = Instance.new("Frame")
	SidebarLine.BackgroundColor3 = T.Separator
	SidebarLine.BorderSizePixel  = 0
	SidebarLine.Size             = UDim2.new(0, 1, 1, 0)
	SidebarLine.Position         = UDim2.new(1, -1, 0, 0)
	SidebarLine.ZIndex           = 13
	SidebarLine.Parent           = Sidebar
	Register(SidebarLine, "BackgroundColor3", "Separator")

	local SidebarTop = Instance.new("Frame")
	SidebarTop.BackgroundTransparency = 1
	SidebarTop.Size                   = UDim2.new(1, 0, 0, HeaderHeight)
	SidebarTop.ZIndex                 = 13
	SidebarTop.Parent                 = Sidebar
	ApplyPadding(SidebarTop, 0, 8, 0, 8)

	local SideLogoImg = nil
	if LoadImage then
		local ImageValue, IsAsset = ResolveIcon(LoadImage)
		if IsAsset then
			SideLogoImg = Instance.new("ImageLabel")
			SideLogoImg.BackgroundTransparency = 1
			SideLogoImg.AnchorPoint            = Vector2.new(0.5, 0.5)
			SideLogoImg.Size                   = UDim2.new(0, 22, 0, 22)
			SideLogoImg.Position               = UDim2.new(0.5, 0, 0.5, 0)
			SideLogoImg.Image                  = ImageValue
			SideLogoImg.ScaleType              = Enum.ScaleType.Fit
			SideLogoImg.ZIndex                 = 14
			SideLogoImg.Parent                 = SidebarTop
		end
	end

	if not SideLogoImg then
		local SideTitleLbl = Instance.new("TextLabel")
		SideTitleLbl.BackgroundTransparency = 1
		SideTitleLbl.AnchorPoint            = Vector2.new(0.5, 0.5)
		SideTitleLbl.Size                   = UDim2.new(1, -4, 0, 20)
		SideTitleLbl.Position               = UDim2.new(0.5, 0, 0.5, Subtitle ~= "" and -4 or 0)
		SideTitleLbl.Text                   = Title
		SideTitleLbl.TextColor3             = T.Text
		SideTitleLbl.Font                   = Enum.Font.GothamBold
		SideTitleLbl.TextSize               = 9
		SideTitleLbl.TextXAlignment         = Enum.TextXAlignment.Center
		SideTitleLbl.TextTruncate           = Enum.TextTruncate.AtEnd
		SideTitleLbl.ZIndex                 = 14
		SideTitleLbl.Parent                 = SidebarTop
		Register(SideTitleLbl, "TextColor3", "Text")
		if Subtitle ~= "" then
			local SideSubLbl = Instance.new("TextLabel")
			SideSubLbl.BackgroundTransparency = 1
			SideSubLbl.AnchorPoint            = Vector2.new(0.5, 0.5)
			SideSubLbl.Size                   = UDim2.new(1, -4, 0, 12)
			SideSubLbl.Position               = UDim2.new(0.5, 0, 0.5, 10)
			SideSubLbl.Text                   = Subtitle
			SideSubLbl.TextColor3             = T.SubText
			SideSubLbl.Font                   = Enum.Font.Gotham
			SideSubLbl.TextSize               = 8
			SideSubLbl.TextXAlignment         = Enum.TextXAlignment.Center
			SideSubLbl.TextTruncate           = Enum.TextTruncate.AtEnd
			SideSubLbl.ZIndex                 = 14
			SideSubLbl.Parent                 = SidebarTop
			Register(SideSubLbl, "TextColor3", "SubText")
		end
	end

	local SideTabLine = Instance.new("Frame")
	SideTabLine.BackgroundColor3 = T.Separator
	SideTabLine.BorderSizePixel  = 0
	SideTabLine.Size             = UDim2.new(1, -16, 0, 1)
	SideTabLine.Position         = UDim2.new(0, 8, 0, HeaderHeight - 1)
	SideTabLine.ZIndex           = 13
	SideTabLine.Parent           = Sidebar
	Register(SideTabLine, "BackgroundColor3", "Separator")

	local SideAccentBar = Instance.new("Frame")
	SideAccentBar.BackgroundColor3 = T.Accent
	SideAccentBar.BorderSizePixel  = 0
	SideAccentBar.Size             = UDim2.new(0, 28, 0, 2)
	SideAccentBar.AnchorPoint      = Vector2.new(0.5, 0)
	SideAccentBar.Position         = UDim2.new(0.5, 0, 0, 0)
	SideAccentBar.ZIndex           = 16
	SideAccentBar.Parent           = Sidebar
	Corner(SideAccentBar, 1)
	Register(SideAccentBar, "BackgroundColor3", "Accent")

	local TabListScroll = Instance.new("ScrollingFrame")
	TabListScroll.BackgroundTransparency = 1
	TabListScroll.BorderSizePixel        = 0
	TabListScroll.Size                   = UDim2.new(1, 0, 1, -(HeaderHeight + 48))
	TabListScroll.Position               = UDim2.new(0, 0, 0, HeaderHeight)
	TabListScroll.CanvasSize             = UDim2.new(0, 0, 0, 0)
	TabListScroll.ScrollBarThickness     = 0
	TabListScroll.ScrollingDirection     = Enum.ScrollingDirection.Y
	TabListScroll.ZIndex                 = 13
	TabListScroll.Parent                 = Sidebar
	ApplyPadding(TabListScroll, 6, 0, 6, 0)

	local TabListLayout = Instance.new("UIListLayout")
	TabListLayout.FillDirection = Enum.FillDirection.Vertical
	TabListLayout.SortOrder     = Enum.SortOrder.LayoutOrder
	TabListLayout.Padding       = UDim.new(0, 2)
	TabListLayout.Parent        = TabListScroll

	TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabListScroll.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y + 12)
	end)

	local SideBottom = Instance.new("Frame")
	SideBottom.BackgroundTransparency = 1
	SideBottom.Size                   = UDim2.new(1, 0, 0, 48)
	SideBottom.AnchorPoint            = Vector2.new(0, 1)
	SideBottom.Position               = UDim2.new(0, 0, 1, 0)
	SideBottom.ZIndex                 = 13
	SideBottom.Parent                 = Sidebar
	ApplyPadding(SideBottom, 0, 8, 8, 8)

	local BottomSep = Instance.new("Frame")
	BottomSep.BackgroundColor3 = T.Separator
	BottomSep.BorderSizePixel  = 0
	BottomSep.Size             = UDim2.new(1, 0, 0, 1)
	BottomSep.Position         = UDim2.new(0, 0, 0, 0)
	BottomSep.ZIndex           = 14
	BottomSep.Parent           = SideBottom
	Register(BottomSep, "BackgroundColor3", "Separator")

	local CloseBtn = Instance.new("TextButton")
	CloseBtn.BackgroundColor3 = T.SectionBG
	CloseBtn.BorderSizePixel  = 0
	CloseBtn.Size             = UDim2.new(1, 0, 0, 30)
	CloseBtn.Position         = UDim2.new(0, 0, 0, 6)
	CloseBtn.Text             = ""
	CloseBtn.ZIndex           = 14
	CloseBtn.Parent           = SideBottom
	Corner(CloseBtn, 8)
	Register(CloseBtn, "BackgroundColor3", "SectionBG")

	local CloseBtnStroke = Stroke(CloseBtn, T.Separator, 1)
	Register(CloseBtnStroke, "Color", "Separator")

	local CloseBtnLbl = Instance.new("TextLabel")
	CloseBtnLbl.BackgroundTransparency = 1
	CloseBtnLbl.Size                   = UDim2.new(1, 0, 1, 0)
	CloseBtnLbl.Text                   = "✕  Close"
	CloseBtnLbl.TextColor3             = T.SubText
	CloseBtnLbl.Font                   = Enum.Font.GothamBold
	CloseBtnLbl.TextSize               = 10
	CloseBtnLbl.ZIndex                 = 15
	CloseBtnLbl.Parent                 = CloseBtn
	Register(CloseBtnLbl, "TextColor3", "SubText")

	local CloseBtnScale = Instance.new("UIScale")
	CloseBtnScale.Scale  = 1
	CloseBtnScale.Parent = CloseBtn

	CloseBtn.MouseEnter:Connect(function()        Tween(CloseBtnLbl, {TextColor3 = T.Text}, .18) end)
	CloseBtn.MouseLeave:Connect(function()        Tween(CloseBtnLbl, {TextColor3 = T.SubText}, .24) end)
	CloseBtn.MouseButton1Down:Connect(function()  TweenLinear(CloseBtnScale, {Scale = .93}, .08) end)
	CloseBtn.MouseButton1Up:Connect(function()    TweenBack(CloseBtnScale, {Scale = 1}, .40) end)

	local MainArea = Instance.new("Frame")
	MainArea.BackgroundTransparency = 1
	MainArea.Size                   = UDim2.new(1, -SidebarWidth, 1, 0)
	MainArea.Position               = UDim2.new(0, SidebarWidth, 0, 0)
	MainArea.ClipsDescendants       = true
	MainArea.ZIndex                 = 11
	MainArea.Parent                 = Win

	local ContentArea = Instance.new("Frame")
	ContentArea.BackgroundTransparency = 1
	ContentArea.Size                   = UDim2.new(1, 0, 1, 0)
	ContentArea.ZIndex                 = 11
	ContentArea.ClipsDescendants       = true
	ContentArea.Parent                 = MainArea

	local TabFadeOverlay = Instance.new("Frame")
	TabFadeOverlay.BackgroundColor3       = T.BG
	TabFadeOverlay.BackgroundTransparency = 1
	TabFadeOverlay.BorderSizePixel        = 0
	TabFadeOverlay.Size                   = UDim2.new(1, 0, 1, 0)
	TabFadeOverlay.ZIndex                 = 50
	TabFadeOverlay.Parent                 = ContentArea
	Register(TabFadeOverlay, "BackgroundColor3", "BG")

	local CloseOverlay = Instance.new("Frame")
	CloseOverlay.BackgroundColor3       = T.BG
	CloseOverlay.BackgroundTransparency = 1
	CloseOverlay.BorderSizePixel        = 0
	CloseOverlay.Size                   = UDim2.new(1, 0, 1, 0)
	CloseOverlay.ZIndex                 = 200
	CloseOverlay.Parent                 = Win
	Corner(CloseOverlay, 14)
	Register(CloseOverlay, "BackgroundColor3", "BG")

	local ImgId  = ButtonId and tostring(ButtonId) or "85798284091961"
	local ShowBtn = Instance.new("ImageButton")
	ShowBtn.Image                  = "rbxassetid://" .. ImgId
	ShowBtn.ImageTransparency      = 1
	ShowBtn.BackgroundColor3       = T.Sidebar
	ShowBtn.BackgroundTransparency = 1
	ShowBtn.Size                   = UDim2.new(0, 48, 0, 48)
	ShowBtn.AnchorPoint            = Vector2.new(0.5, 0)
	ShowBtn.Position               = UDim2.new(0.5, 0, 0, 14)
	ShowBtn.ZIndex                 = 100
	ShowBtn.Visible                = false
	ShowBtn.Parent                 = Gui
	Corner(ShowBtn, 14)

	local ShowBtnStroke = Stroke(ShowBtn, T.Accent, 1.8)
	Register(ShowBtnStroke, "Color", "Accent")
	Register(ShowBtn, "BackgroundColor3", "Sidebar")

	local ShowBtnScale = Instance.new("UIScale")
	ShowBtnScale.Scale  = 1
	ShowBtnScale.Parent = ShowBtn

	ShowBtn.MouseButton1Down:Connect(function()
		TweenService:Create(ShowBtnScale, TweenInfo.new(.10, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Scale = .84}):Play()
		TweenService:Create(ShowBtn, TweenInfo.new(.10, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = .3}):Play()
	end)
	ShowBtn.MouseButton1Up:Connect(function()
		TweenService:Create(ShowBtnScale, TweenInfo.new(.48, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
		TweenService:Create(ShowBtn, TweenInfo.new(.26, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
	end)

	local IsDragging   = false
	local DragStart    = nil
	local StartWinPos  = nil

	Sidebar.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			IsDragging  = true
			DragStart   = Input.Position
			StartWinPos = Win.Position
		end
	end)
	UserInputService.InputChanged:Connect(function(Input)
		if not IsDragging then return end
		if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then return end
		local Delta = Input.Position - DragStart
		Win.Position = UDim2.new(StartWinPos.X.Scale, StartWinPos.X.Offset + Delta.X, StartWinPos.Y.Scale, StartWinPos.Y.Offset + Delta.Y)
	end)
	UserInputService.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
			IsDragging = false
		end
	end)

	CloseBtn.MouseButton1Click:Connect(function()
		local Wp = Win.Position
		Tween(CloseOverlay, {BackgroundTransparency = 0}, .22, Enum.EasingStyle.Quint)
		TweenService:Create(WinScale, TweenInfo.new(.50, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Scale = .86}):Play()
		TweenService:Create(Win, TweenInfo.new(.50, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
			{Position = UDim2.new(Wp.X.Scale, Wp.X.Offset, Wp.Y.Scale, Wp.Y.Offset - 14)}):Play()
		task.delay(.56, function()
			Win.Visible                        = false
			CloseOverlay.BackgroundTransparency = 1
			Win.Position                        = Wp
			WinScale.Scale                      = 1
			ShowBtn.Visible                     = true
			ShowBtn.ImageTransparency           = 1
			ShowBtn.BackgroundTransparency      = 1
			ShowBtnScale.Scale                  = 0.50
			TweenService:Create(ShowBtn, TweenInfo.new(.44, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{ImageTransparency = 0, BackgroundTransparency = 0}):Play()
			TweenService:Create(ShowBtnScale, TweenInfo.new(.74, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
				{Scale = 1}):Play()
		end)
	end)

	ShowBtn.MouseButton1Click:Connect(function()
		TweenService:Create(ShowBtnScale, TweenInfo.new(.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Scale = .72}):Play()
		TweenService:Create(ShowBtn, TweenInfo.new(.26, Enum.EasingStyle.Quint, Enum.EasingDirection.In),
			{ImageTransparency = 1, BackgroundTransparency = 1}):Play()
		task.delay(.28, function()
			ShowBtn.Visible    = false
			ShowBtnScale.Scale = 1
			local Wp           = Win.Position
			Win.Visible        = true
			Win.Position       = UDim2.new(Wp.X.Scale, Wp.X.Offset, Wp.Y.Scale, Wp.Y.Offset + 32)
			WinScale.Scale     = .82
			TweenService:Create(Win, TweenInfo.new(.64, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{Position = UDim2.new(Wp.X.Scale, Wp.X.Offset, Wp.Y.Scale, Wp.Y.Offset)}):Play()
			TweenService:Create(WinScale, TweenInfo.new(.80, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
				{Scale = 1}):Play()
		end)
	end)

	task.spawn(function()
		task.wait(2.4)
		BarConn:Disconnect()
		Tween(LoadBG, {BackgroundTransparency = 1}, .42, Enum.EasingStyle.Quint)
		for _, Descendant in ipairs(LoadBG:GetDescendants()) do
			if Descendant:IsA("GuiObject") then
				local Props = {BackgroundTransparency = 1}
				if Descendant:IsA("TextLabel") then Props.TextTransparency = 1 end
				if Descendant:IsA("ImageLabel") then Props.ImageTransparency = 1 end
				Tween(Descendant, Props, .32, Enum.EasingStyle.Quint)
			end
		end
		task.wait(.48)
		LoadBG:Destroy()
		local Nw, Nh = GetWindowSize()
		Win.Visible  = true
		Win.Position = UDim2.new(0.5, -Nw / 2, 0.5, -Nh / 2 + 32)
		WinScale.Scale = .82
		TweenService:Create(Win, TweenInfo.new(.72, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
			{Position = UDim2.new(0.5, -Nw / 2, 0.5, -Nh / 2)}):Play()
		TweenService:Create(WinScale, TweenInfo.new(.88, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
	end)

	local WindowObj = {}
	local Tabs      = {}
	local TabCount  = 0

	local function DeactivateAllTabs()
		for _, TabData in ipairs(Tabs) do
			TabData.Content.Visible = false
			Tween(TabData.Label,     {TextColor3 = T.TabInactive}, .20)
			Tween(TabData.Pill,      {BackgroundTransparency = 1, Size = UDim2.new(0, 3, 0, 18)}, .24, Enum.EasingStyle.Quint)
			Tween(TabData.PillColor, {BackgroundColor3 = T.TabActiveBG}, .20)
			TabData.PillColor.BackgroundTransparency = 1
			if TabData.Icon then
				local Prop = TabData.Icon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"
				Tween(TabData.Icon, {[Prop] = T.TabInactive}, .20)
			end
		end
	end

	function WindowObj:SetTheme(Name)
		T = Themes[Name] or Themes.Onyx
		local Live = {}
		for _, Node in ipairs(Nodes) do
			if Node.Fn then
				Node.Fn()
				Live[#Live + 1] = Node
			elseif Node.O and Node.O.Parent then
				local Val = T[Node.K]
				if Val then Tween(Node.O, {[Node.P] = Val}, .28) end
				Live[#Live + 1] = Node
			end
		end
		Nodes = Live
		for _, TabData in ipairs(Tabs) do
			local IsActive = TabData.Content.Visible
			local Col      = IsActive and T.TabActive or T.TabInactive
			Tween(TabData.Label, {TextColor3 = Col}, .28)
			if TabData.Icon then
				local Prop = TabData.Icon:IsA("ImageLabel") and "ImageColor3" or "TextColor3"
				Tween(TabData.Icon, {[Prop] = Col}, .28)
			end
		end
	end

	function WindowObj:CreateTab(TabConfig)
		TabConfig  = TabConfig or {}
		local TabTitle = TabConfig.Title or "Tab"
		TabCount = TabCount + 1
		local Idx = TabCount

		local TabBtn = Instance.new("TextButton")
		TabBtn.BackgroundTransparency = 1
		TabBtn.Size                   = UDim2.new(1, 0, 0, 26)
		TabBtn.Text                   = ""
		TabBtn.ZIndex                 = 14
		TabBtn.LayoutOrder            = Idx
		TabBtn.Parent                 = TabListScroll
		ApplyPadding(TabBtn, 0, 8, 0, 8)

		local PillBG = Instance.new("Frame")
		PillBG.BackgroundColor3       = T.TabActiveBG
		PillBG.BackgroundTransparency = 1
		PillBG.BorderSizePixel        = 0
		PillBG.Size                   = UDim2.new(1, 0, 1, 0)
		PillBG.ZIndex                 = 13
		PillBG.Parent                 = TabBtn
		Corner(PillBG, 7)

		local Pill = Instance.new("Frame")
		Pill.BackgroundColor3       = T.TabActive
		Pill.BorderSizePixel        = 0
		Pill.AnchorPoint            = Vector2.new(0, .5)
		Pill.Size                   = UDim2.new(0, 3, 0, 18)
		Pill.Position               = UDim2.new(0, 0, .5, 0)
		Pill.BackgroundTransparency = 1
		Pill.ZIndex                 = 15
		Pill.Parent                 = TabBtn
		Corner(Pill, 2)
		Register(Pill, "BackgroundColor3", "TabActive")

		local TabLbl = Instance.new("TextLabel")
		TabLbl.BackgroundTransparency = 1
		TabLbl.AnchorPoint            = Vector2.new(0, .5)
		TabLbl.Size                   = UDim2.new(1, -14, 0, 12)
		TabLbl.Position               = UDim2.new(0, 8, .5, 0)
		TabLbl.Text                   = TabTitle
		TabLbl.TextColor3             = T.TabInactive
		TabLbl.Font                   = Enum.Font.GothamMedium
		TabLbl.TextSize               = 9
		TabLbl.TextXAlignment         = Enum.TextXAlignment.Left
		TabLbl.TextYAlignment         = Enum.TextYAlignment.Center
		TabLbl.ZIndex                 = 15
		TabLbl.Parent                 = TabBtn

		local TabFrame = Instance.new("Frame")
		TabFrame.Name                = "Tab_" .. Idx
		TabFrame.BackgroundTransparency = 1
		TabFrame.Size                = UDim2.new(1, 0, 1, 0)
		TabFrame.Visible             = false
		TabFrame.ZIndex              = 11
		TabFrame.Parent              = ContentArea

		local ColPad = 8
		local ColGap = 6
		local ColTop = 12
		local ColBot = 14

		local LeftScroll = Instance.new("ScrollingFrame")
		LeftScroll.BackgroundTransparency = 1
		LeftScroll.BorderSizePixel        = 0
		LeftScroll.Size                   = UDim2.new(.5, -ColGap / 2 - ColPad, 1, 0)
		LeftScroll.Position               = UDim2.new(0, ColPad, 0, 0)
		LeftScroll.CanvasSize             = UDim2.new(0, 0, 0, 0)
		LeftScroll.ScrollBarThickness     = 0
		LeftScroll.ScrollingDirection     = Enum.ScrollingDirection.Y
		LeftScroll.ZIndex                 = 11
		LeftScroll.Parent                 = TabFrame

		local RightScroll = Instance.new("ScrollingFrame")
		RightScroll.BackgroundTransparency = 1
		RightScroll.BorderSizePixel        = 0
		RightScroll.Size                   = UDim2.new(.5, -ColGap / 2 - ColPad, 1, 0)
		RightScroll.Position               = UDim2.new(.5, ColGap / 2, 0, 0)
		RightScroll.CanvasSize             = UDim2.new(0, 0, 0, 0)
		RightScroll.ScrollBarThickness     = 0
		RightScroll.ScrollingDirection     = Enum.ScrollingDirection.Y
		RightScroll.ZIndex                 = 11
		RightScroll.Parent                 = TabFrame

		local function MakeColumnInner(ScrollFrame)
			local Inner = Instance.new("Frame")
			Inner.BackgroundTransparency = 1
			Inner.Size                   = UDim2.new(1, 0, 0, 0)
			Inner.AutomaticSize          = Enum.AutomaticSize.Y
			Inner.ZIndex                 = 12
			Inner.Parent                 = ScrollFrame
			local Layout = Instance.new("UIListLayout")
			Layout.FillDirection = Enum.FillDirection.Vertical
			Layout.SortOrder     = Enum.SortOrder.LayoutOrder
			Layout.Padding       = UDim.new(0, 0)
			Layout.Parent        = Inner
			ApplyPadding(Inner, ColTop, 0, ColBot, 0)
			Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + ColTop + ColBot)
			end)
			return Inner
		end

		local LeftInner  = MakeColumnInner(LeftScroll)
		local RightInner = MakeColumnInner(RightScroll)

		local TabData = {Btn = TabBtn, Content = TabFrame, Label = TabLbl, Icon = nil, Pill = Pill, PillColor = PillBG}
		table.insert(Tabs, TabData)

		local function ActivateThis()
			DeactivateAllTabs()
			TabFadeOverlay.BackgroundTransparency = .55
			TabFadeOverlay.ZIndex                 = 50
			TweenService:Create(TabFadeOverlay, TweenInfo.new(.48, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{BackgroundTransparency = 1}):Play()
			TabFrame.Visible  = true
			TabFrame.Position = UDim2.new(.05, 0, 0, 0)
			TweenService:Create(TabFrame, TweenInfo.new(.40, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{Position = UDim2.new(0, 0, 0, 0)}):Play()
			TweenService:Create(TabLbl, TweenInfo.new(.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{TextColor3 = T.TabActive}):Play()
			PillBG.BackgroundTransparency = 1
			TweenService:Create(PillBG, TweenInfo.new(.30, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
				{BackgroundTransparency = 0}):Play()
			Pill.BackgroundTransparency = 1
			Pill.Size                   = UDim2.new(0, 3, 0, 8)
			TweenService:Create(Pill, TweenInfo.new(.56, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
				{BackgroundTransparency = 0, Size = UDim2.new(0, 3, 0, 18)}):Play()
		end

		TabBtn.MouseButton1Click:Connect(ActivateThis)
		TabBtn.MouseButton1Down:Connect(function()  Tween(PillBG, {BackgroundTransparency = .5}, .08) end)
		TabBtn.MouseButton1Up:Connect(function()
			if TabFrame.Visible then
				Tween(PillBG, {BackgroundTransparency = 0}, .18)
			else
				Tween(PillBG, {BackgroundTransparency = 1}, .18)
			end
		end)
		if Idx == 1 then ActivateThis() end

		local TabObj    = {}
		local SectionCount = 0

		function TabObj:CreateSection(SectionConfig)
			SectionConfig = SectionConfig or {}
			local SectionTitle = SectionConfig.Title or "Section"
			local SectionPos   = (SectionConfig.Position or "left"):lower()
			SectionCount       = SectionCount + 1
			local SectionOrder = SectionCount
			local ParentCol    = SectionPos == "right" and RightInner or LeftInner

			local SectionWrapper = Instance.new("Frame")
			SectionWrapper.BackgroundTransparency = 1
			SectionWrapper.Size                   = UDim2.new(1, 0, 0, 0)
			SectionWrapper.AutomaticSize          = Enum.AutomaticSize.Y
			SectionWrapper.LayoutOrder            = SectionOrder
			SectionWrapper.ZIndex                 = 13
			SectionWrapper.Parent                 = ParentCol

			local SectionWrapperLayout = Instance.new("UIListLayout")
			SectionWrapperLayout.FillDirection = Enum.FillDirection.Vertical
			SectionWrapperLayout.SortOrder     = Enum.SortOrder.LayoutOrder
			SectionWrapperLayout.Padding       = UDim.new(0, 0)
			SectionWrapperLayout.Parent        = SectionWrapper

			local TopSpacer = Instance.new("Frame")
			TopSpacer.BackgroundTransparency = 1
			TopSpacer.Size                   = UDim2.new(1, 0, 0, 10)
			TopSpacer.LayoutOrder            = 0
			TopSpacer.ZIndex                 = 13
			TopSpacer.Parent                 = SectionWrapper

			local HeaderWrapper = Instance.new("Frame")
			HeaderWrapper.BackgroundTransparency = 1
			HeaderWrapper.Size                   = UDim2.new(1, 0, 0, 14)
			HeaderWrapper.LayoutOrder            = 1
			HeaderWrapper.ZIndex                 = 13
			HeaderWrapper.Parent                 = SectionWrapper
			ApplyPadding(HeaderWrapper, 0, 2, 0, 4)

			local SectionHeader = Instance.new("TextLabel")
			SectionHeader.BackgroundTransparency = 1
			SectionHeader.Size                   = UDim2.new(1, 0, 1, 0)
			SectionHeader.Text                   = SectionTitle:upper()
			SectionHeader.TextColor3             = T.SecTitle
			SectionHeader.Font                   = Enum.Font.GothamBold
			SectionHeader.TextSize               = 7
			SectionHeader.TextXAlignment         = Enum.TextXAlignment.Left
			SectionHeader.TextYAlignment         = Enum.TextYAlignment.Center
			SectionHeader.ZIndex                 = 14
			SectionHeader.Parent                 = HeaderWrapper
			Register(SectionHeader, "TextColor3", "SecTitle")

			local HeaderSpacer = Instance.new("Frame")
			HeaderSpacer.BackgroundTransparency = 1
			HeaderSpacer.Size                   = UDim2.new(1, 0, 0, 3)
			HeaderSpacer.LayoutOrder            = 2
			HeaderSpacer.ZIndex                 = 13
			HeaderSpacer.Parent                 = SectionWrapper

			local Card = Instance.new("Frame")
			Card.BackgroundColor3  = T.SectionBG
			Card.BorderSizePixel   = 0
			Card.Size              = UDim2.new(1, 0, 0, 0)
			Card.AutomaticSize     = Enum.AutomaticSize.Y
			Card.ClipsDescendants  = true
			Card.LayoutOrder       = 3
			Card.ZIndex            = 13
			Card.Parent            = SectionWrapper
			Corner(Card, 8)
			Register(Card, "BackgroundColor3", "SectionBG")

			local CardStroke = Stroke(Card, T.Separator, .6)
			Register(CardStroke, "Color", "Separator")

			local CardEntryScale = Instance.new("UIScale")
			CardEntryScale.Scale  = .84
			CardEntryScale.Parent = Card
			Card.BackgroundTransparency = 1

			local StaggerDelay = (SectionCount - 1) * .07
			task.delay(StaggerDelay, function()
				TweenService:Create(Card, TweenInfo.new(.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0}):Play()
				TweenService:Create(CardEntryScale, TweenInfo.new(.64, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
					{Scale = 1}):Play()
			end)

			local CardLayout = Instance.new("UIListLayout")
			CardLayout.FillDirection = Enum.FillDirection.Vertical
			CardLayout.SortOrder     = Enum.SortOrder.LayoutOrder
			CardLayout.Padding       = UDim.new(0, 0)
			CardLayout.Parent        = Card

			local BottomSpacer = Instance.new("Frame")
			BottomSpacer.BackgroundTransparency = 1
			BottomSpacer.Size                   = UDim2.new(1, 0, 0, 8)
			BottomSpacer.LayoutOrder            = 4
			BottomSpacer.ZIndex                 = 13
			BottomSpacer.Parent                 = SectionWrapper

			local SecObj      = {}
			SecObj._Card      = Card
			SecObj._RowNumber = 0

			local function MakeSeparator(N)
				local SepWrapper = Instance.new("Frame")
				SepWrapper.BackgroundTransparency = 1
				SepWrapper.BorderSizePixel        = 0
				SepWrapper.Size                   = UDim2.new(1, 0, 0, 1)
				SepWrapper.ZIndex                 = 15
				SepWrapper.LayoutOrder            = N * 10 - 5
				SepWrapper.Parent                 = Card
				local Sep = Instance.new("Frame")
				Sep.BackgroundColor3 = T.Separator
				Sep.BorderSizePixel  = 0
				Sep.Size             = UDim2.new(1, -16, 1, 0)
				Sep.Position         = UDim2.new(0, 13, 0, 0)
				Sep.ZIndex           = 15
				Sep.Parent           = SepWrapper
				Register(Sep, "BackgroundColor3", "Separator")
			end

			local function MakeRow(Height, AutoY)
				SecObj._RowNumber = SecObj._RowNumber + 1
				local N           = SecObj._RowNumber
				if N > 1 then MakeSeparator(N) end
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
					Row.Size = UDim2.new(1, 0, 0, Height or 40)
				end
				ApplyPadding(Row, 0, 12, 0, 12)
				return Row
			end

			local function RowPress(Row)
				Tween(Row, {BackgroundColor3 = T.PressHL}, .06)
				Row.BackgroundTransparency = 0
			end
			local function RowRelease(Row)
				Tween(Row, {BackgroundColor3 = T.SectionBG}, .28, Enum.EasingStyle.Quint)
				task.delay(.28, function() Row.BackgroundTransparency = 1 end)
			end

			function SecObj:CreateToggle(ToggleConfig)
				ToggleConfig     = ToggleConfig or {}
				local ToggleTitle    = ToggleConfig.Title    or "Toggle"
				local ToggleDefault  = ToggleConfig.Default ~= nil and ToggleConfig.Default or false
				local ToggleCallback = ToggleConfig.Callback or function() end
				local Row            = MakeRow(32)

				local Lbl = Instance.new("TextLabel")
				Lbl.BackgroundTransparency = 1
				Lbl.AnchorPoint            = Vector2.new(0, .5)
				Lbl.Size                   = UDim2.new(1, -40, 0, 12)
				Lbl.Position               = UDim2.new(0, 0, .5, 0)
				Lbl.Text                   = ToggleTitle
				Lbl.TextColor3             = T.Text
				Lbl.Font                   = Enum.Font.Gotham
				Lbl.TextSize               = 12
				Lbl.TextXAlignment         = Enum.TextXAlignment.Left
				Lbl.TextYAlignment         = Enum.TextYAlignment.Center
				Lbl.ZIndex                 = 15
				Lbl.Parent                 = Row
				Register(Lbl, "TextColor3", "Text")

				local Track = Instance.new("Frame")
				Track.BackgroundColor3 = ToggleDefault and T.ToggleOn or T.ToggleOff
				Track.BorderSizePixel  = 0
				Track.AnchorPoint      = Vector2.new(1, .5)
				Track.Size             = UDim2.new(0, 30, 0, 18)
				Track.Position         = UDim2.new(1, 0, .5, 0)
				Track.ZIndex           = 15
				Track.Parent           = Row
				Corner(Track, 9)

				local Thumb = Instance.new("Frame")
				Thumb.BackgroundColor3 = T.White
				Thumb.BorderSizePixel  = 0
				Thumb.AnchorPoint      = Vector2.new(0, .5)
				Thumb.Size             = UDim2.new(0, 14, 0, 14)
				Thumb.Position         = ToggleDefault and UDim2.new(0, 14, .5, 0) or UDim2.new(0, 2, .5, 0)
				Thumb.ZIndex           = 16
				Thumb.Parent           = Track
				Corner(Thumb, 7)
				Register(Thumb, "BackgroundColor3", "White")

				local ThumbStroke = Stroke(Thumb, Color3.fromRGB(0, 0, 0), .5)
				ThumbStroke.Transparency = .84

				local State = ToggleDefault
				local Busy  = false

				local function SetState(Value, Animated)
					if Busy then return end
					Busy  = true
					State = Value
					local Target    = Value and UDim2.new(0, 14, .5, 0) or UDim2.new(0, 2, .5, 0)
					local TrackColor = Value and T.ToggleOn or T.ToggleOff
					if Animated then
						TweenService:Create(Track, TweenInfo.new(.26, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
							{BackgroundColor3 = TrackColor}):Play()
						TweenService:Create(Thumb, TweenInfo.new(.08, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
							{Size = UDim2.new(0, 18, 0, 14)}):Play()
						task.delay(.08, function()
							TweenService:Create(Thumb, TweenInfo.new(.52, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
								{Position = Target, Size = UDim2.new(0, 14, 0, 14)}):Play()
						end)
					else
						Track.BackgroundColor3 = TrackColor
						Thumb.Position         = Target
						Thumb.Size             = UDim2.new(0, 14, 0, 14)
					end
					task.delay(.54, function() Busy = false end)
				end

				RegisterFn(function() Tween(Track, {BackgroundColor3 = State and T.ToggleOn or T.ToggleOff}, .24) end)

				local Hit = Instance.new("TextButton")
				Hit.BackgroundTransparency = 1
				Hit.Size                   = UDim2.new(1, 0, 1, 0)
				Hit.Text                   = ""
				Hit.ZIndex                 = 17
				Hit.Parent                 = Row
				Hit.MouseButton1Click:Connect(function()   SetState(not State, true) ToggleCallback(State) end)
				Hit.MouseButton1Down:Connect(function()    RowPress(Row) end)
				Hit.MouseButton1Up:Connect(function()      RowRelease(Row) end)

				local Obj        = {}
				Obj.Value        = {Set = function(_, V) SetState(V, true) ToggleCallback(V) end}
				Obj.Name         = {Set = function(_, N) Lbl.Text = N end}
				Obj.GetValue     = function() return State end
				return Obj
			end

			function SecObj:CreateButton(ButtonConfig)
				ButtonConfig     = ButtonConfig or {}
				local ButtonTitle    = ButtonConfig.Title    or "Button"
				local ButtonCallback = ButtonConfig.Callback or function() end
				local Row            = MakeRow(30)
				local RowScale       = Instance.new("UIScale")
				RowScale.Scale  = 1
				RowScale.Parent = Row

				local Lbl = Instance.new("TextLabel")
				Lbl.BackgroundTransparency = 1
				Lbl.AnchorPoint            = Vector2.new(.5, .5)
				Lbl.Size                   = UDim2.new(1, 0, 0, 14)
				Lbl.Position               = UDim2.new(.5, 0, .5, 0)
				Lbl.Text                   = ButtonTitle
				Lbl.TextColor3             = T.Accent
				Lbl.Font                   = Enum.Font.GothamMedium
				Lbl.TextSize               = 12
				Lbl.TextXAlignment         = Enum.TextXAlignment.Center
				Lbl.TextYAlignment         = Enum.TextYAlignment.Center
				Lbl.ZIndex                 = 15
				Lbl.Parent                 = Row
				Register(Lbl, "TextColor3", "Accent")

				local Hit = Instance.new("TextButton")
				Hit.BackgroundTransparency = 1
				Hit.Size                   = UDim2.new(1, 0, 1, 0)
				Hit.Text                   = ""
				Hit.ZIndex                 = 16
				Hit.Parent                 = Row
				Hit.MouseButton1Down:Connect(function()
					RowPress(Row)
					Tween(Lbl, {TextColor3 = T.AccentDark}, .07)
					TweenLinear(RowScale, {Scale = .94}, .10)
				end)
				Hit.MouseButton1Up:Connect(function()
					RowRelease(Row)
					Tween(Lbl, {TextColor3 = T.Accent}, .24)
					TweenBack(RowScale, {Scale = 1}, .38)
				end)
				Hit.MouseButton1Click:Connect(ButtonCallback)

				local Obj  = {}
				Obj.Name   = {Set = function(_, N) Lbl.Text = N end}
				return Obj
			end

			function SecObj:CreateDropdown(DropConfig)
				DropConfig       = DropConfig or {}
				local DropTitle      = DropConfig.Title    or "Dropdown"
				local Options        = DropConfig.Options  or {}
				local InitSelected   = DropConfig.Selected or {}
				local Multi          = DropConfig.Multi    or false
				local DropCallback   = DropConfig.Callback or function() end
				local SelectedMap    = {}

				for _, V in ipairs(InitSelected) do SelectedMap[V] = true end
				if not Multi and not next(SelectedMap) and #Options > 0 then
					SelectedMap[Options[1]] = true
				end

				local function GetSelectedText()
					local Parts = {}
					for K, V in pairs(SelectedMap) do if V then Parts[#Parts + 1] = K end end
					if #Parts == 0 then return "None" end
					table.sort(Parts)
					return table.concat(Parts, ", ")
				end

				local IsOpen       = false
				local CurrentOptions = {table.unpack(Options)}
				local Row          = MakeRow(32)

				local TitleLbl = Instance.new("TextLabel")
				TitleLbl.BackgroundTransparency = 1
				TitleLbl.AnchorPoint            = Vector2.new(0, .5)
				TitleLbl.Size                   = UDim2.new(1, -76, 0, 14)
				TitleLbl.Position               = UDim2.new(0, 0, .5, 0)
				TitleLbl.Text                   = DropTitle
				TitleLbl.TextColor3             = T.Text
				TitleLbl.Font                   = Enum.Font.Gotham
				TitleLbl.TextSize               = 10
				TitleLbl.TextXAlignment         = Enum.TextXAlignment.Left
				TitleLbl.TextYAlignment         = Enum.TextYAlignment.Center
				TitleLbl.ZIndex                 = 15
				TitleLbl.Parent                 = Row
				Register(TitleLbl, "TextColor3", "Text")

				local SelectedLbl = Instance.new("TextLabel")
				SelectedLbl.BackgroundTransparency = 1
				SelectedLbl.AnchorPoint            = Vector2.new(1, .5)
				SelectedLbl.Size                   = UDim2.new(0, 54, 0, 14)
				SelectedLbl.Position               = UDim2.new(1, -16, .5, 0)
				SelectedLbl.Text                   = GetSelectedText()
				SelectedLbl.TextColor3             = T.SubText
				SelectedLbl.Font                   = Enum.Font.Gotham
				SelectedLbl.TextSize               = 11
				SelectedLbl.TextXAlignment         = Enum.TextXAlignment.Right
				SelectedLbl.TextYAlignment         = Enum.TextYAlignment.Center
				SelectedLbl.TextTruncate           = Enum.TextTruncate.AtEnd
				SelectedLbl.ZIndex                 = 15
				SelectedLbl.Parent                 = Row
				Register(SelectedLbl, "TextColor3", "SubText")

				local Chevron = Instance.new("TextLabel")
				Chevron.BackgroundTransparency = 1
				Chevron.AnchorPoint            = Vector2.new(1, .5)
				Chevron.Size                   = UDim2.new(0, 14, 0, 14)
				Chevron.Position               = UDim2.new(1, 0, .5, 0)
				Chevron.Text                   = "›"
				Chevron.TextColor3             = T.SubText
				Chevron.Font                   = Enum.Font.GothamBold
				Chevron.TextSize               = 18
				Chevron.TextXAlignment         = Enum.TextXAlignment.Center
				Chevron.TextYAlignment         = Enum.TextYAlignment.Center
				Chevron.ZIndex                 = 15
				Chevron.Parent                 = Row
				Register(Chevron, "TextColor3", "SubText")

				local Panel = Instance.new("Frame")
				Panel.BackgroundColor3  = T.SectionBG
				Panel.BorderSizePixel   = 0
				Panel.Size              = UDim2.new(1, 0, 0, 0)
				Panel.ClipsDescendants  = true
				Panel.ZIndex            = 20
				Panel.Visible           = false
				Panel.LayoutOrder       = Row.LayoutOrder + 1
				Panel.Parent            = Card
				Register(Panel, "BackgroundColor3", "SectionBG")

				local PanelScroll = Instance.new("ScrollingFrame")
				PanelScroll.BackgroundTransparency  = 1
				PanelScroll.BorderSizePixel         = 0
				PanelScroll.Size                    = UDim2.new(1, 0, 1, 0)
				PanelScroll.CanvasSize              = UDim2.new(0, 0, 0, 0)
				PanelScroll.ScrollBarThickness      = 3
				PanelScroll.ScrollBarImageColor3    = T.Accent
				PanelScroll.ScrollingDirection      = Enum.ScrollingDirection.Y
				PanelScroll.ZIndex                  = 21
				PanelScroll.Parent                  = Panel
				Register(PanelScroll, "ScrollBarImageColor3", "Accent")

				local PanelList = Instance.new("UIListLayout")
				PanelList.FillDirection = Enum.FillDirection.Vertical
				PanelList.SortOrder     = Enum.SortOrder.LayoutOrder
				PanelList.Parent        = PanelScroll

				PanelList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					PanelScroll.CanvasSize = UDim2.new(0, 0, 0, PanelList.AbsoluteContentSize.Y)
				end)

				local OptionButtons = {}
				local PanelHeight   = 0

				local function RebuildOptions(NewOptions)
					for _, Btn in ipairs(OptionButtons) do Btn:Destroy() end
					OptionButtons = {}

					for I, Opt in ipairs(NewOptions) do
						if I > 1 then
							local SepWrapper = Instance.new("Frame")
							SepWrapper.BackgroundTransparency = 1
							SepWrapper.BorderSizePixel        = 0
							SepWrapper.Size                   = UDim2.new(1, 0, 0, 1)
							SepWrapper.ZIndex                 = 22
							SepWrapper.LayoutOrder            = I * 10 - 5
							SepWrapper.Parent                 = PanelScroll
							table.insert(OptionButtons, SepWrapper)
							local SepLine = Instance.new("Frame")
							SepLine.BackgroundColor3 = T.Separator
							SepLine.BorderSizePixel  = 0
							SepLine.Size             = UDim2.new(1, -13, 1, 0)
							SepLine.Position         = UDim2.new(0, 13, 0, 0)
							SepLine.ZIndex           = 22
							SepLine.Parent           = SepWrapper
							Register(SepLine, "BackgroundColor3", "Separator")
						end

						local OptBtn = Instance.new("TextButton")
						OptBtn.BackgroundTransparency = 1
						OptBtn.Size                   = UDim2.new(1, 0, 0, 30)
						OptBtn.Text                   = ""
						OptBtn.ZIndex                 = 22
						OptBtn.LayoutOrder            = I * 10
						OptBtn.Parent                 = PanelScroll
						table.insert(OptionButtons, OptBtn)
						ApplyPadding(OptBtn, 0, 12, 0, 12)

						local OptScale = Instance.new("UIScale")
						OptScale.Scale  = 1
						OptScale.Parent = OptBtn

						local OptLabel = Instance.new("TextLabel")
						OptLabel.Name                   = "OptionLabel"
						OptLabel.BackgroundTransparency = 1
						OptLabel.AnchorPoint            = Vector2.new(0, .5)
						OptLabel.Size                   = UDim2.new(1, -22, 0, 14)
						OptLabel.Position               = UDim2.new(0, 0, .5, 0)
						OptLabel.Text                   = Opt
						OptLabel.TextColor3             = T.Text
						OptLabel.Font                   = Enum.Font.Gotham
						OptLabel.TextSize               = 12
						OptLabel.TextXAlignment         = Enum.TextXAlignment.Left
						OptLabel.TextYAlignment         = Enum.TextYAlignment.Center
						OptLabel.ZIndex                 = 23
						OptLabel.Parent                 = OptBtn
						Register(OptLabel, "TextColor3", "Text")

						local Checkmark = Instance.new("TextLabel")
						Checkmark.Name                   = "Checkmark"
						Checkmark.BackgroundTransparency = 1
						Checkmark.AnchorPoint            = Vector2.new(1, .5)
						Checkmark.Size                   = UDim2.new(0, 18, 0, 14)
						Checkmark.Position               = UDim2.new(1, 0, .5, 0)
						Checkmark.Text                   = SelectedMap[Opt] and "✓" or ""
						Checkmark.TextColor3             = T.Accent
						Checkmark.Font                   = Enum.Font.GothamBold
						Checkmark.TextSize               = 12
						Checkmark.TextXAlignment         = Enum.TextXAlignment.Center
						Checkmark.TextYAlignment         = Enum.TextYAlignment.Center
						Checkmark.ZIndex                 = 23
						Checkmark.Parent                 = OptBtn
						Register(Checkmark, "TextColor3", "Accent")

						OptBtn.BackgroundTransparency = 1
						OptLabel.TextTransparency     = 1
						OptLabel.Position             = UDim2.new(.06, 0, .5, 0)
						local EntryDelay = (I - 1) * .04
						task.delay(EntryDelay, function()
							if not OptBtn.Parent then return end
							TweenService:Create(OptLabel, TweenInfo.new(.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
								{TextTransparency = 0, Position = UDim2.new(0, 0, .5, 0)}):Play()
						end)

						OptBtn.MouseButton1Down:Connect(function()
							TweenLinear(OptBtn, {BackgroundColor3 = T.PressHL}, .06)
							OptBtn.BackgroundTransparency = 0
							TweenLinear(OptScale, {Scale = .96}, .07)
						end)
						OptBtn.MouseButton1Up:Connect(function()
							Tween(OptBtn, {BackgroundColor3 = T.SectionBG}, .26)
							task.delay(.26, function() OptBtn.BackgroundTransparency = 1 end)
							TweenBack(OptScale, {Scale = 1}, .34)
						end)
						OptBtn.MouseButton1Click:Connect(function()
							if Multi then
								SelectedMap[Opt] = not SelectedMap[Opt]
								Checkmark.Text   = SelectedMap[Opt] and "✓" or ""
							else
								for _, O2 in ipairs(NewOptions) do SelectedMap[O2] = false end
								SelectedMap[Opt] = true
								for _, B2 in ipairs(OptionButtons) do
									if B2:IsA("TextButton") then
										local Ck = B2:FindFirstChild("Checkmark")
										local Ol = B2:FindFirstChild("OptionLabel")
										if Ck and Ol then Ck.Text = SelectedMap[Ol.Text] and "✓" or "" end
									end
								end
							end
							SelectedLbl.Text = GetSelectedText()
							local Result = {}
							for K, V in pairs(SelectedMap) do if V then Result[#Result + 1] = K end end
							DropCallback(Result)
							if not Multi then
								IsOpen = false
								Tween(Panel, {Size = UDim2.new(1, 0, 0, 0)}, .24, Enum.EasingStyle.Quint)
								task.delay(.25, function() Panel.Visible = false end)
								TweenBack(Chevron, {Rotation = 0}, .30)
							end
						end)
					end

					local ItemH    = #NewOptions * 30 + (#NewOptions > 1 and (#NewOptions - 1) or 0)
					PanelHeight    = math.min(ItemH, 150)
					return PanelHeight
				end

				RebuildOptions(CurrentOptions)

				local Hit = Instance.new("TextButton")
				Hit.BackgroundTransparency = 1
				Hit.Size                   = UDim2.new(1, 0, 1, 0)
				Hit.Text                   = ""
				Hit.ZIndex                 = 16
				Hit.Parent                 = Row
				Hit.MouseButton1Down:Connect(function() RowPress(Row) end)
				Hit.MouseButton1Up:Connect(function()   RowRelease(Row) end)
				Hit.MouseButton1Click:Connect(function()
					IsOpen = not IsOpen
					if IsOpen then
						Panel.Visible = true
						Panel.Size    = UDim2.new(1, 0, 0, 0)
						Tween(Panel, {Size = UDim2.new(1, 0, 0, PanelHeight)}, .38, Enum.EasingStyle.Quint)
						TweenBack(Chevron, {Rotation = 90}, .34)
					else
						Tween(Panel, {Size = UDim2.new(1, 0, 0, 0)}, .24, Enum.EasingStyle.Quint)
						task.delay(.25, function() Panel.Visible = false end)
						TweenBack(Chevron, {Rotation = 0}, .30)
					end
				end)

				local Obj    = {}
				Obj.Name     = {Set = function(_, N) TitleLbl.Text = N end}
				Obj.Options  = {Set = function(_, NewOpts)
					CurrentOptions = NewOpts
					SelectedMap    = {}
					if not Multi and #NewOpts > 0 then SelectedMap[NewOpts[1]] = true end
					RebuildOptions(NewOpts)
					SelectedLbl.Text = GetSelectedText()
				end}
				Obj.Value    = {Set = function(_, V)
					SelectedMap = {}
					if type(V) == "table" then
						for _, S in ipairs(V) do SelectedMap[S] = true end
					elseif type(V) == "string" then
						SelectedMap[V] = true
					end
					SelectedLbl.Text = GetSelectedText()
					RebuildOptions(CurrentOptions)
				end}
				return Obj
			end

			function SecObj:CreateSlider(SliderConfig)
				SliderConfig     = SliderConfig or {}
				local SliderTitle    = SliderConfig.Title     or "Slider"
				local Range          = SliderConfig.Range     or {0, 100}
				local Min            = Range[1] or 0
				local Max            = Range[2] or 100
				local Default        = math.clamp(SliderConfig.Default or Min, Min, Max)
				local Increment      = SliderConfig.Increment or 1
				local Suffix         = SliderConfig.Suffix    or ""
				local SliderCallback = SliderConfig.Callback  or function() end
				local Current        = Default
				local Row            = MakeRow(43)

				local TitleLbl = Instance.new("TextLabel")
				TitleLbl.BackgroundTransparency = 1
				TitleLbl.AnchorPoint            = Vector2.new(0, 0)
				TitleLbl.Size                   = UDim2.new(.6, 0, 0, 16)
				TitleLbl.Position               = UDim2.new(0, 0, 0, 8)
				TitleLbl.Text                   = SliderTitle
				TitleLbl.TextColor3             = T.Text
				TitleLbl.Font                   = Enum.Font.Gotham
				TitleLbl.TextSize               = 12
				TitleLbl.TextXAlignment         = Enum.TextXAlignment.Left
				TitleLbl.TextYAlignment         = Enum.TextYAlignment.Center
				TitleLbl.ZIndex                 = 15
				TitleLbl.Parent                 = Row
				Register(TitleLbl, "TextColor3", "Text")

				local ValueLbl = Instance.new("TextLabel")
				ValueLbl.BackgroundTransparency = 1
				ValueLbl.AnchorPoint            = Vector2.new(1, 0)
				ValueLbl.Size                   = UDim2.new(.4, 0, 0, 16)
				ValueLbl.Position               = UDim2.new(1, 0, 0, 8)
				ValueLbl.Text                   = tostring(Current) .. Suffix
				ValueLbl.TextColor3             = T.Accent
				ValueLbl.Font                   = Enum.Font.GothamMedium
				ValueLbl.TextSize               = 10
				ValueLbl.TextXAlignment         = Enum.TextXAlignment.Right
				ValueLbl.TextYAlignment         = Enum.TextYAlignment.Center
				ValueLbl.ZIndex                 = 15
				ValueLbl.Parent                 = Row
				Register(ValueLbl, "TextColor3", "Accent")

				local TrackBG = Instance.new("Frame")
				TrackBG.BackgroundColor3 = T.SliderTrack
				TrackBG.BorderSizePixel  = 0
				TrackBG.AnchorPoint      = Vector2.new(0, 1)
				TrackBG.Size             = UDim2.new(1, 0, 0, 3)
				TrackBG.Position         = UDim2.new(0, 0, 1, -10)
				TrackBG.ZIndex           = 15
				TrackBG.Parent           = Row
				Corner(TrackBG, 2)
				Register(TrackBG, "BackgroundColor3", "SliderTrack")

				local InitPct  = (Current - Min) / math.max(Max - Min, .0001)

				local TrackFill = Instance.new("Frame")
				TrackFill.BackgroundColor3 = T.SliderFill
				TrackFill.BorderSizePixel  = 0
				TrackFill.Size             = UDim2.new(InitPct, 0, 1, 0)
				TrackFill.ZIndex           = 16
				TrackFill.Parent           = TrackBG
				Corner(TrackFill, 2)
				Register(TrackFill, "BackgroundColor3", "SliderFill")

				local TrackGrad = Instance.new("UIGradient")
				TrackGrad.Color        = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 255)),
				}
				TrackGrad.Transparency = NumberSequence.new{
					NumberSequenceKeypoint.new(0, .3),
					NumberSequenceKeypoint.new(1, 0),
				}
				TrackGrad.Parent = TrackFill

				local ThumbScale = Instance.new("UIScale")
				local Thumb      = Instance.new("Frame")
				Thumb.BackgroundColor3 = T.White
				Thumb.BorderSizePixel  = 0
				Thumb.AnchorPoint      = Vector2.new(.5, .5)
				Thumb.Size             = UDim2.new(0, 12, 0, 12)
				Thumb.Position         = UDim2.new(InitPct, 0, .5, 0)
				Thumb.ZIndex           = 17
				Thumb.Parent           = TrackBG
				Corner(Thumb, 6)
				Register(Thumb, "BackgroundColor3", "White")

				ThumbScale.Scale  = 1
				ThumbScale.Parent = Thumb

				local ThumbStroke = Stroke(Thumb, T.Accent, 1.5)
				Register(ThumbStroke, "Color", "Accent")

				local Sliding = false

				local function CalculateValue(Position)
					local Ab  = TrackBG.AbsolutePosition
					local Sz  = TrackBG.AbsoluteSize
					local Pct = math.clamp((Position.X - Ab.X) / Sz.X, 0, 1)
					return math.clamp(math.round((Min + Pct * (Max - Min)) / Increment) * Increment, Min, Max)
				end

				local function ApplyValue(Value, Animated)
					Current    = Value
					local Pct  = (Value - Min) / math.max(Max - Min, .0001)
					if Animated then
						Tween(TrackFill, {Size = UDim2.new(Pct, 0, 1, 0)}, .14)
						Tween(Thumb,     {Position = UDim2.new(Pct, 0, .5, 0)}, .14)
					else
						TrackFill.Size    = UDim2.new(Pct, 0, 1, 0)
						Thumb.Position    = UDim2.new(Pct, 0, .5, 0)
					end
					ValueLbl.Text = tostring(Value) .. Suffix
				end

				local Hit = Instance.new("TextButton")
				Hit.BackgroundTransparency = 1
				Hit.Size                   = UDim2.new(1, 0, 1, 0)
				Hit.Text                   = ""
				Hit.ZIndex                 = 18
				Hit.Parent                 = Row

				Hit.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Sliding    = true
						local Val  = CalculateValue(Input.Position)
						ApplyValue(Val, false)
						SliderCallback(Val)
						TweenBack(ThumbScale, {Scale = 1.32}, .28)
					end
				end)
				UserInputService.InputChanged:Connect(function(Input)
					if not Sliding then return end
					if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then return end
					local Val = CalculateValue(Input.Position)
					ApplyValue(Val, false)
					SliderCallback(Val)
				end)
				UserInputService.InputEnded:Connect(function(Input)
					if not Sliding then return end
					if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
						Sliding = false
						TweenBack(ThumbScale, {Scale = 1}, .36)
					end
				end)

				local Obj    = {}
				Obj.Value    = {Set = function(_, V) ApplyValue(math.clamp(V, Min, Max), true) SliderCallback(Current) end}
				Obj.Name     = {Set = function(_, N) TitleLbl.Text = N end}
				return Obj
			end

			function SecObj:CreateLabel(Content)
				Content    = Content or ""
				local Row  = MakeRow(26)
				local Lbl  = Instance.new("TextLabel")
				Lbl.BackgroundTransparency = 1
				Lbl.AnchorPoint            = Vector2.new(0, .5)
				Lbl.Size                   = UDim2.new(1, 0, 0, 12)
				Lbl.Position               = UDim2.new(0, 0, .5, 0)
				Lbl.Text                   = Content
				Lbl.TextColor3             = T.SubText
				Lbl.Font                   = Enum.Font.Gotham
				Lbl.TextSize               = 11
				Lbl.TextXAlignment         = Enum.TextXAlignment.Left
				Lbl.TextYAlignment         = Enum.TextYAlignment.Center
				Lbl.ZIndex                 = 15
				Lbl.Parent                 = Row
				Register(Lbl, "TextColor3", "SubText")
				local Obj    = {}
				Obj.Value    = {Set = function(_, V) Lbl.Text = V end}
				return Obj
			end

			function SecObj:CreateParagraph(ParagraphConfig)
				ParagraphConfig   = ParagraphConfig or {}
				local ParaTitle   = ParagraphConfig.Title   or ""
				local ParaContent = ParagraphConfig.Content or ""
				SecObj._RowNumber = SecObj._RowNumber + 1
				local N           = SecObj._RowNumber
				if N > 1 then MakeSeparator(N) end

				local Container = Instance.new("Frame")
				Container.BackgroundTransparency = 1
				Container.Size                   = UDim2.new(1, 0, 0, 0)
				Container.AutomaticSize          = Enum.AutomaticSize.Y
				Container.ZIndex                 = 14
				Container.LayoutOrder            = N * 10
				Container.Parent                 = Card
				ApplyPadding(Container, 8, 12, 8, 12)

				local ContainerLayout = Instance.new("UIListLayout")
				ContainerLayout.FillDirection = Enum.FillDirection.Vertical
				ContainerLayout.SortOrder     = Enum.SortOrder.LayoutOrder
				ContainerLayout.Padding       = UDim.new(0, 4)
				ContainerLayout.Parent        = Container

				local TitleLbl = nil
				if ParaTitle ~= "" then
					TitleLbl = Instance.new("TextLabel")
					TitleLbl.BackgroundTransparency = 1
					TitleLbl.Size                   = UDim2.new(1, 0, 0, 0)
					TitleLbl.AutomaticSize          = Enum.AutomaticSize.Y
					TitleLbl.Text                   = ParaTitle
					TitleLbl.TextColor3             = T.Text
					TitleLbl.Font                   = Enum.Font.GothamMedium
					TitleLbl.TextSize               = 12
					TitleLbl.TextWrapped            = true
					TitleLbl.TextXAlignment         = Enum.TextXAlignment.Left
					TitleLbl.LayoutOrder            = 1
					TitleLbl.ZIndex                 = 15
					TitleLbl.Parent                 = Container
					Register(TitleLbl, "TextColor3", "Text")
				end

				local ContentLbl = Instance.new("TextLabel")
				ContentLbl.BackgroundTransparency = 1
				ContentLbl.Size                   = UDim2.new(1, 0, 0, 0)
				ContentLbl.AutomaticSize          = Enum.AutomaticSize.Y
				ContentLbl.Text                   = ParaContent
				ContentLbl.TextColor3             = T.SubText
				ContentLbl.Font                   = Enum.Font.Gotham
				ContentLbl.TextSize               = 9
				ContentLbl.TextWrapped            = true
				ContentLbl.TextXAlignment         = Enum.TextXAlignment.Left
				ContentLbl.LayoutOrder            = 2
				ContentLbl.ZIndex                 = 15
				ContentLbl.Parent                 = Container
				Register(ContentLbl, "TextColor3", "SubText")

				local Obj      = {}
				Obj.Title      = {Set = function(_, V) if TitleLbl then TitleLbl.Text = V end end}
				Obj.Content    = {Set = function(_, V) ContentLbl.Text = V end}
				return Obj
			end

			return SecObj
		end
		return TabObj
	end
	return WindowObj
end

return Library

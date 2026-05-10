# 🧬 Murysium Legacy

A lightweight Lua UI library for Roblox designed for creating modular interfaces (windows, tabs, sections, and UI components like buttons, toggles, dropdowns, sliders, and more).

---

# 📦 Installation

Initialize the library:

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/MuryScript/Murysium-Legacy/refs/heads/main/Library.lua"
))()
```

---

# 🪟 Window

Creates the main UI container.

```lua
local Window = Library:CreateWindow({
    Title           = "Window Title",
    SubTitle        = "by Mury",
    LoadingTitle    = "Murysium Legacy",
    LoadingSubtitle = "Initializing...",
    ShowText        = "Open",
    Theme           = "Dark"
})
```

---

# 📑 Tab

Creates a category inside the window.

```lua
local TabVar = Window:CreateTab({
    Title = "Main",
    Logo  = "rbxassetid://123456789"
})
```

---

# 📂 Section

Organizes elements inside a tab.

```lua
local SecVar = TabVar:CreateSection({
    Title = "Main Controls",
    Position = "left"
})
```

---

# 📜 Paragraph

Displays static text.

```lua
SecVar:CreateParagraph({
    Title = "Info",
    Content = "This is a paragraph."
})
```

---

# 🔘 Button

Executes a function when clicked.

```lua
local ButtonVar = SecVar:CreateButton({
    Title = "Click Me",
    Callback = function()
        print("Button clicked")
    end
})
```

---

# 🔁 Toggle

Boolean switch (true / false).

```lua
local ToggleVar = SecVar:CreateToggle({
    Title = "Enable Feature",
    Default = false,
    Callback = function(Value)
        print("Toggle:", Value)
    end
})
```

---

# 📋 Dropdown

Selectable list of options.

```lua
local DropdownVar = SecVar:CreateDropdown({
    Title = "Mode",
    Options = {"Legit", "Rage", "Blatant"},
    Selected = {"Legit"},
    Multi = false,
    Callback = function(Option)
        print("Selected:", Option)
    end
})
```

---

### Refresh options

```lua
DropdownVar.Options:Set({
    "Option1",
    "Option2",
    "Option3"
})
```

---

# 🎚 Slider

Numeric value selector.

```lua
SecVar:CreateSlider({
    Title = "Speed",
    Range = {16, 200},
    Increment = 1,
    Default = 16,
    Suffix = "studs",
    Callback = function(Value)
        print("Value:", Value)
    end
})
```

---

# 🧠 Structure

Library
 └── Window
      └── Tabs
           └── Sections
                ├── Paragraph
                ├── Button
                ├── Toggle
                ├── Dropdown
                └── Slider

---

# ⚠️ Notes

- All UI elements must be created inside a Section  
- Callbacks run on user interaction  
- Dropdowns and sliders update dynamically  
- Theme affects global appearance  

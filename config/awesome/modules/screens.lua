-- modules/screens.lua
-- Screen configuration for AwesomeWM

local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local variables = require("modules.variables")

local screens = {}

-- Rest of your screens.lua file...

-- Add this function to both screens.lua and wibar.lua
local function get_screen_role(s)
    -- Method 1: By position (leftmost screen is primary)
    local leftmost_x = math.huge
    for screen_obj in screen do
        if screen_obj.geometry.x < leftmost_x then
            leftmost_x = screen_obj.geometry.x
        end
    end
    
    if s.geometry.x == leftmost_x then
        return "primary"
    else
        return "secondary"
    end
end    

-- Add this to the top of both files
local function is_primary_screen(s)
    -- Try multiple methods to reliably identify the primary screen
    if s == screen.primary then
        return true
    end
    
    -- Fallback: identify by position (leftmost screen)
    local leftmost = s
    for screen_obj in screen do
        if screen_obj.geometry.x < leftmost.geometry.x then
            leftmost = screen_obj
        end
    end
    return s == leftmost
end

-- Function to set wallpaper
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then -- check to see that path to wallpaper is valid
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Function to set up each screen
local function setup_screen(s)

    -- Set wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table
    -- awful.tag(variables.tags, s, variables.default_layout)

    -- Add screen-specific widgets or configurations here
    -- For example, you might want different layouts on different screens
    -- or specific widgets only on certain screens

    -- Primary screen gets tags 1-5
--    if s.index == 1 then
    if get_screen_role(s) == "primary" then
        local primary_tags = {variables.tags[1], variables.tags[2], variables.tags[3], 
                             variables.tags[4], variables.tags[5]}
        local primary_layouts = {variables.default_layout, variables.default_layout, 
                                 variables.default_layout, awful.layout.suit.max, 
                                 awful.layout.suit.magnifier}
        awful.tag(primary_tags, s, primary_layouts)
        
    -- Secondary screen - first non-primary screen
    else
        local secondary_tags = {variables.tags[6], variables.tags[7], variables.tags[8], 
                               variables.tags[9], variables.tags[10]}
        local secondary_layouts = {awful.layout.suit.max, variables.default_layout, 
                                   variables.default_layout, awful.layout.suit.max, 
                                   awful.layout.suit.magnifier}
        awful.tag(secondary_tags, s, secondary_layouts)
    end
end

-- Define a function to navigate to a specific screen and tag
local function focus_screen_tag(screen_index, tag_index)
    local screen = screen[screen_index]
    if screen then
        -- For the secondary screen, adjust tag_index based on your setup
        -- If secondary screen tags start at 6, we need to adjust the index
        local actual_tag_index = tag_index
        if screen_index == 2 then  -- Assuming secondary is screen 2
            actual_tag_index = tag_index - 5  -- Convert tag 6 to index 1, tag 7 to index 2, etc.
        end
        
        local tag = screen.tags[actual_tag_index]
        if tag then
            tag:view_only()
            awful.screen.focus(screen)
        end
    end
end

-- Initialize screens
function screens.init()
    -- Add a small delay to ensure screens are properly detected
    gears.timer.start_new(0.1, function()
        awful.screen.connect_for_each_screen(setup_screen)
        return false
    end)
    
    -- Re-set wallpaper when a screen's geometry changes
    screen.connect_signal("property::geometry", set_wallpaper)
    
    -- Remove the problematic auto-restart code entirely
end

return screens

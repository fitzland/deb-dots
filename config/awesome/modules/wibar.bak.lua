-- modules/wibar.lua

-- Load required libraries
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widgets = require("modules.widgets")
local gears = require("gears") -- ensure gears is available

-- Create wibar table
local wibar = {}

-- Wibar configuration
local config = {
    position = "top",
    height = 30,
    opacity = 0.9,
}

-- Setup wibar for each screen
local function setup_wibar(s)
    -- Create taglist for this screen
    local taglist = widgets.create_taglist(s)
    
    -- Create layoutbox for this screen
    local layoutbox = widgets.create_layoutbox(s)
    
    -- Create a separator widget
    local separator = wibox.widget {
        markup = '<span color="' .. beautiful.bg_minimize .. '">|</span>',
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }
    
    -- Calculate the background color with opacity
    -- Use the base color from the theme or a fallback color
    local base_color = beautiful.bg_normal or "#000000" -- fallback
    local alpha_hex = string.format("%02x", math.floor((config.opacity or 1.0) * 255))

    -- Create the wibar
    s.mywibar = awful.wibar({
        position = config.position,
        screen = s,
        height = config.height,
        bg = base_color .. alpha_hex,
        -- bg = wibar_bg_color,
    })

    -- Construct a list of right widgets
    local right_widgets = {
        layout = wibox.layout.fixed.horizontal, -- Align widgets to the right 
        spacing = 6,
        -- widgets will be added here
    }
    
    -- Add systray (always present for all screens)
    table.insert(right_widgets, {
        widgets.systray,
        top = 2,    -- Add top margin for vertical centering
        bottom = 2, -- Add bottom margin for vertical centering
        left = 8,   -- Add left padding
        right = 8,  -- Add right padding
        widget = wibox.container.margin
    })

    -- Condtionally add widgets based on screen
    if s.index == 1 then
        -- Add widgets for the first screen
        if widget.volume_widget then table.insert(right_widgets, widgets.volume_widget) end
        if widget.clock_widget then table.insert(right_widgets, widgets.clock_widget) end
        -- Add more widgets as needed
    else
        -- Add widgets for the second screen
        if widget.cpu_widget then table.insert(right_widgets, widgets.cpu_widget) end
        if widget.mem_widget then table.insert(right_widgets, widgets.mem_widget) end
        -- Add more widgets as needed
    end

    -- Add widgets to the wibar
    s.mywibar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 6,
            layoutbox,
            separator,
            taglist,
        },
        { -- Middle widget
            layout = wibox.layout.align.horizontal,
            expand = "none",  -- This makes the nil widgets expand
            nil,  -- Left expanding spacer
            widgets.window_title,
            nil,  -- Right expanding spacer
        },
        -- right_widgets already contains its own layout 
        -- so we pass the table we built:
        right_widgets,
    }
end

-- Initialize wibars
function wibar.init()
    -- Setup wibar for each screen
    awful.screen.connect_for_each_screen(function(s)
        setup_wibar(s)
    end)
    
    -- Handle screen changes (connecting/disconnecting monitors)
    screen.connect_signal("property::geometry", function(s)
        -- Recreate wibar when screen geometry changes
        if s.mywibar then
            s.mywibar:remove()
        end
        setup_wibar(s)
    end)
end

return wibar

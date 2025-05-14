-- modules/wibar.lua

-- Load required libraries
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widgets = require("modules.widgets")

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
    
    -- Create the wibar
    s.mywibar = awful.wibar({
        position = config.position,
        screen = s,
        height = config.height,
        bg = beautiful.bg_normal .. string.format("%x", math.floor(config.opacity * 255)),
    })
    
    -- Construct a list of right widgets
    local right_widgets = {
        layout = wibox.layout.fixed.horizontal, -- Align widgets to the right 
        spacing = 6,
        -- widgets will be added here
    }
    
    -- Conditionally add widgets based on screen
    if s.index == 1 then
        -- Add volume_widget to screen 1
        if widgets.volume_widget then table.insert(right_widgets, widgets.volume_widget) end
        -- Add clock_widget to screen 1
        if widgets.clock_widget then table.insert(right_widgets, widgets.clock_widget) end
        -- Add systray to screen 1
        if widgets.systray then table.insert(right_widgets, {
                widgets.systray,
                top = 2, bottom = 2, left = 8, right = 8,
                widget = wibox.container.margin
            })
        end

    else -- s.index == 2 (or more)
        -- Add CPU and memory widgets to screen 2
        if widgets.cpu_widget then table.insert(right_widgets, widgets.cpu_widget) end
        if widgets.mem_widget then table.insert(right_widgets, widgets.mem_widget) end
        -- Add clock_widget to screen 2
        if widgets.clock_widget then
            table.insert(right_widgets, widgets.clock_widget)
        end
    end

    -- Add widgets to the wibar
    s.mywibar:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            mylauncher,
            layout = wibox.layout.fixed.horizontal,
            spacing = 4,
            layoutbox,
            separator,
            taglist,
        },
        { -- Middle widget
            layout = wibox.layout.align.horizontal,
            expand = "none",
            nil,
            widgets.window_title,
            nil,
        },
        right_widgets, -- Right widgets
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

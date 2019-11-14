--[[
--MIT License
--
--Copyright (c) 2019 PapyElGringo
--Copyright (c) 2019 Tom Meyers
--
--Permission is hereby granted, free of charge, to any person obtaining a copy
--of this software and associated documentation files (the "Software"), to deal
--in the Software without restriction, including without limitation the rights
--to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
--copies of the Software, and to permit persons to whom the Software is
--furnished to do so, subject to the following conditions:
--
--The above copyright notice and this permission notice shall be included in all
--copies or substantial portions of the Software.
--
--THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
--IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
--FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
--AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
--LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
--OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
--SOFTWARE.
]]

-------------------------------------------------
-- Battery Widget for Awesome Window Manager
-- Shows the battery status using the ACPI tool
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/battery-widget

-- @author Pavel Makhov
-- @copyright 2017 Pavel Makhov
-------------------------------------------------

local awful = require('awful')
local naughty = require('naughty')
local watch = require('awful.widget.watch')
local wibox = require('wibox')
local clickable_container = require('widget.material.clickable-container')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi

-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = '/etc/xdg/awesome/widget/package-updater/icons/'
local updateAvailable = false
local numOfUpdatesAvailable

local widget =
  wibox.widget {
  {
    id = 'icon',
    widget = wibox.widget.imagebox,
    resize = true
  },
  layout = wibox.layout.align.horizontal
}

local widget_button = clickable_container(wibox.container.margin(widget, dpi(14), dpi(14), dpi(7), dpi(7))) -- 4 is top and bottom margin
widget_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        if updateAvailable then
          awful.spawn('st -e tos -Syu')
        else
          awful.spawn('st')
        end
      end
    )
  )
)
-- Alternative to naughty.notify - tooltip. You can compare both and choose the preferred one
awful.tooltip(
  {
    objects = {widget_button},
    mode = 'outside',
    align = 'right',
    timer_function = function()
      if updateAvailable then
        if numOfUpdatesAvailable == "1 " then
            return numOfUpdatesAvailable .. ' updates are available'
        end
        return numOfUpdatesAvailable .. ' updates are available'
      else
        return 'We are up-to-date!'
      end
    end,
    preferred_positions = {'right', 'left', 'top', 'bottom'}
  }
)

-- To use colors from beautiful theme put
-- following lines in rc.lua before require("battery"):
--beautiful.tooltip_fg = beautiful.fg_normal
--beautiful.tooltip_bg = beautiful.bg_normal

local function show_battery_warning()
  naughty.notify {
    icon = PATH_TO_ICONS .. 'battery-alert.svg',
    icon_size = dpi(48),
    text = 'Huston, we have a problem',
    title = 'Battery is dying',
    timeout = 5,
    hover_timeout = 0.5,
    position = 'bottom_left',
    bg = '#d32f2f',
    fg = '#EEE9EF',
    width = 248
  }
end

local last_battery_check = os.time()
local COMMAND = "/bin/bash " .. '/etc/xdg/awesome/updater.sh'
watch(
  COMMAND,
  180,
  function(_, stdout)
    -- Check if there  bluetooth
    local _, replacements = string.gsub(stdout, "\n", " ")
    numOfUpdatesAvailable = _ -- If 'Controller' string is detected on stdout
    local widgetIconName
    if numOfUpdatesAvailable == "0 " then
      widgetIconName = 'package'
      updateAvailable = false
    else
      widgetIconName = 'package-up'
      updateAvailable = true
    end
    widget.icon:set_image(PATH_TO_ICONS .. widgetIconName .. '.svg')
    collectgarbage('collect')
  end,
  widget
)




return widget_button

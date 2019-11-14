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
local watch = require('awful.widget.watch')
local wibox = require('wibox')
local clickable_container = require('widget.material.clickable-container')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local naughty = require('naughty')
-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = '/etc/xdg/awesome/widget/wifi/icons/'
local interface = "wlp2s01"



-- This is the correct way
local command = "ip route get 1.1.1.1 | grep -Po '(?<=dev\\s)\\w+' | cut -f1 -d ' ' > /tmp/interface.txt"

awful.spawn.easy_async_with_shell(command, function()
    awful.spawn.easy_async_with_shell("cat /tmp/interface.txt", function(out)
        interface = out
    end)
end)


local connected = false
local essid = 'N/A'

local widget =
  wibox.widget {
  {
    id = 'icon',
    widget = wibox.widget.imagebox,
    resize = true
  },
  layout = wibox.layout.align.horizontal
}

local widget_button = clickable_container(wibox.container.margin(widget, dpi(14), dpi(14), dpi(7), dpi(7))) -- top and bottom margin  = 4
widget_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn('wicd-client -n')
      end
    )
  )
)

local widget_button = clickable_container(wibox.container.margin(widget, dpi(14), dpi(14), 7, 7)) -- default top bottom margin is 7
widget_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn('nm-connection-editor')
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
      if connected then
        return 'Connected to ' .. essid
      else
        return 'Wireless network is disconnected'
      end
    end,
    preferred_positions = {'right', 'left', 'top', 'bottom'},
    margin_leftright = dpi(8),
    margin_topbottom = dpi(8)
  }
)

local function grabText()
  if connected then
    awful.spawn.easy_async(
      'iw dev ' .. interface .. ' link',
      function(stdout)
        essid = stdout:match('SSID:(.-)\n')
        if (essid == nil) then
          essid = 'N/A'
        end
      end
    )
  end
end

watch(
  "awk 'NR==3 {printf \"%3.0f\" ,($3/70)*100}' /proc/net/wireless",
  5,
  function(_, stdout)
    local widgetIconName = 'wifi-strength'
    local wifi_strength = tonumber(stdout)
    if (wifi_strength ~= nil) then
      connected = true
      -- Update popup text
      local wifi_strength_rounded = math.floor(wifi_strength / 25 + 0.5)
      widgetIconName = widgetIconName .. '-' .. wifi_strength_rounded
      widget.icon:set_image(PATH_TO_ICONS .. widgetIconName .. '.svg')      
    else
      connected = false
      widget.icon:set_image(PATH_TO_ICONS .. widgetIconName .. '-off' .. '.svg')
    end
    if (connected and (essid == 'N/A' or essid == nil)) then
      grabText()
    end
    collectgarbage('collect')
  end,
  widget
)

widget:connect_signal(
  'mouse::enter',
  function()
    grabText()
  end
)

return widget_button

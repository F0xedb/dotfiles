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

local awful = require('awful')
local naughty = require('naughty')
local watch = require('awful.widget.watch')
local wibox = require('wibox')
local clickable_container = require('widget.action-center.clickable-container')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local gap = 1

-- acpi sample outputs
-- Battery 0: Discharging, 75%, 01:51:38 remaining
-- Battery 0: Charging, 53%, 00:57:43 until charged

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = '/etc/xdg/awesome/widget/bluetooth/icons/'
local checker
local mat_list_item = require('widget.material.list-item')

-- TEMPLATE DOWN BELOW DO NOT ALTER OR ELSE WILL DELETE ROOT --
-- Todos:
-- X wifi
-- X bluetooth
-- mpd
-- compositor
-- speaker
-- redshift
-- Screen Resolution (XRANDR)???
--
local barColor = '#ffffff20'
local wifibutton = require('widget.action-center.wifi-button')
local oledbutton = require('widget.action-center.oled-button')
local bluebutton = require('widget.action-center.bluetooth-button')
local comptonbutton = require('widget.action-center.compositor-button')

return wibox.widget {
  spacing = gap,
  -- Wireless Connection
  wibox.widget{
    wibox.widget{
      wifibutton,
      bg = barColor,
      shape = function(cr, width, height)
                gears.shape.partially_rounded_rect(
                  cr,
                  width,
                  height,
                  true,
                  true,
                  false,
                  false,
                  12)
              end,
      widget = wibox.container.background
    },
    widget = mat_list_item,
  },
  -- Bluetooth Connection
  layout = wibox.layout.fixed.vertical,
  wibox.widget{
    wibox.widget{
      bluebutton,
      bg = barColor,
      shape = function(cr, width, height)
                gears.shape.partially_rounded_rect(
                  cr,
                  width,
                  height,
                  false,
                  false,
                  false,
                  false,
                  12)
              end,
      widget = wibox.container.background
    },
    widget = mat_list_item,
  },
  layout = wibox.layout.fixed.vertical,
  -- OLED Toggle
  wibox.widget{
    wibox.widget{
      oledbutton,
      bg = barColor,
      shape = function(cr, width, height)
                gears.shape.partially_rounded_rect(
                  cr,
                  width,
                  height,
                  false,
                  false,
                  false,
                  false,
                  12)
              end,
      widget = wibox.container.background
    },
    widget = mat_list_item,
  },
  -- Compositor Toggle
  layout = wibox.layout.fixed.vertical,
  wibox.widget{
    wibox.widget{
      comptonbutton,
      bg = barColor,
      shape = function(cr, width, height)
                gears.shape.partially_rounded_rect(
                  cr,
                  width,
                  height,
                  false,
                  false,
                  true,
                  true,
                  12)
              end,
      widget = wibox.container.background
    },
    widget = mat_list_item,
    }
}

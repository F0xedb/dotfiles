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

local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local mat_slider = require('widget.material.slider')
local mat_icon_button = require('widget.material.icon-button')
local clickable_container = require('widget.material.clickable-container')
local icons = require('theme.icons')
local watch = require('awful.widget.watch')
local spawn = require('awful.spawn')

local slider =
  wibox.widget {
  read_only = false,
  widget = mat_slider
}

_G.brightness1 = slider
slider:connect_signal(
  'property::value',
  function()
    if (_G.menuopened) then
        _G.brightness2:set_value(slider.value)
    end
    if (_G.oled) then
        spawn('brightness -s ' .. math.max(slider.value, 5) .. ' -F') -- toggle pixel values
    else
        spawn('brightness -s 100 -F') -- reset pixel values
        spawn('brightness -s ' .. math.max(slider.value, 5))
    end
  end
)

watch(
  [[bash -c "grep -q on ~/.cache/oled && brightness -g -F || brightness -g"]],
  1,
  function(widget, stdout, stderr, exitreason, exitcode)
    local brightness = string.match(stdout, '(%d+)')

    slider:set_value(tonumber(brightness))
    collectgarbage('collect')
  end
)

local icon =
  wibox.widget {
  image = icons.brightness,
  widget = wibox.widget.imagebox
}

local button = mat_icon_button(icon)

local brightness_setting =
  wibox.widget {
  button,
  slider,
  widget = mat_list_item
}

return brightness_setting

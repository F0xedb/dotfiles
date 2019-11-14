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

local filesystem = require('gears.filesystem')
local mat_colors = require('theme.mat-colors')
local theme_dir = filesystem.get_configuration_dir() .. '/theme'
local dpi = require('beautiful').xresources.apply_dpi

local theme = {}
theme.icons = theme_dir .. '/icons/'
theme.font = 'Roboto medium 10'
--HERE
theme.titlebars_enabled = true
theme.titlebar_size = dpi(54)
-- Colors Pallets

-- Primary
theme.primary = mat_colors.indigo
theme.primary.hue_500 = '#8AB4F8' --#003f6b

-- Accent
theme.accent = mat_colors.pink

-- Background
theme.background = mat_colors.blue_grey

theme.background.hue_800 = '#000000' .. '66' --99
theme.background.hue_900 = '#000000' .. '66' -- 121e25

local awesome_overrides = function(theme)
  --
end
return {
  theme = theme,
  awesome_overrides = awesome_overrides
}

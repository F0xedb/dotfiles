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
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local awful = require('awful')
local gtk = require("beautiful.gtk")
local theme = {}
theme.icons = theme_dir .. '/icons/'
theme.font = 'Roboto medium 10'
theme.gtk = gtk.get_theme_variables()

-- read out files
-- see if the file exists
function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

-- get all lines from a file, returns an empty 
-- list/table if the file does not exist
function lines_from(file)
  if not file_exists(file) then return "~/Pictures/drawing/simple.png" end
  lines = {}
  for line in io.lines(file) do 
    lines[#lines + 1] = line
  end
  return lines
end

-- Colors Pallets

-- Custom
theme.custom = '#ffffff'

-- Primary
theme.primary = mat_colors.deep_orange

-- Accent
theme.accent = mat_colors.pink

-- Background
theme.background = mat_colors.grey

local awesome_overrides =
  function(theme)
  theme.dir = '/etc/xdg/awesome/theme'
  --theme.dir             = os.getenv("HOME") .. "/code/awesome-pro/themes/pro-dark"

  theme.icons = theme.dir .. '/icons/'
    local command = "head -n3 ~/.config/tos/theme | tail -n1 | awk '{printf $0}'> /tmp/theme.txt"

    awful.spawn.easy_async_with_shell(command, function()
        awful.spawn.easy_async_with_shell("feh --bg-scale $(cat /tmp/theme.txt)", function(out)
            print(out)
        end)
    end)


  --theme.wallpaper = '~/Pictures/simple.png'
  theme.wallpaper = lines_from("~/.config/tos/theme")[2]
  --theme.wallpaper = '#e0e0e0'
  theme.font = 'Roboto medium 10'
  theme.title_font = 'Roboto medium 14'

  theme.fg_normal = '#ffffffde'

  theme.fg_focus = '#e4e4e4'
  theme.fg_urgent = '#CC9393'
  theme.bat_fg_critical = '#232323'

  theme.bg_normal = theme.background.hue_800
  theme.bg_focus = '#5a5a5a'
  theme.bg_urgent = '#3F3F3F'
  theme.bg_systray = theme.background.hue_800

  -- Borders

  theme.border_width = dpi(2)
  theme.border_normal = theme.background.hue_800
  theme.border_focus = theme.primary.hue_300
  theme.border_marked = '#CC9393'

  -- Menu

  theme.menu_height = dpi(16)
  theme.menu_width = dpi(160)

  -- Tooltips
  theme.tooltip_bg = '#232323' .. '99'
  --theme.tooltip_border_color = '#232323'
  theme.tooltip_border_width = 0
  theme.tooltip_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, dpi(6))
  end

  -- Layout

  theme.layout_max = theme.icons .. 'layouts/arrow-expand-all.png'
  theme.layout_tile = theme.icons .. 'layouts/view-quilt.png'
  theme.layout_dwindle = theme.icons .. 'layouts/dwindle.png'

  -- Taglist

  theme.taglist_bg_empty = theme.background.hue_800 .. '99'
  theme.taglist_bg_occupied = -- blank theme.background.hue_800
    'linear:0,0:' ..
    dpi(48) ..
      ',0:0,' ..
        '#ffffff' ..
          ':0.08,' .. '#ffffff' .. ':0.08,' .. theme.background.hue_800 .. '99' .. theme.background.hue_800
  theme.taglist_bg_urgent =
    'linear:0,0:' ..
    dpi(48) ..
      ',0:0,' ..
        theme.accent.hue_500 ..
          ':0.08,' .. theme.accent.hue_500 .. ':0.08,' .. theme.background.hue_800 .. ':1,' .. theme.background.hue_800
  theme.taglist_bg_focus =
    'linear:0,0:' ..
    dpi(48) ..
      ',0:0,' ..
        theme.primary.hue_500 ..
          ':0.08,' .. theme.primary.hue_500 .. ':0.08,' .. theme.background.hue_800 .. ':1,' --[[':1,']] .. theme.background.hue_800

  -- Tasklist

  theme.tasklist_font = 'Roboto Regular 10'
  theme.tasklist_bg_normal = theme.background.hue_800 .. '99'
  theme.tasklist_bg_focus =
    'linear:0,0:0,' ..
    dpi(48) ..
      ':0,' ..
        theme.background.hue_800 ..
          ':0.95,' .. theme.background.hue_800 .. ':0.95,' .. theme.fg_normal .. ':1,' .. theme.fg_normal
  theme.tasklist_bg_urgent = theme.primary.hue_800
  theme.tasklist_fg_focus = '#DDDDDD'
  theme.tasklist_fg_urgent = theme.fg_normal
  theme.tasklist_fg_normal = '#AAAAAA'

  theme.icon_theme = 'Papirus-Dark'

  --Client
  theme.border_width = dpi(0)
  theme.border_focus = theme.primary.hue_500
  theme.border_normal = theme.background.hue_800
end
return {
  theme = theme,
  awesome_overrides = awesome_overrides
}

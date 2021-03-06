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

local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local apps = require('configuration.apps')
local hotkeys_popup = require('awful.hotkeys_popup').widget

terminal = apps.default.terminal
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor




-- Theming Menu
beautiful.menu_font = "Iosevka Custom Regular 10"
beautiful.menu_height = 34
beautiful.menu_width = 180
beautiful.menu_bg_focus = '#8AB4F8AA'
beautiful.menu_bg_normal = '#00000044'
beautiful.menu_submenu = '➤'
beautiful.menu_border_width = 20
beautiful.menu_border_color = '#00000075'

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
  { "Hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "Edit config", editor_cmd .. " " .. awesome.conffile },
  { "Restart", awesome.restart },
  { "Quit", function() awesome.quit() end },
}

myterminalmenu = {
  { "Tos Terminal", function() awful.spawn('st') end },
}
mybrowsermenu = {
  { "Firefox", function() awful.spawn('firefox-developer-edition') end}
}
myeditorsmenu = {
  { "Code", function() awful.spawn('code-insiders') end }
}
myfilemanagermenu = {
  { "Nemo", function() awful.spawn('nemo') end },
}
mymultimediamenu = {
  { "VLC Media Player",  function() awful.spawn('vlc') end },
  { "Spotify",  function() awful.spawn('spotify') end }
}
mygamesmenu = {
  { "SuperTuxKart", function() awful.spawn('supertuxkart') end }
}
myeditingtoolsmenu = {
  { "GIMP",  function() awful.spawn('gimp-2.10') end },
  { "Inkscape", function() awful.spawn('inkscape') end }
}

mymainmenu = awful.menu({
  items = {
                                  { "Terminals", myterminalmenu, beautiful.awesome_icon },
                                  { "Browsers", mybrowsermenu, beautiful.awesome_icon },
                                  { "Text Editors", myeditorsmenu, beautiful.awesome_icon },
                                  { "File Manager", myfilemanagermenu, beautiful.awesome_icon },
                                  { "Multimedia", mymultimediamenu, beautiful.awesome_icon },
                                  { "Games", mygamesmenu, beautiful.awesome_icon },
                                  { "Editors", myeditingtoolsmenu, beautiful.awesome_icon },
                                  { "Awesome Settings", myawesomemenu, beautiful.awesome_icon },
  }
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })

-- Embed mouse bindings
root.buttons(gears.table.join(awful.button({ }, 3, function () mymainmenu:toggle() end)))

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

local leftpanel_icon_theme = 'macos' -- Available Themes: 'lines', 'original', 'macos'
local lit_dir = '/etc/xdg/awesome/theme/icons/themes/' .. leftpanel_icon_theme

local dir = '/etc/xdg/awesome/theme/icons'

return {
  --tags
  chrome = lit_dir .. '/google-chrome.svg',
  code = lit_dir .. '/code.svg',
  social = lit_dir .. '/forum.svg',
  folder = lit_dir .. '/folder.svg',
  music = lit_dir .. '/music.svg',
  game = lit_dir .. '/google-controller.svg',
  lab = lit_dir .. '/flask.svg',
  terminal = lit_dir .. '/terminal.svg',
  art = lit_dir .. '/art.svg',
  --others
  menu = lit_dir .. '/menu.svg',
  logo = lit_dir .. '/logo.svg',
  close = dir .. '/close.svg',
  logout = dir .. '/logout.svg',
  sleep = dir .. '/power-sleep.svg',
  power = dir .. '/power.svg',
  lock = dir .. '/lock.svg',
  restart = dir .. '/restart.svg',
  search = dir .. '/magnify.svg',
  monitor = dir .. '/laptop.svg',
  wifi = dir .. '/wifi.svg',
  volume = dir .. '/volume-high.svg',
  muted = dir .. '/volume-mute.svg',
  brightness = dir .. '/brightness-7.svg',
  chart = dir .. '/chart-areaspline.svg',
  memory = dir .. '/memory.svg',
  harddisk = dir .. '/harddisk.svg',
  thermometer = dir .. '/thermometer.svg',
  plus = dir .. '/plus.svg'
}

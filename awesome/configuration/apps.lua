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
local HOME = os.getenv('HOME')

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function getComptonFile()
    userfile = HOME .. "/.config/compton.conf"
    if(file_exists(userfile)) then
        return userfile
    end
    return filesystem.get_configuration_dir() .. '/configuration/compton.conf '
end



return {
  -- List of apps to start by default on some actions
  default = {
    terminal = 'st',
    editor = 'code-insiders',
    rofi = 'rofi -show drun -theme ' .. filesystem.get_configuration_dir() .. '/configuration/rofi/sidebar/rofi.rasi',
    rofiappmenu = 'rofi -show drun -theme ' .. filesystem.get_configuration_dir() .. '/configuration/rofi/appmenu/drun.rasi',
    rofidpimenu = [[bash /etc/xdg/awesome/dpi.sh]],
    rofiwifimenu = [[bash /etc/xdg/awesome/wifi.sh]],
    lock = 'dm-tool lock' --[['i3lock-fancy-rapid 5 3 -k --timecolor=ffffffff --datecolor=ffffffff']],
    quake = 'st --title QuakeTerminal'
  },
  -- List of apps to start once on start-up
  run_on_start_up = {
    'compton --config ' .. getComptonFile(),
    'blueman-applet', -- Bluetooth tray icon
    'xfce4-power-manager', -- Power manager
    '/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
    'xfsettingsd', -- Settings
    'nitrogen --restore', -- Wallpaper
    'xrdb $HOME/.Xresources',
    'nm-applet',
    'sh -c "/etc/xdg/awesome/autorun.sh"'
    -- 'mpd'
    --'redshift -l 14.45:121.05'
  }
}

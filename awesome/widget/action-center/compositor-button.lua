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
local wibox = require('wibox')
local clickable_container = require('widget.action-center.clickable-container')
local gears = require('gears')
local dpi = require('beautiful').xresources.apply_dpi
local watch = require('awful.widget.watch')
local mat_list_item = require('widget.material.list-item')
local filesystem = require('gears.filesystem')

local HOME = os.getenv('HOME')
local PATH_TO_ICONS = '/etc/xdg/awesome/widget/action-center/icons/'

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


local cmd = 'grep -F "blur-background-frame = false;" ' .. getComptonFile() .."| tr -d '[\\-\\;\\=\\ ]' "
local frameStatus
local widgetIconName

-- Image wibox

local widget =
  wibox.widget {
  {
    id = 'icon',
    widget = wibox.widget.imagebox,
    resize = true
  },
  layout = wibox.layout.align.horizontal
}


local function update_icon()
  if frameStatus then
    widgetIconName = 'toggled-on'
    widget.icon:set_image(PATH_TO_ICONS .. widgetIconName .. '.svg')
  else
    widgetIconName = 'toggled-off'
    widget.icon:set_image(PATH_TO_ICONS .. widgetIconName .. '.svg')
  end
end

------

-- The cmd variable is declared above
-- It checks the line "blur-background-frame: false;"
-- I use 'tr' shell command to remove the special characters
-- because lua is choosy on MATCH method
-- So the output will be 'blurbackgroundframefalse'
-- if it matches the assigned value inside the match method below
-- then it will declared as value of frameCheker
-- The rest is history
local frameChecker
function checkFrame()
  awful.spawn.easy_async_with_shell(cmd, function( stdout )
    frameChecker = stdout:match('blurbackgroundframefalse')
    if frameChecker == nil then
      frameStatus = true
      update_icon()
    else
      frameStatus = false
      update_icon()
    end
  end)
end


-- Commands that will be executed when I toggle the button
blurDisable = {
  'sed -i -e "s/blur-background-frame = true/blur-background-frame = false/g" ' .. getComptonFile(),
  'compton --config ' .. getComptonFile(),
  'notify-send "Blur effect disabled"'
}
blurEnable = {
  'sed -i -e "s/blur-background-frame = false/blur-background-frame = true/g" ' .. getComptonFile(),
  'compton --config ' .. getComptonFile(),
  'notify-send "Blur effect enabled"'
}


local function run_once(cmd)
  local findme = cmd
  local firstspace = cmd:find(' ')
  if firstspace then
    findme = cmd:sub(0, firstspace - 1)
  end
  awful.spawn.with_shell(string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd))
end


local function toggle_compositor()
  if(frameStatus == true) then
    awful.spawn.with_shell('kill -9 $(pidof compton)')
    for _, app in ipairs(blurDisable) do
      run_once(app)
    end
    frameStatus = false
    update_icon()
  else
    awful.spawn.with_shell('kill -9 $(pidof compton)')
    for _, app in ipairs(blurEnable) do
      run_once(app)
    end
    frameStatus = true
    update_icon()
  end
end

checkFrame()
-----------------------------------------------------------------------------------------------------------------


local compton_button = clickable_container(wibox.container.margin(widget, dpi(7), dpi(7), dpi(7), dpi(7))) -- 4 is top and bottom margin
compton_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        toggle_compositor()
      end
    )
  )
)

local settingsName = wibox.widget {
  text = 'Window Effects',
  font = 'Iosevka Regular 10',
  align = 'left',
  widget = wibox.widget.textbox
}

local content =   wibox.widget {
    settingsName,
    compton_button,
    bg = '#ffffff20',
    shape = gears.shape.rounded_rect,
    widget = wibox.container.background(settingsName),
    layout = wibox.layout.ratio.horizontal,

  }
content:set_ratio(1, .85)

local comptonButton =  wibox.widget {
  wibox.widget {
    content,
    widget = mat_list_item
  },
  layout = wibox.layout.fixed.vertical
}

return comptonButton

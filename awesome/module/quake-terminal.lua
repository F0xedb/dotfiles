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

local spawn = require('awful.spawn')
local app = require('configuration.apps').default.quake

local quake_id = 'notnil'
local quake_client
local opened = false
function create_shell()
  quake_id =
    spawn(
    app,
    {
      skip_decoration = true
    }
  )
end

function open_quake()
  quake_client.hidden = false
end

function close_quake()
  quake_client.hidden = true
end

toggle_quake = function()
  opened = not opened
  if not quake_client then
    create_shell()
  else
    if opened then
      open_quake()
    else
      close_quake()
    end
  end
end

_G.client.connect_signal(
  'manage',
  function(c)
    if (c.pid == quake_id) then
      quake_client = c
      c.opacity = 0.9
      c.floating = true
      c.skip_taskbar = true
      c.ontop = true
      c.above = true
      c.sticky = true
      c.hidden = not opened
      c.maximized_horizontal = true
    end
  end
)

_G.client.connect_signal(
  'unmanage',
  function(c)
    if (c.pid == quake_id) then
      opened = false
      quake_client = nil
    end
  end
)

-- create_shell()

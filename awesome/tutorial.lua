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


local naughty = require('naughty')

function tutorial ()
    function workspaces ()
    naughty.notify({ title = "TOS tutorial!", text = "To go to a new workspace try mod+2, launch a program and switch back with mod+1", timeout = 0, position = "top_left", 
    destroy = function ()
        naughty.notify({ title = "TOS tutorial!", text = "For the help menu use mod+f1.", timeout = 0, position = "top_left", 
        destroy = function ()
            naughty.notify({ title = "TOS tutorial!", text = "Nice all you need to do now is start the installer, open a terminal (mod+Enter) and type in 'tos c'. Good luck on your journey", timeout = 0, position = "top_left",
               destroy = function ()
                  local HOME = os.getenv('HOME')
                  local FILE = HOME .. '/.cache/tutorial_tos'
                  io.open(FILE,"w"):write("tutorial is complete"):close()
               end}) 
        end})
    end})
    end


    naughty.notify({ title = "TOS tutorial!", text = "<- All the icons on the left represent workspaces", timeout = 0, position = "top_left", 
    destroy = function ()
        naughty.notify({ title = "TOS tutorial!", text = "<- This sets the staking layout of your windows. Notice the pattern.", timeout = 0, position = "bottom_left", 
        destroy = function ()
            naughty.notify({ title = "TOS tutorial!", text = "Try to open a few terminals and see what happens. mod+Enter to open a terminal (windows key) Now click on the icon in the bottom left corner a few times", timeout = 0, position = "bottom_left", 
            destroy = function ()
                naughty.notify({ title = "TOS tutorial!", text = "To kill a program use mod+q", timeout = 0, position = "top_right", 
                destroy = function ()
                    naughty.notify({ title = "TOS tutorial!", text = "To launch applications use mod+d. Try to start a few and kill them.", timeout = 0, position = "top_right", 
                    destroy = function ()
                        naughty.notify({ title = "TOS tutorial!", text = "<- Click on the tos logo to access general settings.", timeout = 0, position = "top_left", destroy = workspaces})
                    end})
                end})
            end})
        end})
    end})
end

local HOME = os.getenv('HOME')
local FILE = HOME .. '/.cache/tutorial_tos'
local f=io.open(FILE,"r")
if f~=nil then 
        io.close(f) 
else 
    tutorial()
end

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
local beautiful = require('beautiful')
local wibox = require('wibox')
local mat_list_item = require('widget.material.list-item')
local mat_icon = require('widget.material.icon')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')
local gears = require('gears')
local scrollbar = require('widget.scrollbar')

return function(_, panel)
  local search_button =
    wibox.widget {
    wibox.widget {
      icon = icons.search,
      size = dpi(24),
      widget = mat_icon
    },
    wibox.widget {
      text = 'Search Applications',
      font = 'Iosevka Regular 12',
      widget = wibox.widget.textbox,
      align = center
    },
    forced_height = dpi(12),
    clickable = true,
    widget = mat_list_item
  }

  search_button:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          panel:run_rofi()
        end
      )
    )
  )
  local dpi_button =
    wibox.widget {
    wibox.widget {
      icon = icons.monitor,
      size = dpi(24),
      widget = mat_icon
    },
    wibox.widget {
      text = 'Change Application Scaling',
      font = 'Iosevka Regular 12',
      widget = wibox.widget.textbox,
      align = center
    },
    forced_height = dpi(12),
    clickable = true,
    widget = mat_list_item
  }

  dpi_button:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          panel:run_dpi()
        end
      )
    )
  )

  local wifi_button =
    wibox.widget {
    wibox.widget {
      icon = icons.wifi,
      size = dpi(24),
      widget = mat_icon
    },
    wibox.widget {
      text = 'Connect to a wireless network',
      font = 'Iosevka Regular 12',
      widget = wibox.widget.textbox,
      align = center
    },
    forced_height = dpi(12),
    clickable = true,
    widget = mat_list_item
  }

  wifi_button:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          panel:run_wifi()
        end
      )
    )
  )

  local exit_button =
    wibox.widget {
    wibox.widget {
      icon = icons.logout,
      size = dpi(24),
      widget = mat_icon
    },
    wibox.widget {
      text = 'End work session',
      font = 'Iosevka Regular 12',
      widget = wibox.widget.textbox
    },
    clickable = true,
    divider = false,
    widget = mat_list_item
  }

  exit_button:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          panel:toggle()
          _G.exit_screen_show()
        end
      )
    )
  )


  local separator = wibox.widget {
    orientation = 'vertical',
    forced_height = 10,
    opacity = 0.00,
    widget = wibox.widget.separator
  }

  local topSeparator = wibox.widget {
    orientation = 'horizontal',
    forced_height = 20,
    opacity = 0,
    widget = wibox.widget.separator,
  }

  local bottomSeparator = wibox.widget {
    orientation = 'horizontal',
    forced_height = 5,
    opacity = 0,
    widget = wibox.widget.separator,

  }

  return scrollbar(wibox.widget {
    layout = wibox.layout.align.vertical,
    {
      topSeparator,
      layout = wibox.layout.fixed.vertical,
      {
        wibox.widget {
          search_button,
          bg = '#ffffff20',     --beautiful.background.hue_800,
          shape = function(cr, w, h)
                    gears.shape.rounded_rect(cr, w, h, 28)
                  end,
          widget = wibox.container.background,
        },
        widget = mat_list_item,
      },
      separator,
      require('layout.left-panel.dashboard.quick-settings'),
      require('layout.left-panel.dashboard.hardware-monitor'),
      require('layout.left-panel.dashboard.action-center'),
      separator,
      layout = wibox.layout.fixed.vertical,
      {
        wibox.widget {
            text = 'Network Settings',
            font = 'Iosevka Regular 10',
            align = 'left',
            widget = wibox.widget.textbox
        },
        widget = mat_list_item,
      },
        layout = wibox.layout.fixed.vertical,
        {
            wibox.widget {
                wifi_button,
          bg = '#ffffff20',     --beautiful.background.hue_800,
          shape = function(cr, w, h)
                    gears.shape.rounded_rect(cr, w, h, 28)
                  end,
          widget = wibox.container.background,
        },
        widget = mat_list_item,
      },
      separator,
      layout = wibox.layout.fixed.vertical,
      {
        wibox.widget {
            text = 'Screen Settings',
            font = 'Iosevka Regular 10',
            align = 'left',
            widget = wibox.widget.textbox
        },
        widget = mat_list_item,
      },
        layout = wibox.layout.fixed.vertical,
        {
            wibox.widget {
                dpi_button,
          bg = '#ffffff20',     --beautiful.background.hue_800,
          shape = function(cr, w, h)
                    gears.shape.rounded_rect(cr, w, h, 28)
                  end,
          widget = wibox.container.background,
        },
        widget = mat_list_item,
      },
    },
    nil,
    {

      layout = wibox.layout.fixed.vertical,
      wibox.widget{
        wibox.widget{
          exit_button,
          bg = '#ffffff20',--beautiful.background.hue_800,
          widget = wibox.container.background,
          shape = function(cr, w, h)
                    gears.shape.rounded_rect(cr, w, h, 12)
                  end,
        },
        widget = mat_list_item,
      },
      bottomSeparator
    }
  })
end

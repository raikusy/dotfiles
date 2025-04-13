-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
local mux = wezterm.mux

wezterm.on("gui-startup", function()
  local tab, pane, window = mux.spawn_window {}
  window:gui_window():set_position(0, 0)
  window:gui_window():set_inner_size(1920, 700)
end)

---Return the suitable argument depending on the appearance
---@param arg { light: any, dark: any } light and dark alternatives
---@return any
local function depending_on_appearance(arg)
  local appearance = wezterm.gui.get_appearance()
  if appearance:find 'Dark' then
    return arg.dark
  else
    return arg.light
  end
end

-- This is where you actually apply your config choices
config.color_scheme = depending_on_appearance {
  light = 'Catppuccin Latte',
  dark = 'Catppuccin Mocha',
}

config.keys = {
  {
    key = ']',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ToggleAlwaysOnTop,
  },
}

config.use_fancy_tab_bar = false
config.tab_max_width = 32
config.colors = {
  tab_bar = {
    active_tab = depending_on_appearance {
      light = { fg_color = '#f8f8f2', bg_color = '#209fb5' },
      dark = { fg_color = '#6c7086', bg_color = '#74c7ec' },
    }
  }
}

-- config.initial_rows = 30
-- config.initial_cols = 280

config.window_decorations = 'RESIZE'

config.font_size = 14
config.font = wezterm.font {
  family = 'JetBrainsMono Nerd Font Mono',
  weight = 'DemiBold',
}


config.window_frame = {
  -- The font used in the tab bar.
  -- Roboto Bold is the default; this font is bundled
  -- with wezterm.
  -- Whatever font is selected here, it will have the
  -- main font setting appended to it to pick up any
  -- fallback fonts you may have used there.
  font = wezterm.font { family = 'JetBrainsMono Nerd Font Mono', weight = 'DemiBold' },

  -- The size of the font in the tab bar.
  -- Default to 10.0 on Windows but 12.0 on other systems
  font_size = 14.0,

  -- The overall background color of the tab bar when
  -- the window is focused
  active_titlebar_bg = '#333333',

  -- The overall background color of the tab bar when
  -- the window is not focused
  inactive_titlebar_bg = '#333333',
}

config.colors = {
  tab_bar = {
    -- The color of the inactive tab bar edge/divider
    inactive_tab_edge = '#575757',
  },
}

config.native_macos_fullscreen_mode = true
config.pane_focus_follows_mouse = true

config.default_prog = { '/Users/raikusy/.nix-profile/bin/fish', '-l' }
config.launch_menu = {
  {
    label = 'fish',
    args = { '/Users/raikusy/.nix-profile/bin/fish', '-l' },
  },
  {
    label = 'zsh',
    args = { '/bin/zsh', '-l' },
  },
  {
    label = 'bash',
    args = { '/bin/bash', '-l' },
  }
}

config.mouse_bindings = {
  -- Open URLs with CMD+Click
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'CMD',
    action = wezterm.action.OpenLinkAtMouseCursor,
  }
}

config.keys = {
  -- Show tab navigator
  {
    key = 'p',
    mods = 'CMD',
    action = wezterm.action.ShowTabNavigator
  },
  -- Show launcher menu
  {
    key = 'P',
    mods = 'CMD|SHIFT',
    action = wezterm.action.ShowLauncher
  },
  -- Vertical pipe (|) -> horizontal split
  {
    key = '\\',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitHorizontal {
      domain = 'CurrentPaneDomain'
    },
  },
  -- Underscore (_) -> vertical split
  {
    key = '-',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SplitVertical {
      domain = 'CurrentPaneDomain'
    },
  },
  -- Rename current tab
  {
    key = 'E',
    mods = 'CMD|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(
        function(window, _, line)
          if line then
            window:active_tab():set_title(line)
          end
        end
      ),
    },
  },
  -- Move to a pane (prompt to which one)
  {
    mods = "CMD",
    key = "m",
    action = wezterm.action.PaneSelect
  },
  -- Use CMD + [h|j|k|l] to move between panes
  {
    key = "h",
    mods = "CMD",
    action = wezterm.action.ActivatePaneDirection('Left')
  },

  {
    key = "j",
    mods = "CMD",
    action = wezterm.action.ActivatePaneDirection('Down')
  },

  {
    key = "k",
    mods = "CMD",
    action = wezterm.action.ActivatePaneDirection('Up')
  },

  {
    key = "l",
    mods = "CMD",
    action = wezterm.action.ActivatePaneDirection('Right')
  },
  -- Move to another pane (next or previous)
  {
    key = "[",
    mods = "CMD",
    action = wezterm.action.ActivatePaneDirection('Prev')
  },

  {
    key = "]",
    mods = "CMD",
    action = wezterm.action.ActivatePaneDirection('Next')
  },
  -- Move to another tab (next or previous)
  {
    key = "{",
    mods = "CMD|SHIFT",
    action = wezterm.action.ActivateTabRelative(-1)
  },

  {
    key = "}",
    mods = "CMD|SHIFT",
    action = wezterm.action.ActivateTabRelative(1)
  },
  -- Use CMD+Shift+S t swap the active pane and another one
  {
    key = "s",
    mods = "CMD|SHIFT",
    action = wezterm.action {
      PaneSelect = { mode = "SwapWithActiveKeepFocus" }
    }
  },
  -- Use CMD+w to close the pane, CMD+SHIFT+w to close the tab
  {
    key = "w",
    mods = "CMD",
    action = wezterm.action.CloseCurrentPane { confirm = true }
  },

  {
    key = "W",
    mods = "CMD|SHIFT",
    action = wezterm.action.CloseCurrentTab { confirm = true }
  },
  -- Use CMD+z to enter zoom state
  {
    key = 'z',
    mods = 'CMD',
    action = wezterm.action.TogglePaneZoomState,
  },
  -- Launch commands in a new pane
  {
    key = 'g',
    mods = 'CMD',
    action = wezterm.action.SplitHorizontal {
      domain = 'CurrentPaneDomain'
    }
  },
  -- Run lazygit with push and PR creation (CMD+G)
  {
    key = 'G',
    mods = 'CMD|SHIFT',
    action = wezterm.action.SpawnCommandInNewTab {
      args = {
        'lazygit branch'
      },
    }
  }
}

local bar = wezterm.plugin.require("https://github.com/adriankarlen/bar.wezterm")
bar.apply_to_config(config)
-- and finally, return the configuration to wezterm
return config

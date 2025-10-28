{ host, ... }: ''
  binds {
      // === System & Overview ===
      Mod+grave repeat=false { toggle-overview; }
      Mod+Shift+Slash { show-hotkey-overlay; }

      // === Window Management ===
      Mod+Q repeat=false { close-window; }
      Alt+F4 repeat=false { close-window; }
      Mod+F { maximize-column; }
      Mod+Shift+F { fullscreen-window; }
      Alt+Return { fullscreen-window; }
      Mod+W { toggle-window-floating; }
      Mod+Ctrl+W { switch-focus-between-floating-and-tiling; }
      Mod+V { toggle-column-tabbed-display; }

      // === Focus Navigation ===
      Mod+Left  { focus-column-left; }
      Mod+Down  { focus-window-down; }
      Mod+Up    { focus-window-up; }
      Mod+Right { focus-column-right; }
      Mod+H     { focus-column-left; }
      Mod+J     { focus-window-down; }
      Mod+K     { focus-window-up; }
      Mod+L     { focus-column-right; }

      // === Window Movement ===
      Mod+Shift+Left  { move-column-left; }
      Mod+Shift+Down  { move-window-down; }
      Mod+Shift+Up    { move-window-up; }
      Mod+Shift+Right { move-column-right; }
      Mod+Shift+H     { move-column-left; }
      Mod+Shift+J     { move-window-down; }
      Mod+Shift+K     { move-window-up; }
      Mod+Shift+L     { move-column-right; }

      // === Column Navigation ===
      Mod+Home { focus-column-first; }
      Mod+End  { focus-column-last; }
      Mod+Ctrl+Home { move-column-to-first; }
      Mod+Ctrl+End  { move-column-to-last; }

      // === Monitor Navigation ===
      Mod+Ctrl+Left  { focus-monitor-left; }
      Mod+Ctrl+Right { focus-monitor-right; }
      Mod+Ctrl+H     { focus-monitor-left; }
      Mod+Ctrl+J     { focus-monitor-down; }
      Mod+Ctrl+K     { focus-monitor-up; }
      Mod+Ctrl+L     { focus-monitor-right; }

      // === Move to Monitor ===
      Mod+Shift+Ctrl+Left  { move-column-to-monitor-left; }
      Mod+Shift+Ctrl+Down  { move-column-to-monitor-down; }
      Mod+Shift+Ctrl+Up    { move-column-to-monitor-up; }
      Mod+Shift+Ctrl+Right { move-column-to-monitor-right; }
      Mod+Shift+Ctrl+H     { move-column-to-monitor-left; }
      Mod+Shift+Ctrl+J     { move-column-to-monitor-down; }
      Mod+Shift+Ctrl+K     { move-column-to-monitor-up; }
      Mod+Shift+Ctrl+L     { move-column-to-monitor-right; }

      // === Workspace Navigation ===
      Mod+Ctrl+U            { focus-workspace-down; }
      Mod+Ctrl+D           { focus-workspace-up; }
      Mod+Ctrl+Down        { focus-workspace-down; }
      Mod+Ctrl+Up          { focus-workspace-up; }
      Mod+Ctrl+Alt+Down    { move-column-to-workspace-down; }
      Mod+Ctrl+Alt+Up      { move-column-to-workspace-up; }

      // === Move Workspaces ===
      Mod+Shift+Page_Down { move-workspace-down; }
      Mod+Shift+Page_Up   { move-workspace-up; }
      Mod+Shift+U         { move-workspace-down; }
      Mod+Shift+I         { move-workspace-up; }

      // === Mouse Wheel Navigation ===
      Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
      Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
      Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
      Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

      Mod+WheelScrollRight      { focus-column-right; }
      Mod+WheelScrollLeft       { focus-column-left; }
      Mod+Ctrl+WheelScrollRight { move-column-right; }
      Mod+Ctrl+WheelScrollLeft  { move-column-left; }

      Mod+Shift+WheelScrollDown      { focus-column-right; }
      Mod+Shift+WheelScrollUp        { focus-column-left; }
      Mod+Ctrl+Shift+WheelScrollDown { move-column-right; }
      Mod+Ctrl+Shift+WheelScrollUp   { move-column-left; }

      // === Numbered Workspaces ===
      Mod+1 { focus-workspace 1; }
      Mod+2 { focus-workspace 2; }
      Mod+3 { focus-workspace 3; }
      Mod+4 { focus-workspace 4; }
      Mod+5 { focus-workspace 5; }
      Mod+6 { focus-workspace 6; }
      Mod+7 { focus-workspace 7; }
      Mod+8 { focus-workspace 8; }
      Mod+9 { focus-workspace 9; }

      // === Move to Numbered Workspaces ===
      Mod+Shift+1 { move-column-to-workspace 1; }
      Mod+Shift+2 { move-column-to-workspace 2; }
      Mod+Shift+3 { move-column-to-workspace 3; }
      Mod+Shift+4 { move-column-to-workspace 4; }
      Mod+Shift+5 { move-column-to-workspace 5; }
      Mod+Shift+6 { move-column-to-workspace 6; }
      Mod+Shift+7 { move-column-to-workspace 7; }
      Mod+Shift+8 { move-column-to-workspace 8; }
      Mod+Shift+9 { move-column-to-workspace 9; }

      // === Column Management ===
      Mod+BracketLeft  { consume-or-expel-window-left; }
      Mod+BracketRight { consume-or-expel-window-right; }
      Mod+Period { expel-window-from-column; }

      // === Sizing & Layout ===
      Mod+R { switch-preset-column-width; }
      Mod+Shift+R { switch-preset-window-height; }
      Mod+Ctrl+R { reset-window-height; }
      Mod+Ctrl+F { expand-column-to-available-width; }
      Mod+Shift+C { center-column; }

      // === Manual Sizing ===
      Mod+Minus { set-column-width "-10%"; }
      Mod+Equal { set-column-width "+10%"; }
      Mod+Shift+Minus { set-window-height "-10%"; }
      Mod+Shift+Equal { set-window-height "+10%"; }

      // === Screenshots ===
      Mod+Shift+S { screenshot; }
      XF86Launch1 { screenshot; }
      Ctrl+XF86Launch1 { screenshot-screen; }
      Alt+XF86Launch1 { screenshot-window; }
      Print { screenshot; }
      Ctrl+Print { screenshot-screen; }
      Alt+Print { screenshot-window; }

      // === System Controls ===
      Mod+Alt+P { power-off-monitors; }

      // === Custom Application Launchers ===
      Mod+T hotkey-overlay-title="Open a Terminal: kitty" { spawn "kitty"; }
      Mod+B hotkey-overlay-title="Open a Browser: firefox" { spawn "firefox"; }
      Mod+D hotkey-overlay-title="Open a File Browser: Dolphin" { spawn "dolphin"; }
      Mod+Ctrl+S hotkey-overlay-title="Open Steam" { spawn "steam"; }
      Mod+Shift+D hotkey-overlay-title="Open Discord" { spawn "discord"; }
      Mod+Space hotkey-overlay-title="Noctalia Launcher" { spawn "noctalia-shell" "ipc" "--any-display" "call" "launcher" "toggle"; }

      // === Color picker ===
      Mod+Ctrl+P { spawn-sh "niri msg pick-color | grep 'Hex:' | cut -d' ' -f2 | wl-copy"; }
  }
''

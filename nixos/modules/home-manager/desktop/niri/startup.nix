{ host, ... }:
let
  # Determine which bar to launch - returns the full spawn command
in ''
  spawn-at-startup "swww-daemon"
  spawn-at-startup "swww" "img" "~/Pictures/Backgrounds/wallhaven-lyqljy.png"
  spawn-at-startup "/usr/lib/xdg-desktop-portal-gtk"
  spawn-at-startup "/usr/lib/xdg-desktop-portal-gnome"
''

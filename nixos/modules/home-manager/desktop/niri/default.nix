{
  config,
  lib,
  pkgs,
  ...
}:

with lib;
let
  cfg = config.modules.desktop.niri;
in
{
  options.modules.desktop.niri = {
    enable = lib.mkEnableOption "Enable Niri window manager";
    outputs = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.anything);
      default = [ ];
      example = [
        {
          name = "DP-1";
          mode = "2560x1440@240";
          position = "x=0 y=0";
        }
        {
          name = "DP-2";
          mode = "2560x1440@360";
          position = "x=2560 y=0";
        }
      ];
      description = "List of output configurations for niri";
    };
    customThemeFile = lib.mkOption {
      type = lib.types.str;
      default = "";
      description = "Path to the custom theme file for DankMaterialShell";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = with pkgs; [
        # libappindicator
        # mpvpaper
        # swww
        xwayland-satellite
      ];

      home.file = {
        ".config/niri/dms/outputs.kdl" = {
          text =
            lib.concatStringsSep "\n" (
              map (o: ''
                output "${o.identifier or o.name}" {
                    mode "${o.mode}"
                    scale 1
                    position ${o.position}
                    variable-refresh-rate on-demand=true
                }
              '') (filter (o: o.vrrOnDemand or false) cfg.outputs)
            )
            + "\n"
            + lib.concatStringsSep "\n" (
              map (o: ''
                output "${o.identifier or o.name}" {
                    mode "${o.mode}"
                    scale 1
                    position ${o.position}
                }
              '') (filter (o: !(o.vrrOnDemand or false)) cfg.outputs)
            );
          force = true;
        };
        ".config/niri/dms/windowrules.kdl" = {
          force = true;
          text = ''
            window-rule {
                match app-id=r#".*$"#
                variable-refresh-rate false
                open-floating true
            }

            window-rule {
                match app-id=r#"^faugus.*$"#
                open-on-workspace "gaming"
            }

            window-rule {
                match app-id="mpv"
                match app-id="dolphin"
                match app-id="steam"
                match app-id="spotify"
                match title=r#"^(Battle\.net.*)$"#
                default-column-width { proportion 0.5; }
                default-window-height { proportion 0.75; }
            }

            window-rule {
                match app-id="dolphin"
                match app-id="discord"
                match app-id="spotify"
                opacity 0.97
            }

            window-rule {
                match app-id="kitty"
                default-column-width { proportion 0.85; }
                default-window-height { proportion 0.85; }
                open-on-workspace "terminal"
            }

            window-rule {
                match app-id="steam"
                open-on-workspace "gaming"
            }

            window-rule {
                match app-id="spotify"
                open-on-workspace "spotify"
                default-column-width { proportion 0.85; }
                default-window-height { proportion 0.85; }
            }

            window-rule {
                match app-id="firefox"
                open-on-workspace "browser"
                open-floating false
            }

            window-rule {
                match app-id="discord"
                open-on-workspace "discord"
                open-floating false
            }

            window-rule {
                match title="Diablo II"
                open-fullscreen true
            }

            window-rule {
                match title="World of Warcraft"
                open-fullscreen true
            }
          '';
        };

        ".config/niri/config.kdl" = {
          force = true;
          text =
            let
              primaryOutput = findFirst (o: o.vrrOnDemand or false) (head cfg.outputs) cfg.outputs;
              primaryName = primaryOutput.identifier or primaryOutput.name;
            in
            ''

              workspace "terminal" {
                  open-on-output "${primaryName}"
              }
              workspace "gaming" {
                  open-on-output "${primaryName}"
              }
              workspace "browser" {
                  open-on-output "${primaryName}"
              }
              workspace "discord" {
                  open-on-output "${primaryName}"
              }
              workspace "spotify" {
                  open-on-output "${primaryName}"
              }

              input {
                  keyboard {
                      repeat-delay 250
                      repeat-rate 25
                      numlock
                  }
                  touchpad {
                      tap
                      natural-scroll
                  }
                  mouse {
                      accel-profile "flat"
                  }
              }

              prefer-no-csd

              gestures {
                  // ... other gesture settings
                  hot-corners {
                      off
                  }
              }

              cursor {
                  xcursor-theme "Bibata-Modern-Ice"
                  xcursor-size 24
                  hide-when-typing
                  hide-after-inactive-ms 5000
              }

              environment {
                  QT_QPA_PLATFORM "wayland"
                  QT_QPA_PLATFORMTHEME "qt6ct"
                  XDG_CURRENT_DESKTOP "niri"
              }

              debug {
                  force-disable-connectors-on-resume
              }

              hotkey-overlay {
                skip-at-startup
              }

              binds {
                  Super+Shift+Slash { show-hotkey-overlay; }

                  Super+V { spawn-sh "dms ipc call clipboard toggle"; }
                  Ctrl+Alt+Shift+P { power-off-monitors; }
                  Ctrl+Alt+L { spawn-sh "dms ipc call lock lock "; }


                  Super+grave repeat=false { toggle-overview; }
                  Alt+F4 repeat=false { close-window; }

                  Super+T { spawn-sh "~/.local/bin/raise-cycle-or-spawn niri kitty"; }
                  Super+B { spawn-sh "~/.local/bin/raise-cycle-or-spawn niri firefox"; }
                  Super+E { spawn-sh "~/.local/bin/raise-cycle-or-spawn niri dolphin"; }
                  Super+Shift+D { spawn-sh "~/.local/bin/raise-cycle-or-spawn niri discord"; }
                  Super+Ctrl+S { spawn-sh "~/.local/bin/raise-cycle-or-spawn niri steam"; }
                  Super+Shift+M { spawn-sh "~/.local/bin/raise-cycle-or-spawn niri spotify"; }

                  Super+Q { close-window; }
                  Super+F { maximize-column; }
                  Super+Shift+F { fullscreen-window; }
                  Super+M { maximize-window-to-edges; }
                  Super+W { toggle-window-floating; }
                  Super+C { center-column; }
                  Super+Ctrl+C { center-visible-columns; }

                  Super+Minus { set-column-width "-10%"; }
                  Super+Equal { set-column-width "+10%"; }
                  Super+Shift+Minus { set-window-height "-10%"; }
                  Super+Shift+Equal { set-window-height "+10%"; }

                  Super+R { switch-preset-column-width; }
                  Super+Shift+R { switch-preset-window-height; }
                  Super+Ctrl+R { reset-window-height; }
                  Super+Ctrl+F { expand-column-to-available-width; }

                  Super+1 { focus-workspace "terminal"; }
                  Super+2 { focus-workspace "gaming"; }
                  Super+3 { focus-workspace "browser"; }
                  Super+4 { focus-workspace "discord"; }
                  Super+5 { focus-workspace "spotify"; }

                  Super+Left  { focus-column-left; }
                  Super+Down  { focus-workspace-down; }
                  Super+Up    { focus-workspace-up; }
                  Super+Right { focus-column-right; }
                  Super+H     { focus-column-left; }
                  Super+J     { focus-workspace-down; }
                  Super+K     { focus-workspace-up; }
                  Super+L     { focus-column-right; }

                  // Focus other monitor
                  Ctrl+Super+H    { focus-monitor-left; }
                  Ctrl+Super+L    { focus-monitor-right; }

                  Super+Shift+1 { move-column-to-workspace "terminal"; }
                  Super+Shift+2 { move-column-to-workspace "gaming"; }
                  Super+Shift+3 { move-column-to-workspace "browser"; }
                  Super+Shift+4 { move-column-to-workspace "discord"; }
                  Super+Shift+5 { move-column-to-workspace "spotify"; }

                  Super+Shift+H { move-column-left; }
                  Super+Shift+L { move-column-right; }
                  Super+Shift+J { move-column-to-workspace-down; }
                  Super+Shift+K { move-column-to-workspace-up; }

                  Super+Shift+Left  { move-column-to-monitor-left; }
                  Super+Shift+Right { move-column-to-monitor-right; }
                  Super+Shift+Ctrl+H     { move-column-to-monitor-left; }
                  Super+Shift+Ctrl+L     { move-column-to-monitor-right; }

                  Super+BracketLeft  { consume-or-expel-window-left; }
                  Super+BracketRight { consume-or-expel-window-right; }
                  Super+Comma  { consume-window-into-column; }
                  Super+Period { expel-window-from-column; }

                  Super+Shift+S { screenshot; }
                  Alt+Shift+S { screenshot-window; }
                  F12 { screenshot-screen; }

                  XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"; }
                  Super+F12            allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"; }
                  XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
                  Super+F11            allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
                  XF86AudioMute        allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
                  Super+F9             allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
                  XF86AudioMicMute     allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
                  Super+F10            allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }
                  Alt+MouseBack allow-invalidation=false {
                      press { spawn-sh "mic-ptt press"; }
                      release { spawn-sh "mic-ptt release"; }
                  }

                  XF86AudioPlay        allow-when-locked=true { spawn-sh "playerctl play-pause"; }
                  Super+F5             allow-when-locked=true { spawn-sh "playerctl play-pause"; }
                  XF86AudioStop        allow-when-locked=true { spawn-sh "playerctl stop"; }
                  Super+F8             allow-when-locked=true { spawn-sh "playerctl stop"; }
                  XF86AudioPrev        allow-when-locked=true { spawn-sh "playerctl previous"; }
                  Super+F6             allow-when-locked=true { spawn-sh "playerctl previous"; }
                  XF86AudioNext        allow-when-locked=true { spawn-sh "playerctl next"; }
                  Super+F7             allow-when-locked=true { spawn-sh "playerctl next"; }

                  XF86MonBrightnessUp allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
                  XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }
              }

              include "dms/outputs.kdl"
              include "dms/colors.kdl"
              include "dms/layout.kdl"
              include "dms/alttab.kdl"
              include "dms/binds.kdl"
              include "dms/wpblur.kdl"
              include "dms/windowrules.kdl"
            '';
        };
      };

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
        ];
        config = {
          common.default = [ "gnome" ];
        };
      };
    }
  ]);
}

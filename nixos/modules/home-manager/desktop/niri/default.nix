{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.modules.desktop.niri;
  settingsBase = import ./settings-base.nix;

  # Create niriOutputSettings from cfg.outputs
  niriOutputSettings = builtins.listToAttrs (
    map (o: {
      name = o.name;
      value = {
        hotCorners = {
          off = true;
        };
        layout = {
          alwaysCenterSingleColumn = true;
        };
      } // (lib.optionalAttrs (o.vrrOnDemand or false) { vrrOnDemand = true; });
    }) cfg.outputs
  )
  # Map VRR to the barScreen name (e.g. "DP-1") if specified
  // builtins.listToAttrs (
    map (o: {
      name = o.barScreen;
      value = { vrrOnDemand = true; };
    }) (filter (o: (o.vrrOnDemand or false) && (o ? barScreen)) cfg.outputs)
  );

  # Final settings merge
  dmsSettings = lib.recursiveUpdate settingsBase ({
    inherit niriOutputSettings;
  } // (lib.optionalAttrs (cfg.customThemeFile != "") { inherit (cfg) customThemeFile; }));

  jsonFormat = pkgs.formats.json { };

  barOutput = builtins.head (filter (o: o ? barScreen) cfg.outputs);

  barScreenData =
    if barOutput != null then
      [
        {
          "name" = barOutput.barScreen;
          "model" = barOutput.barModel or "";
        }
      ]
    else
      [ ];
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
        # swww
        # mpvpaper
        xwayland-satellite
        udiskie
        xdg-desktop-portal-gtk
        kdePackages.dolphin
        kdePackages.kate
        adw-gtk3
        qt6Packages.qt6ct
        kdePackages.qt6ct
      ];

      home.file = {
        ".config/DankMaterialShell/settings.json" = {
          source = jsonFormat.generate "settings.json" dmsSettings;
          force = true;
        };
        ".config/DankMaterialShell/barScreen.json" = {
          source = jsonFormat.generate "barScreen.json" barScreenData;
          force = true;
        };
        ".config/niri/dms/outputs.kdl" = {
          text =
            lib.concatStringsSep "\n" (
              map (o: ''
                output "${o.barScreen or o.name}" {
                    mode "${o.mode}"
                    scale 1
                    position ${o.position}
                    variable-refresh-rate on-demand=true
                }
              '') (filter (o: o.vrrOnDemand or false) cfg.outputs)
            ) + "\n" + lib.concatStringsSep "\n" (
              map (o: ''
                output "${o.barScreen or o.name}" {
                    mode "${o.mode}"
                    scale 1
                    position ${o.position}
                }
              '') (filter (o: !(o.vrrOnDemand or false)) cfg.outputs)
            );
          force = true;
        };
        ".config/niri/config.kdl".text =
          let
            primaryOutput = findFirst (o: o.vrrOnDemand or false) (head cfg.outputs) cfg.outputs;
            primaryName = primaryOutput.barScreen or primaryOutput.name;
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

            layout {
                gaps 16
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
                XDG_CURRENT_DESKTOP "niri"
            }

            hotkey-overlay {
              skip-at-startup
            }

            binds {
                Mod+Shift+Slash { show-hotkey-overlay; }

                Super+V { spawn-sh "dms ipc call clipboard toggle"; }

                Super+grave repeat=false { toggle-overview; }
                Alt+F4 repeat=false { close-window; }

                Super+T { spawn "kitty"; }
                Super+B { spawn "firefox"; }
                Super+E { spawn "dolphin"; }
                Super+Shift+D { spawn "discord"; }
                Super+Ctrl+S { spawn "steam"; }
                Super+Shift+M { spawn "spotify"; }

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

                Super+Left  { focus-column-left; }
                Super+Down  { focus-workspace-down; }
                Super+Up    { focus-workspace-up; }
                Super+Right { focus-column-right; }
                Super+H     { focus-column-left; }
                Super+J     { focus-workspace-down; }
                Super+K     { focus-workspace-up; }
                Super+L     { focus-column-right; }

                // Focus other monitor
                Ctrl+Super+Left  { focus-monitor-left; }
                Ctrl+Super+Right { focus-monitor-right; }
                Ctrl+Super+H    { focus-monitor-left; }
                Ctrl+Super+L    { focus-monitor-right; }

                Mod+Page_Down { focus-workspace-down; }
                Mod+Page_Up   { focus-workspace-up; }

                Super+Home { focus-column-first; }
                Super+End  { focus-column-last; }

                Super+BracketLeft  { consume-or-expel-window-left; }
                Super+BracketRight { consume-or-expel-window-right; }
                Super+Comma  { consume-window-into-column; }
                Super+Period { expel-window-from-column; }

                Super+Shift+S { screenshot; }
                Print { screenshot; }
                Ctrl+Print { screenshot-screen; }
                Alt+Print { screenshot-window; }

                Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

                Super+Shift+P { power-off-monitors; }

                XF86AudioRaiseVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+"; }
                XF86AudioLowerVolume allow-when-locked=true { spawn-sh "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
                XF86AudioMute        allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
                XF86AudioMicMute     allow-when-locked=true { spawn-sh "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }

                XF86AudioPlay        allow-when-locked=true { spawn-sh "playerctl play-pause"; }
                XF86AudioStop        allow-when-locked=true { spawn-sh "playerctl stop"; }
                XF86AudioPrev        allow-when-locked=true { spawn-sh "playerctl previous"; }
                XF86AudioNext        allow-when-locked=true { spawn-sh "playerctl next"; }

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
    }
  ]);
}

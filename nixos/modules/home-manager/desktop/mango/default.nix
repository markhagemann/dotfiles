{ config, lib, pkgs, ... }:

let
  cfg = config.modules.desktop.mango;
in
{
  options.modules.desktop.mango = {
    enable = lib.mkEnableOption "Enable Mango window manager";
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.mango = {
      enable = true;
      settings = ''
        blur=0
        blur_layer=0
        blur_optimized=1
        border_radius=0
        no_radius_when_single=0
        focused_opacity=1.0
        unfocused_opacity=0.9
        animations=1
        animation_type_open=slide
        animation_type_close=slide
        animation_duration_open=400
        animation_duration_close=800
        no_border_when_single=0
        focus_on_activate=1
        sloppyfocus=1
        cursor_size=24
        repeat_rate=25
        repeat_delay=600
        xkb_rules_layout=us
        tap_to_click=1
        disable_while_typing=1
        borderpx=4
        tagrule=id:1,layout_name:deck
        tagrule=id:2,layout_name:scroller
        tagrule=id:3,layout_name:scroller
        tagrule=id:4,layout_name:scroller
        tagrule=id:5,layout_name:scroller
        tagrule=id:6,layout_name:scroller
        tagrule=id:7,layout_name:scroller
        tagrule=id:8,layout_name:scroller
        tagrule=id:9,layout_name:scroller

        exec-once=${config.home.homeDirectory}/.config/mango/autostart.sh
      '';

      autostart_sh = ''
        ${lib.getExe' pkgs.systemd "systemctl"} --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        ${lib.getExe' pkgs.systemd "systemctl"} --user reset-failed
        ${lib.getExe' pkgs.systemd "systemctl"} --user start mango-session.target
        dms session start
      '';

      systemd.xdgAutostart = true;
    };
  };
}
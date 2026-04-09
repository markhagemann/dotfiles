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
        # Window effect
        blur=0
        blur_layer=0
        blur_optimized=1

        border_radius=0
        no_radius_when_single=0
        focused_opacity=1.0
        unfocused_opacity=0.9

        # Animation Configuration(support type:zoom,slide)
        animations=1
        animation_type_open=slide
        animation_type_close=slide
        animation_duration_open=400
        animation_duration_close=800

        # Misc
        no_border_when_single=0
        focus_on_activate=1
        sloppyfocus=1
        cursor_size=24

        # keyboard
        repeat_rate=25
        repeat_delay=600
        xkb_rules_layout=us

        # Trackpad
        tap_to_click=1
        disable_while_typing=1

        # Appearance
        borderpx=4

        # layout support: tile, scroller, grid, deck, monocle, center_tile, vertical_tile
        tagrule=id:1,layout_name:deck
        tagrule=id:2,layout_name:scroller
        tagrule=id:3,layout_name:scroller
        tagrule=id:4,layout_name:scroller
        tagrule=id:5,layout_name:scroller
        tagrule=id:6,layout_name:scroller
        tagrule=id:7,layout_name:scroller
        tagrule=id:8,layout_name:scroller
        tagrule=id:9,layout_name:scroller

        # reload config
        bind=SUPER,r,reload_config

        # DMS keybinds (Temporarily disabled for syntax debugging)
        # bind=SUPER,v,spawn,dms ipc call clipboard toggle
        # bind=NONE,CTRL+ALT+SHIFT+p,spawn,power-off-monitors
        # bind=CTRL+ALT+l,spawn,dms ipc call lock lock

        # menu and terminal (Temporarily disabled for syntax debugging)
        # bind=SUPER,Tab,spawn,dms ipc call spotlight toggle
        # bind=SUPER,t,spawn,kitty
        # bind=SUPER,b,spawn,firefox
        # bind=SUPER,e,spawn,dolphin
        # bind=SUPER+SHIFT+d,spawn,discord
        # bind=SUPER+CTRL,s,spawn,steam
        # bind=SUPER+SHIFT,m,spawn,spotify

        # window controls
        bind=ALT,F4,killclient
        bind=SUPER,q,killclient
        bind=SUPER,f,togglefullscreen
        bind=SUPER+SHIFT,f,togglefakefullscreen
        bind=SUPER,w,togglefloating
        # bind=SUPER,m,maximize
        bind=ALT,a,togglemaximizescreen

        # exit
        bind=SUPER+SHIFT,m,quit

        # switch window focus
        bind=ALT,Left,focusdir,left
        bind=ALT,Right,focusdir,right
        bind=ALT,Up,focusdir,up
        bind=ALT,Down,focusdir,down
        bind=SUPER,h,focusdir,left
        bind=SUPER,l,focusdir,right
        bind=SUPER,j,focusdir,down
        bind=SUPER,k,focusdir,up

        # switch window status
        bind=SUPER,g,toggleglobal,
        bind=ALT,Tab,toggleoverview,
        bind=ALT,backslash,togglefloating,
        bind=SUPER,o,toggleoverlay,

        # switch layout
        bind=SUPER,n,switch_layout

        # tag switch (workspaces: terminal, gaming, browser, discord, spotify)
        bind=SUPER,1,view,1,0
        bind=SUPER,2,view,2,0
        bind=SUPER,3,view,3,0
        bind=SUPER,4,view,4,0
        bind=SUPER,5,view,5,0
        bind=SUPER,6,view,6,0
        bind=SUPER,7,view,7,0
        bind=SUPER,8,view,8,0
        bind=SUPER,9,view,9,0

        # tag: move client to the tag and focus it
        bind=SUPER+SHIFT,1,tag,1,0
        bind=SUPER+SHIFT,2,tag,2,0
        bind=SUPER+SHIFT,3,tag,3,0
        bind=SUPER+SHIFT,4,tag,4,0
        bind=SUPER+SHIFT,5,tag,5,0
        bind=SUPER+SHIFT,6,tag,6,0
        bind=SUPER+SHIFT,7,tag,7,0
        bind=SUPER+SHIFT,8,tag,8,0
        bind=SUPER+SHIFT,9,tag,9,0

        # move window
        # bind=SUPER+SHIFT,Left,tagtoleft
        # bind=SUPER+SHIFT,Right,tagtoright
        # bind=SUPER+SHIFT,Up,tagtodown
        # bind=SUPER+SHIFT,Down,tagtoup
        bind=SUPER+SHIFT,j,movewin,0,50
        bind=SUPER+SHIFT,k,movewin,0,-50
        bind=SUPER+SHIFT,h,movewin,-50,0
        bind=SUPER+SHIFT,l,movewin,50,0

        # monitor switch
        bind=alt+shift,Left,focusmon,left
        bind=alt+shift,Right,focusmon,right

        # screenshot (Temporarily disabled for syntax debugging)
        # bind=SUPER+SHIFT,s,spawn,${config.home.homeDirectory}/.local/bin/screenshot.sh
        # bind=ALT+SHIFT,s,spawn,${config.home.homeDirectory}/.local/bin/screenshot-window.sh

        # media controls (Temporarily disabled for syntax debugging)
        # bind=SUPER+F5,spawn,${config.home.homeDirectory}/.local/bin/playerctl-play-pause.sh
        # bind=SUPER+F6,spawn,${config.home.homeDirectory}/.local/bin/playerctl-previous.sh
        # bind=SUPER+F7,spawn,${config.home.homeDirectory}/.local/bin/playerctl-next.sh
        # bind=SUPER+F8,spawn,${config.home.homeDirectory}/.local/bin/playerctl-stop.sh
        # bind=NONE,XF86AudioRaiseVolume,spawn,${config.home.homeDirectory}/.local/bin/wpctl-volume-up.sh
        # bind=NONE,XF86AudioLowerVolume,spawn,${config.home.homeDirectory}/.local/bin/wpctl-volume-down.sh
        # bind=NONE,XF86AudioMute,spawn,${config.home.homeDirectory}/.local/bin/wpctl-mute-sink.sh
        # bind=NONE,XF86AudioPlay,spawn,${config.home.homeDirectory}/.local/bin/playerctl-play-pause.sh
        # bind=NONE,XF86AudioNext,spawn,${config.home.homeDirectory}/.local/bin/playerctl-next.sh
        # bind=NONE,XF86AudioPrev,spawn,${config.home.homeDirectory}/.local/bin/playerctl-previous.sh

        # brightness (Temporarily disabled for syntax debugging)
        # bind=NONE,XF86MonBrightnessUp,spawn,${config.home.homeDirectory}/.local/bin/brightness-up.sh
        # bind=NONE,XF86MonBrightnessDown,spawn,${config.home.homeDirectory}/.local/bin/brightness-down.sh

        # Mouse Button Bindings
        mousebind=SUPER,btn_left,moveresize,curmove
        mousebind=SUPER,btn_right,moveresize,curresize

        exec-once=${config.home.homeDirectory}/.config/mango/autostart.sh
      '';

      autostart_sh = ''
        ${lib.getExe pkgs.systemd}/bin/systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
        ${lib.getExe pkgs.systemd}/bin/systemctl --user reset-failed
        ${lib.getExe pkgs.systemd}/bin/systemctl --user start mango-session.target
        dms session start
      '';

      systemd.xdgAutostart = true;
    };
  };
}

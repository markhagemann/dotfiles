{
  config,
  lib,
  pkgs,
  osConfig ? null,
  ...
}:

let
  cfg = config.modules.desktop.mango;

  # Helper to parse "2560x1440@240" into { width, height, refresh }
  parseMode =
    mode:
    let
      parts = builtins.split "@" mode;
      res = builtins.split "x" (builtins.elemAt parts 0);
    in
    {
      width = builtins.elemAt res 0;
      height = builtins.elemAt res 2;
      refresh = builtins.elemAt parts 2;
    };

  # Helper to parse "x=2560 y=0" into { x, y }
  parsePosition =
    pos:
    let
      parts = builtins.split " " pos;
      xPart = builtins.split "=" (builtins.elemAt parts 0);
      yPart = builtins.split "=" (builtins.elemAt parts 2);
    in
    {
      x = builtins.elemAt xPart 2;
      y = builtins.elemAt yPart 2;
    };

  monitorRules = lib.concatMapStringsSep "\n        " (
    m:
    let
      mode = parseMode m.mode;
      pos = parsePosition m.position;
      name = m.identifier;
      # Don't want to use VRR until it can be enabled on demand in certain windows
      # vrr = if (m.vrrOnDemand or false) then "1" else "0";
      vrr = if (m.vrrOnDemand or false) then "0" else "0";
    in
    "monitorrule=name:^${name}$,width:${mode.width},height:${mode.height},refresh:${mode.refresh},x:${pos.x},y:${pos.y},vrr:${vrr}"
  ) cfg.outputs;

in
{
  options.modules.desktop.mango = {
    enable = lib.mkEnableOption "Enable Mango window manager";
    outputs = lib.mkOption {
      type = lib.types.listOf (lib.types.attrsOf lib.types.anything);
      default = [ ];
      description = "List of output configurations for mango";
    };
  };

  config = lib.mkIf cfg.enable {
    wayland.windowManager.mango = {
      enable = true;
      settings = ''
        env=XDG_CURRENT_DESKTOP,mango
        env=XDG_SESSION_TYPE,wayland
        env=XCURSOR_THEME,Bibata-Modern-Ice

        ${monitorRules}

        # Window effect
        blur=0
        blur_layer=0
        blur_optimized=1
        blur_params_num_passes = 2
        blur_params_radius = 5
        blur_params_noise = 0.02
        blur_params_brightness = 0.9
        blur_params_contrast = 0.9
        blur_params_saturation = 1.2

        shadows = 0
        layer_shadows = 0
        shadow_only_floating = 1
        shadows_size = 10
        shadows_blur = 15
        shadows_position_x = 0
        shadows_position_y = 0
        shadowscolor= 0x000000ff

        border_radius=0
        no_radius_when_single=0
        focused_opacity=1.0
        unfocused_opacity=0.9

        # Animation Configuration(support type:zoom,slide)
        # tag_animation_direction: 1-horizontal,0-vertical
        animations=1
        layer_animations=1
        animation_type_open=slide
        animation_type_close=slide
        animation_fade_in=1
        animation_fade_out=1
        tag_animation_direction=1
        zoom_initial_ratio=0.3
        zoom_end_ratio=0.8
        fadein_begin_opacity=0.5
        fadeout_begin_opacity=0.8
        animation_duration_move=500
        animation_duration_open=400
        animation_duration_tag=350
        animation_duration_close=800
        animation_duration_focus=0
        animation_curve_open=0.46,1.0,0.29,1
        animation_curve_move=0.46,1.0,0.29,1
        animation_curve_tag=0.46,1.0,0.29,1
        animation_curve_close=0.08,0.92,0,1
        animation_curve_focus=0.46,1.0,0.29,1
        animation_curve_opafadeout=0.5,0.5,0.5,0.5
        animation_curve_opafadein=0.46,1.0,0.29,1

        # Scroller Layout Setting
        scroller_structs=0
        scroller_default_proportion=0.5
        scroller_focus_center=0
        scroller_prefer_center=0
        edge_scroller_pointer_focus=1
        scroller_default_proportion_single=1.0
        scroller_proportion_preset=0.5,0.8,1.0

        # Master-Stack Layout Setting
        new_is_master=1
        default_mfact=0.55
        default_nmaster=1
        smartgaps=0

        # Overview Setting
        enable_hotarea=0
        ov_tab_mode=0
        overviewgappi=5
        overviewgappo=30

        # Misc
        no_border_when_single=0
        axis_bind_apply_timeout=100
        focus_on_activate=1
        idleinhibit_ignore_visible=0
        sloppyfocus=1
        warpcursor=1
        focus_cross_monitor=0
        focus_cross_tag=0
        enable_floating_snap=0
        snap_distance=30
        cursor_size=24
        drag_tile_to_tile=1

        # keyboard
        repeat_rate=25
        repeat_delay=600
        numlockon=0
        xkb_rules_layout=us

        # Trackpad
        # need relogin to make it apply
        disable_trackpad=0
        tap_to_click=1
        tap_and_drag=1
        drag_lock=1
        trackpad_natural_scrolling=0
        disable_while_typing=1
        left_handed=0
        middle_button_emulation=0
        swipe_min_threshold=1

        # mouse
        # need relogin to make it apply
        mouse_natural_scrolling=0

        # Appearance
        gappih=3
        gappiv=3
        gappoh=0
        gappov=0
        scratchpad_width_ratio=0.8
        scratchpad_height_ratio=0.9
        borderpx=4

        # reload config
        bind=CTRL+ALT+SUPER,r,reload_config

        # menu and terminal
        bind=CTRL+ALT,l,spawn,dms ipc call lock lock
        bind=SUPER+SHIFT,S,spawn,dms screenshot
        bind=SUPER,F12,spawn,dms screenshot full
        bind=SUPER,F1,spawn,dms ipc call keybinds toggle mangowc
        bind=SUPER,space,spawn,dms ipc call spotlight toggle
        bind=SUPER,v,spawn,dms ipc call clipboard toggle
        bind=SUPER,t,spawn,~/.local/bin/raise-cycle-or-spawn mango kitty
        bind=SUPER,b,spawn,~/.local/bin/raise-cycle-or-spawn mango firefox
        bind=SUPER,e,spawn,~/.local/bin/raise-cycle-or-spawn mango dolphin
        bind=SUPER,m,spawn,~/.local/bin/raise-cycle-or-spawn mango spotify
        bind=CTRL+SUPER,s,spawn,~/.local/bin/raise-cycle-or-spawn mango steam
        bind=SUPER+SHIFT,d,spawn,~/.local/bin/raise-cycle-or-spawn mango discord

        # exit
        bind=CTRL+SUPER+ALT,q,quit
        bind=SUPER,q,killclient,
        bind=ALT,f4,killclient,

        # switch window focus
        bind=SUPER,Tab,focusstack,next
        bind=ALT,Left,focusdir,left
        bind=ALT,Right,focusdir,right
        bind=ALT,Up,focusdir,up
        bind=ALT,Down,focusdir,down

        # swap window
        bind=SUPER+SHIFT,J,exchange_client,up
        bind=SUPER+SHIFT,K,exchange_client,down
        bind=SUPER+SHIFT,H,exchange_client,left
        bind=SUPER+SHIFT,L,exchange_client,right

        # switch window status
        bind=SUPER,g,toggleglobal,
        bind=ALT,grave,toggleoverview,
        bind=SUPER,w,togglefloating,
        bind=SUPER+SHIFT,m,togglemaximizescreen,
        bind=SUPER,f,togglefullscreen,
        bind=SUPER+SHIFT,f,togglefakefullscreen,
        bind=SUPER,h,minimized,
        bind=SUPER,o,toggleoverlay,
        bind=SUPER+SHIFT,I,restore_minimized
        bind=ALT,z,toggle_scratchpad

        # scroller layout
        bind=ALT,e,set_proportion,1.0
        bind=ALT,x,switch_proportion_preset,

        # switch layout
        bind=SUPER,n,switch_layout

        # tag switch
        bind=SUPER,H,viewtoleft,0
        bind=CTRL+SHIFT,H,viewtoleft_have_client,0
        bind=SUPER,L,viewtoright,0
        bind=CTRL+SHIFT,L,viewtoright_have_client,0
        bind=CTRL+SHIFT+SUPER,H,tagtoleft,0
        bind=CTRL+SHIFT+SUPER,L,tagtoright,0

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
        # tagsilent: move client to the tag and not focus it
        # bind=Alt,1,tagsilent,1
        bind=SUPER+SHIFT,1,tag,1,0
        bind=SUPER+SHIFT,2,tag,2,0
        bind=SUPER+SHIFT,3,tag,3,0
        bind=SUPER+SHIFT,4,tag,4,0
        bind=SUPER+SHIFT,5,tag,5,0
        bind=SUPER+SHIFT,6,tag,6,0
        bind=SUPER+SHIFT,7,tag,7,0
        bind=SUPER+SHIFT,8,tag,8,0
        bind=SUPER+SHIFT,9,tag,9,0

        # monitor switch
        bind=CTRL+SUPER,H,focusmon,left
        bind=CTRL+SUPER,L,focusmon,right
        bind=SUPER+Alt,Left,tagmon,left
        bind=SUPER+Alt,Right,tagmon,right

        # gaps
        bind=ALT+SHIFT,M,incgaps,1
        bind=ALT+SHIFT,N,incgaps,-1
        bind=ALT+SHIFT,G,togglegaps

        # movewin
        bind=CTRL+SHIFT,Up,movewin,+0,-50
        bind=CTRL+SHIFT,Down,movewin,+0,+50
        bind=CTRL+SHIFT,Left,movewin,-50,+0
        bind=CTRL+SHIFT,Right,movewin,+50,+0

        # resizewin
        bind=CTRL+ALT,Up,resizewin,+0,-50
        bind=CTRL+ALT,Down,resizewin,+0,+50
        bind=CTRL+ALT,Left,resizewin,-50,+0
        bind=CTRL+ALT,Right,resizewin,+50,+0

        # Mouse Button Bindings
        # NONE mode key only work in ov mode
        mousebind=SUPER,btn_left,moveresize,curmove
        mousebind=NONE,btn_middle,togglemaximizescreen,0
        mousebind=SUPER,btn_right,moveresize,curresize

        # Axis Bindings
        axisbind=SUPER,UP,viewtoleft_have_client
        axisbind=SUPER,DOWN,viewtoright_have_client

        exec-once=${config.home.homeDirectory}/.config/mango/autostart.sh

        # DMS Setup
        source=~/.config/mango/dms/colors.conf
        source=~/.config/mango/dms/layout.conf
        source=~/.config/mango/dms/outputs.conf
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

{ config, inputs, lib, pkgs, ... }: {
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  # TODO: Setup panels and widgets - see https://github.com/nix-community/plasma-manager/blob/trunk/examples/homeManager/home.nix
  # TODO: Investigate default window rules for "Keep below others"
  # TODO: Try fix wallpaper-engine-plugin otherwise set window slideshow and poitn to backgrounds folder

  home.packages = with pkgs; [
    kde-rounded-corners
    kdePackages.kcalc
    kdePackages.krohnkite
    kdePackages.wallpaper-engine-plugin # TODO: Crashes plasmashell and sometimes ends up immutable
  ];

  programs.plasma = {
    enable = true;

    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      gwenviewrc.ThumbnailView.AutoplayVideos = true;
      kdeglobals = {
        General = { BrowserApplication = "firefox.desktop"; };
        Icons = { Theme = "Vivid-Dark-Icons"; };
        KDE = { AnimationDurationFactor = 0.25; };
      };
      klaunchrc.FeedbackStyle.BusyCursor = false;
      klipperrc.General.MaxClipItems = 1000;
      kwinrc = {
        Effect-overview.BorderActivate = 9;
        Plugins = {
          krohnkiteEnabled = true;
          screenedgeEnabled = false;
        };
        "Effect-translucency" = {
          ComboboxPopups = 99;
          Dialogs = 99;
          DropdownMenus = 99;
          Menus = 99;
          PopupMenus = 99;
          TornOffMenus = 99;
        };
        "Round-Corners" = {
          ActiveOutlinePalette = 14;
          ActiveShadowAlpha = 255;
          ActiveShadowUseCustom = true;
          DisableOutlineTile = false;
          DisableRoundTile = false;
          InactiveCornerRadius = 8;
          InactiveOutlineAlpha = 123;
          InactiveOutlineColor = "67,80,125";
          InactiveSecondOutlineThickness = 0;
          InactiveShadowAlpha = 255;
          InactiveShadowColor = "67,80,125";
          InactiveShadowSize = 25;
          OutlineColor = "67,80,125";
          OutlineThickness = 1.75;
          SecondOutlineThickness = 0;
          ShadowColor = "67,80,125";
          ShadowSize = 25;
          Size = 8;
          UseNativeDecorationShadows = false;
        };
        "Script-krohnkite" = {
          floatingClass =
            "org.kde.kcalc,org.freedesktop.impl.portal.desktop.kde";
          ignoreScreen = "DP-2";
          screenGapBetween = 6;
          screenGapBottom = 6;
          screenGapLeft = 6;
          screenGapRight = 6;
          screenGapTop = 6;
        };
        Windows = {
          DelayFocusInterval = 0;
          # FocusPolicy = "FocusFollowsMouse";
        };
      };
      plasmanotifyrc = {
        DoNotDisturb = {
          WhenFullscreen = false;
          WhenScreenSharing = false;
          WhenScreensMirrored = false;
        };
        Notifications = {
          PopupPosition = "TopRight";
          PopupTimeout = 7000;
        };
      };
      plasmarc.OSD.Enabled = false;
      spectaclerc = {
        Annotations = {
          annotationToolType = 8;
          rectangleStrokeColor = "255,0,0";
        };
        General = {
          launchAction = "DoNotTakeScreenshot";
          showCaptureInstructions = false;
          useReleaseToCapture = true;
        };
        ImageSave.imageCompressionQuality = 100;
      };
    };

    dataFile = {
      "dolphin/view_properties/global/.directory"."Dolphin"."ViewMode" = 1;
      "dolphin/view_properties/global/.directory"."Settings"."HiddenFilesShown" =
        true;
    };

    fonts = {
      fixedWidth = {
        family = "Space Mono";
        pointSize = 10;
      };
      general = {
        family = "Poppins";
        pointSize = 11;
      };
      menu = {
        family = "Poppins";
        pointSize = 11;
      };
      small = {
        family = "Poppins";
        pointSize = 9;
      };
      toolbar = {
        family = "Poppins";
        pointSize = 11;
      };
      windowTitle = {
        family = "Poppins";
        pointSize = 11;
      };
    };

    hotkeys.commands = {
      launch-brave = {
        name = "Launch Browser";
        key = "Meta+Shift+B";
        command = "firefox";
      };
      launch-discord = {
        name = "Launch Discord";
        key = "Meta+Shift+D";
        command = "discord";
      };
      launch-kitty = {
        name = "Launch Kitty";
        key = "Meta+Shift+T";
        command = "kitty";
      };
      launch-krunner = {
        name = "Launch KRunner";
        key = "Meta+Space";
        command = "krunner";
      };
      launch-spotify = {
        name = "Launch Spotify Music";
        key = "Meta+Shift+M";
        command = "spotify";
      };
      screenshot-region = {
        name = "Capture a rectangular region of the screen";
        key = "Meta+Shift+S";
        command = "spectacle --region --nonotify";
      };
      screenshot-screen = {
        name = "Capture the entire desktop";
        key = "Meta+Ctrl+S";
        command = "spectacle --fullscreen --nonotify";
      };
    };

    input = {
      keyboard = {
        repeatDelay = 250;
        repeatRate = 25;
      };
      mice = [
        {
          accelerationProfile = "none";
          name = "       AJAZZ 2.4G 8K";
          productId = "402d";
          vendorId = "3151";
        }
        {
          accelerationProfile = "none";
          name = "Compx Ninjutso Sora 4K";
          productId = "f51b";
          vendorId = "3554";
        }
      ];
    };

    krunner.activateWhenTypingOnDesktop = false;
    krunner.position = "center";

    kwin = {
      effects = {
        blur = {
          enable = true;
          strength = 2;
        };
        cube.enable = false;
        desktopSwitching.animation = "off";
        dimAdminMode.enable = false;
        dimInactive.enable = false;
        fallApart.enable = false;
        fps.enable = false;
        minimization.animation = "off";
        shakeCursor.enable = false;
        slideBack.enable = false;
        snapHelper.enable = false;
        translucency.enable = true;
        windowOpenClose.animation = "off";
        wobblyWindows.enable = false;
      };

      # nightLight = {
      #   enable = true;
      #   location.latitude = "27.47";
      #   location.longitude = "153.02";
      #   mode = "location";
      #   temperature.night = 4000;
      # };

      virtualDesktops = {
        number = 5;
        rows = 1;
      };
    };

    # Until I am confident I can set every setting then this should remain false
    overrideConfig = false;

    session = {
      general.askForConfirmationOnLogout = false;
      sessionRestore.restoreOpenApplicationsOnLogin = "startWithEmptySession";
    };

    shortcuts = {
      ksmserver = {
        "Lock Session" = [ "Screensaver" "Ctrl+Alt+L" ];
        "LogOut" = [ "Ctrl+Alt+Q" ];
      };

      kwin = {
        "KrohnkiteMonocleLayout" = [ ];
        "Overview" = "Meta+`";
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Window to Desktop 1" = "Meta+!";
        "Window to Desktop 2" = "Meta+@";
        "Window to Desktop 3" = "Meta+#";
        "Window to Desktop 4" = "Meta+$";
        "Window to Desktop 5" = "Meta+%";
        "Window Fullscreen" = "Alt+Return";
        "Window Move Center" = "Ctrl+Alt+C";
      };

      plasmashell = { "show-on-mouse-pos" = ""; };

      "services/org.kde.dolphin.desktop"."_launch" = "Meta+Shift+F";
    };

    spectacle = {
      shortcuts = {
        captureEntireDesktop = "";
        captureRectangularRegion = "";
        launch = "";
        recordRegion = "Meta+Shift+R";
        recordScreen = "Meta+Ctrl+R";
        recordWindow = "";
      };
    };

    workspace = {
      clickItemTo = "select";
      colorScheme = "VividCustom";
      cursor.theme = "Bibata-Modern-Ice";
      enableMiddleClickPaste = false;
      lookAndFeel = "Vivid-Dark-Global-6";
      tooltipDelay = 1;
    };
  };
}


{ config, inputs, lib, pkgs, ... }: {
  imports = [ inputs.plasma-manager.homeManagerModules.plasma-manager ];

  home.packages = with pkgs; [
    kde-rounded-corners
    kdePackages.kcalc
    kdePackages.krohnkite
    # kdePackages.wallpaper-engine-plugin # TODO: Crashes plasmashell and sometimes ends up immutable
    kdotool
  ];

  programs.plasma = {
    enable = true;

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
        pointSize = 8;
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
      launch-albert = {
        name = "Launch albert";
        key = "Meta+Space";
        command = "albert toggle";
      };
      launch-brave = {
        name = "Launch Browser";
        key = "Meta+Shift+B";
        command = "firefox";
      };
      launch-kitty = {
        name = "Launch Kitty";
        key = "Meta+Shift+Return";
        command = "kitty";
      };
      move-window-and-focus-to-desktop-1 = {
        name = "Move Window and Focus to Desktop 1";
        key = "Meta+!";
        command = "kde_mv_window 1";
      };
      move-window-and-focus-to-desktop-2 = {
        name = "Move Window and Focus to Desktop 2";
        key = "Meta+@";
        command = "kde_mv_window 2";
      };
      move-window-and-focus-to-desktop-3 = {
        name = "Move Window and Focus to Desktop 3";
        key = "Meta+#";
        command = "kde_mv_window 3";
      };
      move-window-and-focus-to-desktop-4 = {
        name = "Move Window and Focus to Desktop 4";
        key = "Meta+$";
        command = "kde_mv_window 4";
      };
      move-window-and-focus-to-desktop-5 = {
        name = "Move Window and Focus to Desktop 5";
        key = "Meta+%";
        command = "kde_mv_window 5";
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
      show-all-applications = {
        name = "Show all applications in Albert";
        key = "Meta+A";
        command = ''albert show "apps "'';
      };
    };

    input = {
      mice = [
        {
          accelerationProfile = "none";
          name = "AJAZZ 2.4G 8K";
          productId = "3151";
          vendorId = "402d";
        }
        {
          accelerationProfile = "none";
          name = "Compx Ninjutso Sora 4K";
          productId = "3554";
          vendorId = "f51b";
        }
      ];
    };

    krunner.activateWhenTypingOnDesktop = false;

    kwin = {
      effects = {
        blur.enable = false;
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
        translucency.enable = false;
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

    overrideConfig = true;

    panels = [
      {
        alignment = "left";
        height = 30;
        lengthMode = "fit";
        location = "top";
        opacity = "translucent";
        widgets = [{
          name = "org.dhruv8sh.kara";
          config = {
            general = {
              animationDuration = 0;
              highlightType = 1;
              spacing = 3;
              type = 1;
            };
            type1 = {
              fixedLen = 3;
              labelSource = 0;
            };
          };
        }];
      }
      {
        alignment = "center";
        height = 30;
        lengthMode = "fit";
        location = "top";
        opacity = "translucent";
        widgets = [{
          name = "org.kde.plasma.digitalclock";
          config = {
            Appearance = {
              autoFontAndSize = false;
              customDateFormat = "ddd MMM d";
              dateDisplayFormat = "BesideTime";
              dateFormat = "custom";
              fontSize = 11;
              fontStyleName = "Regular";
              fontWeight = 400;
              use24hFormat = 2;
            };
          };
        }];
      }
      {
        alignment = "right";
        height = 30;
        lengthMode = "fit";
        location = "top";
        opacity = "translucent";
        widgets = [{
          systemTray = {
            icons.scaleToFit = true;
            items = {
              showAll = false;
              shown = [
                "org.kde.plasma.keyboardlayout"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.volume"
              ];
              hidden = [
                "org.kde.plasma.battery"
                "org.kde.plasma.brightness"
                "org.kde.plasma.clipboard"
                "org.kde.plasma.devicenotifier"
                "org.kde.plasma.mediacontroller"
                "plasmashell_microphone"
                "xdg-desktop-portal-kde"
                "zoom"
              ];
              configs = {
                "org.kde.plasma.notifications".config = {
                  Shortcuts = { global = "Meta+N"; };
                };
              };
            };
          };
        }];
      }
    ];

    # powerdevil = {
    #   AC = {
    #     autoSuspend.action = "nothing";
    #     dimDisplay.enable = false;
    #     powerButtonAction = "shutDown";
    #     turnOffDisplay.idleTimeout = "never";
    #   };
    #   battery = {
    #     autoSuspend.action = "nothing";
    #     dimDisplay.enable = false;
    #     powerButtonAction = "shutDown";
    #     turnOffDisplay.idleTimeout = "never";
    #   };
    # };

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
        "Switch to Desktop 1" = "Meta+1";
        "Switch to Desktop 2" = "Meta+2";
        "Switch to Desktop 3" = "Meta+3";
        "Switch to Desktop 4" = "Meta+4";
        "Switch to Desktop 5" = "Meta+5";
        "Switch to Desktop 6" = "Meta+6";
        "Switch to Desktop 7" = "Meta+7";
        "Window Close" = "Meta+Q";
        "Window Fullscreen" = "Meta+M";
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

    # window-rules = [
    #   {
    #     apply = {
    #       noborder = {
    #         value = true;
    #         apply = "initially";
    #       };
    #     };
    #     description = "Hide titlebar by default";
    #     match = {
    #       window-class = {
    #         value = ".*";
    #         type = "regex";
    #       };
    #     };
    #   }
    #   {
    #     apply = {
    #       desktops = "Desktop_1";
    #       desktopsrule = "3";
    #     };
    #     description = "Assign Brave to Desktop 1";
    #     match = {
    #       window-class = {
    #         value = "brave-browser";
    #         type = "substring";
    #       };
    #       window-types = [ "normal" ];
    #     };
    #   }
    #   {
    #     apply = {
    #       desktops = "Desktop_2";
    #       desktopsrule = "3";
    #     };
    #     description = "Assign Alacritty to Desktop 2";
    #     match = {
    #       window-class = {
    #         value = "Alacritty";
    #         type = "substring";
    #       };
    #       window-types = [ "normal" ];
    #     };
    #   }
    #   {
    #     apply = {
    #       desktops = "Desktop_3";
    #       desktopsrule = "3";
    #     };
    #     description = "Assign Telegram to Desktop 3";
    #     match = {
    #       window-class = {
    #         value = "org.telegram.desktop";
    #         type = "substring";
    #       };
    #       window-types = [ "normal" ];
    #     };
    #   }
    #   {
    #     apply = {
    #       desktops = "Desktop_4";
    #       desktopsrule = "3";
    #     };
    #     description = "Assign OBS to Desktop 4";
    #     match = {
    #       window-class = {
    #         value = "com.obsproject.Studio";
    #         type = "substring";
    #       };
    #       window-types = [ "normal" ];
    #     };
    #   }
    #   {
    #     apply = {
    #       desktops = "Desktop_4";
    #       desktopsrule = "3";
    #       fsplevel = "4";
    #       fsplevelrule = "2";
    #       minimizerule = "2";
    #     };
    #     description = "Assign Steam to Desktop 4";
    #     match = {
    #       window-class = {
    #         value = "steam";
    #         type = "exact";
    #         match-whole = false;
    #       };
    #       window-types = [ "normal" ];
    #     };
    #   }
    #   {
    #     apply = {
    #       desktops = "Desktop_5";
    #       desktopsrule = "3";
    #       fsplevel = "4";
    #       fsplevelrule = "2";
    #     };
    #     description = "Assign Steam Games to Desktop 5";
    #     match = {
    #       window-class = {
    #         value = "steam_app_";
    #         type = "substring";
    #         match-whole = false;
    #       };
    #     };
    #   }
    #   {
    #     apply = {
    #       desktops = "Desktop_5";
    #       desktopsrule = "3";
    #       fsplevel = "4";
    #       fsplevelrule = "2";
    #       minimizerule = "2";
    #     };
    #     description = "Assign Zoom to Desktop 5";
    #     match = {
    #       window-class = {
    #         value = "zoom";
    #         type = "substring";
    #       };
    #       window-types = [ "normal" ];
    #     };
    #   }
    # ];

    workspace = {
      enableMiddleClickPaste = false;
      clickItemTo = "select";
      colorScheme = "CatppuccinMacchiatoLavender";
      cursor.theme = "Yaru";
      splashScreen.engine = "none";
      splashScreen.theme = "none";
      tooltipDelay = 1;
    };

    configFile = {
      baloofilerc."Basic Settings"."Indexing-Enabled" = false;
      gwenviewrc.ThumbnailView.AutoplayVideos = true;
      kdeglobals = {
        General = { BrowserApplication = "firefox-browser.desktop"; };
        Icons = { Theme = "Tela-circle-dark"; };
        KDE = { AnimationDurationFactor = 0; };
      };
      klaunchrc.FeedbackStyle.BusyCursor = false;
      klipperrc.General.MaxClipItems = 1000;
      kwinrc = {
        Effect-overview.BorderActivate = 9;
        Plugins = {
          krohnkiteEnabled = true;
          screenedgeEnabled = false;
        };
        "Round-Corners" = {
          ActiveOutlineAlpha = 255;
          ActiveOutlineUseCustom = false;
          ActiveOutlineUsePalette = true;
          DisableOutlineTile = false;
          DisableRoundTile = false;
          InactiveCornerRadius = 8;
          InactiveOutlineAlpha = 0;
          InactiveSecondOutlineThickness = 0;
          OutlineThickness = 1;
          SecondOutlineThickness = 0;
          Size = 8;
        };
        "Script-krohnkite" = {
          floatingClass =
            "org.kde.kcalc,org.freedesktop.impl.portal.desktop.kde";
          screenGapBetween = 6;
          screenGapBottom = 6;
          screenGapLeft = 6;
          screenGapRight = 6;
          screenGapTop = 6;
        };
        Windows = {
          DelayFocusInterval = 0;
          FocusPolicy = "FocusFollowsMouse";
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

    startup.startupScript = {
      albert = {
        text = "albert";
        priority = 8;
        runAlways = true;
      };
    };
  };
}

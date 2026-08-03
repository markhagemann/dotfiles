{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

with lib;

let
  cfg = config.modules.desktop.dms;
in
{
  options.modules.desktop.dms = {
    enable = lib.mkEnableOption "Enable DankMaterialShell (DMS)";
  };

  config = mkIf cfg.enable {
    programs.dms-shell = {
      enable = true;
      package = mkDefault inputs.dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
      systemd = {
        enable = true;
        restartIfChanged = true;
      };

      enableSystemMonitoring = true;
      enableVPN = true;
      enableDynamicTheming = true;
      enableAudioWavelength = true;
      enableCalendarEvents = true;
      enableClipboardPaste = true;
    };

    users.groups.greeter = { };
  };
}
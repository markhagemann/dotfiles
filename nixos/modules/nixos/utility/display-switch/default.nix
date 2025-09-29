# Taken from: https://www.monotux.tech/posts/2023/05/nixos-overlay/
{ config, pkgs, ... }: {
  boot.kernelModules = [ "i2c_dev" ]; # i2c_dev for DDC support (/dev/i2c-*)

  # DDC support (/dev/i2c-*)
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", TAG+="uaccess"
  '';

  # TODO: Make this configurable
  systemd.services.display-switch = let
    display-switch-config = pkgs.runCommand "display-switch-config" {
      # The configuration file for display-switch, works like on all other
      # platforms
      config = pkgs.writeText "display-switch.ini" ''
        usb_device = "05e3:0610"
        on_usb_connect = "0x0f"
        on_usb_disconnect = "0x13"
        on_usb_connect_execute = "echo DisplayPort1 activated"
        on_usb_disconnect_execute = "echo DisplayPort2 activated"
      '';
    } ''
      mkdir -p "$out/display-switch"
      cp "$config" "$out/display-switch/display-switch.ini"
    '';
  in {
    description = "USB-triggered display switch";
    environment = { XDG_CONFIG_HOME = "${display-switch-config}"; };
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.display-switch}/bin/display_switch";
    };
    wantedBy = [ "default.target" ];
  };
}

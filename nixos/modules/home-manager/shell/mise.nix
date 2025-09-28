{ options, config, lib, pkgs, inputs, ... }:
with lib;
let cfg = config.modules.shell.mise;
in {
  options.modules.shell.mise.enable =
    lib.mkEnableOption "Enable the mise module";

  config = mkIf cfg.enable {

    programs.mise = {
      enable = true;
      enableZshIntegration = true;

      settings = {
        experimental = true;
        verbose = false;
        auto_install = true;
      };
    };

    home.file.".config/mise/setup.sh".text = ''
      ${pkgs.mise}/bin/mise set MISE_NODE_COREPACK=true
      ${pkgs.mise}/bin/mise settings add idiomatic_version_file_enable_tools "[]"
    '';

    programs.zsh.initExtra = ''
      source ~/.config/mise/setup.sh
    '';
  };
}

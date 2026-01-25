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

      globalConfig = {
        settings = {
          all_compile = false;
          auto_install = true;
          experimental = true;
          verbose = false;
        };

        tools = {
          node = "24";
          python = "3.14";
          lua = "5.1";
          go = "1.25";
          golangci-lint = "2.8.0";
        };
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

{ inputs, ... }:

{

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;

  # Per-user HM config
  home-manager.users.mark = { pkgs, ... }: {
    home.stateVersion = "25.05";
    home.enableNixpkgsReleaseCheck = false;

    programs.quickshell.enable = true;

    # DMS & Niri HM modules
    imports = [
      inputs.dms.homeModules.dankMaterialShell.default
      inputs.niri-flake.homeModules.niri
      inputs.dms.homeModules.dankMaterialShell.niri
    ];

    # Enable DMS
    programs.dankMaterialShell.enable = true;

    # DMS deps
    home.packages = with pkgs; [
      matugen
      cliphist
      brightnessctl
      gammastep
      kdePackages.qtmultimedia
    ];

    # Environment
    home.file.".config/environment.d/20-qt-qml.conf".text = ''
      QML_IMPORT_PATH=${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml:${pkgs.kdePackages.qtsvg}/lib/qt-6/qml:${pkgs.kdePackages.qtimageformats}/lib/qt-6/qml:${pkgs.kdePackages.qt5compat}/lib/qt-6/qml
      QML2_IMPORT_PATH=${pkgs.kdePackages.qtmultimedia}/lib/qt-6/qml:${pkgs.kdePackages.qtsvg}/lib/qt-6/qml:${pkgs.kdePackages.qtimageformats}/lib/qt-6/qml:${pkgs.kdePackages.qt5compat}/lib/qt-6/qml
      QT_PLUGIN_PATH=${pkgs.kdePackages.qtimageformats}/lib/qt-6/plugins:${pkgs.kdePackages.qtsvg}/lib/qt-6/plugins:${pkgs.kdePackages.qtmultimedia}/lib/qt-6/plugins:${pkgs.kdePackages.qt5compat}/lib/qt-6/plugins
    '';
  };
}

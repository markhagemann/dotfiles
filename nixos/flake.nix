{
  description = "Minimal flake for NixOS with Home Manager modules";
  inputs = {
    # dms is pinned to 069df80 (2026-07-18) because that was the last rev that still
    # ships the Greetd module (Modules/Greetd) used by services.displayManager.dms-greeter.
    # On 2026-07-19 the greeter was migrated to github:AvengeMedia/dank-greeter, so newer
    # dms revs crash greetd on boot (missing ${pkg}/share/quickshell/dms/Modules/Greetd/...).
    #
    # To use a non-pinned (latest) version instead:
    #   1. Change the url below to: url = "github:AvengeMedia/DankMaterialShell/stable";   (or drop the "/rev" for master/-git)
    #   2. Update the lockfile:  nix flake lock --update-input dms
    #   3. If greetd then fails to boot, you'll need to migrate to the dank-greeter flake
    #      (github:AvengeMedia/dank-greeter) and switch services.displayManager.dms-greeter
    #      to programs.dms-greeter (import inputs.dank-greeter.nixosModules.default).
    dms = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AvengeMedia/DankMaterialShell/069df80b22996adaff5d2f1afa96fa8d50d7a1f6";
    };
    dms-plugin-registry = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AvengeMedia/dms-plugin-registry";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/master";
    };
    kwin-effects-glass = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:4v3ngR/kwin-effects-glass";
    };
    lsfg-vk-flake = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:pabloaul/lsfg-vk-flake/main";
    };
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=v0.6.0";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    plasma-manager.url = "github:AlexNabokikh/plasma-manager";
    quickshell-git = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+https://git.outfoxxed.me/quickshell/quickshell?rev=6eb12551baf924f8fdecdd04113863a754259c34";
    };
    # dolphin-overlay = {
    #   url = "github:rumboon/dolphin-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    textfox.url = "github:adriankarlen/textfox";
    dgop.url = "github:AvengeMedia/dgop";
    dgop.inputs.nixpkgs.follows = "nixpkgs";
    gsr-ui-nix = {
      url = "github:rPlakama/gsr-ui-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      nur,
      lsfg-vk-flake,
      nixos-hardware,
      textfox,
      home-manager,
      nix-flatpak,
      nix-cachyos-kernel,
      ...
    }:
    let
      system = "x86_64-linux";
      overlays = [ (import ./overlays/pkgs.nix) ];
      # Create a properly configured pkgs instance
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = overlays ++ [
          (final: prev: {
            pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
              (pyFinal: pyPrev: {
                picosvg = pyPrev.picosvg.overrideAttrs (_: {
                  doCheck = false;
                });
              })
            ];
          })
        ];
      };
    in
    {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            nur.modules.nixos.default
            lsfg-vk-flake.nixosModules.default
            nix-flatpak.nixosModules.nix-flatpak
            inputs.dms.nixosModules.default
            inputs.dms-plugin-registry.nixosModules.default
            inputs.gsr-ui-nix.nixosModules.default
            ./hosts/default.nix
            ./hosts/desktop
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [
                nix-cachyos-kernel.overlays.pinned
                inputs.niri-flake.overlays.niri
                # inputs.dolphin-overlay.overlays.default
              ];
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              # home-manager.backupFileExtension = "backup";
              home-manager.users.mark = import ./hosts/desktop/home.nix;
            }
          ];
          specialArgs = { inherit self inputs system; };
        };
      };
    };
}

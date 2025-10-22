{
  description = "Minimal flake for NixOS with Home Manager modules";

  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT
    dms = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:AvengeMedia/DankMaterialShell";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/master";
    };
    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lsfg-vk-flake = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:pabloaul/lsfg-vk-flake/main";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=v0.6.0";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    niri-flake = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    plasma-manager.url = "github:AlexNabokikh/plasma-manager";
    quickshell-git = {
      # known-good commit that includes IdleMonitor
      inputs.nixpkgs.follows = "nixpkgs";
      url =
        "git+https://git.outfoxxed.me/quickshell/quickshell?rev=6eb12551baf924f8fdecdd04113863a754259c34";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    textfox.url = "github:adriankarlen/textfox";
  };

  outputs = inputs@{ self, nixpkgs, chaotic, nur, lsfg-vk-flake, nixos-hardware
    , textfox, home-manager, ... }:
    let
      system = "x86_64-linux"; # Define your system once here
      pkgsFor = sys: import nixpkgs { inherit sys; };
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default

      ];
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/default.nix
            ./hosts/desktop
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = overlays;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mark = import ./hosts/desktop/home.nix;
            }
            chaotic.nixosModules.default # IMPORTANT
            nur.modules.nixos.default
            lsfg-vk-flake.nixosModules.default

            # Enable quickshell-git
            ({ ... }: {
              nixpkgs.overlays = [
                (final: prev: {
                  quickshell =
                    inputs.quickshell-git.packages.${final.system}.default;
                })
              ];
            })

            # Enable DMS
            inputs.home-manager.nixosModules.home-manager
            ./modules/home-manager/desktop/dms.nix
          ];
          # specialArgs = { inherit home-manager nur; };
          specialArgs = { inherit self inputs pkgsFor system; };
        };
      };
    };
}

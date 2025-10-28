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
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell"; # Use same quickshell version
    };
    nur.url = "github:nix-community/NUR";
    plasma-manager.url = "github:AlexNabokikh/plasma-manager";
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    textfox.url = "github:adriankarlen/textfox";
  };

  outputs = inputs@{ self, nixpkgs, chaotic, nur, lsfg-vk-flake, nixos-hardware
    , textfox, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgsFor = sys: import nixpkgs { inherit sys; };
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
        (import ./overlays/pkgs.nix)
      ];
      # Helper function to create a host configuration
      mkHost = { hostname, profile, username }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs system;
            host = hostname;
            inherit profile;
            inherit username;
            # zen-browser = inputs.zen-browser.packages.${system}.default;
          };
          modules = [
            ./hosts/default.nix
            ./hosts/${profile}
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = overlays;
              home-manager.extraSpecialArgs = {
                inherit inputs;
                host = hostname;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} =
                import ./hosts/${profile}/home.nix;
            }
            chaotic.nixosModules.default
            nur.modules.nixos.default
            lsfg-vk-flake.nixosModules.default
            inputs.noctalia.nixosModules.default
          ];
        };
    in {
      nixosConfigurations = {
        desktop = mkHost {
          hostname = "desktop";
          profile = "desktop";
          username = "mark";
        };
      };
    };
}

{
  description = "Minimal flake for NixOS with Home Manager modules";

  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    lsfg-vk-flake.url = "github:pabloaul/lsfg-vk-flake/main";
    lsfg-vk-flake.inputs.nixpkgs.follows = "nixpkgs";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=v0.6.0";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    plasma-manager.url = "github:AlexNabokikh/plasma-manager";
    textfox.url = "github:adriankarlen/textfox";
  };

  outputs = inputs@{ self, nixpkgs, chaotic, nur, lsfg-vk-flake, nixos-hardware
    , textfox, home-manager, ... }:
    let
      pkgsFor = system: import nixpkgs { inherit system; };
      overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
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
            # {
            #   # Import the Windscribe module directly
            #   imports = [ ./modules/nixos/desktop/programs/windscribe ];
            #   # Enable nixpkgs config
            #   nixpkgs.config.allowUnfree = true;
            # }
          ];
          specialArgs = { inherit home-manager nur; };
        };
      };
    };
}

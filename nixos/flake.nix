{
  description = "Minimal flake for NixOS with Home Manager modules";

  inputs = {
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT
    lsfg-vk-flake.url = "github:pabloaul/lsfg-vk-flake/main";
    lsfg-vk-flake.inputs.nixpkgs.follows = "nixpkgs";
    textfox.url = "github:adriankarlen/textfox";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, chaotic, nur, lsfg-vk-flake, nixos-hardware
    , textfox, home-manager, ... }:
    let pkgsFor = system: import nixpkgs { inherit system; };
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/desktop
            home-manager.nixosModules.home-manager
            {
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

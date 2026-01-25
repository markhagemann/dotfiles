{
  description = "Minimal flake for NixOS with Home Manager modules";
  inputs = {
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
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
      inputs.nixpkgs.follows = "nixpkgs";
      url =
        "git+https://git.outfoxxed.me/quickshell/quickshell?rev=6eb12551baf924f8fdecdd04113863a754259c34";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    textfox.url = "github:adriankarlen/textfox";
  };
  outputs = inputs@{ self, nixpkgs, chaotic, nur, lsfg-vk-flake, nixos-hardware
    , textfox, home-manager, nix-flatpak, ... }:
    let
      system = "x86_64-linux";
      overlays = [ (import ./overlays/pkgs.nix) ];
      # Create a properly configured pkgs instance
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = overlays ++ [
          (final: prev: {
            quickshell = inputs.quickshell-git.packages.${final.system}.default;
          })
        ];
      };
    in {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          inherit system pkgs;
          modules = [
            chaotic.nixosModules.default
            nur.modules.nixos.default
            lsfg-vk-flake.nixosModules.default
            nix-flatpak.nixosModules.nix-flatpak
            ./hosts/default.nix
            ./hosts/desktop
            home-manager.nixosModules.home-manager
            {
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


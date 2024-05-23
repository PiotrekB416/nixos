{
  description = "Nixos system";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
        inherit system;

        config = {
            allowUnfree = true;
        };
    };
  in
  {
    nixosConfigurations = {
        myNixos = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit system; inherit inputs; inherit pkgs; };

            modules = [
                ./nixos/configuration.nix
            ];
        };
    };
  };
}

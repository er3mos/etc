{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

#   outputs = { self, nixpkgs, ... }@inputs: 
#     let
#       system = "x86_64-linux";
#       pkgs = nixpkgs.legacyPackages.${system};
#     in
#     {
#       nixosConfigurations = {
#         nixos = nixpkgs.lib.nixosSystem {
#           specialArgs = {inherit inputs;};
#           modules = [
#             ./hosts/default/configuration.nix
#           ];
#         };

#         main-pc = nixpkgs.lib.nixosSystem {
#           specialArgs = {inherit inputs;};
#           modules = [
#             ./hosts/main-pc/configuration.nix
#           ];
#       };
#     };

# }

  outputs = {...} @ inputs: let
    # super simple boilerplate-reducing
    # lib with a bunch of functions
    customLib = import ./customLib/default.nix {inherit inputs;};
  in
    with customLib; {
      nixosConfigurations = {

        nixos = mkSystem .hosts/default/configuration.nix;
        main-pc = mkSystem .hosts/main-pc/configuration.nix;
        homeConfiguration = {
          "sean@nixos" = mkHome "x86_64-linux" .hosts/default/home.nix;
          "sean@main" = mkHome "x86_64-linux" .hosts/main-pc/home.nix;
        };
      homeManagerModules.default = ./homeManagerModules;
      nixosModules.default = ./nixosModules;
    };
  };
}
{
  description = "sean's nixos config - testing";


  # Declare all dependencies/programs that we want to use inside inputs. 
  inputs = {

    # Sets the nixpkgs channel to unstable. 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Includes home-manager from nix-community, and pins its version to 
    # nixpkgs/nixos-unstable above.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };
  
  
  outputs = { self, nixpkgs, ... }@inputs: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {inherit inputs;};
          modules = [
            ./configuration.nix
            inputs.home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
    };
  };
}
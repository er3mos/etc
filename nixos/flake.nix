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
  
  
  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  # `@inputs` will expose the block of code below, to the inputs that you set above.

    let
      # system setting defaults
      system = "x86_64-linux";
      timezone = "Europe/London";
      locale = "en_GB.UTF-8";

    in

    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
            inherit system;
            inherit timezone;
            inherit locale;
          };

          modules = [
            ./system/nixos/configuration.nix
          ];
        };
        homeConfigurations = {
          
          "sean@nixos" = home-manager.lib.homeManagerConfiguration {
            # pkgs instance for home-manager
            pkgs = nixpkgs.legacyPackages.${system};
          
            extraSpecialArgs = { 
              inherit inputs;
            };

            modules = [ 
              ./home-manager/nixos/home.nix
            ];
          };
        };
      };
    };
  };
}
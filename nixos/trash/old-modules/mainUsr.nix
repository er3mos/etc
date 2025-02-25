# mainusr.nix

{ lib, config, pkgs, input, ... }:

let 
  cfg = config.mainUsr;
in
{
  options.mainUsr = {
    enable = lib.mkEnableOption "enable user module";
    
    userName = lib.mkOption {
      default = "mainuser";
      description = "mainUsr username";
    };
    # homeDir = lib.mkOption {
    #   default = /home/mainUsr;
    #   description = "mainUsr home dir"
    # };
  };

  config = lib.mkIf cfg.enable {
    users.users.${cfg.userName} = {
      isNormalUser = true;
      initalPassword = "password";
      description = "Main User";
      extraGroups = [ "networkmanager" "wheel" ];

      # Laptop Public Key
      openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBWPEWzFeIINdIlYzT742n6Mi0sM+HD/nTzrF+3Vyu5W" ];
      packages = with pkgs; [
        firefox
        git
        vscodium
      ];
    };
    home-manager = {
      extraSpecialArgs = { inherit inputs };
      users = {
        "sean" = import ../
      };
    }
  };
}



# # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.sean = {
    # isNormalUser = true;
    # description = "sean";
    # extraGroups = [ "networkmanager" "wheel" ];
    
    # # Laptop Public Key
    # openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBWPEWzFeIINdIlYzT742n6Mi0sM+HD/nTzrF+3Vyu5W" ];
    # packages = with pkgs; [
      # firefox
      # git
      # vscodium
    # ];
  # };

  # home-manager = {
    # # also pass input to home-manager modules
    # extraSpecialArgs = { inherit inputs; };
    # users = {
      # "sean" = import ./home.nix;
    # };
  # }
  # for main-user.nix module - unfinished 
  # # main-user.enable = true;
  # # main-user.userName = "sean";
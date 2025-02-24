# main-user.nix

{ lib, config, pkgs, ... }:


let 
  cfg = config.main-user;
in
{
  options = {
    main-user.enable
      = lib.mkEnableOption "enable user module";
    
    userName = lib.mkOption {
      default = "mainuser";
      description = ''
        username
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    users.user.${cfg.userName} = {
      isNormalUser = "true";
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
  };
}
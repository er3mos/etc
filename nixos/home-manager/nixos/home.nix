# default nixos home-manager file

{ config, pkgs, ... }:

{

  home.username = "sean";
  home.homeDirectory = "/home/sean";
  home.stateVersion = "24.11"; # DONT CHANGE

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # enable font config
  fonts.fontconfig.enable = true;

  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "Hack" ];})
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  systemd.user.sessionVariables = {
    EDITOR = "nvim";
    TERM = "fish";
  };
  
}
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
  
  imports = [
			# ../packages/bat.nix
			# ../packages/brave.nix
			../packages/direnv.nix
			# ../packages/erdtree.nix
			../packages/eza.nix
			../packages/fd.nix
			# ../packages/feh.nix
			../packages/fish.nix
			../packages/helix.nix
			../packages/htop.nix
			# ../packages/megasync.nix
			../packages/nap.nix
			../packages/qbittorrent.nix
			# ../packages/rename.nix
			../packages/ripgrep.nix
			# ../packages/signal-desktop.nix
			../packages/starship.nix
			../packages/tree.nix
			../packages/vlc.nix
			../packages/wezterm.nix
			# ../packages/ytdlp.nix
  ];

}
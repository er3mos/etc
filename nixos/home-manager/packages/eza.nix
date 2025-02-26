{ config, pkgs, ... }:

{

	home.packages = with pkgs; [
    eza
	];

  programs.eza = {
  	enable = true;
    git = true;
    enableFishIntegration = true;
    extraOptions = [ "--group-directories-first" ];
  };
  
}

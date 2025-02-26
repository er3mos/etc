{ config, pkgs, ... }:

{

	home.packages = with pkgs; [
    tidal-hifi
	];

  programs.tidal-hifi = {
    enable = true;
  
  };
  
}

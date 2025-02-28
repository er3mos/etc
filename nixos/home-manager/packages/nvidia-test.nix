{ config, pkgs, ... }:

{

	home.packages = with pkgs; [
    nvidia-opens
	];

  programs. = {
    enable = true;
  
  };
  
}

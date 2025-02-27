{ config, pkgs, ... }:

{

	home.packages = with pkgs; [
    fastfetch
	];
# 
  # programs. = {
    # enable = true;
  # 
  # };
  # 
  }

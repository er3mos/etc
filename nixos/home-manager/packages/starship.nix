{ config, pkgs, lib, ... }:

{

	home.packages = with pkgs; [
	];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
    
    settings = {
      add_newline = false;
      
      format = lib.concatStrings [
        "$line_break"
        "$package"
        "$line_break"
        "$character"
      ];
      
        scan_timeout = 10;
        character = {
        success_symbol = "➜";
        error_symbol = "➜";
      };

    };
    
  }; 
  
}

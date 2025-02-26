{ config, pkgs, ... }:

{

	# home.packages = with pkgs; [
  #   fish
	# ];

  programs.fish = {
    enable = true;
    generateCompletions = true;

    shellAbbrs = {
    "ld" = "eza -ld */ --no-quotes --time-style long-iso";    
    "l" = "eza -lah --no-quotes --time-style long-iso";   
    "ll" = "eza -lh --no-quotes --time-style long-iso";   
    "llr" = "eza -lhr --no-quotes --time-style long-iso";   
    "lls" = "eza -lh -s size --no-quotes --time-style long-iso";    
    "llt" = "eza -lh -s time --no-quotes --time-style long-iso";  
    };

    # git abbreviations
		"gaa"  = "git add -A";
		"ga"   = "git add";
		"gbd"  = "git branch --delete";
		"gb"   = "git branch";
		"gc"   = "git commit";
		"gcm"  = "git commit -m";
		"gcob" = "git checkout -b";
		"gco"  = "git checkout";
		"gd"   = "git diff";
		"gl"   = "git log";
		"gp"   = "git push";
		"gpom" = "git push origin main";
		"gs"   = "git status";
		"gst"  = "git stash";
		"gstp" =  "git stash pop";

	};
  
}

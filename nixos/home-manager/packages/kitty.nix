{
  pkgs,
  config,
  ...
}: {
  programs.kitty = {
    enable = true;
    keybindings = {
      "kitty_mod+h" = "neighboring_window left";
      "kitty_mod+l" = "neighboring_window right";
      "kitty_mod+j" = "neighboring_window down";
      "kitty_mod+k" = "neighboring_window up";
    };
    shellIntegration.enableFishIntegration = true;
    settings = {
      enable_audio_bell = "no";

      # cursor = "#${base06}";
      cursor_text_color = "background";

      scrollback_pager = ''nvim -c "set signcolumn=no showtabline=0" -c "silent write! /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer - "'';

      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      shell_integration = "enabled";

      cursor_trail = 3;
    };
  };
}

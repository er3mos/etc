# HOW TO GET SHIT INTO MY NIX_PATH HOLY FUCK YEAH AT LAST

### Update flake.lock
nix flake update

### Or replace only the specific input, such as home-manager:
nix flake update home-manager

### Apply the updates
sudo nixos-rebuild switch --flake .

### Or to update flake.lock & apply with one command (i.e. same as running "nix flake update" before)
sudo nixos-rebuild switch --recreate-lock-file --flake .

> warning: '--recreate-lock-file' is deprecated and will be removed in a future version; use 'nix flake update' instead.
building the system configuration...
warning: '--recreate-lock-file' is deprecated and will be removed in a future version; use 'nix flake update' instead.
evaluation warning: The option `services.xserver.displayManager.autoLogin' defined in `/nix/store/s2jhcq06hxb42lz7zi6lxhs82rj9w2sr-source/nixos/system/nixos/configuration.nix' has been renamed to `services.displayManager.autoLogin'.
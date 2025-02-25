# copied this shit, i understand about 46% of it. At best.

{inputs}: let
  customLib = (import ./default.nix) {inherit inputs;};
  outputs = inputs.self.outputs
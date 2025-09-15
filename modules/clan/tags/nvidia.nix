{ inputs, ... }:
let
  imports = with inputs.self.modules.nixos; [
    nvidia
  ];
in
{
  inherit imports;
}

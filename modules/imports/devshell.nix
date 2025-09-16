{ inputs, ... }:
{
  imports = [
    inputs.devshell.flakeModule
  ];

  flake-file.inputs = {
    devshell.url = "github:numtide/devshell";
  };
}

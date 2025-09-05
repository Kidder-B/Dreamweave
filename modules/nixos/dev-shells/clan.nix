{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    {
      devshells.default.packages = [ inputs.clan-core.packages.${system}.clan-cli ];
    };
}

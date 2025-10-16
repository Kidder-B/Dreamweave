{
  flake-file.inputs = {
    hyprland.url = "github:hyprwm/Hyprland?submodules=1";
    hy3 = {
      url = "github:outfoxxed/hy3";
      inputs.hyprland.follows = "hyprland";
    };
  };
}

{
  flake.modules.homeManager."Brett" = {
    wayland.windowManager.hyprland.settings = {
      bind =
        [
          # Toggle floating windows
          "$mod, V, togglefloating"

          # Move focus with arrow keys
          "$mod, left, movefocus, l"
          "$mod, right, movefocus, r"
          "$mod, up, movefocus, u"
          "$mod, down, movefocus, d"

          # Scroll through existing workspaces
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # Move/resize windows with mainMod + LMB/RMB and dragging
        ];
       bindm =
        [
          "$mod, mouse:272, movewindow"  # Left mouse button
          "$mod, mouse:273, resizewindow" # Right mouse button
        ];
    };
  };
}

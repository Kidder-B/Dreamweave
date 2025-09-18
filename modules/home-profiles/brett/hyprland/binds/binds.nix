{
  flake.modules.homeManager."Brett" = {
    wayland.windowManager.hyprland.settings = {
    binds =[
      "mod, Return, exec, ${users.users.myuser.shell}"
    ];

};
};
}

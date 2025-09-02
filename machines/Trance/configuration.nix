{
    imports = with inputs.self.modules.nixos [
        # enables GNOME desktop (optional)
        gnome-desktop
        nvidia
        unfree
    ];

    # Set nixosOptions here
    # Or import your own modules via 'imports'
    # ...
}


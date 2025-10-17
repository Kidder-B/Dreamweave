# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    allfollow = {
      url = "github:spikespaz/allfollow";
    };
    clan-core = {
      url = "https://git.clan.lol/clan/clan-core/archive/main.tar.gz";
    };
    devshell = {
      url = "github:numtide/devshell";
    };
    flake-file = {
      url = "github:vic/flake-file";
    };
    flake-parts = {
      follows = "clan-core/flake-parts";
      url = "github:hercules-ci/flake-parts";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    hypr-dynamic-cursors = {
      inputs = {
        hyprland = {
          follows = "hyprland";
        };
      };
      url = "github:VirtCode/hypr-dynamic-cursors";
    };
    hyprland = {
      inputs = {
        hyprlang = {
          follows = "hyprlang";
        };
        hyprutils = {
          follows = "hyprutils";
        };
        nixpkgs = {
          follows = "nixpkgs";
        };
        systems = {
          follows = "systems";
        };
      };
      url = "github:hyprwm/Hyprland";
    };
    hyprland-hy3 = {
      inputs = {
        hyprland = {
          follows = "hyprland";
        };
      };
      url = "github:outfoxxed/hy3";
    };
    hyprlang = {
      inputs = {
        hyprutils = {
          follows = "hyprutils";
        };
        nixpkgs = {
          follows = "nixpkgs";
        };
        systems = {
          follows = "systems";
        };
      };
      url = "github:hyprwm/hyprlang";
    };
    hyprutils = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
        systems = {
          follows = "systems";
        };
      };
      url = "github:hyprwm/hyprutils";
    };
    import-tree = {
      url = "github:vic/import-tree";
    };
    khanelivim = {
      url = "github:khaneliman/khanelivim";
    };
    nixpkgs = {
      follows = "clan-core/nixpkgs";
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    nixpkgs-lib = {
      follows = "nixpkgs";
    };
    quadlet-nix = {
      url = "github:SEIAROTg/quadlet-nix";
    };
    quickshell = {
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };
  };

}

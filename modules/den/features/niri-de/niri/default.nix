{
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    niri = {
      url = "git+https://codeberg.org/BANanaD3V/niri-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri-de.niri = let
    mkCommonPkgs = pkgs: [
      pkgs.xwayland-satellite
      pkgs.wl-clipboard
    ];
  in {
    includes = with den.aspects.niri-de.niri; [
      environment
      general
      cursor
      layer-rules
      window-rules
      workspaces
    ];

    nixos = {pkgs, ...}: {
      imports = [inputs.niri.nixosModules.default];

      programs.niri.enable = true;
      environment.systemPackages = mkCommonPkgs pkgs;
    };

    homeManager = {pkgs, ...}: {
      imports = [inputs.niri.homeModules.default];

      wayland.windowManager.niri.enable = true;
      home.packages = mkCommonPkgs pkgs;
    };
  };
}

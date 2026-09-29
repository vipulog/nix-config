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

  den.aspects.niri-de.niri = {
    includes = with den.aspects.niri-de;
    with niri; [
      environment
      general
      outputs
      niri.inputs
      cursor
      layout
      layer-rules
      window-rules
      workspaces
      startup
      dms
      misc
    ];

    nixos = {
      imports = [inputs.niri.nixosModules.default];

      programs.niri = {
        enable = true;
      };
    };

    homeManager = {
      imports = [inputs.niri.homeModules.default];

      wayland.windowManager.niri = {
        enable = true;

        extraConfig = with den.aspects.niri-de;
        with niri; ''
          ${environment.configKdl}
          ${general.configKdl}
          ${outputs.configKdl}
          ${niri.inputs.configKdl}
          ${cursor.configKdl}
          ${layout.configKdl}
          ${layer-rules.configKdl}
          ${window-rules.configKdl}
          ${workspaces.configKdl}
          ${startup.configKdl}
          ${dms.configKdl}
          ${misc.configKdl}
        '';
      };
    };
  };
}

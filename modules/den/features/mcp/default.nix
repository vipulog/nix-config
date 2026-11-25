{inputs, ...}: {
  flake-file.inputs = {
    mcp-servers-nix = {
      url = "github:natsukium/mcp-servers-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.mcp = {
    os = {
      pkgs,
      inputs',
      ...
    }: {
      environment.systemPackages = [
        pkgs.mcp-nixos
        pkgs.github-mcp-server
        inputs'.mcp-servers-nix.packages.chrome-devtools-mcp
      ];
    };

    homeManager = {
      lib,
      config,
      options,
      ...
    }: {
      imports = [inputs.mcp-servers-nix.homeManagerModules.default];

      config = lib.mkMerge [
        {
          programs.mcp.enable = true;

          mcp-servers.programs = {
            nixos.enable = true;
            github.enable = true;
            chrome-devtools.enable = true;
          };
        }

        (lib.optionalAttrs (options ? sops) {
          sops = {
            secrets.github-mcp-pat.sopsFile = config.sops-nix.sharedSopsFile;

            templates.github-mcp-env = {
              content = ''
                GITHUB_PERSONAL_ACCESS_TOKEN=${
                  config.sops.placeholder.github-mcp-pat
                }
              '';
            };
          };

          mcp-servers.programs = {
            github.envFile = config.sops.templates.github-mcp-env.path;
          };
        })
      ];
    };
  };
}

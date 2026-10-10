{
  den,
  inputs,
  self,
  ...
}: {
  flake-file.inputs = {
    mcp-servers-nix = {
      url = "github:natsukium/mcp-servers-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.mcp = {
    includes = [den.aspects.mcp.secrets];

    homeManager = {pkgs, ...}: {
      imports = [inputs.mcp-servers-nix.homeManagerModules.default];

      programs.mcp.enable = true;

      mcp-servers.programs = {
        nixos.enable = true;
        github.enable = true;
        chrome-devtools.enable = true;
      };
    };

    secrets = let
      inherit (self.lib.den.sops-nix) sharedSecretsFilePath userHasSops;
    in {
      homeManager = {
        lib,
        user,
        config,
        ...
      }:
        lib.mkIf (userHasSops {inherit user;}) {
          sops = {
            secrets.github-mcp-pat = {
              sopsFile = sharedSecretsFilePath;
            };

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
        };
    };
  };
}

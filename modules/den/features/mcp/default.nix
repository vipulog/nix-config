{
  den,
  inputs,
  self,
  ...
}: {
  den.aspects.mcp = {
    includes = [den.aspects.mcp.secrets];

    homeManager = {pkgs, ...}: let
      mcpRemote = pkgs.writeShellApplication {
        name = "mcp-remote";
        runtimeInputs = [pkgs.nodejs_26];
        text = "exec npx -y mcp-remote \"$@\"";
      };
    in {
      programs.mcp = {
        enable = true;

        servers = {
          deepwiki = {
            command = "${mcpRemote}/bin/mcp-remote";
            args = ["https://mcp.deepwiki.com/mcp"];
          };

          github = {
            command = "${mcpRemote}/bin/mcp-remote";
            args = ["https://api.githubcopilot.com/mcp"];
          };
        };
      };
    };

    secrets = let
      inherit (self.lib.den.sops-nix) userHasSops;
    in {
      homeManager = {
        lib,
        user,
        config,
        ...
      }:
        lib.mkIf (userHasSops {inherit user;}) {
          sops.secrets.github-mcp-pat = {
            sopsFile = "${inputs.my-secrets}/secrets/sops/shared.yaml";
          };

          programs.mcp.servers = {
            github = {
              env.GITHUB_MCP_PAT.file = config.sops.secrets.github-mcp-pat.path;
              args = ["--header" "Authorization:Bearer \$\{GITHUB_MCP_PAT\}"];
            };
          };
        };
    };
  };
}

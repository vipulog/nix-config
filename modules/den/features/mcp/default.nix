{
  den,
  inputs,
  ...
}: {
  den.aspects.mcp = let
    inherit (den.lib) policy;

    hasSops = {user ? null, ...}:
      user != null && user.hasAspect den.aspects.sops-nix;
  in {
    includes = [
      (policy.when hasSops (policy.include den.aspects.mcp.secrets))
    ];

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

    secrets = {
      homeManager = {config, ...}: {
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

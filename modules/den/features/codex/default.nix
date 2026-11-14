{
  den,
  self,
  ...
}: {
  den.aspects.codex = {
    includes = [den.aspects.mcp];

    os = {pkgs, ...}: {
      environment.systemPackages = [pkgs.codex];
    };

    homeManager = {
      programs.codex = {
        enable = true;
        enableMcpIntegration = true;
        inherit (self.lib.den.agents) context;
      };
    };

    persist-user = {
      directories = {
        ".codex".enable = true;
      };
    };
  };
}

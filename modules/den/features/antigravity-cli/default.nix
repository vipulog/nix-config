{
  den,
  self,
  ...
}: {
  den.aspects.antigravity-cli = {
    includes = [
      (den.batteries.unfree ["antigravity-cli"])
      den.aspects.mcp
    ];

    os = {pkgs, ...}: {
      environment.systemPackages = [pkgs.antigravity-cli];
    };

    homeManager = {
      programs.antigravity-cli = {
        enable = true;
        enableMcpIntegration = true;
        context.GEMINI = self.lib.den.agents.context;
      };
    };

    persist-user = {
      directories = {
        ".gemini".enable = true;
      };
    };
  };
}

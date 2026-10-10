{
  den,
  self,
  ...
}: {
  den.aspects.opencode = {
    includes = [den.aspects.mcp];

    homeManager = {
      programs.opencode = {
        enable = true;
        enableMcpIntegration = true;
        web.enable = true;
        inherit (self.lib.den.agents) context;
      };
    };

    persist-user = {
      directories = [
        ".local/share/opencode"
      ];
    };
  };
}

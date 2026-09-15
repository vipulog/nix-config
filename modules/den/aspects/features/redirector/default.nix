{inputs, ...}: {
  flake-file.inputs = {
    redirector = {
      url = "github:vipulog/redirector-flake";

      inputs = {
        flake-parts.follows = "flake-parts";
        git-hooks-nix.follows = "git-hooks-nix";
        treefmt-nix.follows = "treefmt-nix";
        home-manager.follows = "home-manager";
      };
    };
  };

  den.aspects.redirector = {
    homeManager = {
      imports = [inputs.redirector.homeModules.default];

      services.redirector = {
        enable = true;

        settings = {
          port = 3030;
          default_search = "https://duckduckgo.com/?q={}";
          search_suggestions = "https://search.brave.com/api/suggest?q={}";
        };
      };
    };
  };
}

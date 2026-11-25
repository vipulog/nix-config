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

  den.aspects.redirector = let
    sharedModule = {
      nix.settings = {
        extra-substituters = [
          "https://redirector.cachix.org"
        ];

        extra-trusted-public-keys = [
          "redirector.cachix.org-1:lx9grKUxrkiq/H1qkIV/oEgRB9SmYGD2Yg37fHs6TlE="
        ];
      };
    };
  in {
    os = {inputs', ...}: {
      imports = [sharedModule];
      environment.systemPackages = [inputs'.redirector.packages.default];
    };

    homeManager = {
      imports = [
        inputs.redirector.homeModules.default
        sharedModule
      ];

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

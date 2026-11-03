{inputs, ...}: {
  flake-file.inputs = {
    dsearch = {
      url = "github:duxlabs-dev/dux-search";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri-de.dms.dsearch = {
    homeManager = {pkgs, ...}: {
      imports = [inputs.dsearch.homeModules.dsearch];

      programs.dsearch = {
        enable = true;
        package = pkgs.dux-search;

        config = {
          max_file_bytes = 2097152; # 2MB
          worker_count = 4;
          index_all_files = true;

          index_paths = [
            {
              path = "~/Documents";
              max_depth = 6;
              exclude_hidden = true;
              exclude_dirs = ["node_modules" "venv" "target"];
            }
            {
              path = "~/Dev";
              max_depth = 6;
              exclude_hidden = true;
              exclude_dirs = ["node_modules" ".git" "target" "dist"];
            }
          ];
        };
      };
    };

    persist-user = {
      directories = [
        ".cache/dsearch"
      ];
    };
  };
}

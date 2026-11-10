{
  den.aspects."tux@igloo".syncthing = {
    homeManager = {
      services.syncthing = {
        enable = true;

        settings = {
          devices.glacier.id = "GWKJUX2-RIITNN7-RCYJ3IH-TQQ25E6-CNU5GIU-X2BF25J-RGFHJLK-73XAXQ7";

          folders = {
            DCIM = {
              id = "dcim";
              path = "~/DCIM";
              devices = ["glacier"];
              ignorePerms = true;

              ignorePatterns = [
                "(?d)**/.thumbnails"
                "(?d)**/.trashed*"
              ];

              versioning = {
                type = "staggered";

                params = {
                  cleanInterval = "3600";
                  maxAge = "604800"; # 7 days
                };
              };
            };

            Documents = {
              id = "documents";
              path = "~/Documents";
              devices = ["glacier"];
              ignorePerms = true;

              versioning = {
                type = "staggered";

                params = {
                  cleanInterval = "3600";
                  maxAge = "604800"; # 7 days
                };
              };
            };

            Music = {
              id = "music";
              path = "~/Music";
              devices = ["glacier"];
              ignorePerms = true;

              ignorePatterns = [
                "(?d)**/.thumbnails"
                "(?d)**/.trashed*"
              ];

              versioning = {
                type = "staggered";

                params = {
                  cleanInterval = "3600";
                  maxAge = "604800"; # 7 days
                };
              };
            };

            Pictures = {
              id = "pictures";
              path = "~/Pictures";
              devices = ["glacier"];
              ignorePerms = true;

              ignorePatterns = [
                "(?d)**/.thumbnails"
                "(?d)**/.trashed*"
              ];

              versioning = {
                type = "staggered";

                params = {
                  cleanInterval = "3600";
                  maxAge = "604800"; # 7 days
                };
              };
            };

            Projects = {
              id = "projects";
              path = "~/Projects";
              devices = ["glacier"];
              fsWatcherDelayS = 30;
              ignorePerms = true;

              ignorePatterns = [
                "*.swp"
                "*.swo"
                "*~"
                ".#*"
                "#*#"
                "(?d).direnv"
                "(?d).devenv"
                "(?d)node_modules"
                "(?d).next"
                "(?d).nuxt"
                "(?d).svelte-kit"
                "(?d).astro"
                "(?d).turbo"
                "(?d).parcel-cache"
                "(?d).vite"
                "(?d).eslintcache"
                "(?d).stylelintcache"
                "(?d)*.tsbuildinfo"
                "npm-debug.log*"
                "yarn-debug.log*"
                "yarn-error.log*"
                ".pnpm-debug.log*"
                "(?d).venv"
                "(?d)venv"
                "(?d)__pycache__"
                "(?d)*.py[cod]"
                "(?d)*.egg-info"
                "(?d).pytest_cache"
                "(?d).mypy_cache"
                "(?d).ruff_cache"
                "(?d).tox"
                "(?d).nox"
                "(?d).ipynb_checkpoints"
                "(?d)htmlcov"
                "(?d).coverage"
                "(?d).clangd"
                "(?d).ccls-cache"
                "(?d)CMakeFiles"
                "(?d)CMakeCache.txt"
                "(?d)*.o"
                "(?d)*.obj"
                "(?d).gradle"
                "(?d).mvn"
              ];

              versioning = {
                type = "staggered";

                params = {
                  cleanInterval = "3600";
                  maxAge = "604800"; # 7 days
                };
              };
            };

            Recordings = {
              id = "recordings";
              path = "~/Recordings";
              devices = ["glacier"];
              ignorePerms = true;

              ignorePatterns = [
                "(?d)**/.thumbnails"
                "(?d)**/.trashed*"
              ];

              versioning = {
                type = "staggered";

                params = {
                  cleanInterval = "3600";
                  maxAge = "604800"; # 7 days
                };
              };
            };

            Videos = {
              id = "videos";
              path = "~/Videos";
              devices = ["glacier"];
              ignorePerms = true;

              ignorePatterns = [
                "(?d)**/.thumbnails"
                "(?d)**/.trashed*"
              ];

              versioning = {
                type = "staggered";

                params = {
                  cleanInterval = "3600";
                  maxAge = "604800"; # 7 days
                };
              };
            };
          };
        };
      };
    };

    persist-user = {
      directories = {
        ".config/syncthing".enable = true;
      };
    };
  };
}

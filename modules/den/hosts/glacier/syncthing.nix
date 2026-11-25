{
  den.aspects.glacier.syncthing = {
    nixos = {lib, ...}: {
      services.syncthing = {
        enable = true;
        dataDir = "/srv/syncthing";
        guiAddress = "127.0.0.1:8384";

        settings = {
          gui.insecureSkipHostcheck = true;

          devices = {
            igloo.id = "56QERGR-JFANNUO-Q4RUWTF-W3QWMRT-54XRAHL-E2DEQRZ-LF727VM-F7IVRAQ";
            np2.id = "WCL2VTA-FIYGHZ2-KAF4EDY-IVM3JDJ-5EUUGNX-5R3DP6F-ZNKEA7A-7SMNWQJ";
          };

          folders = {
            Backups = {
              id = "backups";
              path = "/srv/syncthing/Backups";
              devices = ["igloo" "np2"];
              ignorePerms = true;

              versioning = {
                type = "staggered";

                params = {
                  cleanInterval = "3600";
                  maxAge = "604800"; # 7 days
                };
              };
            };

            DCIM = {
              id = "dcim";
              path = "/srv/syncthing/DCIM";
              devices = ["igloo" "np2"];
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
              path = "/srv/syncthing/Documents";
              devices = ["igloo" "np2"];
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
              path = "/srv/syncthing/Music";
              devices = ["igloo" "np2"];
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
              path = "/srv/syncthing/Pictures";
              devices = ["igloo" "np2"];
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
              path = "/srv/syncthing/Projects";
              devices = ["igloo"];
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
              path = "/srv/syncthing/Recordings";
              devices = ["igloo" "np2"];
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
              path = "/srv/syncthing/Videos";
              devices = ["igloo" "np2"];
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

      systemd.services.syncthing.serviceConfig = {
        UMask = "0007";
      };

      users = {
        groups = {
          synced = {};
          synced-backups = {};
          synced-docs = {};
          synced-media = {};
          synced-music = {};
          synced-projects = {};
          synced-recordings = {};
        };

        users.syncthing = {
          createHome = lib.mkForce false;

          extraGroups = [
            "synced"
            "synced-backups"
            "synced-docs"
            "synced-media"
            "synced-music"
            "synced-projects"
            "synced-recordings"
          ];
        };
      };

      systemd.tmpfiles.rules = [
        "d /srv/syncthing 0710 syncthing synced -"

        "d /srv/syncthing/Backups 2770 syncthing synced-backups -"
        "d /srv/syncthing/DCIM 2770 syncthing synced-media -"
        "d /srv/syncthing/Documents 2770 syncthing synced-docs -"
        "d /srv/syncthing/Music 2770 syncthing synced-music -"
        "d /srv/syncthing/Pictures 2770 syncthing synced-media -"
        "d /srv/syncthing/Projects 2770 syncthing synced-projects -"
        "d /srv/syncthing/Recordings 2770 syncthing synced-recordings -"
        "d /srv/syncthing/Videos 2770 syncthing synced-media -"
      ];
    };
  };
}

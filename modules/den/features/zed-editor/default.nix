{den, ...}: {
  den.aspects.zed-editor = {
    includes = [den.aspects.mcp];

    homeManager = {pkgs, ...}: {
      programs.zed-editor = {
        enable = true;
        enableMcpIntegration = true;

        extensions = [
          "nix"
          "html"
          "toml"
          "justfile"
          "dockerfile"
          "xy-zed"
          "colored-zed-icons-theme"
        ];

        userSettings = {
          telemetry = {
            diagnostics = false;
            metrics = false;
            anthropic_retention = false;
          };

          vim_mode = true;

          icon_theme = {
            mode = "dark";
            light = "Colored Zed Icons Theme Light";
            dark = "Colored Zed Icons Theme Dark";
          };

          theme = {
            mode = "dark";
            light = "XY-Zed";
            dark = "XY-Zed";
          };

          format_on_save = "on";

          languages = {
            Nix = {
              language_servers = ["nil"];
              formatter = "language_server";
            };
          };

          lsp = {
            nil = {
              binary.path = "${pkgs.nil}/bin/nil";

              initialization_options = {
                formatting = {
                  command = ["${pkgs.alejandra}/bin/alejandra" "--quiet" "--"];
                };
              };
            };
          };

          agent = {
            play_sound_when_agent_done = "always";
          };

          agent_servers = {
            claude-acp = {
              type = "registry";
            };

            github-copilot-cli = {
              type = "registry";
            };

            codex-acp = {
              type = "registry";
            };

            antigravity-acp = {
              type = "registry";
            };
          };
        };
      };
    };

    persist-user = {
      directories = [
        ".config/zed"
        ".local/share/zed"
        ".cache/zed"
      ];
    };
  };
}

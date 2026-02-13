{
  config,
  namespace,
  lib,
  pkgs,
  ...
}: let
  cfg = config.${namespace}.programs.helix;
in {
  options.${namespace}.programs.helix = {
    enable = lib.mkEnableOption "helix";

    defaultEditor = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = ''
        Whether to configure {command}`hx` as the default
        editor using the {env}`EDITOR` environment variable.
      '';
    };

    theme = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "The theme to use for helix.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
      inherit (cfg) defaultEditor;

      settings = lib.mkMerge [
        {
          editor = {
            cursorline = true;
            line-number = "relative";
            rulers = [100];
            true-color = true;

            cursor-shape = {
              insert = "bar";
              normal = "block";
              select = "underline";
            };

            indent-guides = {
              character = "╎";
              render = true;
            };

            lsp = {
              auto-signature-help = true;
              display-messages = true;
            };
          };
        }

        (lib.optionalAttrs (cfg.theme != null) {
          inherit (cfg) theme;
        })
      ];

      languages = {
        language-server = {
          nix-ls = {
            command = "${pkgs.nil}/bin/nil";
          };

          python-ls = {
            command = "${pkgs.ruff}/bin/ruff";
            args = ["server"];
          };

          ts-ls = {
            command = "${pkgs.typescript-language-server}/bin/typescript-language-server";
            args = ["--stdio"];
          };

          html-ls = {
            command = "${pkgs.vscode-langservers-extracted}/bin/vscode-html-language-server";
            args = ["--stdio"];
          };

          css-ls = {
            command = "${pkgs.vscode-langservers-extracted}/bin/vscode-css-language-server";
            args = ["--stdio"];
          };

          json-ls = {
            command = "${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server";
            args = ["--stdio"];
          };

          eslint-ls = {
            command = "${pkgs.vscode-langservers-extracted}/bin/vscode-eslint-language-server";
            args = ["--stdio"];
          };

          svelte-ls = {
            command = "${pkgs.svelte-language-server}/bin/svelteserver";
            args = ["--stdio"];
          };

          go-ls = {
            command = "${pkgs.gopls}/bin/gopls";
          };
        };

        language = [
          {
            name = "nix";
            language-servers = ["nix-ls"];
            formatter.command = "${pkgs.alejandra}/bin/alejandra";
            auto-format = true;
          }

          {
            name = "python";
            language-servers = ["python-ls"];
            formatter = {
              command = "${pkgs.ruff}/bin/ruff";
              args = ["format" "-"];
            };
            auto-format = true;
          }

          {
            name = "javascript";
            language-servers = ["ts-ls" "eslint-ls"];
            formatter = {
              command = "${pkgs.nodePackages.prettier}/bin/prettier";
              args = ["--stdin-filepath" "file.js"];
            };
            auto-format = true;
          }

          {
            name = "typescript";
            language-servers = ["ts-ls" "eslint-ls"];
            formatter = {
              command = "${pkgs.nodePackages.prettier}/bin/prettier";
              args = ["--stdin-filepath" "file.ts"];
            };
            auto-format = true;
          }

          {
            name = "jsx";
            language-servers = ["ts-ls" "eslint-ls"];
            formatter = {
              command = "${pkgs.nodePackages.prettier}/bin/prettier";
              args = ["--stdin-filepath" "file.jsx"];
            };
            auto-format = true;
          }

          {
            name = "tsx";
            language-servers = ["ts-ls" "eslint-ls"];
            formatter = {
              command = "${pkgs.nodePackages.prettier}/bin/prettier";
              args = ["--stdin-filepath" "file.tsx"];
            };
            auto-format = true;
          }

          {
            name = "html";
            language-servers = ["html-ls"];
            formatter = {
              command = "${pkgs.nodePackages.prettier}/bin/prettier";
              args = ["--stdin-filepath" "file.html"];
            };
            auto-format = true;
          }

          {
            name = "css";
            language-servers = ["css-ls"];
            formatter = {
              command = "${pkgs.nodePackages.prettier}/bin/prettier";
              args = ["--stdin-filepath" "file.css"];
            };
            auto-format = true;
          }

          {
            name = "json";
            language-servers = ["json-ls"];
            formatter = {
              command = "${pkgs.nodePackages.prettier}/bin/prettier";
              args = ["--stdin-filepath" "file.json"];
            };
            auto-format = true;
          }

          {
            name = "svelte";
            language-servers = ["svelte-ls"];
            formatter = {
              command = "${pkgs.nodePackages.prettier}/bin/prettier";
              args = ["--stdin-filepath" "file.svelte"];
            };
            auto-format = true;
          }

          {
            name = "go";
            language-servers = ["go-ls"];
            formatter = {
              command = "${pkgs.go}/bin/gofmt";
            };
            auto-format = true;
          }
        ];
      };
    };
  };
}

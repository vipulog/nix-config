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
            bufferline = "multiple";
            cursorline = true;
            line-number = "relative";
            rulers = [120];
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
              auto-signature-help = false;
              display-messages = true;
            };

            statusline.left = [
              "mode"
              "spinner"
              "version-control"
              "file-name"
            ];
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
        };

        language = [
          {
            name = "nix";
            language-servers = ["nix-ls"];
            formatter.command = "${pkgs.alejandra}/bin/alejandra";
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
        ];
      };
    };
  };
}

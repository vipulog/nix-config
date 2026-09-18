{
  imports = [
    ./min.nix
    ./workarounds/nvim-notify-bg-fix.nix
  ];

  vim = {
    keymaps = [
      {
        key = "-";
        mode = "n";
        action = "<cmd>Oil<CR>";
        desc = "Open parent directory";
      }
    ];

    languages = {
      css.enable = true;
      go.enable = true;
      html.enable = true;
      just.enable = true;
      markdown.enable = true;
      python.enable = true;
      svelte.enable = true;
      typescript.enable = true;
    };

    mini = {
      icons.enable = true;
    };

    utility = {
      oil-nvim = {
        enable = true;
        gitStatus.enable = true;
      };
    };

    notify = {
      nvim-notify.enable = true;
    };

    notes = {
      neorg.enable = true;
      todo-comments.enable = true;
    };

    statusline = {
      lualine = {
        enable = true;

        setupOpts = {
          sections = {
            lualine_a = [
              {
                "@1" = "mode";
                separator = {
                  left = "";
                  right = "";
                };
              }
            ];

            lualine_b = [
              {
                "@1" = "filetype";
                separator = {
                  left = "";
                  right = "";
                };
              }
              {
                "@1" = "filename";
                separator = {
                  left = "";
                  right = "";
                };
              }
            ];

            lualine_c = [
              {
                "@1" = "diff";
                separator = {
                  left = "";
                  right = "";
                };
              }
            ];

            lualine_x = [
              {
                "@1" = "diagnostics";
                separator = {
                  left = "";
                  right = "";
                };
              }
            ];

            lualine_y = [
              {
                "@1" = "branch";
                separator = {
                  left = "";
                  right = "";
                };
              }
            ];

            lualine_z = [
              {
                "@1" = "location";
                separator = {
                  left = "";
                  right = "";
                };
              }
            ];
          };
        };
      };
    };

    terminal = {
      toggleterm = {
        enable = true;
        lazygit.enable = true;
      };
    };

    git = {
      gitsigns.enable = true;
    };
  };
}

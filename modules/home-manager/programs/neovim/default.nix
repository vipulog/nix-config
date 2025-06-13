{
  inputs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.programs.neovim;
in {
  imports = [inputs.nvf.homeManagerModules.default];

  options.internal.programs.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      VISUAL = "nvim";
      EDITOR = "nvim";
    };

    programs.nvf = with lib.generators; {
      enable = true;

      settings.vim = {
        vimAlias = true;
        viAlias = true;
        withNodeJs = true;

        options = {
          tabstop = 2;
          shiftwidth = 2;
          scrolloff = 5;
          wrap = false;
        };

        keymaps = [
          {
            key = "<leader>bd";
            mode = ["n"];
            action = "<Cmd>lua MiniBufremove.delete()<CR>";
            silent = true;
            desc = "Delete buffer";
          }
          {
            key = "<leader>bw";
            mode = ["n"];
            action = "<Cmd>lua MiniBufremove.wipeout()<CR>";
            silent = true;
            desc = "Wipeout buffer";
          }
        ];

        lsp = {
          enable = true;
          formatOnSave = true;
          inlayHints.enable = true;
          lightbulb = {
            enable = true;
            setupOpts = {
              sign = {
                enabled = true;
                text = "";
                lens_text = "";
              };
            };
          };
          lspSignature.enable = true;
          lspkind.enable = true;
          lspconfig.enable = true;
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;
          nix.enable = true;
          lua.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };
          python.enable = true;
          markdown.enable = true;
          html.enable = true;
          css.enable = true;
          ts = {
            enable = true;
            extensions.ts-error-translator.enable = true;
          };
        };

        diagnostics = {
          enable = true;
          config = {
            virtual_lines.enable = true;
            underline = true;
          };
        };

        spellcheck = {
          enable = true;
          languages = ["en"];
          programmingWordlist.enable = true;
        };

        clipboard = {
          enable = true;
          registers = "unnamed";
          providers = {
            wl-copy.enable = true;
            xsel.enable = true;
          };
        };

        comments = {
          comment-nvim.enable = true;
        };

        telescope = {
          enable = true;
        };

        treesitter = {
          enable = true;
          autotagHtml = true;
          context = {
            enable = false;
            setupOpts = {
              line_numbers = false;
              max_lines = 4;
            };
          };
        };

        autocomplete = {
          nvim-cmp.enable = true;
        };

        utility = {
          surround = {
            enable = true;
            useVendoredKeybindings = false;
          };
          outline.aerial-nvim = {
            enable = true;
            mappings.toggle = "<leader>a";
          };
        };

        notify = {
          nvim-notify = {
            enable = true;
            setupOpts = {
              render = "minimal";
              stages = "fade";
              timeout = 1500;
            };
          };
        };

        ui = {
          smartcolumn = {
            enable = true;
            setupOpts = {
              disabled_filetypes = ["dashboard"];
            };
          };
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
            lualine.winbar = {
              enable = true;
              alwaysRender = false;
            };
          };
          noice.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
            activeSection = {
              a = [
                ''
                  {
                    "mode",
                    icons_enabled = false,
                    icon = nil,
                    separator = nil,
                    draw_empty = true,
                    color = {
                      gui = 'bold',
                    },
                    fmt = function(str)
                      return " "
                    end,
                    padding = {
                      left = 0,
                      right = 0,
                    },
                  }
                ''
              ];
              b = [
                ''
                  {
                    "filename",
                    icons_enabled = true,
                    icon = nil,
                    symbols = {
                      modified = ' ',
                      readonly = ' ',
                    },
                    separator = nil,
                    draw_empty = false,
                    color = {
                      fg = "${config.lib.stylix.colors.withHashtag.base05}",
                      bg = "${config.lib.stylix.colors.withHashtag.base01}",
                    },
                  }
                ''
              ];
              c = [];
              x = [
                ''
                  {
                    require("noice").api.statusline.mode.get,
                    cond = require("noice").api.statusline.mode.has,
                    icons_enabled = false,
                    icon = nil,
                    separator = nil,
                    draw_empty = false,
                    color = {
                      fg = "${config.lib.stylix.colors.withHashtag.base0E}",
                      bg = "${config.lib.stylix.colors.withHashtag.base01}",
                    },
                    padding = {
                      left = 0,
                      right = 1,
                    },
                  }
                ''
                ''
                  {
                    function()
                      return [[|]]
                    end,
                    cond = require("noice").api.statusline.mode.has,
                    icons_enabled = false,
                    icon = nil,
                    separator = nil,
                    draw_empty = false,
                    color = {
                      fg = "${config.lib.stylix.colors.withHashtag.base03}",
                      bg = "${config.lib.stylix.colors.withHashtag.base01}",
                    },
                    padding = {
                      left = 0,
                      right = 1,
                    },
                  }
                ''
                ''
                  {
                    -- Lsp server name
                    function()
                      local buf_ft = vim.bo.filetype
                      local excluded_buf_ft = {
                        toggleterm = true,
                        NvimTree = true,
                        ["neo-tree"] = true,
                        TelescopePrompt = true
                      }

                      if excluded_buf_ft[buf_ft] then
                        return ""
                        end

                      local bufnr = vim.api.nvim_get_current_buf()
                      local clients = vim.lsp.get_clients({ bufnr = bufnr })

                      if vim.tbl_isempty(clients) then
                        return "No Active LSP"
                      end

                      local active_clients = {}
                      for _, client in ipairs(clients) do
                        table.insert(active_clients, client.name)
                      end

                      return table.concat(active_clients, ", ")
                    end,
                    icons_enabled = true,
                    icon = ' ',
                    separator = nil,
                    draw_empty = false,
                    color = {
                      fg = "${config.lib.stylix.colors.withHashtag.base04}",
                      bg = "${config.lib.stylix.colors.withHashtag.base01}",
                    },
                    padding = {
                      left = 0,
                      right = 1,
                    },
                  }
                ''
                ''
                  {
                    function()
                      return [[|]]
                    end,
                    icons_enabled = false,
                    icon = nil,
                    separator = nil,
                    draw_empty = false,
                    color = {
                      fg = "${config.lib.stylix.colors.withHashtag.base03}",
                      bg = "${config.lib.stylix.colors.withHashtag.base01}",
                    },
                    padding = {
                      left = 0,
                      right = 1,
                    },
                  }
                ''
              ];
              y = [
                ''
                  {
                    "branch",
                    cond = function()
                      local ok, MiniGit = pcall(require, 'mini.git')
                      if not ok then return false end

                      local data = MiniGit.get_buf_data()
                      local git_branch = data and data.head_name
                      return git_branch ~= nil and git_branch ~= ""
                    end,
                    icons_enabled = true,
                    icon = '',
                    separator = nil,
                    draw_empty = false,
                    color = {
                      fg = "${config.lib.stylix.colors.withHashtag.base04}",
                      bg = "${config.lib.stylix.colors.withHashtag.base01}",
                    },
                    padding = {
                      left = 0,
                      right = 1,
                    },
                  }
                ''
                ''
                  {
                    function()
                      return [[|]]
                    end,
                    cond = function()
                      local ok, MiniGit = pcall(require, 'mini.git')
                      if not ok then return false end

                      local data = MiniGit.get_buf_data()
                      local git_branch = data and data.head_name
                      return git_branch ~= nil and git_branch ~= ""
                    end,
                    icons_enabled = false,
                    icon = nil,
                    separator = nil,
                    draw_empty = false,
                    color = {
                      fg = "${config.lib.stylix.colors.withHashtag.base03}",
                      bg = "${config.lib.stylix.colors.withHashtag.base01}",
                    },
                    padding = {
                      left = 0,
                      right = 1,
                    },
                  }
                ''
              ];
              z = [
                ''
                  {
                    "progress",
                    icons_enabled = false,
                    icon = nil,
                    separator = nil,
                    draw_empty = false,
                    color = {
                      fg = "${config.lib.stylix.colors.withHashtag.base04}",
                      bg = "${config.lib.stylix.colors.withHashtag.base01}",
                    },
                    padding = {
                      left = 0,
                      right = 1,
                    },
                  }
                ''
                ''
                  {
                    "location",
                    icons_enabled = false,
                    icon = nil,
                    separator = nil,
                    draw_empty = false,
                    color = {
                      fg = "${config.lib.stylix.colors.withHashtag.base04}",
                      bg = "${config.lib.stylix.colors.withHashtag.base01}",
                    },
                    padding = {
                      left = 0,
                      right = 1,
                    },
                  }
                ''
              ];
            };
          };
        };

        git = {
          gitsigns = {
            enable = true;
            mappings = {
              nextHunk = "]h";
              previousHunk = "[h";
              blameLine = "<leader>gb";
              diffProject = "<leader>gD";
              diffThis = "<leader>gd";
              previewHunk = "<leader>gP";
              resetBuffer = "<leader>gR";
              resetHunk = "<leader>gr";
              stageBuffer = "<leader>gS";
              stageHunk = "<leader>gs";
              toggleBlame = "<leader>gtb";
              toggleDeleted = "<leader>gtd";
              undoStageHunk = "<leader>gu";
            };
          };
        };

        visuals = {
          indent-blankline = {
            enable = true;
            setupOpts = {
              exclude.filetypes = ["log" "txt" "md" "dashboard" "help"];
            };
          };
          rainbow-delimiters.enable = true;
          nvim-web-devicons.enable = true;
          cinnamon-nvim = {
            enable = true;
            setupOpts = {
              keymaps.basic = true;
            };
          };
          cellular-automaton = {
            enable = true;
            mappings.makeItRain = null;
          };
        };

        notes = {
          todo-comments.enable = true;
        };

        binds = {
          hardtime-nvim.enable = true;
          whichKey.enable = true;
        };

        projects = {
          project-nvim.enable = true;
        };

        dashboard = {
          dashboard-nvim = {
            enable = true;
            setupOpts = {
              config = {
                week_header.enable = true;
                packages.enable = false;
                shortcut = mkForce {};
                footer = mkForce {};
              };
            };
          };
        };

        mini = {
          ai.enable = true;
          basics = {
            enable = true;
            setupOpts = {
              mappings = {
                windows = true;
                move_with_alt = true;
              };
            };
          };
          bracketed.enable = true;
          bufremove.enable = true;
          cursorword.enable = true;
          git.enable = true;
          indentscope = {
            enable = true;
            setupOpts = {
              ignore_filetypes = ["log" "txt" "md" "dashboard" "help"];
              draw.animation = mkLuaInline "require('mini.indentscope').gen_animation.none()";
            };
          };
          jump.enable = true;
          jump2d.enable = true;
          move.enable = true;
          operators.enable = true;
          pairs.enable = true;
          splitjoin.enable = true;
          tabline.enable = true;
          trailspace.enable = true;
        };

        assistant.codecompanion-nvim = {
          enable = true;
          setupOpts = {
            adapters = mkLuaInline ''
              {
                gemini = function()
                  return require("codecompanion.adapters").extend("gemini", {
                    env = {
                      api_key = "",
                    },
                    schema = {
                      model = {
                        default = "gemini-2.0-flash",
                      },
                    },
                  })
                end
              }
            '';
            strategies = {
              chat.adapter = "gemini";
              inline.adapter = "gemini";
              cmd.adapter = "gemini";
            };
            opts.send_code = true;
            display.chat.auto_scroll = true;
          };
        };
      };
    };
  };
}

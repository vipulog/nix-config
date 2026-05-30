# REASON FOR PATCH:
# nvim-notify warns "Highlight group 'NotifyBackground' has no background highlight"
# when using transparent themes. NVF hardcodes background_colour = "NotifyBackground".
#
# THE FIX:
# Dynamically forces a fallback background on the 'NotifyBackground' highlight group
# every time a colorscheme loads, avoiding the need to eagerly load the plugin or
# hardcode colors in Nix.
#
# WHEN TO REMOVE:
# Remove this file when NVF either exposes an option to disable the hardcoded
# `background_colour` parameter, or nvim-notify gracefully handles transparent backgrounds.
{
  vim.luaConfigRC."00-nvim-notify-patch" =
    # lua
    ''
      vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, {
        group = vim.api.nvim_create_augroup("FixNotifyBackground", { clear = true }),
        callback = function()
          local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
          local normal_float = vim.api.nvim_get_hl(0, { name = "NormalFloat" })

          local fallback_bg = normal.bg or normal_float.bg or 0x000000

          vim.api.nvim_set_hl(0, "NotifyBackground", {
            bg = fallback_bg,
            default = false
          })
        end,
      })
    '';
}

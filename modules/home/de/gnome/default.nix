{
  pkgs,
  config,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.de.gnome;

  extensionIds = builtins.map (x: x.extensionUuid) extensions;
  extensions = with pkgs.gnomeExtensions; [
    alphabetical-app-grid
    tiling-shell
    blur-my-shell
  ];
in {
  options.${namespace}.de.gnome = {
    enable = lib.mkEnableOption "gnome";
  };

  config = lib.mkIf cfg.enable {
    home.packages = lib.mkMerge [
      (with pkgs; [pkgs.refine nerd-fonts.jetbrains-mono])
      extensions
    ];

    dconf = {
      enable = true;

      settings = with lib.hm.gvariant; {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = extensionIds;

          favorite-apps = [
            "com.mitchellh.ghostty.desktop"
            "org.gnome.Nautilus.desktop"
            "org.gnome.Software.desktop"
            "zen-beta.desktop"
            "net.lutris.Lutris.desktop"
            "org.gnome.Geary.desktop"
            "org.gnome.Settings.desktop"
          ];
        };

        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          gtk-theme = "Adwaita";
          icon-theme = "Adwaita";
          cursor-theme = "Adwaita";
          show-battery-percentage = true;
        };

        "org/gnome/shell/extensions/tilingshell" = {
          show-indicator = true;
          enable-autotiling = true;
          inner-gaps = mkUint32 12;
          enable-window-border = false;
          enable-smart-window-border-radius = true;
          layouts-json = builtins.readFile ./layouts.json;
          override-wndow-menu = false;
          overriden-settings = ''
            {"org.gnome.mutter":{"edge-tiling":"false"}}
          '';
        };
      };
    };

    gtk = {
      enable = true;
      gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
      gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    };

    qt = {
      enable = true;
      platformTheme.name = "adwaita";
      style.name = "adwaita-dark";
    };

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = ["JetBrainsMono Nerd Font"];
      };
    };

    ${namespace}.programs = {
      helix.theme = "adwaita-dark";
      ghostty.theme = "Adwaita Dark";
    };

    systemd.user.sessionVariables = {
      __HM_SESS_VARS_SOURCED = "";
    };
  };
}

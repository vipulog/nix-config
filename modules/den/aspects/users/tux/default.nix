{den, ...}: {
  den.aspects.tux = {
    includes = [
      # User setup
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "zsh")

      # Shell / CLI environment
      den.aspects.zsh
      den.aspects.starship
      den.aspects.atuin
      den.aspects.zoxide
      den.aspects.eza
      den.aspects.bat
      den.aspects.btop
      den.aspects.nix-index
      den.aspects.zellij

      # Version control
      den.aspects.git
      den.aspects.delta
      den.aspects.jujutsu
      den.aspects.lazygit

      # Dev tooling
      den.aspects.neovim
      den.aspects.zed-editor
      den.aspects.direnv

      # AI / coding agents
      den.aspects.codex
      den.aspects.antigravity-cli

      # Virtualization / containers
      den.aspects.podman
      den.aspects.waydroid

      # Networking / remote access
      den.aspects.ssh
      den.aspects.tailscale
      den.aspects.kdeconnect

      # System / security
      den.aspects.sudo

      # Desktop environment
      den.aspects.niri-de

      # Browsers
      den.aspects.chromium
      den.aspects.firefox
      den.aspects.redirector
    ];

    homeManager = {
      home.file.".face".source = ./avatar.png;
    };
  };
}

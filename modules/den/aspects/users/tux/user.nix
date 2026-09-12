{den, ...}: {
  den.aspects.tux = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "zsh")

      den.aspects.zsh
      den.aspects.atuin
      den.aspects.neovim
      den.aspects.ssh
      den.aspects.git
      den.aspects.jujutsu
      den.aspects.delta
      den.aspects.lazygit
      den.aspects.zoxide
      den.aspects.eza
      den.aspects.bat
      den.aspects.direnv
      den.aspects.starship
      den.aspects.btop
      den.aspects.zellij
      den.aspects.nix-index
      den.aspects.antigravity-cli
      den.aspects.codex
      den.aspects.zed-editor

      # den.aspects.qutebrowser
      den.aspects.chromium
      den.aspects.firefox
      den.aspects.redirector

      den.aspects.kdeconnect
    ];

    homeManager = {
      home.file.".face".source = ./avatar.png;
    };
  };
}

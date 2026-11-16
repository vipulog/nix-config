{den, ...}: {
  den.aspects.tux = {
    includes = [
      den.batteries.define-user
      (den.batteries.user-shell "zsh")
      den.aspects.zsh
      den.aspects.starship
      den.aspects.atuin
      den.aspects.zoxide
      den.aspects.eza
      den.aspects.bat
      den.aspects.btop
      den.aspects.nix-index
      den.aspects.zellij
      den.aspects.tux.git
      den.aspects.delta
      den.aspects.tux.jujutsu
      den.aspects.lazygit
      den.aspects.neovim
      den.aspects.direnv
      den.aspects.codex
      den.aspects.antigravity-cli
      den.aspects.opencode
      den.aspects.ssh
    ];

    homeManager = {
      home.file.".face".source = ./res/avatar.png;
    };
  };
}

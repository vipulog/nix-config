{den, ...}: {
  den.aspects.tux = {
    includes = [
      den.batteries.define-user
      (den.batteries.user-shell "zsh")
      den.aspects.zsh
      den.aspects.atuin
      den.aspects.direnv
      den.aspects.starship
      den.aspects.zellij
      den.aspects.zoxide
      den.aspects.bat
      den.aspects.btop
      den.aspects.eza
      den.aspects.nix-index
      den.aspects.delta
      den.aspects.git
      den.aspects.jujutsu
      den.aspects.lazygit
      den.aspects.neovim
      den.aspects.antigravity-cli
      den.aspects.codex
      den.aspects.opencode
      den.aspects.ssh
    ];

    homeManager = {
      home.file.".face".source = ./res/avatar.png;

      programs.git.settings.user = {
        name = "vipulog";
        email = "90324465+vipulog@users.noreply.github.com";
      };
    };
  };
}

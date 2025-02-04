{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.git = {
    enable = true;

    userName = "VipulOG";
    userEmail = "90324465+VipulOG@users.noreply.github.com";

    extraConfig = {
      init.defaultBranch = "main";
      trim.bases = "develop,master,main"; # for git-trim
      push.autoSetupRemote = true;
      pull.rebase = true;

      # Replace https with ssh
      url."ssh://git@github.com/vipulog" = {
        insteadOf = "https://github.com/vipulog";
      };
    };

    # A syntax-highlighting pager in Rust
    delta = {
      package = pkgs.delta;
      enable = true;
      options = {
        diff-so-fancy = true;
        line-numbers = true;
        true-color = "always";
      };
    };

    aliases = {
      # Improved log formatting
      ls = ''log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'';
      ll = ''log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'';

      # Undo commands
      undo = "reset --soft HEAD~1"; # Undo last commit, keep changes
      undo-hard = "reset --hard HEAD~1"; # Completely remove last commit
      unstage = "restore --staged"; # Unstage file without modifying it
    };
  };

  home = {
    packages = [pkgs.git-trim];

    # programs.git will generate the config file: ~/.config/git/config
    # to make git use this config file, ~/.gitconfig should not exist!
    # https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
    activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
      rm -f ${config.home.homeDirectory}/.gitconfig
    '';
  };
}

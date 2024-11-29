{ pkgs, username, home-manager, ... }:

{
  home-manager.users.${username} = { lib, config, ... }: {

    home = {
      packages = with pkgs; [ git-trim ];
      sessionVariables = {
        # enable scrolling in git diff
        DELTA_PAGER = "less -R";
      };
    };

    # programs.git will generate the config file: ~/.config/git/config
    # to make git use this config file, ~/.gitconfig should not exist!
    # https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
    home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
      rm -f ${config.home.homeDirectory}/.gitconfig
    '';

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
        ls = ''log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate'';
        ll = ''log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'';

        amend = "commit --amend"; # Amend commit via `git amend`
        unstage = "reset HEAD --"; # Unstage file via `git unstage <file>`
        merged = "branch --merged"; # List merged (into HEAD) branches via `git merged`
        unmerged = "branch --no-merged"; # List unmerged (into HEAD) branches via `git unmerged`
        nonexist = "remote prune origin --dry-run"; # List non-existent (remote) branches via `git nonexist`

        # Delete merged branches except main, master, dev, staging
        delmerged = ''! git branch --merged | egrep -v "(^\*|main|master|dev|staging)" | xargs git branch -d'';

        # Delete non-existent (remote) branches
        delnonexist = "remote prune origin";

        # Aliases for submodule
        update = "submodule update --init --recursive";
        foreach = "submodule foreach";
      };
    };
  };
}

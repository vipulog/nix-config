{
  config,
  lib,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.git;
in {
  options.${namespace}.programs.git = {
    enable = lib.mkEnableOption "git";
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;

      # A syntax-highlighting pager in Rust
      delta = {
        enable = true;
        options = {
          diff-so-fancy = true;
          line-numbers = true;
          true-color = "always";
        };
      };

      extraConfig = {
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        pull.rebase = true;

        # Replace https with ssh
        url."git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };

    home = {
      # programs.git will generate the config file: ~/.config/git/config
      # to make git use this config file, ~/.gitconfig should not exist!
      # https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
      activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
        rm -f ${config.home.homeDirectory}/.gitconfig
      '';
    };
  };
}

{pkgs, ...}: {
  imports = [
    ./zsh.nix
    ./ghostty.nix
    ./helix.nix
    ./git.nix
  ];

  home = {
    sessionPath = ["$HOME/.local/bin"];

    sessionVariables = {
      FLAKE = "$HOME/nixos-config";
      EDITOR = "hx";

      # enable scrolling in git diff
      DELTA_PAGER = "less -R";
    };
  };

  home.packages = with pkgs; [
    # Packages that don't have custom configs go here
    coreutils # basic gnu utils
  ];
}

{pkgs, ...}: {
  imports = [
    ./zsh.nix
    ./helix.nix
    ./git.nix
  ];

  home = {
    sessionPath = ["$HOME/.local/bin"];

    sessionVariables = {
      FLAKE = "$HOME/nixos-config";
      # enable scrolling in git diff
      DELTA_PAGER = "less -R";
    };

    packages = with pkgs; [
      # Packages that don't have custom configs go here
      coreutils # basic gnu utils
    ];
  };
}

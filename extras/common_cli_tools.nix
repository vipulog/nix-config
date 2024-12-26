{ pkgs, username, home-manager, ... }: {
  home-manager.users.${username}.home.packages =  with pkgs; [
    wget
    curl
    gnugrep
    gnused
    gawk
    file
    which
    tree
    rsync
    gnutar
    zip
    xz
    parted
  ];
}

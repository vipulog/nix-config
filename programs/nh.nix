{ username, ... }: {
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 1m --keep 15";
    flake = "/home/${username}/nixos-config";
  };
}

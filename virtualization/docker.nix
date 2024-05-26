{ pkgs, username, ... }: {
  environment.systemPackages = with pkgs; [ docker-compose ];
  virtualisation.docker.enable = true;
  users.users.${username}.extraGroups = [ "docker" ];
}

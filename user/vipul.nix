{ pkgs, username, ... }: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    shell = pkgs.zsh;
    isNormalUser = true;
    initialPassword = "1";
    extraGroups = [ "wheel" ];
  };
}

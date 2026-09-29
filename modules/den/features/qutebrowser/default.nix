{
  den.aspects.qutebrowser = {user}: {
    homeManager = {
      programs.qutebrowser = {
        enable = true;
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".local/share/qutebrowser"
        ".cache/qutebrowser"
      ];
    };
  };
}

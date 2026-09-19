{
  den.aspects.qutebrowser = {
    homeManager = {
      programs.qutebrowser = {
        enable = true;
      };
    };

    persist-user = {
      directories = [
        ".local/share/qutebrowser"
        ".cache/qutebrowser"
      ];
    };
  };
}

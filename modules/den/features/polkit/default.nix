{
  den.aspects.polkit = {
    nixos = {
      security.polkit = {
        enable = true;
        enablePkexecWrapper = true;
      };
    };
  };
}

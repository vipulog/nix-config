{den, ...}: {
  den.aspects.tux = {
    includes = [
      den.batteries.define-user
      den.batteries.primary-user
      (den.batteries.user-shell "zsh")
    ];

    user = {
      initialPassword = "1234";
    };
  };
}

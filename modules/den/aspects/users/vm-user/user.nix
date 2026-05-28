{den, ...}: {
  den.aspects.vm-user = {
    includes = [den.batteries.define-user];

    user = {
      initialPassword = "1";
    };
  };
}

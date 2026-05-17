{den, ...}: {
  den.aspects.tux = {
    includes = [den.batteries.primary-user];

    user = {
      initialPassword = "1234";
    };
  };
}

{lib, ...}: {
  den.schema.user = {
    includes = [];
    classes = lib.mkDefault ["homeManager"];
  };
}

{den, ...}: {
  den.aspects.ephemeral-host.preservation.persist-user = {
    includes = [den.aspects.ephemeral-host.preservation.persist-user.defaults];

    nixos = {
      lib,
      user,
      persist-user,
      ...
    }: let
      userPersists =
        builtins.filter (p: (p.username or null) == user.name)
        persist-user;
    in {
      preservation.preserve.users.${user.name} = {
        files = lib.unique (lib.concatLists (
          map (p: p.files or []) userPersists
        ));

        directories = lib.unique (lib.concatLists (
          map (p: p.directories or []) userPersists
        ));
      };
    };

    defaults = {
      persist-user = {
        files = [
          ".config/mimeapps.list"
        ];

        directories = [
          "Documents"
          "Music"
          "Pictures"
          "Videos"
          "Dev"

          {
            directory = ".local/share/keyrings";
            mode = "0700";
          }
        ];
      };
    };
  };
}

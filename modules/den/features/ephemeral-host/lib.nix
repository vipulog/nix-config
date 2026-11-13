{lib, ...}: {
  flake.lib.den.ephemeral-host = {
    mkPersistSubmodule = {options}: let
      preserveOpt = options.preservation.preserveAt;
      preserveSub = preserveOpt.type.nestedTypes.elemType.getSubOptions [];
      fileSub = preserveSub.files.type.nestedTypes.elemType.getSubOptions [];
      dirSub = preserveSub.directories.type.nestedTypes.elemType.getSubOptions [];

      mkEntrySubmodule = {isFile}: let
        subOpts =
          if isFile
          then fileSub
          else dirSub;
      in
        lib.types.submodule ({name, ...}: {
          options = {
            enable = lib.mkOption {
              type = lib.types.bool;
              default = true;

              description = "Whether to preserve this ${
                if isFile
                then "file"
                else "directory"
              }.";
            };

            ${
              if isFile
              then "file"
              else "directory"
            } = lib.mkOption {
              type = lib.types.str;
              default = name;

              description =
                subOpts.${
                  if isFile
                  then "file"
                  else "directory"
                }.description or "";
            };

            how = lib.mkOption {
              type = lib.types.nullOr subOpts.how.type;
              default = null;
              description = subOpts.how.description or "";
            };

            user = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = subOpts.user.description or "";
            };

            group = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = subOpts.group.description or "";
            };

            mode = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = subOpts.mode.description or "";
            };

            configureParent = lib.mkOption {
              type = lib.types.nullOr subOpts.configureParent.type;
              default = null;
              description = subOpts.configureParent.description or "";
            };

            parent = lib.mkOption {
              type = lib.types.nullOr (lib.types.submodule {
                options = {
                  user = lib.mkOption {
                    type = lib.types.nullOr lib.types.str;
                    default = null;
                    description = subOpts.parent.user.description or "";
                  };

                  group = lib.mkOption {
                    type = lib.types.nullOr lib.types.str;
                    default = null;
                    description = subOpts.parent.group.description or "";
                  };

                  mode = lib.mkOption {
                    type = lib.types.nullOr lib.types.str;
                    default = null;
                    description = subOpts.parent.mode.description or "";
                  };
                };
              });

              default = null;
              description = "Parent directory configuration.";
            };

            mountOptions = lib.mkOption {
              type = lib.types.nullOr subOpts.mountOptions.type;
              default = null;
              description = subOpts.mountOptions.description or "";
            };

            createLinkTarget = lib.mkOption {
              type = lib.types.nullOr subOpts.createLinkTarget.type;
              default = null;
              description = subOpts.createLinkTarget.description or "";
            };

            inInitrd = lib.mkOption {
              type = lib.types.nullOr subOpts.inInitrd.type;
              default = null;
              description = subOpts.inInitrd.description or "";
            };
          };
        });
    in
      lib.types.submodule {
        options = {
          directories = lib.mkOption {
            type = lib.types.attrsOf (mkEntrySubmodule {isFile = false;});
            default = {};
            description = "Directories to preserve.";
          };

          files = lib.mkOption {
            type = lib.types.attrsOf (mkEntrySubmodule {isFile = true;});
            default = {};
            description = "Files to preserve.";
          };
        };
      };

    persistToPreservation = entries:
      lib.pipe entries [
        (lib.filterAttrs (_: cfg: cfg.enable))
        (lib.mapAttrsToList (_: cfg: builtins.removeAttrs cfg ["enable"]))
        (map (lib.filterAttrs (_: v: v != null)))
        (map (entry:
          if entry ? parent && builtins.isAttrs entry.parent
          then entry // {parent = lib.filterAttrs (_: v: v != null) entry.parent;}
          else entry))
      ];
  };
}

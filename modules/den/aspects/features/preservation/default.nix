{
  lib,
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    preservation.url = "github:nix-community/preservation";
  };

  den.aspects.preservation = {defaultPreserveAt ? "/persistent"}: let
    preservationFwd = {
      host,
      aspect-chain,
      ...
    }: (
      den.provides.forward {
        each = lib.singleton true;
        fromClass = _: "preservation";
        intoClass = _: host.class;
        intoPath = _: ["$denPreservationAspect"];
        fromAspect = _: lib.head aspect-chain;
        guard = {options, ...}: options ? preservation.preserveAt;
      }
    );
  in {
    includes = [preservationFwd];

    nixos = {
      config,
      options,
      ...
    }: let
      preserveAtOpt = options.preservation.preserveAt;
      preserveAtOpts = preserveAtOpt.type.getSubOptions [];
    in {
      imports = [inputs.preservation.nixosModules.default];

      options."$denPreservationAspect" = {
        preserveAt = preserveAtOpt;
        inherit (preserveAtOpts) directories files users;
      };

      config = {
        preservation = {
          enable = true;

          preserveAt = lib.mkMerge [
            config."$denPreservationAspect".preserveAt

            {
              ${defaultPreserveAt} = {
                directories = config."$denPreservationAspect".directories;
                files = config."$denPreservationAspect".files;
                users = config."$denPreservationAspect".users;
              };
            }
          ];
        };
      };
    };
  };
}

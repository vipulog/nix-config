{
  lib,
  username,
  ...
}: let
  homePath = "modules/home/${username}/";

  optionalModulePaths = map (x: "${homePath}/optional/${x}") [
    "desktop/niri"
    "browsers"
    "ghostty.nix"
    "btop.nix"
    "direnv.nix"
  ];
in {
  home-manager.users.${username} = {
    imports = lib.flatten [
      (map lib.custom.relativeToRoot (lib.flatten [
        "${homePath}/core"
        optionalModulePaths
      ]))
    ];

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";
  };
}

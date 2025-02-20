{lib, ...}: {
  home-manager.users.vipul = {
    imports = lib.flatten [
      (map lib.custom.relativeToRoot [
        "modules/home/vipul/core"
        "modules/home/vipul/optional/desktop/niri"
        "modules/home/vipul/optional/browsers"
        "modules/home/vipul/optional/ghostty.nix"
        "modules/home/vipul/optional/btop.nix"
        "modules/home/vipul/optional/nnn.nix"
        "modules/home/vipul/optional/direnv.nix"
        "modules/home/vipul/optional/zoxide.nix"
        "modules/home/vipul/optional/lazygit.nix"
        "modules/home/vipul/optional/atuin.nix"
      ])
    ];

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "23.11";
  };
}

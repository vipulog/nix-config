# nix-config

Personal NixOS and Home Manager configuration built as a dendritic flake using
[`flake-parts`](https://flake.parts/),
[`import-tree`](https://github.com/vic/import-tree),
[`flake-file`](https://github.com/vic/flake-file), and
[`den`](https://den.denful.dev/).

## Structure

Every `.nix` file under `modules/` (except `_`-prefixed directories) is
auto-imported by `import-tree`. Features declare their own `flake-file.inputs`
locally rather than in `flake.nix`.

- [`modules/den/hosts/`](modules/den/hosts/) — machine definitions, hardware,
  and host-specific configuration (including per-host user overrides under
  `<host>/users/<user>/`)
- [`modules/den/users/`](modules/den/users/) — shared user definitions across
  hosts and standalone homes
- [`modules/den/homes/`](modules/den/homes/) — standalone Home Manager
  configurations
- [`modules/den/features/`](modules/den/features/) — reusable feature modules
  for hosts and users
- [`modules/nvf/`](modules/nvf/) — standalone `nvf` Neovim packages
- [`modules/devshell/`](modules/devshell/),
  [`modules/pre-commit/`](modules/pre-commit/),
  [`modules/treefmt/`](modules/treefmt/) — devshell commands, git hooks, and
  formatting

## How-To Recipes

Because flakes only see git-tracked files, stage new `.nix` files before
building or checking.

### Add a Host

1. Create `modules/den/hosts/<host>/hardware.nix` defining
   `den.aspects.<host>.hardware.nixos = { ... }: { ... };`.
2. Create `modules/den/hosts/<host>/default.nix`:

```nix
{den, ...}: {
  den.hosts.x86_64-linux.<host> = {
    channel = "unstable"; # optional: "unstable" | "stable"
    users.<user> = {};
  };

  den.aspects.<host> = {
    includes = [
      den.aspects.<host>.hardware
      den.aspects.ephemeral-host
      den.aspects.disko.btrfs-impermanence
      den.aspects.my-secrets
      den.aspects.sshd
    ];

    nixos = {
      disko.btrfs-impermanence.device = "/dev/nvme0n1";
      system.stateVersion = "26.05";
    };

    persist-host.directories."/var/log".enable = true;
  };
}
```

3. For a server/headless host without Home Manager, set
   `users.root.classes = ["user"];` and
   `excludes = [den.aspects.home-manager den.aspects.nur];` on
   `den.aspects.<host>`.
4. If using `my-secrets`, add `<host>.yaml` in `my-secrets/secrets/sops/` (and
   `<user>_<host>.yaml` for hosted HM users).

### Add a User

1. Create a shared user aspect in `modules/den/users/<user>/default.nix`:

```nix
{den, ...}: {
  den.aspects.<user> = {
    includes = [
      den.batteries.define-user
      (den.batteries.user-shell "zsh")
      den.aspects.zsh
      den.aspects.git
    ];

    homeManager = {
      home.stateVersion = "26.05";
      programs.git.settings.user = {
        name = "<name>";
        email = "<email>";
      };
    };
  };
}
```

2. Attach the user to any host via
   `den.hosts.<system>.<host>.users.<user> = {};` (which defaults `classes` to
   `["homeManager"]`), or expose a standalone home in
   `modules/den/homes/<user>/default.nix` via `den.homes.<system>.<user> = {};`.
3. Put machine-specific user config in
   `modules/den/hosts/<host>/users/<user>/default.nix` under
   `den.aspects."<user>@<host>"` (for example `den.batteries.primary-user`,
   `user.hashedPasswordFile`, desktop/feature includes, and `persist-user`
   entries); Den merges both `den.aspects."<user>@<host>"` and
   `den.aspects.<user>`.

### Add a Feature

1. Create `modules/den/features/<feature>/default.nix`. Keep any new flake
   inputs local with `flake-file.inputs` and split class concerns cleanly
   (`os`/`nixos`/`darwin`, `homeManager`, `user`, `persist-host`,
   `persist-user`):

```nix
{inputs, ...}: {
  # Optional: declare inputs needed only by this feature
  # flake-file.inputs.<name>.url = "...";

  den.aspects.<feature> = {
    nixos = {
      programs.<feature>.enable = true;
    };

    homeManager = {
      programs.<feature>.enable = true;
    };

    persist-user.directories.".config/<feature>".enable = true;
  };
}
```

2. If you added or changed `flake-file.inputs`, regenerate `flake.nix` with
   `nix run .#write-flake`.
3. Include `den.aspects.<feature>` in `den.aspects.<host>.includes` (for
   system/`persist-host` config) and/or `den.aspects.<user>.includes` or
   `den.aspects."<user>@<host>".includes` (for
   `homeManager`/`user`/`persist-user` config).

## Commands

```sh
# Enter devshell (provides nh host-{build,test,boot,switch} helpers and git hooks)
nix develop

# Regenerate flake.nix after editing any module's `flake-file.inputs`
nix run .#write-flake

# Format and run checks
nix fmt
nix flake check
```

## Notes

- **Generated `flake.nix`:** Do not edit `flake.nix` directly; update
  `flake-file.inputs` in the relevant module and run `nix run .#write-flake`.
- **Secrets:** Encrypted SOPS data lives in the external `my-secrets` flake
  input and requires the matching host/user SSH age keys to decrypt on
  activation.

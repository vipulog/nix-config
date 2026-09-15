{den, ...}: {
  den.aspects.antigravity-cli = {user}: {
    includes = [
      (den.batteries.unfree ["antigravity-cli"])
      den.aspects.mcp
    ];

    homeManager = {
      programs.antigravity-cli = {
        enable = true;
        enableMcpIntegration = true;

        context = {
          GEMINI = ''
            ## Environment

            - Nix-based.
            - Missing command: `nix shell nixpkgs#<pkg> -c <command>`.
            - Devshell exists: prefer `nix develop -c <command>`.
            - Don't touch `flake.nix`/`flake.lock`/`shell.nix` unless asked.

            ## VCS

            - Check `.jj/` in project root.
            - No `.jj/`: plain git.
            - Else: use `jj` for writes (commit, rebase, merge, checkout).
            - Never raw `git` writes on `.jj/` projects — causes conflicts.
            - Read-only git (status/log/diff) always fine.

            ## Secrets

            - Never touch/read/print/log contents of:
              - Private keys (`id_rsa*`, `id_ed25519*`, gpg, etc)
              - `/run/secrets*`, `~/.config/sops-nix/*`, sops-encrypted files
              - `.env`, `.envrc`, tokens, credentials
            - Paths/filenames OK to reference; contents are not.
            - Unsure if something's a secret? Ask first.

            ## Destructive commands

            - Command maybe destructive? Stop. Ask. Wait for explicit yes.

            ## Dependencies

            - Adding/changing a dep? Stop. Ask. Wait for explicit yes.

            ## Formatting

            - Formatter config found? Run it after task done.
          '';
        };
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".gemini"
      ];
    };
  };
}

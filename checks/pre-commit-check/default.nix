{...}: {
  perSystem = {inputs', ...}: {
    pre-commit.settings = {
      default_stages = ["pre-commit"];

      hooks = {
        check-added-large-files.enable = true;
        check-case-conflicts.enable = true;
        check-executables-have-shebangs.enable = true;
        check-shebang-scripts-are-executable.enable = false;
        check-merge-conflicts.enable = true;
        detect-private-keys.enable = true;
        fix-byte-order-marker.enable = true;
        mixed-line-endings.enable = true;
        trim-trailing-whitespace.enable = true;
        end-of-file-fixer.enable = true;

        treefmt.enable = true;

        forbid-submodules = {
          enable = true;
          name = "forbid submodules";
          description = "forbids any submodules in the repository";
          language = "fail";
          entry = "submodules are not allowed in this repository:";
          types = ["directory"];
        };

        destroyed-symlinks = {
          enable = true;
          name = "detect destroyed symlinks";
          description = "detects symlinks which are changed to regular files with a content of a path which that symlink was pointing to.";
          package = inputs'.git-hooks-nix.checks.pre-commit-hooks;
          entry = "${inputs'.git-hooks-nix.checks.pre-commit-hooks}/bin/destroyed-symlinks";
          types = ["symlink"];
        };
      };
    };
  };
}

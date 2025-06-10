{pkgs ? import <nixpkgs> {}}:
pkgs.writeScriptBin "kdlinfmt" (builtins.readFile (
  pkgs.replaceVars ./kdlinfmt.sh.in {
    KDLFMT_EXE = pkgs.lib.getExe pkgs.kdlfmt;
  }
))

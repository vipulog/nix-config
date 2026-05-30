{
  imports = [
    ./default.nix
  ];

  vim.languages = {
    clang.enable = true;
    cmake.enable = true;
    java.enable = true;
    jinja.enable = true;
    jq.enable = true;
    lua.enable = true;
    qml.enable = true;
    rust.enable = true;
    scss.enable = true;
    sql.enable = true;
    tsx.enable = true;
    typst.enable = true;
    vue.enable = true;
  };
}

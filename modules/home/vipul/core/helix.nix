{...}: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
  };
}

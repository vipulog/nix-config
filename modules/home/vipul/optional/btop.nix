{
  programs.btop = {
    enable = true;

    settings = {
      vim_keys = true;
      rounded_corners = false;
      shown_boxes = "proc cpu gpu0 mem net";
      proc_tree = true;
      clock_format = "/username@/host %X - %A, %d %B %Y";
    };
  };
}

{namespace, ...}: {
  config = {
    home.stateVersion = "24.11";

    ${namespace} = {
      roles = {
        workstation.enable = true;
        gaming.enable = false;
      };
    };
  };
}

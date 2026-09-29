{inputs, ...}: {
  den.aspects.nur = {
    nixos = {
      imports = [inputs.nur.modules.nixos.default];
    };
  };
}

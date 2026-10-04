{inputs, ...}: {
  den.aspects.nur = {
    nixos = {
      imports = [inputs.nur.modules.nixos.default];
    };

    darwin = {
      imports = [inputs.nur.modules.darwin.default];
    };
  };
}

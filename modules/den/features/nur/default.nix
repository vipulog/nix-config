{inputs, ...}: {
  den.aspects.nur = {
    nixpkgs-overlays = _: [
      inputs.nur.overlays.default
    ];
  };
}

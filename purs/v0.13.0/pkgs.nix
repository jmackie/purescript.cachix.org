{
  extras = hackage: {
    packages = {
      "network" = (((hackage.network)."3.0.1.1").revisions).default;
    } // {
      purescript = ./purescript.nix;
    };
  };
  resolver = "lts-13.12";
}

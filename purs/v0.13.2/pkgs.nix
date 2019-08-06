{
  extras = hackage: {
    packages = {
      "happy" = (((hackage.happy)."1.19.9").revisions).default;
      "language-javascript" =
        (((hackage.language-javascript)."0.6.0.13").revisions).default;
      "network" = (((hackage.network)."3.0.1.1").revisions).default;
    } // {
      purescript = ./purescript.nix;
    };
  };
  resolver = "lts-13.26";
}

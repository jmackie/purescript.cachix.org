{
  extras = hackage: {
    packages = {
      "dhall" = (((hackage.dhall)."1.21.0").revisions).default;
      "dhall-json" = (((hackage.dhall-json)."1.2.7").revisions).default;
      "async-pool" = (((hackage.async-pool)."0.9.0.2").revisions).default;
      "versions" = (((hackage.versions)."3.5.0").revisions).default;
      "dotgen" = (((hackage.dotgen)."0.4.2").revisions).default;
      "megaparsec" = (((hackage.megaparsec)."7.0.3").revisions).default;
      "repline" = (((hackage.repline)."0.2.0.0").revisions).default;
      "serialise" = (((hackage.serialise)."0.2.1.0").revisions).default;
      "Glob" = (((hackage.Glob)."0.10.0").revisions).default;
      "turtle" = (((hackage.turtle)."1.5.14").revisions).default;
      "cborg-json" =
        (((hackage.cborg-json)."0.2.1.0").revisions)."af9137557002ca5308fe80570a9a29398dfb9708423870875223796760689ac3";
      "Win32" =
        (((hackage.Win32)."2.5.4.1").revisions)."e623a1058bd8134ec14d62759f76cac52eee3576711cb2c4981f398f1ec44b85";
    } // {
      spago = ./spago.nix;
    };
  };
  resolver = "lts-12.21";
}

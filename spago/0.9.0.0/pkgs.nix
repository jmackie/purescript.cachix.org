{
  extras = hackage: {
    packages = {
      "dhall" = (((hackage.dhall)."1.25.0").revisions).default;
      "dhall-json" = (((hackage.dhall-json)."1.4.0").revisions).default;
      "async-pool" = (((hackage.async-pool)."0.9.0.2").revisions).default;
      "either" = (((hackage.either)."5").revisions).default;
      "versions" = (((hackage.versions)."3.5.0").revisions).default;
      "dotgen" = (((hackage.dotgen)."0.4.2").revisions).default;
      "megaparsec" = (((hackage.megaparsec)."7.0.3").revisions).default;
      "repline" = (((hackage.repline)."0.2.1.0").revisions).default;
      "serialise" = (((hackage.serialise)."0.2.1.0").revisions).default;
      "Glob" = (((hackage.Glob)."0.10.0").revisions).default;
      "turtle" = (((hackage.turtle)."1.5.14").revisions).default;
      "semver-range" = (((hackage.semver-range)."0.2.8").revisions).default;
      "cborg-json" =
        (((hackage.cborg-json)."0.2.1.0").revisions)."af9137557002ca5308fe80570a9a29398dfb9708423870875223796760689ac3";
      "Win32" =
        (((hackage.Win32)."2.5.4.1").revisions)."e623a1058bd8134ec14d62759f76cac52eee3576711cb2c4981f398f1ec44b85";
      "libyaml" =
        (((hackage.libyaml)."0.1.1.0").revisions)."b3fcd8c44622c75e054c2267f3fec39a58a311748000310cbc8257a4683d3f02";
      "yaml" =
        (((hackage.yaml)."0.11.1.0").revisions)."3dc3ed2760f6d1bb280b3a2da29f9032f508d57bfc545fb16b1424f2a5560641";
      "th-lift" =
        (((hackage.th-lift)."0.8.0.1").revisions)."cceb81b12c0580e02a7a3898b6d60cca5e1be080741f69ddde4f12210d8ba7ca";
      "th-lift-instances" =
        (((hackage.th-lift-instances)."0.1.13").revisions)."2852e468511805cb25d9e3923c9e91647d008ab4a764ec0921e5e40ff8a8e874";
    } // {
      spago = ./spago.nix;
    };
  };
  resolver = "lts-12.21";
}

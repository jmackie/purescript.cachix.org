{ system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
({
  flags = { };
  package = {
    specVersion = "0";
    identifier = {
      name = "purty";
      version = "4.5.1";
    };
    license = "BSD-3-Clause";
    copyright = "2018 Hardy Jones";
    maintainer = "jones3.hardy@gmail.com";
    author = "Hardy Jones";
    homepage = "https://github.com/joneshf/purty#readme";
    url = "";
    synopsis = "";
    description = "";
    buildType = "Simple";
  };
  components = {
    "library" = {
      depends = [
        (hsPkgs.base)
        (hsPkgs.bytestring)
        (hsPkgs.componentm)
        (hsPkgs.dhall)
        (hsPkgs.optparse-applicative)
        (hsPkgs.purescript)
        (hsPkgs.rio)
        (hsPkgs.text)
      ];
    };
    exes = { "purty" = { depends = [ (hsPkgs.base) (hsPkgs.purty) ]; }; };
    tests = {
      "golden" = {
        depends = [
          (hsPkgs.base)
          (hsPkgs.bytestring)
          (hsPkgs.componentm)
          (hsPkgs.purty)
          (hsPkgs.rio)
          (hsPkgs.tasty)
          (hsPkgs.tasty-golden)
          (hsPkgs.tasty-hunit)
          (hsPkgs.text)
        ];
      };
    };
  };
} // rec {
  src = with builtins.fromJSON (builtins.readFile ./purty-src.json);
    builtins.fetchTarball {
      name = "purty-4.5.1";
      url = "${url}/-/archive/${rev}.tar.gz";
      inherit sha256;
    };
}) // {
  cabal-generator = "hpack";
}

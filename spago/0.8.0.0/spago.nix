{ system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
({
  flags = { };
  package = {
    specVersion = "0";
    identifier = {
      name = "spago";
      version = "0.8.0.0";
    };
    license = "BSD-3-Clause";
    copyright = "2018-2019 Justin Woo, Fabrizio Ferrai";
    maintainer = "@jusrin00, @fabferrai";
    author = "Justin Woo, Fabrizio Ferrai";
    homepage = "https://github.com/spacchetti/spago#readme";
    url = "";
    synopsis = "";
    description =
      "Please see the README on GitHub at <https://github.com/spacchetti/spago#readme>";
    buildType = "Simple";
  };
  components = {
    exes = {
      "spago" = {
        depends = [
          (hsPkgs.Glob)
          (hsPkgs.aeson)
          (hsPkgs.aeson-pretty)
          (hsPkgs.async)
          (hsPkgs.async-pool)
          (hsPkgs.base)
          (hsPkgs.bytestring)
          (hsPkgs.containers)
          (hsPkgs.dhall)
          (hsPkgs.dhall-json)
          (hsPkgs.directory)
          (hsPkgs.exceptions)
          (hsPkgs.file-embed)
          (hsPkgs.filepath)
          (hsPkgs.fsnotify)
          (hsPkgs.github)
          (hsPkgs.lens)
          (hsPkgs.mtl)
          (hsPkgs.network-uri)
          (hsPkgs.optparse-applicative)
          (hsPkgs.prettyprinter)
          (hsPkgs.process)
          (hsPkgs.safe)
          (hsPkgs.stm)
          (hsPkgs.template-haskell)
          (hsPkgs.text)
          (hsPkgs.turtle)
          (hsPkgs.unliftio)
          (hsPkgs.versions)
        ];
      };
    };
  };
} // rec {
  src = with builtins.fromJSON (builtins.readFile ./spago-src.json);
    builtins.fetchTarball {
      name = "spago-0.8.0.0";
      url = "${url}/archive/${rev}.tar.gz";
      inherit sha256;
    };
}) // {
  cabal-generator = "hpack";
}

{ system, compiler, flags, pkgs, hsPkgs, pkgconfPkgs, ... }:
({
  flags = { };
  package = {
    specVersion = "0";
    identifier = {
      name = "spago";
      version = "0.8.4.0";
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
    "library" = {
      depends = [
        (hsPkgs.Glob)
        (hsPkgs.aeson)
        (hsPkgs.aeson-pretty)
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
        (hsPkgs.foldl)
        (hsPkgs.fsnotify)
        (hsPkgs.github)
        (hsPkgs.http-conduit)
        (hsPkgs.lens)
        (hsPkgs.mtl)
        (hsPkgs.network-uri)
        (hsPkgs.prettyprinter)
        (hsPkgs.process)
        (hsPkgs.safe)
        (hsPkgs.stm)
        (hsPkgs.tar)
        (hsPkgs.template-haskell)
        (hsPkgs.temporary)
        (hsPkgs.text)
        (hsPkgs.time)
        (hsPkgs.turtle)
        (hsPkgs.unliftio)
        (hsPkgs.vector)
        (hsPkgs.versions)
        (hsPkgs.zlib)
      ];
    };
    exes = {
      "spago" = {
        depends = [
          (hsPkgs.base)
          (hsPkgs.optparse-applicative)
          (hsPkgs.spago)
          (hsPkgs.text)
          (hsPkgs.turtle)
        ];
      };
      "spago-curator" = {
        depends = [
          (hsPkgs.aeson-pretty)
          (hsPkgs.async-pool)
          (hsPkgs.base)
          (hsPkgs.bytestring)
          (hsPkgs.containers)
          (hsPkgs.dhall)
          (hsPkgs.filepath)
          (hsPkgs.github)
          (hsPkgs.lens)
          (hsPkgs.process)
          (hsPkgs.retry)
          (hsPkgs.spago)
          (hsPkgs.stm)
          (hsPkgs.temporary)
          (hsPkgs.text)
          (hsPkgs.turtle)
          (hsPkgs.vector)
        ];
      };
    };
    tests = {
      "spec" = {
        depends = [
          (hsPkgs.base)
          (hsPkgs.directory)
          (hsPkgs.extra)
          (hsPkgs.hspec)
          (hsPkgs.process)
          (hsPkgs.text)
          (hsPkgs.turtle)
        ];
        build-tools = [
          (hsPkgs.buildPackages.hspec-discover or (pkgs.buildPackages.hspec-discover))
        ];
      };
    };
  };
} // rec {
  src = with builtins.fromJSON (builtins.readFile ./spago-src.json);
    builtins.fetchTarball {
      name = "spago-0.8.4.0";
      url = "${url}/archive/${rev}.tar.gz";
      inherit sha256;
    };
}) // {
  cabal-generator = "hpack";
}

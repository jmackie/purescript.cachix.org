let
  fetchPin = name: specJSON:
    with builtins.fromJSON (builtins.readFile specJSON);
    builtins.fetchTarball {
      inherit name sha256;
      url = "${url}/archive/${rev}.tar.gz";
    };

  pkgs = import (fetchPin "nixpkgs" ./nixpkgs-src.json) { };

  haskell =
    import (fetchPin "haskell-nix" ./haskell-nix-src.json) { inherit pkgs; };

  # https://github.com/input-output-hk/haskell.nix/issues/214#issuecomment-515785254
  mkStackPkgSet = pkgs-nix:
    haskell.mkStackPkgSet {
      stack-pkgs = import pkgs-nix;
      pkg-def-extras =
        [ (hackage: { hsc2hs = hackage.hsc2hs."0.68.4".revisions.default; }) ];
      modules = [{ doHaddock = false; }];
    };

  exe = package: name: pkgSet:
    pkgSet.config.hsPkgs.${package}.components.exes.${name};
in {
  purs = {
    v0_13_0 = exe "purescript" "purs" (mkStackPkgSet ./purs/v0.13.0/pkgs.nix);
    v0_13_2 = exe "purescript" "purs" (mkStackPkgSet ./purs/v0.13.2/pkgs.nix);
  };

  spago = {
    v0_9_0_0 = exe "spago" "spago" (mkStackPkgSet ./spago/0.9.0.0/pkgs.nix);
    v0_8_5_0 = exe "spago" "spago" (mkStackPkgSet ./spago/0.8.5.0/pkgs.nix);
    v0_8_4_0 = exe "spago" "spago" (mkStackPkgSet ./spago/0.8.4.0/pkgs.nix);
    v0_8_3_0 = exe "spago" "spago" (mkStackPkgSet ./spago/0.8.3.0/pkgs.nix);
    v0_8_1_0 = exe "spago" "spago" (mkStackPkgSet ./spago/0.8.1.0/pkgs.nix);
    v0_8_0_0 = exe "spago" "spago" (mkStackPkgSet ./spago/0.8.0.0/pkgs.nix);
  };
}

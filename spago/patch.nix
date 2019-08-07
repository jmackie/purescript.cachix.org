# Need to do two things:
#
#   - Patch the missing hpack defaults feature
#     (https://github.com/input-output-hk/haskell.nix/issues/219)
#
#   - Drop purescript-docs-search into templates
#     (https://github.com/spacchetti/purescript-docs-search/releases)
#
{ pkgs }:
let
  hspecDefaults =
    # https://github.com/hspec/hspec/blob/master/.hpack/defaults.yaml
    "main: Spec.hs\\n    source-dirs: test\\n    dependencies:\\n    - hspec == 2\\.\\*\\n    verbatim:\\n      build-tool-depends:\\n        hspec-discover:hspec-discover == 2\\.\\*";

  # https://github.com/spacchetti/purescript-docs-search
  docs_search = rec {
    version = "v0.0.4";
    "docs-search-app.js" = pkgs.fetchurl {
      name = "purescript-docs-search--docs-search-app.js";
      url =
        "https://github.com/spacchetti/purescript-docs-search/releases/download/${version}/docs-search-app.js";
      sha256 = "0cv7z0b0wk9fd2kwmzr5nbi6x6r71z0ffhr1ixgy9x6ch91yjdwf";
    };

    "purescript-docs-search" = pkgs.fetchurl {
      name = "purescript-docs-search--purescript-docs-search";
      url =
        "https://github.com/spacchetti/purescript-docs-search/releases/download/${version}/purescript-docs-search";
      sha256 = "1gzxakpgz25nb5sw42225z0djcwhfx2npi99wagmbn9y1fnyg5l1";
    };
  };

in pkgs-nix:
pkgs-nix // {
  extras = hackage:
    let result = pkgs-nix.extras hackage;
    in result // {
      packages = result.packages // {
        spago = { ... }@args:
          let

          in (import result.packages.spago) args // {
            postUnpack = ''
              if grep -q 'defaults: hspec/hspec@master' $sourceRoot/package.yaml; then
                echo splicing defaults into $sourceRoot/package.yaml
                sed -i 's/defaults: hspec\/hspec@master/${hspecDefaults}/g' $sourceRoot/package.yaml 
              fi
              echo Adding templates from purescript-docs-search
              cp ${
                docs_search."docs-search-app.js"
              } $sourceRoot/templates/docs-search-app.js
              cp ${
                docs_search."purescript-docs-search"
              } $sourceRoot/templates/purescript-docs-search
            '';
          };
      };
    };
}

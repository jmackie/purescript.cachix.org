{
  extras = hackage: {
    packages = {
      "componentm" =
        (((hackage.componentm)."0.0.0.2").revisions)."d15df070056810a512183021d95af6fc99a4ff96a26352de4fe46b92ebc84728";
      "dhall" =
        (((hackage.dhall)."1.23.0").revisions)."12a699b7ed30ee40b1a3e05dfd3eef1b053914a5aebeb2f76cc568306570e51b";
      "dhall-json" =
        (((hackage.dhall-json)."1.2.8").revisions)."e098f4f7891ea9ab2ac38c126614e07c821166dea47f10d876eaeda0ad5ceb11";
      "language-javascript" =
        (((hackage.language-javascript)."0.6.0.13").revisions)."06238479380c78a7e0fa19da6576fb1750f44c25235c942fd33af6f3969fef85";
      "purescript" =
        (((hackage.purescript)."0.13.2").revisions)."73fba1f0a8e9d42ae5d35450639eedf12cad47fe20ffa43e9f591eb9fcd62332";
      "repline" =
        (((hackage.repline)."0.2.1.0").revisions)."0f8e92d78e771afb9d41243c2b6ab9609fe02f94e676fae3caed66fa4ce09b18";
      "rio" =
        (((hackage.rio)."0.1.9.2").revisions)."d46a202ae0930b496fd17fd9041d051d45645ab28a2f8d30cf483f50ccb21eb3";
      "teardown" =
        (((hackage.teardown)."0.5.0.1").revisions)."b7a6812637f79d81632bb7adebc5ad9a96fffacf3e5f655d5bf21728bd3786f9";
    } // {
      purty = ./purty.nix;
    };
  };
  resolver = "lts-13.12";
}

{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "leptosfmt";
  version = "unstable-2021-10-21";

  src = fetchFromGitHub {
    owner = "bram209";
    repo = pname;
    rev = "refs/pull/152/head";
    fetchSubmodules = true;
    hash = "sha256-wkv5eVXvHX6RYOTEui91Qeoopqjsc3xpP5jl0dIbTyk=";
  };

  cargoHash = "sha256-OXfluFh24nB4WvB5xtduEHDA18yO5SAeQyfGBYHVuN0=";

  meta = {
    description = "A formatter for the leptos view! macro";
    mainProgram = "leptosfmt";
    homepage = "https://github.com/bram209/leptosfmt";
    changelog = "https://github.com/bram209/leptosfmt/blob/${version}/CHANGELOG.md";
    license = with lib.licenses; [asl20 mit];
  };
}

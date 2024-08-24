# From nixpkgs/pkgs/development/tools/rust/cargo-leptos/default.nix
{
  darwin,
  fetchCrate,
  lib,
  rustPlatform,
  stdenv,
}: let
  inherit
    (darwin.apple_sdk.frameworks)
    CoreServices
    SystemConfiguration
    Security
    ;
  inherit (lib) optionals;
  inherit (stdenv) isDarwin;
in
  rustPlatform.buildRustPackage rec {
    pname = "cargo-leptos";
    version = "0.2.20";

    src = fetchCrate {
      inherit pname version;
      hash = "sha256-owaDnDmAiZcQA6SI1u7eqW86rx7WeQRFgM0/8vibrI4=";
    };

    cargoHash = "sha256-Qgwx92hnLTcvK9+wapZOi4Ky3k6hDqbBRZGYMwcLgjU=";

    buildInputs = optionals isDarwin [
      SystemConfiguration
      Security
      CoreServices
    ];

    # https://github.com/leptos-rs/cargo-leptos#dependencies
    buildFeatures = ["no_downloads"]; # cargo-leptos will try to install missing dependencies on its own otherwise
    doCheck = false; # Check phase tries to query crates.io

    meta = with lib; {
      description = "Build tool for the Leptos web framework";
      mainProgram = "cargo-leptos";
      homepage = "https://github.com/leptos-rs/cargo-leptos";
      changelog = "https://github.com/leptos-rs/cargo-leptos/releases/tag/v${version}";
      license = with licenses; [mit];
    };
  }

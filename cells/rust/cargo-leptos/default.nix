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
    version = "0.2.24";

    src = fetchCrate {
      inherit pname version;
      hash = "sha256-ZYKk/3oGOFf1aks2YDS8x6eYXGS0mZqh7VSVhcrDcXE=";
    };

    cargoHash = "sha256-dxDmJVkkdT6hbhboyn8XwMJp379xAVZ8GFVp3F+LtWA=";

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

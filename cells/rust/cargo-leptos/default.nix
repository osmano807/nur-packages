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
    version = "0.2.26";

    src = fetchCrate {
      inherit pname version;
      hash = "sha256-J98JWL1XcuPLJkDJHbk0ZxOcObZ3deFIpTzHoX+rWgA=";
    };

    cargoHash = "sha256-D9/ZXmXWrKhLLx2aJZgctidpxef53Z7H+X37m8Yz0Hs=";

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

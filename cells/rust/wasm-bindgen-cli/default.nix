# From nixpkgs/pkgs/development/tools/wasm-bindgen-cli/default.nix
{
  lib,
  rustPlatform,
  fetchCrate,
  nix-update-script,
  nodejs,
  pkg-config,
  openssl,
  stdenv,
  curl,
  darwin,
  version ? "0.2.100",
  hash ? "sha256-3RJzK7mkYFrs7C/WkhW9Rr4LdP5ofb2FdYGz1P7Uxog=",
  cargoHash ? "sha256-qsO12332HSjWCVKtf1cUePWWb9IdYUmT+8OPj/XP2WE=",
}: let
  inherit
    (darwin.apple_sdk.frameworks)
    Security
    ;
in
  rustPlatform.buildRustPackage rec {
    pname = "wasm-bindgen-cli";
    inherit version hash cargoHash;

    src = fetchCrate {
      inherit pname version hash;
    };

    nativeBuildInputs = [pkg-config];

    buildInputs = [openssl] ++ lib.optionals stdenv.isDarwin [curl Security];

    nativeCheckInputs = [nodejs];

    # tests require it to be ran in the wasm-bindgen monorepo
    doCheck = false;

    meta = with lib; {
      homepage = "https://rustwasm.github.io/docs/wasm-bindgen/";
      license = with licenses; [
        asl20
        /*
        or
        */
        mit
      ];
      description = "Facilitating high-level interactions between wasm modules and JavaScript";
      mainProgram = "wasm-bindgen";
    };

    passthru.updateScript = nix-update-script {};
  }

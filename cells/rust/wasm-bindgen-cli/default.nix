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
  version ? "0.2.97",
  hash ? "sha256-DDUdJtjCrGxZV84QcytdxrmS5qvXD8Gcdq4OApj5ktI=",
  cargoHash ? "sha256-Zfc2aqG7Qi44dY2Jz1MCdpcL3lk8C/3dt7QiE0QlNhc=",
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

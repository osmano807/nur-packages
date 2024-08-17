{
  lib,
  sqliteSupport ? true,
  postgresqlSupport ? true,
  mysqlSupport ? true,
  rustPlatform,
  fetchFromGitHub,
  installShellFiles,
  pkg-config,
  openssl,
  stdenv,
  Security,
  libiconv,
  sqlite,
  postgresql,
  libmysqlclient,
  zlib,
}:
assert lib.assertMsg
(sqliteSupport == true || postgresqlSupport == true || mysqlSupport == true)
"support for at least one database must be enabled"; let
  inherit (lib) optional optionals optionalString;
in
  rustPlatform.buildRustPackage {
    pname = "diesel-cli";
    version = "unstable-2024-07-30";

    src = fetchFromGitHub {
      owner = "diesel-rs";
      repo = "diesel";
      rev = "56b0247f6916eed1e639d5462b34b747d592dca5";
      sha256 = "sha256-1E061BQBwAezEbLIHbNJJySDdeeXx9i9M1+nyHpu/xA=";
    };

    buildAndTestSubdir = "diesel_cli";

    #src = "${diesel-src}/diesel_cli";

    #cargoHash = "";
    cargoLock = {lockFile = ./Cargo.lock;};
    postPatch = ''
      ln -s ${./Cargo.lock} Cargo.lock
    '';

    nativeBuildInputs = [installShellFiles pkg-config];

    buildInputs =
      [openssl]
      ++ optional stdenv.isDarwin Security
      ++ optional (stdenv.isDarwin && mysqlSupport) libiconv
      ++ optional sqliteSupport sqlite
      ++ optional postgresqlSupport postgresql
      ++ optionals mysqlSupport [libmysqlclient zlib];

    buildNoDefaultFeatures = true;
    buildFeatures =
      optional sqliteSupport "sqlite"
      ++ optional postgresqlSupport "postgres"
      ++ optional mysqlSupport "mysql";

    checkPhase =
      ''
        runHook preCheck
      ''
      + optionalString sqliteSupport ''
        cargo check --features sqlite
      ''
      + optionalString postgresqlSupport ''
        cargo check --features postgres
      ''
      + optionalString mysqlSupport ''
        cargo check --features mysql
      ''
      + ''
        runHook postCheck
      '';

    postInstall = ''
      installShellCompletion --cmd diesel \
        --bash <($out/bin/diesel completions bash) \
        --fish <($out/bin/diesel completions fish) \
        --zsh <($out/bin/diesel completions zsh)
    '';

    # Fix the build with mariadb, which otherwise shows "error adding symbols:
    # DSO missing from command line" errors for libz and libssl.
    NIX_LDFLAGS = optionalString mysqlSupport "-lz -lssl -lcrypto";

    meta = with lib; {
      description = "Database tool for working with Rust projects that use Diesel";
      homepage = "https://github.com/diesel-rs/diesel/tree/master/diesel_cli";
      license = with licenses; [mit asl20];
      mainProgram = "diesel";
    };
  }

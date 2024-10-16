{
  lib,
  rustPlatform,
  fetchCrate,
}:
rustPlatform.buildRustPackage rec {
  pname = "leptosfmt";
  version = "0.1.32";

  src = fetchCrate {
    inherit version;
    crateName = pname;
    hash = "sha256-9T510sSR/+qrTk2iOgBWWL3BPnT3bRls8Cjkxk6fYOk=";
  };

  cargoHash = "sha256-MetYHwnjkPFr/Xj7EuPEsjjD4kBH2fEnFXIni1olqhU=";

  meta = {
    description = "A formatter for the leptos view! macro";
    mainProgram = "leptosfmt";
    homepage = "https://github.com/bram209/leptosfmt";
    changelog = "https://github.com/bram209/leptosfmt/blob/${version}/CHANGELOG.md";
    license = with lib.licenses; [asl20 mit];
  };
}

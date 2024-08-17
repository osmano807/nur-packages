{
  lib,
  rustPlatform,
  fetchCrate,
}:
rustPlatform.buildRustPackage rec {
  pname = "leptosfmt";
  version = "0.1.30";

  src = fetchCrate {
    inherit version;
    crateName = pname;
    hash = "sha256-BSWU4KjEfbs8iDkCq+n2D34WS9kqKCVePKnghgQQb/0=";
  };

  cargoHash = "sha256-ZhzcrjVLdR7V6ylmZrQJAFFOL6hSuiORA3iNQdSXEzA=";

  meta = {
    description = "A formatter for the leptos view! macro";
    mainProgram = "leptosfmt";
    homepage = "https://github.com/bram209/leptosfmt";
    changelog = "https://github.com/bram209/leptosfmt/blob/${src.rev}/CHANGELOG.md";
    license = with lib.licenses; [asl20 mit];
  };
}

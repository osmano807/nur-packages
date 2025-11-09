{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "leptosfmt";
  version = "unstable-2024-10-25";

  src = fetchFromGitHub {
    owner = "bram209";
    repo = pname;
    rev = "dd2d8e3bb3a875535983cc117939ba4655abcd9c";
    fetchSubmodules = true;
    hash = "sha256-kqWLevqOErQcF0WeJKUMIlEo1EMcR0aWqa1+agA5B5Q=";
  };

  cargoHash = "sha256-RXflkXkB9b/VajWT2L5SNQ723nyc4+P1VKdRytN3ZA8=";

  meta = {
    description = "A formatter for the leptos view! macro";
    mainProgram = "leptosfmt";
    homepage = "https://github.com/bram209/leptosfmt";
    changelog = "https://github.com/bram209/leptosfmt/blob/${version}/CHANGELOG.md";
    license = with lib.licenses; [asl20 mit];
  };
}

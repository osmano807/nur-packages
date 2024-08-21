{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "prettier-plugin-tailwindcss";
  version = "0.5.11";

  src = fetchFromGitHub {
    owner = "tailwindlabs";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-MeIgDgcxrhkKFvpgyEkBlMV8VfOmND3Z5Zev1Gf4qYY=";
  };

  npmDepsHash = "sha256-YVtpPDUzl9kaiNtyKdKA02vqIwLAETynhEcTbCFFqAs=";

  # Need for runtime dependencies
  dontNpmPrune = true;

  meta = with lib; {
    description = "A Prettier plugin for Tailwind CSS that automatically sorts classes based on our recommended class order. ";
    homepage = "https://github.com/tailwindlabs/prettier-plugin-tailwindcss";
    license = licenses.mit;
  };
}

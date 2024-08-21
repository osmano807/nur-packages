{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "prettier-plugin-jinja-template";
  version = "1.3.2";

  src = fetchFromGitHub {
    owner = "davidodenwald";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-B30UaEwn6FjtHGZKDt5+J9eDhsLMnIVLDphTF6YWC2k=";
  };

  npmDepsHash = "sha256-btmBT0T97bug2ltyhuQGqSvKeUGQOcOGeIPVSapYcMA=";

  # Need for runtime dependencies
  dontNpmPrune = true;

  meta = with lib; {
    description = "A Prettier plugin for for jinja2 template files. ";
    homepage = "https://github.com/davidodenwald/prettier-plugin-jinja-template";
    license = licenses.mit;
  };
}

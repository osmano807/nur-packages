{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:
buildNpmPackage rec {
  pname = "daisyui";
  version = "4.12.10";

  src = fetchFromGitHub {
    owner = "saadeghi";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-1KUwETAVYKdD2LMLnn+w8JayvkDTVRzmY5TBOW/5D7k=";
  };

  npmDepsHash = "sha256-PS8fhBmDfJBxaUb2YXQhRrqMXsfRP9ugbglZpow6LDU=";

  # use generated package-lock.json as upstream does not provide one
  postPatch = ''
    cp ${./package-lock.json} ./package-lock.json
  '';

  passthru.updateScript = ./update.sh;

  meta = with lib; {
    description = "A free and open-source Tailwind CSS component library";
    homepage = "https://daisyui.com/";
    license = licenses.mit;
  };
}

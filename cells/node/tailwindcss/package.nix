{ lib, buildNpmPackage, fetchurl }:

buildNpmPackage rec {
  pname = "tailwindcss";
  version = "4.0.0-beta.8";

  src = fetchurl {
    url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
    hash = "sha256-ky7kOSBfl0fTrmbhInLrKoomyJ0XYoHhdkgleXe6jYU=";
  };

  npmDepsHash = "sha256-EmnJW3Z1hhLwGs5/7QfXzlhkqb2Pio54J6ptVDlc/EA=";

  postPatch = ''
    ln -s ${./package-lock.json} package-lock.json
  '';

  dontNpmBuild = true;

  passthru.updateScript = ./update.sh;

  meta = {
    description = "A utility-first CSS framework for rapidly building custom user interfaces. ";
    homepage = "https://tailwindcss.com/";
    license = lib.licenses.mit;
  };
}
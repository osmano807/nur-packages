{
  lib,
  buildNpmPackage,
  fetchurl,
}:
buildNpmPackage rec {
  pname = "daisyui";
  version = "5.0.0-beta.1";

  src = fetchurl {
    url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
    hash = "sha256-vfCShcsQZ+ld4PWJiZLrQNmcqR+4flA2G10C0aSLPdQ=";
  };

  npmDepsHash = "sha256-iXvxup6uSg7ourv7FNMbOc7R48h3oEWbgUOU3o7lUVI=";

  # use generated package-lock.json as upstream does not provide one
  postPatch = ''
    ln -s ${./package-lock.json} ./package-lock.json
  '';

  dontNpmBuild = true;

  forceEmptyCache = true;

  installPhase = ''
    mkdir -p $out/lib/node_modules/daisyui
    cp -r . $out/lib/node_modules/daisyui
  '';

  passthru.updateScript = ./update.sh;

  meta = with lib; {
    description = "A free and open-source Tailwind CSS component library";
    homepage = "https://daisyui.com/";
    license = licenses.mit;
  };
}

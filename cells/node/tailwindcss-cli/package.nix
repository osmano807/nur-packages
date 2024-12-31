{ lib, buildNpmPackage, fetchurl, makeWrapper, nodejs, plugins? [] }:

buildNpmPackage rec {
  pname = "@tailwindcss/cli";
  version = "4.0.0-beta.8";

  src = fetchurl {
    url = "https://registry.npmjs.org/@tailwindcss/cli/-/cli-${version}.tgz";
    hash = "sha256-qUR9Uy7CN37dK/8M8VbIxx/N7sWOxY6Ge4N9iSVQwzI=";
  };

  npmDepsHash = "sha256-LyUVi/WmuYUtBMdEyHeiAvWNixfytyTfXAdTDIck5nk=";

  postPatch = ''
    ln -s ${./package-lock.json} package-lock.json
  '';

  dontNpmBuild = true;

  passthru.updateScript = ./update.sh;

  postInstall = ''
      nodePath=""
      for p in "$out" $plugins; do
        nodePath="$nodePath''${nodePath:+:}$p/lib/node_modules"
      done
      wrapProgram "$out/bin/tailwindcss" --prefix NODE_PATH : "$nodePath"
      makeWrapper "$out/bin/tailwindcss" "$out/bin/tailwind"
      unset nodePath
    '';

  meta = {
    description = "Command-line tool for the CSS framework with composable CSS classes, standalone CLI";
    homepage = "https://tailwindcss.com/";
    mainProgram = "tailwindcss";
    license = lib.licenses.mit;
  };
}
{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  tailwindcss-cli = nixpkgs.callPackage ./tailwindcss-cli/package.nix {};
}

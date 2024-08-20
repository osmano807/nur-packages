{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  daisyui = nixpkgs.callPackage ./daisyui/package.nix {};

  prettier-plugin-tailwindcss =
    nixpkgs.callPackage ./prettier-plugin-tailwindcss {};
  prettier-plugin-jinja-template =
    nixpkgs.callPackage ./prettier-plugin-jinja-template {};
}

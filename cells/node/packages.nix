{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  tailwindcss = nixpkgs.callPackage ./tailwindcss/package.nix {};

  daisyui = nixpkgs.callPackage ./daisyui/package.nix {};

  prettier-plugin-tailwindcss =
    nixpkgs.callPackage ./prettier-plugin-tailwindcss {};
  prettier-plugin-jinja-template =
    nixpkgs.callPackage ./prettier-plugin-jinja-template {};
}

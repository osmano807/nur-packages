{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  leptosfmt = nixpkgs.callPackage ./leptosfmt {};

  cargo-leptos = nixpkgs.callPackage ./cargo-leptos {};

}

{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  leptosfmt = nixpkgs.callPackage ./leptosfmt {};

  diesel-cli = nixpkgs.callPackage ./diesel-cli/package.nix {inherit (nixpkgs.rustPackages_1_79) rustPlatform;};

  cargo-leptos = nixpkgs.callPackage ./cargo-leptos {inherit (nixpkgs.rustPackages_1_79) rustPlatform;};

  wasm-bindgen-cli = nixpkgs.callPackage ./wasm-bindgen-cli {};
}

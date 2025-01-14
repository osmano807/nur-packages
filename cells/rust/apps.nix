{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
in {
  leptosfmt = nixpkgs.callPackage ./leptosfmt {};

  diesel-cli = nixpkgs.callPackage ./diesel-cli/package.nix {inherit (nixpkgs.rustPackages) rustPlatform;};

  cargo-leptos = nixpkgs.callPackage ./cargo-leptos {inherit (nixpkgs.rustPackages) rustPlatform;};

  wasm-bindgen-cli = nixpkgs.callPackage ./wasm-bindgen-cli {};
}

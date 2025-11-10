{
  description = "My personal NUR repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/086b448a5d54fd117f4dc2dee55c9f0ff461bdc1";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/99dc8785f6a0adac95f5e2ab05cc2e1bf666d172";

    std = {
      url = "github:divnix/std/f8f6f70cdc9234d36d3d445d99a60b9267644df8";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.devshell.url = "github:numtide/devshell/67cce7359e4cd3c45296fb4aaf6a19e2a9c757ae";
    };

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {std, ...} @ inputs:
    std.growOn
    {
      # Necessary for `std` to perform its magic.
      inherit inputs;

      cellsFrom = ./cells;

      cellBlocks = with std.blockTypes; [
        (functions "library")
        (runnables "apps" {ci.build = true;})
        (installables "packages" {ci.build = true;})
        (devshells "devshells" {ci.build = true;})
      ];
    }
    {
      packages = std.harvest inputs.self [
        ["rust" "packages"]
        ["rust" "apps"]
        ["node" "packages"]
      ];

      devShells = std.harvest inputs.self ["repo" "devshells"];

      lib = std.harvest inputs.self ["nix" "library"];
    };
}

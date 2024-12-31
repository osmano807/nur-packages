{
  description = "My personal NUR repository";

  inputs = {
    nixpkgs.url = "nixpkgs";
    #nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-unstable.url = "latest";

    std = {
      url = "github:divnix/std";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.devshell.url = "github:numtide/devshell";
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
        ["node" "apps"]
      ];

      devShells = std.harvest inputs.self ["repo" "devshells"];

      lib = std.harvest inputs.self ["nix" "library"];
    };
}

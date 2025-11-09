{
  description = "My personal NUR repository";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/6faeb062ee4cf4f105989d490831713cc5a43ee1?narHash=sha256-Zg/SCgCaAioc0/SVZQJxuECGPJy%2BOAeBcGeA5okdYDc%3D";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/b6a8526db03f735b89dd5ff348f53f752e7ddc8e?narHash=sha256-rXXuz51Bq7DHBlfIjN7jO8Bu3du5TV%2B3DSADBX7/9YQ%3D";

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
      ];

      devShells = std.harvest inputs.self ["repo" "devshells"];

      lib = std.harvest inputs.self ["nix" "library"];
    };
}

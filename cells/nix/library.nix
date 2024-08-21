{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs;
  l = nixpkgs.lib // builtins;
in {
  recursiveMerge = import ./recursiveMerge.nix {lib = l;};
}

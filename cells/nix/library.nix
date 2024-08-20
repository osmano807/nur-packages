{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in {
  recursiveMerge = import ./recursiveMerge.nix {lib = l;};
}

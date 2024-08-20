{
  inputs,
  cell,
}: let
  inherit (inputs) nixpkgs std;
  l = nixpkgs.lib // builtins;
in
  # Here we map an attribute set to the `std.std.lib.mkShell` function.
  # This is a small wrapper around the numtide/devshell `mkShell` function and
  # provides integration with `nixago`. The
  # result of this map is a attribute set where the value is a proper
  # development shell derivation.
  l.mapAttrs (_: std.lib.dev.mkShell) {
    # This is our only development shell, so we name it "default". The
    # numtide/devshell `mkShell` function uses modules, so the `{ ... }` here is
    # simply boilerplate.
    default = {...}: {
      # The structure of this attribute set is defined here:
      # https://github.com/numtide/devshell/tree/master/modules
      #

      name = "devshell";

      # Since we're using modules here, we can import other modules into our
      # final configuration. In this case, we import the `std` default development
      # shell profile which will, among other things, automatically include the
      # `std` TUI in our environment.
      imports = [std.std.devshellProfiles.default];

      packages = [nixpkgs.yq-go];

      commands = [
        {
          name = "tests";
          command = "cargo test";
          help = "run the unit tests";
          category = "Testing";
        }
      ];
    };
  }

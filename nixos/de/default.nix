{ ... }:
let
  modules = (builtins.map
              (name: import (./. + "/${name}"))
              (builtins.filter
                (name: name != "default.nix")
                (builtins.attrNames
                  (builtins.readDir ./. ))));
in
{
  imports = [ ] ++ modules;
}

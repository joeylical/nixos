{ pkgs, ... }:

let
  enable = true;
in if enable then
{
  environment.systemPackages = with pkgs; [
    (python3.withPackages (ps: with ps; [
        pip
        virtualenv
        ipython
        python-lsp-server
        numba
        dasbus
        requests
        pillow
    ]))
  ];

} else { }

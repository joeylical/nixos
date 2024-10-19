{ pkgs, ... }:

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
}

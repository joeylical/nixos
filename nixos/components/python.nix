{ pkgs, ... }:

let
  enable = true;
  girep = "girepository-1.0";
  giPkgs = with pkgs; [
    gobject-introspection
    gtk3
    gtk4
    pango
    harfbuzz
    gdk-pixbuf
    at-spi2-atk
    graphene
    gst_all_1.gstreamer
  ];
  giTypelibPath = (builtins.concatStringsSep
      ":"
      (builtins.map
        (pkg: "${pkg.out}/lib/${girep}")
        giPkgs));
in if enable then
{
  environment.systemPackages = with pkgs; [
    (python3.withPackages (ps: with ps; [
        pip
        virtualenv
        ipython
        python-lsp-server
        pygobject3
        gst-python
        numba
        dasbus
        requests
        pillow
    ]))
    # gst_all_1.gstreamer
    # gobject-introspection
    # at-spi2-atk
  ] ++ giPkgs;

  environment.sessionVariables.GI_TYPELIB_PATH = giTypelibPath;
} else { }

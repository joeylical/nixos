{ ... }:

{
  environment.sessionVariables = {
    # for gtk3
    GDK_SCALE = "1";
    GDK_DPI_SCALE = "1";
    # java
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
    XDG_SESSION_TYPE = "wayland";
    # QT_WAYLAND_FORCE_DPI = "250";
    QT_AUTO_SCREEN_SCALE_FACTOR = "0";
    QT_ENABLE_HIGHDPI_SCALING = "1";
    # QT_FONT_DPI = "250";
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME="gtk2";
    NIXOS_OZONE_WL = "1";
  };
}

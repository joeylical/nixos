{ ... }:
{
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
            action.id == "org.freedesktop.policykit.exec"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';

  security.pam.services.swaylock = { };
  security.sudo.wheelNeedsPassword = false;
}

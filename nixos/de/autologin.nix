{ specialArgs, ... }:

{
  services.displayManager.autoLogin.user = specialArgs.userName;
  services.displayManager.sddm.settings.AutoLogin.User = specialArgs.userName;
}

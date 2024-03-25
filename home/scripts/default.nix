{ config, pkgs, lib, environment, ... }:
let

  # todo: generate list frome readdir
  scripts = [
    "getweather.py"
    "getweather1.py"
    "condense"
  ];

  shellscripts = [
  ];
in
{
  home.packages =with pkgs; [
      (writeShellScriptBin "import-gsettings" (builtins.readFile ./import-settings))
      (writeShellScriptBin "dirinit" (builtins.readFile ./nsinit.sh))
      (writeShellScriptBin "light_wrap" (builtins.readFile ./light_wrap.sh))
      (writeShellScriptBin "fetch_weather" (builtins.readFile ./fetch_weather.sh))
      (writeShellScriptBin "lockscreen" (builtins.readFile ./lockscreen.sh))

      (writeShellScriptBin "setwp" (builtins.readFile ./setwp.sh))

      (writeShellScriptBin "setrr" (builtins.readFile ./setrr.sh))
      (writeShellScriptBin "paper" (builtins.readFile ./paper.sh))
      # (writeScriptBin "condense" (builtins.readFile ./condense))

    ] ++ (builtins.map (name: (writeScriptBin name (builtins.readFile (./. + "/${name}")))) scripts)
     ++ (builtins.map (name: (writeShellScriptBin name (builtins.readFile (./. + "/${name}"))))
     shellscripts);
}

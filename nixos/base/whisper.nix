{ pkgs, lib, config, ... }:
let
  model = "small";
in
{
  environment.systemPackages = [
    pkgs.openai-whisper-cpp
  ];

  system.userActivationScripts."whisper-downloader" = {
    text = ''
      cd /storage/whisper/
      if [ ! -f ./ggml-${model}.bin ]; then
        ${pkgs.openai-whisper-cpp.out}/bin/whisper-cpp-download-ggml-model ${model}
      fi
    '';
  };

  systemd.tmpfiles.rules = [
    "d /storage/whisper/ 0777 nixos users"
  ];
}

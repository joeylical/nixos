{ pkgs, lib, config, ... }:
let
  model = "small";
in
lib.mkIf (config.networking.hostName == "homeserver") {
  environment.systemPackages = [
    pkgs.openai-whisper-cpp
  ];

  systemd.user.services.whisper = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    description = "whisper model downloader";
    serviceConfig = {
      Type = "simple";
    };
    script = ''
      cd /data/whisper/
      if [ ! -f ./ggml-${model}.bin ]; then
        ${pkgs.openai-whisper-cpp.out}/bin/whisper-cpp-download-ggml-model ${model}
      fi
      exit 0
    '';
  };



  systemd.tmpfiles.rules = [
    "d /data/whisper/ 0777 nixos users"
  ];
}

{ pkgs, lib, config, ... }:
let
  url = "https://huggingface.co/hfl/chinese-alpaca-2-7b-64k-gguf/raw/main/ggml-model-q4_0.gguf";
  model = "ggml-model-q4_0.gguf";
  llama_override = if (config.networking.hostName == "homeserver" || config.networking.hostName ==
    "laptop") then {
      rocmSupport = true;
    } else {};
in
{
  environment.systemPackages = with pkgs; [
    (llama-cpp.override llama_override)
  ];

  system.userActivationScripts."llama-downloader" = {
    text = ''
      if [ -d /storage/llama ]; then
        cd /storage/llama/
        if [ ! -f ${model} ]; then
          ${pkgs.wget.out}/bin/wget "${url}" -O "${model}"
        fi
      fi
    '';
  };

  systemd.tmpfiles.rules = [
    "d /storage/llama/ 0777 nixos users"
  ];
}

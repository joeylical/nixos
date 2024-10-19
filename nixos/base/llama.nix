{ pkgs, lib, config, ... }:
let
  url = "https://huggingface.co/QuantFactory/Llama-3.2-3B-Instruct-GGUF/resolve/main/Llama-3.2-3B-Instruct.Q8_0.gguf?download=true";
  model = "ggml-model-q4_0.gguf";
in
{
  environment.systemPackages = with pkgs; [
    llama-cpp
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

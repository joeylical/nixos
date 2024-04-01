{ lib, config, ... }:
{
  services.llama-cpp = {
    enable = true;
    host = "0.0.0.0";
    port = 9920;
    openFirewall = true;
    model = "/storage/llama/ggml-model-q4_0.gguf";
  };
}

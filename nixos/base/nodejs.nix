{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodejs_21
    vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    typescript
  ];
}

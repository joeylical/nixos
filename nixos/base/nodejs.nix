{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nodePackages_latest.nodejs
    vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    typescript
  ];
}

#!/usr/bin/env bash

if [ -f ".envrc" ]; then
    echo ".envrc already existed!"
    exit
fi

if [ -f "shell.nix" ]; then
    echo "shell.nix already existed!"
    exit
fi

echo "creating .envrc"

echo "use_nix" > .envrc

echo "creating default shell.nix"

cat<<EOF>>shell.nix
with import <nixpkgs> { };

let
    pythonPackages = python3Packages;
in pkgs.mkShell rec {
    name = "impurePythonEnv";
    venvDir = "./.venv";
    buildInputs = [
        #TODO: Add custom pkgs
        # pythonPackages.python
        # pythonPackages.venvShellHook
    ];

    postVenvCreation = ''
        #TODO: add commands
        # unset SOURCE_DATE_EPOCH
        # pip install -r requirements.txt
    '';

    postshellhook = ''
        #TODO: add commands
        # unset source_date_epoch
    '';
}
EOF


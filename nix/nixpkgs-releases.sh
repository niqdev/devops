#!/usr/bin/env nix-shell
#! nix-shell -i bash --pure
#! nix-shell -p bash cacert curl jq python3Packages.xmljson
#! nix-shell -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/2a601aafdc5605a5133a2ca506a34a3a73377247.tar.gz

# -i option, bash is specified as the interpreter for the rest of the file
# --pure prevent the script from implicitly using programs that may already exist on the system on which the script is run
# -p lists the packages required for the script to run
# -I refers to a specific Git commit of the Nixpkgs repository

curl https://github.com/NixOS/nixpkgs/releases.atom | xml2json | jq .

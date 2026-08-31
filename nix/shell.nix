let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-26.05";
  # avoid being inadvertently overridden by global configuration
  # { } is an attribute set and [ ] is a list
  pkgs = import nixpkgs { config = {}; overlays = []; };
in

# mkShellNoCC is a wrapper around stdenv.mkDerivation and "NoCC" is without compiler toolchain
pkgs.mkShellNoCC {
  # "packages" is an attribute, "pkgs" is an attribute set
  packages = with pkgs; [
    cowsay
    lolcat
  ];

  GREETING = "hello nix";
  shellHook = ''
    echo $GREETING | cowsay | lolcat
  '';
}

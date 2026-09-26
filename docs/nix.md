# Nix

> Declarative builds and deployments

Resources

* [documentation](https://nixos.org/learn)
* [nix.dev](https://nix.dev)
* Nix [manual](https://nixos.org/manual/nix/stable)
* Home Manager [ [manual](https://nix-community.github.io/home-manager) | [Option Search](https://home-manager-options.extranix.com) ]
* Packages [ [search](https://search.nixos.org/packages) | [source](https://github.com/NixOS/nixpkgs/tree/master/pkgs) ]
* Flakes [ [documentation](https://nix.dev/concepts/flakes.html) | [wiki](https://wiki.nixos.org/wiki/Flakes) | [manual](https://nix.dev/manual/nix/latest/command-ref/new-cli/nix3-flake.html) ]

Guides and samples

* [Zero to Nix](https://zero-to-nix.com) guide
* [NixOS & Flakes](https://nixos-and-flakes.thiscute.world) book
* [Nix Pills]( https://nixos.org/guides/nix-pills)
* [awesome-nix](https://github.com/nix-community/awesome-nix)
* [nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)

Install (multi-user)
```bash
# ubuntu
wget --https-only -qO- https://nixos.org/nix/install | sh -s -- --daemon

# macos
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh
```

Enable flakes (experimental)
```bash
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf
```

Alternative installations

* Unoffical [Determinate Nix installer](https://docs.determinate.systems)
* Automatically activate dev shell [ [direnv](https://direnv.net) | [direnv shell hook](https://direnv.net/docs/hook.html) | [nix-direnv](https://github.com/nix-community/nix-direnv) ]

See VS Code [plugin](https://github.com/nix-community/vscode-nix-ide)

## Examples

```sh
# hello world
nix run nixpkgs#hello
echo "Hello Nix" | nix run "https://flakehub.com/f/NixOS/nixpkgs/*#ponysay"

# shell
nix-shell -p git --run "git --version" --pure
nix-shell -p cowsay lolcat
nix shell nixpkgs#figlet nixpkgs#lolcat --command sh -c 'figlet Hello Nix | lolcat'
nix shell nixpkgs#fastfetch --command fastfetch

# cleanup
nix-collect-garbage

# reproducible interpreted scripts i.e. shebang scripts
chmod +x nix/nixpkgs-releases.sh
./nix/nixpkgs-releases.sh

# evaluate expression from file, default is "default.nix"
echo "{ a.b.c = 1; }" > nix/file.nix
nix-instantiate --eval --strict nix/file.nix

# uses lazy evaluation
nix repl
# force evaluation with ":p"
:p { a.b.b = 1; }
let x=1; y=2; in x+y
let name = "nix"; in "hello ${name}"
# calling functions
let f = x: y: x+y; in f 1 2
let pkgs = import <nixpkgs> {}; in pkgs.lib.strings.toUpper "foo bar"
let pkgs = import <nixpkgs> {}; in "${pkgs.git}"
# function libraries
builtins.getEnv("HOME")

# declerative shell environments
nix-shell nix/shell.nix
```

Flake
```sh
# flake example
nix build github:NixOS/nixpkgs#hello -o nix/result
./nix/result/bin/hello

# local flake needs to be tracked by git first or it won't run i.e. git add
nix run ./nix#hello
# list what a flake provide
nix flake show ./nix
# update every input in the lock
nix flake update --flake ./nix

# create flake template
nix flake init -t templates#devshell

# verify package
nix derivation show nixpkgs#hello | jq
```

Flake explained in REPL
```sh
# open a REPL with the nixpkgs flake's outputs as variables
nix repl github:nixos/nixpkgs/nixos-unstable

# "set"
builtins.typeOf legacyPackages

# the systems: [ "aarch64-darwin" "aarch64-linux" ... ]
builtins.attrNames legacyPackages

# "lambda": a function
builtins.typeOf lib.genAttrs

# try it: { a = "a!"; b = "b!"; }
lib.genAttrs [ "a" "b" ] (n: n + "!")

# a package is a "set" too
builtins.typeOf legacyPackages.x86_64-linux.hello

# package source https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/he/hello/package.nix
builtins.attrNames legacyPackages.x86_64-linux.hello
builtins.toJSON legacyPackages.x86_64-linux.hello.meta
```

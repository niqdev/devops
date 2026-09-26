# Nix

> Declarative builds and deployments

Resources

* [documentation](https://nixos.org/learn)
* [nix.dev](https://nix.dev)
* Nix [manual](https://nixos.org/manual/nix/stable)
* Home Manager [ [manual](https://nix-community.github.io/home-manager) | [Option Search](https://home-manager-options.extranix.com) ]
* Packages [ [search](https://search.nixos.org/packages) | [source](https://github.com/NixOS/nixpkgs/tree/master/pkgs) ]
* Flakes [ [documentation](https://nix.dev/concepts/flakes.html) | [wiki](https://wiki.nixos.org/wiki/Flakes) | [manual](https://nix.dev/manual/nix/latest/command-ref/new-cli/nix3-flake.html) ]
* Guide [Zero to Nix](https://zero-to-nix.com)

Samples

- [nix-starter-configs](https://github.com/Misterio77/nix-starter-configs)
- [awesome-nix](https://github.com/nix-community/awesome-nix)

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
nix-shell -p cowsay lolcat
nix-shell -p git --run "git --version" --pure

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
```

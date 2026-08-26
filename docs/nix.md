# Nix

> Declarative builds and deployments

Resources

* [documentation](https://nixos.org/learn)
* [nix.dev](https://nix.dev)
* Nix [manual](https://nixos.org/manual/nix/stable)
* Home Manager [manual](https://nix-community.github.io/home-manager)
* Package [ [search](https://search.nixos.org/packages) | [source](https://github.com/NixOS/nixpkgs/tree/master/pkgs) ]

Setup
```bash
# ubuntu
wget --https-only -qO- https://nixos.org/nix/install | sh -s -- --daemon

# macos
curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh
```

## Examples

```bash
# hello world
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
```

<br>

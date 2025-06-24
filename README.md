# Use as a flake

[![FlakeHub](https://img.shields.io/endpoint?url=https://flakehub.com/f/raikusy/dotfiles/badge)](https://flakehub.com/flake/raikusy/dotfiles)

Add `dotfiles` to your `flake.nix`:

```nix
{
  inputs.dotfiles.url = "https://flakehub.com/f/raikusy/dotfiles/*";

  outputs = { self, dotfiles }: {
    darwinConfigurations.raikusy = dotfiles.darwinConfigurations.raikusy;
  };
}
```

# dotfiles

1. Clone this repo
2. Install nix using [determinate-systems](https://docs.determinate.systems/getting-started/individuals/):

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate
```

3. For first time install Run this command:

```bash
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake . --impure
```

4. Next run this:

```bash
darwin-rebuild switch --flake ~/dotfiles --impure
```

```bash
get-library-docs /nixos/nixpkgs
get-library-docs /nix-darwin/nix-darwin
get-library-docs /nix-community/home-manager
get-library-docs /nixos/nix
```

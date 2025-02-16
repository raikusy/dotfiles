# dotfiles

1. Clone this repo
2. Install nix using [determinate-systems](https://docs.determinate.systems/getting-started/individuals/https://):

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

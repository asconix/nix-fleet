final: prev:
let
  # Pick an Emacs build: prefer emacs-git if the emacs overlay provides it.
  emacsPkg =
    if prev ? emacs-git then prev.emacs-git
    else prev.emacs;

  # Pick a Neovim build: prefer nightly overlay if present.
  nvimPkg =
    if prev ? neovim-nightly then prev.neovim-nightly
    else prev.neovim;

  # Common helper tools editors often expect.
  editorTools = with prev; [
    ripgrep
    fd
    git
    tree-sitter
    nodejs
    python3
  ];
in
{
  # Opinionated defaults (so installing pkgs.emacs/pkgs.neovim uses your chosen variants)
  emacs = emacsPkg;
  neovim = nvimPkg;

  # Convenience bundle you can install as a single item.
  editors = prev.symlinkJoin {
    name = "editors";
    paths = [ emacsPkg nvimPkg ] ++ editorTools;
  };

  # Optional: explicit names if you want stable/nightly access regardless of defaults
  editors-emacs = emacsPkg;
  editors-neovim = nvimPkg;
}

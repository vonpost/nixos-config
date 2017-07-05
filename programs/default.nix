{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./ssh.nix
    ./zsh.nix
  ];

  services.nixosManual.enable = false; # It's always broken anyway.

  /*
  # Minimal package set for testing
  environment.systemPackages = with pkgs; [
    gnupg21 pinentry_qt5
    git pass
    htop
    manpages
    nix-prefetch-scripts nix-repl
    quilt
    ripgrep
    tmux
    firefox
  ];
  */

  environment.systemPackages = with pkgs; [
    # Encryption
    cryptsetup
    gnupg21 pinentry_qt5

    # Languages
    chibi
    clang llvm
    fricas
    haskellPackages.cabal2nix
    haskellPackages.cabal-install
    haskellPackages.ghc
    haskellPackages.ghcid
    haskellPackages.hpack
    maxima
    rustNightlyBin.rustc rustNightlyBin.cargo

    # TeX
    (texlive.combine {
      inherit (texlive)
        scheme-full collection-publishers collection-science;
    })

    # Utilities
    androidenv.platformTools # adb and fastboot
    aspell aspellDicts.en
    bibutils
    briss # crop PDFs
    cloc
    ghostscript
    git pass vcsh gitAndTools.gitflow
    htop
    keybase-go
    ledger
    libburn
    manpages
    nix-prefetch-scripts nix-repl
    pandoc
    pdftk poppler_utils # Tools for manipulating PDF files
    quilt
    ripgrep
    tmux

    # KDE
    kdeApplications.akonadiconsole
    audaciousQt5
    ark
    gwenview
    kcolorchooser
    kdeApplications.kmail
    okular
    spectacle

    firefox
    gimp
    inkscape
    ipe
    lyx
    pkgsi686Linux.skype
    spotify
    vlc
  ];

  # Needed for GHC 8
  boot.kernelPackages = pkgs.linuxPackages_latest;
}

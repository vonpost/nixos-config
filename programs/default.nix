{ config, pkgs, ... }:

{
  imports = [
    ./nix.nix
    ./ssh.nix
    ./zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    cryptsetup

    # KDE packages that need to be kept in sync
    kde5.ark
    kde5.gwenview
    kde5.spectacle
    kde5.okular
    kde5.quasselClient

    aspell
    aspellDicts.en
    cloc
    darcs
    git
    gitAndTools.git-annex
    gitAndTools.hub  # command-line interface to GitHub
    gnupg
    gnuplot_qt
    haskellPackages.cabal2nix
    ((ttuegel.cabal-install.override {
        Cabal = ttuegel.Cabal.overrideDerivation (drv: {
            src = builtins.filterSource ttuegel.omitGit ./cabal/Cabal;
        });
    }).overrideDerivation (drv: {
      src = builtins.filterSource ttuegel.omitGit ./cabal/cabal-install;
    }))
    haskellPackages.ghcid
    htop
    ledger
    linuxPackages.cpupower
    llvm
    manpages
    mr
    nix-repl
    nox
    pass
    quilt
    rubber
    silver-searcher
    sox
    (texlive.combine {
      inherit (texlive) scheme-small collection-publishers collection-science;
    })
    tmux
    vcsh
    wget
    youtube-dl

    clementine
    firefoxWrapper
    gimp
    inkscape
    ipe
    lyx
    spotify
    vlc
  ];
}

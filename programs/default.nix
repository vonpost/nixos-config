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
    kde4.k3b
    kdeApps_stable.ark
    kdeApps_stable.gwenview
    kdeApps_stable.ksnapshot
    kdeApps_stable.okular

    aspell
    aspellDicts.en
    cloc
    darcs
    git
    gitAndTools.git-annex
    gnupg
    gnuplot_qt
    haskellPackages.cabal2nix
    haskellPackages.cabal-install
    haskellPackages.ghcid
    htop
    ledger
    linuxPackages.cpupower
    llvm
    manpages
    mr
    nox
    pass
    silver-searcher
    sox
    (texlive.combine {
      inherit (texlive) scheme-basic collection-publishers collection-science;
    })
    tmux
    vcsh
    wget
    youtube-dl

    clementine
    dropbox
    firefoxWrapper
    gimp
    inkscape
    ipe
    lyx
    pidgin
    quasselClient_kf5
    spotify
    vlc
    zotero
  ];
}
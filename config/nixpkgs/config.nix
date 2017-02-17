pkgs:

let

  config = {
    allowBroken = true;
    allowUnfree = true;
    clementine.spotify = true;
    pulseaudio = true;
  };

in

config // {
  packageOverrides = super: let self = super.pkgs; in
    super.lib.fold (a: b: a // (b // { ttuegel = (a.ttuegel or {}) // (b.ttuegel or {}); })) {}
    [
      (import ../../overrides/gnupg self super)
      (import ../../overrides/gnuplot.nix self super)
      (import ../../overrides/helpers.nix self super)
      ({
        feast = self.callPackage ../../pkgs/feast {
          openblas = self.openblasCompat;
        };

        # Enable OpenGL 4 support
        mesa_drivers = self.mesaDarwinOr (
          let mo = self.mesa_noglu.override {
            grsecEnabled = config.nixpkgs.config.grsecurity or false;
            enableTextureFloats = true;
          };
          in mo.drivers
        );
      })
    ];
}

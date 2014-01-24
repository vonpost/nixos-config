# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, pkgs, ... }:

{
  imports =
    [ <nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_hcd" "ata_piix" "ahci" "firewire_ohci" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/sda1";
      fsType = "ext4";
      options = "rw,data=ordered,relatime";
    };

  networking.hostName = "duo";

  swapDevices =
    [ { device = "/dev/sda2"; }
    ];

  nix.maxJobs = 2;
  nix.daemonIONiceLevel = 7;
  nix.daemonNiceLevel = 19;

  services.xserver.synaptics = {
    enable = true;
    twoFingerScroll = true;
    vertEdgeScroll = false;
  };
}

{ config, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ./common.nix
  ];

  boot.initrd.availableKernelModules = [
    "uhci_hcd"
    "ehci_hcd"
    "ata_piix"
    "ahci"
    "firewire_ohci"
  ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/sda1";
    fsType = "ext4";
    options = "rw,data=ordered,relatime";
  };

  networking.hostName = "duo";

  swapDevices = [ { device = "/dev/sda2"; } ];

  nix.maxJobs = 2;
  nix.daemonIONiceLevel = 7;
  nix.daemonNiceLevel = 19;
  nix.extraOptions = ''
    build-cores = 0
    gc-keep-outputs = true
    gc-keep-derivations = true
  '';

  services.thinkfan.enable = true;

  services.xserver.synaptics = {
    enable = true;
    # Use vertical edge scrolling as long as I'm on the Toshiba because its
    # touchpad doesn't do multi-touch :(
    twoFingerScroll = true;
    vertEdgeScroll = false;
    additionalOptions = ''
      Option "LockedDrags" "True"
      Option "LockedDragTimeout" "500"
    '';
  };
}

{ config, pkgs, ... }:

{
  imports = [
    <nixos/modules/installer/scan/not-detected.nix>
    ./config
    ./features/desktop.nix
    ./features/dvorak-swapcaps
    ./features/gitolite
    ./features/hplip
    ./features/nix-serve.nix
    ./features/quassel.nix
    ./overrides/mesa_drivers.nix
    ./programs
    ./programs/emacs.nix
    ./programs/gpg-agent.nix
    ./programs/mathematica
  ];

  boot.loader.grub = {
    enable = true;
    version = 2;
    device = "/dev/sda";
  };

  boot.cleanTmpDir = true;
  boot.initrd.availableKernelModules = [
    "ahci"
    "ehci_hcd"
    "firewire_ohci"
    "ohci_hcd"
    "pata_atiixp"
  ];
  boot.kernelModules = [ "kvm-amd" "radeon" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/sda3";
      fsType = "ext4";
      options = "rw,data=ordered,relatime";
    };

  fileSystems.extrn = {
    label = "tuegel2";
    mountPoint = "/mnt/extrn";
    options = "nofail";
  };

  networking = {
    hostName = "mugen";
    wireless.enable = true;
    firewall = {
      enable = false;
      allowPing = true;
      allowedTCPPorts = [ 631 5000 8080 ];
    };
    interfaces = {
      enp3s0.ip4 = [ { address = "192.168.1.1"; prefixLength = 24; } ];
    };
  };

  services.dnsmasq = {
    enable = true;
    extraConfig = ''
      interface=enp3s0
      dhcp-range=192.168.1.2,192.168.1.127
      dhcp-host=DEV1B82FE,192.168.1.2
    '';
    resolveLocalQueries = false;
  };
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = true;
  };

  nix.maxJobs = 4;

  swapDevices = [ { device = "/dev/sda4"; } ];

  time.timeZone = "America/Chicago";
}

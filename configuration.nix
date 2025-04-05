# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, inputs, extra_config, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  system.stateVersion = "25.05";
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.substituters = lib.mkForce [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" ];
  

  hardware.graphics = { # hardware.graphics since NixOS 24.11
    enable = true;
    extraPackages = with pkgs; [
      libvdpau-va-gl
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # Enable "Silent boot"
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.initrd.systemd.enable = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "udev.log_priority=3"
    "rd.systemd.show_status=auto"
    "bgrt_disable"
    "acpi_osi=Linux"
    "mem_sleep_default=deep"
    "nvme.noacpi=1"
  ];
  # Hide the OS choice for bootloaders.
  # It's still possible to open the bootloader list by pressing any key
  # It will just not appear on screen unless a key is pressed
  boot.loader.timeout = 0;
  boot.plymouth = {
    enable = true;
    theme = "rings";
    themePackages = with pkgs; [
      # By default we would install all themes
      (adi1090x-plymouth-themes.override {
        selected_themes = [ "rings" ];
      })
    ];
  };

  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.forceImportRoot = false;
  networking.hostId = "df95611e"; # <-- for `zfs`

  networking.hostName = "nixos"; # Define your hostname.
  networking.proxy.default = "http://127.0.0.1:7890";
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8080 ];
    allowedUDPPorts = [ 8080 ];
  };

  time.timeZone = "Asia/Shanghai";

  security.polkit.enable = true;
  security.sudo.extraRules = [
    {
      users = [ "${extra_config.user_name}" ];
      commands = [
        {
          command = "ALL" ;
          options = [ "NOPASSWD" ]; # "SETENV" # Adding the following could be a good idea
        }
      ];
    }
  ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      fcitx5-chinese-addons
      fcitx5-fluent
      fcitx5-pinyin-moegirl
      fcitx5-pinyin-zhwiki
      fcitx5-rime
      rime-data
    ];
    fcitx5.settings = {
      addons = {
        classicui.globalSection.Theme = "FluentDark";
        classicui.globalSection.DarkTheme = "FluentDark";
        pinyin.globalSection = {
          PageSize = 10;
          CloudPinyinEnabled = "True";
          CloudPinyinIndex = 2;
        };
        cloudpinyin.globalSection = {
          Backend = "Baidu";
        };
      };
      globalOptions = {
        "Hotkey/TriggerKeys" = { "0" = "Alt+space"; };
      };
      inputMethod = {
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "keyboard-us";
        };
        "Groups/0/Items/0".Name = "keyboard-us";
        "Groups/0/Items/1".Name = "pinyin";
        GroupOrder."0" = "Default";
      };
    };

  };

  # Select internationalisation properties.
  i18n.defaultLocale = "zh_CN.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "zh_CN.UTF-8";
    LC_IDENTIFICATION = "zh_CN.UTF-8";
    LC_MEASUREMENT = "zh_CN.UTF-8";
    LC_MONETARY = "zh_CN.UTF-8";
    LC_NAME = "zh_CN.UTF-8";
    LC_NUMERIC = "zh_CN.UTF-8";
    LC_PAPER = "zh_CN.UTF-8";
    LC_TELEPHONE = "zh_CN.UTF-8";
    LC_TIME = "zh_CN.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    xkb = {
      layout = "cn";
      variant = "";
    };
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = false;
  };
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "${extra_config.user_name}";
  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.fstrim.enable = true;
  services.auto-cpufreq.enable = true;  
  services.auto-cpufreq.settings = {
    battery = {
       governor = "powersave";
       turbo = "never";
    };
    charger = {
       governor = "performance";
       turbo = "auto";
    };
  };

  # Enable sound with pipewire.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."${extra_config.user_name}" = {
    isNormalUser = true;
    description = "${extra_config.user_name}";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      vim
    ];
  };

  programs.firefox.enable = true;
  programs.niri.enable = true;

  fonts.packages = with pkgs; [
    maple-mono.NF-CN
  ];

  users.defaultUserShell = pkgs.nushell;
  environment.systemPackages = with pkgs; [
    vim
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

}

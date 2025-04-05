{
  description = "nixos configuration";

  nixConfig.substituters = ["https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"];

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.nixos =
    let
      extra_config = {
        user_name = "jedsek";
        user_email = "jedsek@qq.com";
      };
    in
    nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit extra_config;
        inherit inputs;
      };
      modules = [
        ./nixos/default.nix # Your system configuration.
        # ./rust-overlay.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = { inherit inputs; inherit extra_config; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."${extra_config.user_name}" = import ./home.nix;
        }
      ];
    };
  };
}

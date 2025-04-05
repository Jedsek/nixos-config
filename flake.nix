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
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        # user_name = "jedsek";
        inherit inputs;
      };
      modules = [
        ./configuration.nix # Your system configuration.
        # ./rust-overlay.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jedsek = import ./home.nix;
        }
      ];
    };
  };
}

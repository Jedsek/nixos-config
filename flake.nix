{
  description = "nixos configuration";

  nixConfig = {
    substituters = ["https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs;};
      modules = [
        ./configuration.nix # Your system configuration.
        ./rust-overlay.nix
      ];
    };
  };
}

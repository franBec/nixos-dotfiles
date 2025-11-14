{
    description = "NixOS flake";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";

        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = {self, nixpkgs, home-manager, ...}: {

        # Define configurations for specific hosts
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            
            # IMPORTS NOW POINT TO THE HOST DIRECTORY
            modules = [
                ./hosts/Lenovo-ideapad-320-15IKB/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.pollito = import ./home-manager/home.nix;
                        backupFileExtension = "backup";
                    };
                }
            ];
        };
    };
}
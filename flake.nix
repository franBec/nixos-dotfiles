{
    description = "NixOS flake";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";

        # home-manager is defined inside of the flake so the flake itself manages home-manager
        home-manager = {
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs"; # Prevents home-manager to pull its own version of nix packages
        };
    };

    outputs = {self, nixpkgs, home-manager, ...}:{

        # Define the ecosystem for the "nixos" hostname
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";

            # Tells the flake to:
            # - Build the system using ./configuration.nix
            # - Use home-manager inside these modules
            modules = [
                ./configuration.nix
                home-manager.nixosModules.home-manager
                {
                    # Global settings for home-manager
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.pollito = import ./home.nix;
                        backupFileExtension = "backup";
                    };
                }

            ];
        };
    };
}

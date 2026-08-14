{
	description = "Кастомный Flake для Maksim NixOS";

  inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    # Стабильную ветку 25.11
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # AAGL Для лаунчера Genshin Impact
    aagl.url = "github:ezKEa/aagl-gtk-on-nix/release-26.05";
    aagl.inputs.nixpkgs.follows = "nixpkgs";

    # Смарт очистка билдов системы
    nix-gc-env.url = "github:Julow/nix-gc-env";
	};

	outputs = { nixpkgs, nixpkgs-stable, home-manager, aagl, nix-gc-env, ... }:
    let
      system = "x86_64-linux";

      # !!! Важно поменять тип системы
      # Ноутбук -> laptop
      # ПК -> desktop | desktop-gnome
      hostType = "desktop-gnome";
    in {
      nixosConfigurations.maksim = nixpkgs.lib.nixosSystem {
        inherit system;

        # Передаем стабильный срез пакетов во все модули системы
        specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };

        modules = [
          ./hosts/root/default.${hostType}.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.maksim = import ./hosts/maksim/default.${hostType}.nix;
          }

          aagl.nixosModules.default

          nix-gc-env.nixosModules.default
        ];
      };
    };
}

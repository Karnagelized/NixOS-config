{
	description = "Кастомный Flake для Maksim NixOS";

	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
	};
	
	outputs = { nixpkgs, ... }:
	{
		nixosConfigurations.maksim = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
    
    	modules = [
    		./hosts/maksim
    	];
		};
	};
}

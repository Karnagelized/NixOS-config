{ pkgs, ... }:
{
  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
  	git
  	sublime3
  	docker
  	filezilla
  	github-desktop
  	sqlitestudio
  	postgresql
  	pgadmin
  	mongodb
  	mongodb-compass
  	# figma-linux
  	obsidian
  	postman
  	python3
  	onlyoffice-desktopeditors
  	authenticator
  	kitty
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
}

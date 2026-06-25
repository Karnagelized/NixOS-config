{ pkgs, ... }:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

	# Включение Hyprland
	programs.hyprland.enable = true;

  # Включение поддержки Flatpak для установки приложений
  services.flatpak.enable = true;
}

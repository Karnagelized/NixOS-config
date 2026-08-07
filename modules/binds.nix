{ config, pkgs, ... }:

{
  services.desktopManager.gnome.extraGSettingsOverrides = ''
    [org.gnome.settings-daemon.plugins.media-keys]
    custom-keybindings=['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/','/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']

    [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom0]
    binding='<Super>e'
    command='nautilus'
    name='Open Files'

    [org.gnome.settings-daemon.plugins.media-keys.custom-keybindings.custom1]
    binding='<Super>t'
    command='kgx'
    name='Open Terminal'
  '';
}
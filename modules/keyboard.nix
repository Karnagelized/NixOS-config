{ ... }:
{
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "ru,us";
    variant = "";
    options = "grp:win_space_toggle";
  };
}

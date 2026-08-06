{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "happ";
  version = "latest";

  # Укажите путь к скачанному файлу
  src = ../utils/Happ.linux.x64.deb;

  nativeBuildInputs = [ pkgs.dpkg pkgs.autoPatchelfHook ];

  # Библиотеки, необходимые для работы Happ (электрон, графика, сеть)
  buildInputs = with pkgs; [
    alsa-lib
    at-spi2-atk
    cairo
    cups
    dbus
    expat
    glib
    gtk3
    libdrm
    libxkbcommon
    mesa
    nspr
    nss
    pango
    systemd
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libxcb
  ];

  unpackPhase = "dpkg-deb -x $src .";

  installPhase = ''
    mkdir -p $out
    cp -r usr/* $out/

    # Исправляем путь к иконкам и ярлыку, если они есть
    if [ -d "$out/share/applications" ]; then
      substituteInPlace $out/share/applications/*.desktop \
        --replace "/usr/bin/" "$out/bin/"
    fi
  '';

  meta = {
    description = "Happ Client";
    homepage = "https://github.com/Happ-proxy/happ-desktop";
  };
}

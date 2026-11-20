{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}:
let
  onlyofficeFontPackages = osConfig.custom.fontPackages;

  onlyofficeFonts = pkgs.runCommand "onlyoffice-fonts" { } ''
    mkdir -p "$out"

    fontPackageIndex=0
    for fontPackage in ${lib.escapeShellArgs (map toString onlyofficeFontPackages)}; do
      if [[ -d "$fontPackage/share/fonts" ]]; then
        destination="$out/$fontPackageIndex"
        mkdir -p "$destination"

        (
          cd "$fontPackage/share/fonts"
          find -L . -type f \
            \( -iname '*.ttf' -o -iname '*.ttc' -o -iname '*.otf' -o -iname '*.otc' \) \
            -exec cp -L --parents --no-preserve=mode,ownership,timestamps -t "$destination" {} +
        )
      fi

      ((fontPackageIndex += 1))
    done
  '';

  onlyofficeFontsDirectory = "${config.home.homeDirectory}/.local/share/fonts/nixos-system-fonts";
  onlyofficeFontsCache = "${config.home.homeDirectory}/.local/share/onlyoffice/desktopeditors/data/fonts";
in
{
  # OnlyOffice не обходит символические ссылки, поэтому копируем реальные файлы.
  home.activation.copyOnlyofficeFonts = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [[ ! -f "${onlyofficeFontsDirectory}/.nix-source" ]] \
      || [[ "$(<"${onlyofficeFontsDirectory}/.nix-source")" != "${onlyofficeFonts}" ]]; then
      run rm -rf -- "${onlyofficeFontsDirectory}"
      run mkdir -p -- "${onlyofficeFontsDirectory}"
      run cp -LR --no-preserve=mode,ownership,timestamps -- \
        "${onlyofficeFonts}/." "${onlyofficeFontsDirectory}/"
      run chmod -R u+rwX -- "${onlyofficeFontsDirectory}"
      printf '%s\n' "${onlyofficeFonts}" > "${onlyofficeFontsDirectory}/.nix-source"

      # Индекс пересоздастся при следующем запуске OnlyOffice.
      run rm -rf -- "${onlyofficeFontsCache}"
    fi
  '';
}

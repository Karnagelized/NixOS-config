#!/usr/bin/env nix-shell
#!nix-shell -i sh -p jq socat hyprland -I nixpkgs=channel:nixos-unstable

get_workspaces() {
    active=$(hyprctl activeworkspace -j | jq '.id')
    jq -c -n --argjson active "$active" '[range(1; 7)] | map({id: ., active: (. == $active)})'
}

get_workspaces

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hy/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do
  get_workspaces
done

#!/usr/bin/env python3
import subprocess
import json
import sys

bt_name_cache = {}

def run_cmd(cmd):
    try:
        return subprocess.check_output(cmd, shell=True, stderr=subprocess.DEVNULL).decode('utf-8')
    except:
        return "[]"

def parse_pactl(output):
    try:
        return json.loads(output)
    except:
        return []

def get_valid_string(*args):
    """Safely return the first valid string that isn't 'null' or empty."""
    for arg in args:
        value = str(arg).strip().strip('"').strip()
        if value and value.lower() not in ["null", "(null)", "none", ""]:
            return value
    return ""

def human_node_type(node_name):
    if node_name.startswith("bluez_output"):
        return "Bluetooth Output"
    if node_name.startswith("bluez_input"):
        return "Bluetooth Input"
    if node_name.startswith("alsa_output"):
        return "System Output"
    if node_name.startswith("alsa_input"):
        return "System Input"
    return "Audio Device"

def get_active_port_description(node):
    active_port = get_valid_string(node.get("active_port"))
    for port in node.get("ports", []):
        if get_valid_string(port.get("name")) == active_port:
            return get_valid_string(port.get("description"), port.get("type"))
    return ""

def get_bluetooth_name(props):
    address = get_valid_string(props.get("api.bluez5.address"), props.get("device.string"))
    if not address:
        return ""
    if address in bt_name_cache:
        return bt_name_cache[address]

    bt_name = ""
    try:
        out = subprocess.check_output(
            ["bluetoothctl", "info", address],
            stderr=subprocess.DEVNULL
        ).decode("utf-8", errors="replace")
        values = {}
        for line in out.splitlines():
            if ":" not in line:
                continue
            key, value = line.split(":", 1)
            values[key.strip()] = value.strip()
        bt_name = get_valid_string(values.get("Alias"), values.get("Name"))
    except:
        pass

    bt_name_cache[address] = bt_name
    return bt_name

def format_profile_name(profile):
    profile = get_valid_string(profile)
    if profile == "a2dp-sink":
        return "A2DP Output"
    if profile == "headset-head-unit":
        return "Headset"
    if profile:
        return profile.replace("-", " ").title()
    return ""

def get_wpctl_default(node_target):
    """Gets the accurate default node name directly from WirePlumber."""
    try:
        out = run_cmd(f"wpctl inspect {node_target}")
        for line in out.splitlines():
            if "node.name" in line:
                parts = line.split("=", 1)
                if len(parts) == 2:
                    return parts[1].strip().strip('"')
    except:
        pass
    return ""

def get_data():
    sinks = parse_pactl(run_cmd("pactl -f json list sinks"))
    sources = parse_pactl(run_cmd("pactl -f json list sources"))
    sink_inputs = parse_pactl(run_cmd("pactl -f json list sink-inputs"))
    
    # Use wpctl for accurate default nodes under PipeWire
    default_sink = get_wpctl_default("@DEFAULT_AUDIO_SINK@")
    default_source = get_wpctl_default("@DEFAULT_AUDIO_SOURCE@")

    # Fallback to pactl info if wpctl fails
    if not default_sink or not default_source:
        try:
            info = parse_pactl(run_cmd("pactl -f json info"))
            if not default_sink: default_sink = info.get("default_sink_name", "")
            if not default_source: default_source = info.get("default_source_name", "")
        except:
            pass

    def format_node(n, is_default=False, is_app=False):
        vol = 0
        if "volume" in n and isinstance(n["volume"], dict):
            if "front-left" in n["volume"]:
                vol = int(n["volume"]["front-left"].get("value_percent", "0%").strip("%"))
            elif "mono" in n["volume"]:
                vol = int(n["volume"]["mono"].get("value_percent", "0%").strip("%"))

        props = n.get("properties", {})
        
        if is_app:
            display_name = get_valid_string(props.get("application.name"), props.get("application.process.binary"), "Unknown App")
            sub_desc = get_valid_string(props.get("media.name"), props.get("window.title"), props.get("media.role"), "Audio Stream")
        else:
            node_name = get_valid_string(n.get("name"))
            bt_name = get_bluetooth_name(props)
            display_name = get_valid_string(
                props.get("node.description"),
                props.get("node.nick"),
                props.get("device.alias"),
                bt_name,
                n.get("description"),
                props.get("device.description"),
                props.get("device.product.name"),
                props.get("alsa.card_name"),
                human_node_type(node_name)
            )
            sub_desc = get_valid_string(
                props.get("device.profile.description"),
                get_active_port_description(n),
                format_profile_name(props.get("api.bluez5.profile")),
                human_node_type(node_name)
            )

        icon = get_valid_string(props.get("application.icon_name"), props.get("device.icon_name"), "audio-card")
        
        return {
            "id": str(n.get("index")),
            "name": sub_desc,
            "node_name": get_valid_string(n.get("name")),
            "description": display_name,
            "volume": vol,
            "mute": bool(n.get("mute", False)),
            "is_default": bool(is_default),
            "icon": icon
        }

    apps = []
    for s in sink_inputs:
        props = s.get("properties", {})
        if props.get("application.id") != "org.PulseAudio.pavucontrol":
            apps.append(format_node(s, is_app=True))

    # Filter out monitor sources so outputs don't show up in the inputs tab
    real_inputs = []
    for s in sources:
        props = s.get("properties", {})
        if props.get("device.class") == "monitor" or str(s.get("name", "")).endswith(".monitor"):
            continue
        real_inputs.append(format_node(s, s.get("name") == default_source))

    out = {
        "outputs": [format_node(s, s.get("name") == default_sink) for s in sinks],
        "inputs": real_inputs,
        "apps": apps
    }
    
    print(json.dumps(out))

if __name__ == "__main__":
    get_data()

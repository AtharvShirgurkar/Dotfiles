import os

# --- 1. Catppuccin Palette Definition ---
# These are the official hex codes for all 4 flavors.
PALETTE = {
    "latte": {
        "rosewater": "#dc8a78", "flamingo": "#dd7878", "pink": "#ea76cb", "mauve": "#8839ef",
        "red": "#d20f39", "maroon": "#e64553", "peach": "#fe640b", "yellow": "#df8e1d",
        "green": "#40a02b", "teal": "#179299", "sky": "#04a5e5", "sapphire": "#209fb5",
        "blue": "#1e66f5", "lavender": "#7287fd",
        "text": "#4c4f69", "subtext1": "#5c5f77", "subtext0": "#6c6f85",
        "overlay2": "#7c7f93", "overlay1": "#8c8fa1", "overlay0": "#9ca0b0",
        "surface2": "#acb0be", "surface1": "#bcc0cc", "surface0": "#ccd0da",
        "base": "#eff1f5", "mantle": "#e6e9ef", "crust": "#dce0e8",
    },
    "frappe": {
        "rosewater": "#f2d5cf", "flamingo": "#eebebe", "pink": "#f4b8e4", "mauve": "#ca9ee6",
        "red": "#e78284", "maroon": "#ea999c", "peach": "#ef9f76", "yellow": "#e5c890",
        "green": "#a6d189", "teal": "#81c8be", "sky": "#99d1db", "sapphire": "#85c1dc",
        "blue": "#8caaee", "lavender": "#babbf1",
        "text": "#c6d0f5", "subtext1": "#b5bfe2", "subtext0": "#a5adce",
        "overlay2": "#949cbb", "overlay1": "#838ba7", "overlay0": "#737994",
        "surface2": "#626880", "surface1": "#51576d", "surface0": "#414559",
        "base": "#303446", "mantle": "#292c3c", "crust": "#232634",
    },
    "macchiato": {
        "rosewater": "#f4dbd6", "flamingo": "#f0c6c6", "pink": "#f5bde6", "mauve": "#c6a0f6",
        "red": "#ed8796", "maroon": "#ee99a0", "peach": "#f5a97f", "yellow": "#eed49f",
        "green": "#a6da95", "teal": "#8bd5ca", "sky": "#91d7e3", "sapphire": "#7dc4e4",
        "blue": "#8aadf4", "lavender": "#b7bdf8",
        "text": "#cad3f5", "subtext1": "#b8c0e0", "subtext0": "#a5adcb",
        "overlay2": "#939ab7", "overlay1": "#8087a2", "overlay0": "#6e738d",
        "surface2": "#5b6078", "surface1": "#494d64", "surface0": "#363a4f",
        "base": "#24273a", "mantle": "#1e2030", "crust": "#181926",
    },
    "mocha": {
        "rosewater": "#f5e0dc", "flamingo": "#f2cdcd", "pink": "#f5c2e7", "mauve": "#cba6f7",
        "red": "#f38ba8", "maroon": "#eba0ac", "peach": "#fab387", "yellow": "#f9e2af",
        "green": "#a6e3a1", "teal": "#94e2d5", "sky": "#89dceb", "sapphire": "#74c7ec",
        "blue": "#89b4fa", "lavender": "#b4befe",
        "text": "#cdd6f4", "subtext1": "#bac2de", "subtext0": "#a6adc8",
        "overlay2": "#9399b2", "overlay1": "#7f849c", "overlay0": "#6c7086",
        "surface2": "#585b70", "surface1": "#45475a", "surface0": "#313244",
        "base": "#1e1e2e", "mantle": "#181825", "crust": "#11111b",
    },
}

ACCENTS = [
    "rosewater", "flamingo", "pink", "mauve", "red", "maroon", "peach", 
    "yellow", "green", "teal", "sky", "sapphire", "blue", "lavender"
]

# --- 2. Helper Functions ---

def hex_to_rgba(hex_code, alpha=1.0):
    """Converts a hex string (e.g., #1e1e2e) to 'rgba(30,30,46,1)'"""
    hex_code = hex_code.lstrip('#')
    r = int(hex_code[0:2], 16)
    g = int(hex_code[2:4], 16)
    b = int(hex_code[4:6], 16)
    return f"rgba({r},{g},{b},{alpha})"

def generate_config_content(flavor, accent_name):
    """Generates the Zathura configuration string for a specific flavor and accent."""
    c = PALETTE[flavor] # Colors for this flavor
    accent_hex = c[accent_name] # The specific accent color chosen
    
    # Mapping logic based on standard Zathura + Catppuccin guidelines
    return f"""# Zathura {flavor.capitalize()} {accent_name.capitalize()} Theme

set default-fg                {hex_to_rgba(c['text'])}
set default-bg                {hex_to_rgba(c['base'])}

set completion-bg             {hex_to_rgba(c['surface0'])}
set completion-fg             {hex_to_rgba(c['text'])}
set completion-highlight-bg   {hex_to_rgba(accent_hex)}
set completion-highlight-fg   {hex_to_rgba(c['base'])}
set completion-group-bg       {hex_to_rgba(c['mantle'])}
set completion-group-fg       {hex_to_rgba(c['text'])}

set statusbar-fg              {hex_to_rgba(c['text'])}
set statusbar-bg              {hex_to_rgba(c['crust'])}
set inputbar-fg               {hex_to_rgba(c['text'])}
set inputbar-bg               {hex_to_rgba(c['base'])}

set notification-bg           {hex_to_rgba(c['base'])}
set notification-fg           {hex_to_rgba(c['text'])}
set notification-error-bg     {hex_to_rgba(c['base'])}
set notification-error-fg     {hex_to_rgba(c['red'])}
set notification-warning-bg   {hex_to_rgba(c['base'])}
set notification-warning-fg   {hex_to_rgba(c['yellow'])}

set recolor                   "true"
set recolor-lightcolor        {hex_to_rgba(c['base'])}
set recolor-darkcolor         {hex_to_rgba(c['text'])}

set index-fg                  {hex_to_rgba(c['text'])}
set index-bg                  {hex_to_rgba(c['base'])}
set index-active-fg           {hex_to_rgba(c['text'])}
set index-active-bg           {hex_to_rgba(c['surface0'])}

set render-loading-bg         {hex_to_rgba(c['base'])}
set render-loading-fg         {hex_to_rgba(c['text'])}

set highlight-color           {hex_to_rgba(c['overlay2'], 0.3)}
set highlight-fg              {hex_to_rgba(c['text'])}
set highlight-active-color    {hex_to_rgba(accent_hex, 0.3)}
"""

# --- 3. Main Execution ---

output_dir = "zathura_configs"
os.makedirs(output_dir, exist_ok=True)

print(f"Generating configs in '{output_dir}'...")

for flavor in PALETTE.keys():
    for accent in ACCENTS:
        filename = f"catppuccin-{flavor}-{accent}"
        filepath = os.path.join(output_dir, filename)
        
        content = generate_config_content(flavor, accent)
        
        with open(filepath, "w") as f:
            f.write(content)

print("Done! Generated all flavor and accent combinations.")

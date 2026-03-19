import os

# Official Catppuccin Palette
flavors = {
    "latte": {"base": "eff1f5", "text": "4c4f69", "surface0": "ccd0da", "surface2": "acb0be"},
    "frappe": {"base": "303446", "text": "c6d0f5", "surface0": "414559", "surface2": "626880"},
    "macchiato": {"base": "24273a", "text": "cad3f5", "surface0": "363a4f", "surface2": "5b6078"},
    "mocha": {"base": "1e1e2e", "text": "cdd6f4", "surface0": "313244", "surface2": "585b70"},
}

accents = {
    "rosewater": {"latte": "dc8a78", "frappe": "f2d5cf", "macchiato": "f4dbd6", "mocha": "f5e0dc"},
    "flamingo": {"latte": "dd7878", "frappe": "eebebe", "macchiato": "f0c1c1", "mocha": "f2cdcd"},
    "pink": {"latte": "ea76cb", "frappe": "f4b8e4", "macchiato": "f5bde6", "mocha": "f5c2e7"},
    "mauve": {"latte": "8839ef", "frappe": "ca9ee6", "macchiato": "c6a0f6", "mocha": "cba6f7"},
    "red": {"latte": "d20f39", "frappe": "e78284", "macchiato": "ed8796", "mocha": "f38ba8"},
    "maroon": {"latte": "e64553", "frappe": "ea999c", "macchiato": "ee99a0", "mocha": "eba0ac"},
    "peach": {"latte": "fe640b", "frappe": "ef9f76", "macchiato": "f5a97f", "mocha": "fab387"},
    "yellow": {"latte": "df8e1d", "frappe": "e5c890", "macchiato": "eed49f", "mocha": "f9e2af"},
    "green": {"latte": "40a02b", "frappe": "a6d189", "macchiato": "a6da95", "mocha": "a6e3a1"},
    "teal": {"latte": "179287", "frappe": "81c8be", "macchiato": "8bd5ca", "mocha": "94e2d5"},
    "sky": {"latte": "04a5e5", "frappe": "99d1db", "macchiato": "91d7e3", "mocha": "89dceb"},
    "sapphire": {"latte": "209fb5", "frappe": "85c1dc", "macchiato": "7dc4e4", "mocha": "74c7ec"},
    "blue": {"latte": "1e66f5", "frappe": "8caaee", "macchiato": "8aadf4", "mocha": "89b4fa"},
    "lavender": {"latte": "7287fd", "frappe": "babbf1", "macchiato": "b7bdf8", "mocha": "b4befe"},
}

# The template now uses a specific typing_hl_color
template = """# Catppuccin {flavor_name} {accent_name} Optimized Swaylock Config
color={base_hex}
indicator-radius=100
indicator-thickness=12
ring-color={accent_hex}
key-hl-color={typing_hl_color}
bs-hl-color=f38ba8
text-color={text_hex}
line-color=00000000
inside-color={base_hex}
separator-color=00000000

# Status Colors
ring-ver-color={accent_hex}
inside-ver-color={base_hex}
ring-wrong-color=f38ba8
inside-wrong-color={base_hex}
ring-clear-color=a6e3a1
inside-clear-color={base_hex}
"""

output_dir = os.path.expanduser("~/.config/swaylock/themes")
os.makedirs(output_dir, exist_ok=True)

for f_name, f_colors in flavors.items():
    for a_name, a_hexes in accents.items():
        
        # LOGIC: If it's the light theme (Latte), use a darker surface for typing contrast.
        # If it's a dark theme, use the Surface2 color so the typing arc looks like 
        # a glowing highlight that matches the palette.
        typing_hl = f_colors["surface2"]
        
        config_content = template.format(
            flavor_name=f_name.capitalize(),
            accent_name=a_name.capitalize(),
            accent_hex=a_hexes[f_name],
            base_hex=f_colors["base"],
            text_hex=f_colors["text"],
            typing_hl_color=typing_hl
        )
        file_path = f"{output_dir}/catppuccin-{f_name}-{a_name}.conf"
        with open(file_path, "w") as f:
            f.write(config_content)

print(f"Generated {len(flavors) * len(accents)} themes with optimized typing highlights.")

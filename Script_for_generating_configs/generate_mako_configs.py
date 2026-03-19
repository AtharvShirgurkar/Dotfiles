import os

# --- Configuration Template ---
# This matches the functional settings you liked in the previous step.
TEMPLATE = """# Mako Config: Catppuccin {flavor_name} {accent_name}

# --- Layout & Geometry ---
font=monospace 11
width=350
height=150
margin=20
padding=15
border-size=2
border-radius=6
icons=1
max-icon-size=48
icon-path=/usr/share/icons/hicolor
markup=1
actions=1
history=1
text-alignment=left
default-timeout=5000
ignore-timeout=0
max-visible=5
layer=overlay
anchor=top-right

# --- Formatting ---
format=<b>%s</b>\\n%b

# --- Input / Binding ---
on-button-left=invoke-default-action
on-button-right=dismiss
on-button-middle=dismiss-all

# --- Colors ---
background-color={base}
text-color={text}
border-color={accent}
progress-color=over {surface0}

# --- Urgency Overrides ---
[urgency=low]
border-color={base}
default-timeout=2000

[urgency=high]
border-color={accent}
default-timeout=0
"""

# --- Catppuccin Palette Data ---
# Accents are consistent names, but values change per flavor.
PALETTES = {
    "latte": {
        "base": "#eff1f5", "text": "#4c4f69", "surface0": "#ccd0da",
        "accents": {
            "rosewater": "#dc8a78", "flamingo": "#dd7878", "pink": "#ea76cb",
            "mauve": "#8839ef", "red": "#d20f39", "maroon": "#e64553",
            "peach": "#fe640b", "yellow": "#df8e1d", "green": "#40a02b",
            "teal": "#179299", "sky": "#04a5e5", "sapphire": "#209fb5",
            "blue": "#1e66f5", "lavender": "#7287fd"
        }
    },
    "frappe": {
        "base": "#303446", "text": "#c6d0f5", "surface0": "#414559",
        "accents": {
            "rosewater": "#f2d5cf", "flamingo": "#eebebe", "pink": "#f4b8e4",
            "mauve": "#ca9ee6", "red": "#e78284", "maroon": "#ea999c",
            "peach": "#ef9f76", "yellow": "#e5c890", "green": "#a6d189",
            "teal": "#81c8be", "sky": "#99d1db", "sapphire": "#85c1dc",
            "blue": "#8caaee", "lavender": "#babbf1"
        }
    },
    "macchiato": {
        "base": "#24273a", "text": "#cad3f5", "surface0": "#363a4f",
        "accents": {
            "rosewater": "#f4dbd6", "flamingo": "#f0c6c6", "pink": "#f5bde6",
            "mauve": "#c6a0f6", "red": "#ed8796", "maroon": "#ee99a0",
            "peach": "#f5a97f", "yellow": "#eed49f", "green": "#a6da95",
            "teal": "#8bd5ca", "sky": "#91d7e3", "sapphire": "#7dc4e4",
            "blue": "#8aadf4", "lavender": "#b7bdf8"
        }
    },
    "mocha": {
        "base": "#1e1e2e", "text": "#cdd6f4", "surface0": "#313244",
        "accents": {
            "rosewater": "#f5e0dc", "flamingo": "#f2cdcd", "pink": "#f5c2e7",
            "mauve": "#cba6f7", "red": "#f38ba8", "maroon": "#eba0ac",
            "peach": "#fab387", "yellow": "#f9e2af", "green": "#a6e3a1",
            "teal": "#94e2d5", "sky": "#89dceb", "sapphire": "#74c7ec",
            "blue": "#89b4fa", "lavender": "#b4befe"
        }
    }
}

def main():
    output_dir = "mako_configs"
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
        print(f"Created directory: {output_dir}")

    count = 0
    for flavor, colors in PALETTES.items():
        base = colors["base"]
        text = colors["text"]
        surface0 = colors["surface0"]
        
        for accent_name, accent_hex in colors["accents"].items():
            # Generate the filename: e.g., config-catppuccin-mocha-lavender
            filename = f"config-catppuccin-{flavor}-{accent_name}"
            filepath = os.path.join(output_dir, filename)
            
            # Fill the template
            content = TEMPLATE.format(
                flavor_name=flavor.capitalize(),
                accent_name=accent_name.capitalize(),
                base=base,
                text=text,
                accent=accent_hex,
                surface0=surface0
            )
            
            with open(filepath, "w") as f:
                f.write(content)
            
            count += 1
            print(f"Generated: {filename}")

    print(f"\\nSuccess! {count} configuration files created in '{output_dir}/'.")

if __name__ == "__main__":
    main()

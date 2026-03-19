import os

PALETTES = {
    "mocha": {
        "base": "#1e1e2e", "text": "#cdd6f4", "surface0": "#313244", "surface1": "#45475a",
        "red": "#f38ba8", "green": "#a6e3a1", "yellow": "#f9e2af",
        "blue": "#89b4fa", "flamingo": "#f2cdcd", "lavender": "#b4befe", "maroon": "#eba0ac",
        "mauve": "#cba6f7", "peach": "#fab387", "pink": "#f5c2e7", "rosewater": "#f5e0dc",
        "sapphire": "#74c7ec", "sky": "#89dceb", "teal": "#94e2d5"
    },
    "macchiato": {
        "base": "#24273a", "text": "#cad3f5", "surface0": "#363a4f", "surface1": "#494d64",
        "red": "#ed8796", "green": "#a6da95", "yellow": "#eed49f",
        "blue": "#8aadf4", "flamingo": "#f0c6c6", "lavender": "#b7bdf8", "maroon": "#ee99a0",
        "mauve": "#c6a0f6", "peach": "#f5a97f", "pink": "#f5bde6", "rosewater": "#f4dbd6",
        "sapphire": "#7dc4e4", "sky": "#91d7e3", "teal": "#8bd5ca"
    },
    "frappe": {
        "base": "#303446", "text": "#c6d0f5", "surface0": "#414559", "surface1": "#51576d",
        "red": "#e78284", "green": "#a6d189", "yellow": "#e5c890",
        "blue": "#8caaee", "flamingo": "#eebebe", "lavender": "#babbf1", "maroon": "#ea999c",
        "mauve": "#ca9ee6", "peach": "#ef9f76", "pink": "#f4b8e4", "rosewater": "#f2d5cf",
        "sapphire": "#85c1dc", "sky": "#99d1db", "teal": "#81c8be"
    },
    "latte": {
        "base": "#eff1f5", "text": "#4c4f69", "surface0": "#ccd0da", "surface1": "#bcc0cc",
        "red": "#d20f39", "green": "#40a02b", "yellow": "#df8e1d",
        "blue": "#1e66f5", "flamingo": "#dd7878", "lavender": "#7287fd", "maroon": "#e64553",
        "mauve": "#8839ef", "peach": "#fe640b", "pink": "#ea76cb", "rosewater": "#dc8a78",
        "sapphire": "#209fb5", "sky": "#04a5e5", "teal": "#179299"
    }
}

CSS_TEMPLATE = """/* =============================================================================
 * CATPPUCCIN {flavor_name} - {accent_name}
 * =========================================================================== */

* {{
  font-family: "Noto Sans", "Font Awesome 7 Free", "Font Awesome 7 Brands", Roboto, Helvetica, Arial, sans-serif;
  font-size: 14px;
}}

window#waybar {{
  background: {base}; /* Base Color */
  color: {text};
  opacity: 0.95;
}}

#waybar {{
  background-color: rgba(0, 0, 0, 0.0);
}}

#workspaces {{
  padding: 0 5px;
  margin: 0;
}}

#workspaces button {{
  padding: 0 10px;
  margin: 0 2px;
  min-width: 0;
  color: {text};
  background-color: {surface0}; /* Module BG */
  border: none;
  transition: background-color 0.2s ease;
}}

#workspaces button.focused,
#workspaces button.active {{
  color: {base}; /* Text becomes base color on accent background for contrast */
  background-color: {accent}; /* Chosen Accent */
  font-weight: bold;
}}

#workspaces button.urgent {{
  color: {base};
  background-color: {red};
  font-weight: bold;
}}

#clock {{
  padding: 0 10px;
  margin: 0 2px;
  background-color: {surface0};
  color: {text};
  transition: background-color 0.2s ease;
  border-radius: 6px;
}}

#tray {{
  background-color: {surface0};
  color: {text};
  padding: 0 5px;
  margin: 0 2px;
  transition: background-color 0.2s ease;
  border-radius: 6px;
}}

#tray > .item {{
  padding: 0 5px;
  color: {text};
  min-width: 0;
}}

#tray > .item:hover {{
  background-color: {surface1}; /* Hover Color */
}}

#pulseaudio {{
  padding: 0 10px;
  margin: 0 2px;
  background-color: {surface0};
  color: {text};
  transition: background-color 0.2s ease;
  border-radius: 6px;
}}

#pulseaudio.muted {{
  color: {red};
}}

#idle_inhibitor {{
  padding: 2px 12px;
  margin: 0 2px;
  background-color: {surface0};
  color: {text};
  transition: background-color 0.2s ease;
  border-radius: 6px;
}}

#idle_inhibitor.activated {{
  color: {base};
  background-color: {accent};
  font-weight: bold;
}}

#idle_inhibitor.deactivated {{
  background-color: {surface0};
  color: {text};
}}

#battery {{
  padding: 0 10px;
  margin: 0 2px;
  background-color: {surface0};
  color: {text};
  transition: background-color 0.2s ease;
  border-radius: 6px;
}}

#battery.charging {{
  color: {green};
}}

#battery.discharging.warning {{
  color: {yellow};
  font-weight: bold;
}}

#battery.discharging.critical {{
  color: {red};
  font-weight: bold;
}}

#battery.full {{
  background-color: {surface0};
  color: {green};
}}

#cpu {{
  padding: 0 10px;
  margin: 0 2px;
  background-color: {surface0};
  color: {text};
  transition: background-color 0.2s ease;
  border-radius: 6px;
}}

#cpu.warning {{
  color: {yellow};
  font-weight: bold;
}}

#cpu.critical {{
  color: {red};
  font-weight: bold;
  background-color: {surface1};
}}

#scratchpad {{
   padding: 0 10px;
   margin: 0 2px;
   min-width: 0;
   border: none;
   transition: background-color 0.2s ease;
   color: {base};
   background-color: {accent};
   font-weight: bold;
}}

#scratchpad.empty {{
   color: {text};
   background-color: {surface0};
   font-weight: normal;
}}

#clock:hover,
#tray:hover,
#pulseaudio:hover,
#idle_inhibitor:hover,
#battery:hover,
#cpu:hover,
#scratchpad:hover {{
  background-color: {surface1};
}}
"""

OUTPUT_DIR = "waybar_configs"
if not os.path.exists(OUTPUT_DIR):
    os.makedirs(OUTPUT_DIR)

print(f"Generating themes in '{OUTPUT_DIR}'...")

for flavor, colors in PALETTES.items():
    # Iterate through all keys in the palette that are likely accents
    # (Exclude base, text, surfaces, and basic red/green/yellow if they aren't the primary accent)
    accents = [k for k in colors.keys() if k not in ["base", "text", "surface0", "surface1"]]
    
    for accent in accents:
        # Determine the specific hex code for this accent in this flavor
        accent_hex = colors[accent]
        
        # Fill the template
        css_content = CSS_TEMPLATE.format(
            flavor_name=flavor.upper(),
            accent_name=accent.upper(),
            base=colors["base"],
            text=colors["text"],
            surface0=colors["surface0"],
            surface1=colors["surface1"],
            accent=accent_hex,
            red=colors["red"],
            green=colors["green"],
            yellow=colors["yellow"]
        )
        
        filename = f"catppuccin-{flavor}-{accent}.css"
        filepath = os.path.join(OUTPUT_DIR, filename)
        
        with open(filepath, "w") as f:
            f.write(css_content)
        
        print(f"Generated: {filename}")

print("\nSuccess! All Waybar CSS files generated.")

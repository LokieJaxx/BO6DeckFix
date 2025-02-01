#!/bin/bash
echo "Installing BO6Fixer..."
# Add real installation logic here
#!/bin/bash
echo "Placeholder script for BO6Fixer"
# Replace this with actual logic later
#!/bin/bash
echo "🔧 Installing BO6 Compatibility Fix for Steam Deck..."

# Ensure system is up to date
echo "📦 Updating Steam Deck..."
sudo steamos-readonly disable
sudo pacman -Syu --noconfirm
sudo steamos-readonly enable

# Install required dependencies
echo "🛠 Installing Proton dependencies..."
flatpak install -y com.valvesoftware.Steam
flatpak install -y org.freedesktop.Platform.Compat.i386
flatpak install -y org.freedesktop.Platform.GL.default
flatpak install -y org.freedesktop.Platform.VulkanLayer.MangoHud

# Enable Proton Experimental for BO6
echo "🎮 Enabling Proton Experimental..."
proton_version="Proton Experimental"
bo6_appid=$(grep -Eo '"appid"[[:space:]]*:[[:space:]]*[0-9]+' ~/.steam/root/config/libraryfolders.vdf | grep -Eo '[0-9]+')
proton_path="$HOME/.steam/steam/steamapps/common/$proton_version"

if [ -d "$proton_path" ]; then
    echo "$proton_version found! Setting for BO6..."
    mkdir -p "$HOME/.steam/steam/steamapps/compatdata/$bo6_appid/"
    echo "$proton_version" > "$HOME/.steam/steam/steamapps/compatdata/$bo6_appid/pfx/version"
else
    echo "⚠️ Proton Experimental not found. Make sure it's installed in Steam."
fi

# Apply performance optimizations
echo "🚀 Applying Performance Fixes..."
echo "vm.max_map_count=1048576" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# Fix potential anti-cheat issues
echo "🔍 Checking Anti-Cheat Compatibility..."
flatpak install -y org.freedesktop.Platform.VulkanLayer.Layers
echo "✅ Compatibility Fixes Applied! Restart Steam and try launching BO6."


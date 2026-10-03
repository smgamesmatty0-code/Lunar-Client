# Lunar Client 1.21.11 (Fabric) - Standalone Ultra-Potato Edition

A portable, standalone build of Lunar Client (Fabric 1.21.11) with zero Electron/Chromium launcher overhead, offline/cracked server compatibility, and pre-configured PvP optimization packs.

---

## ⚡ Quick Start

1. **Launch the Game**:
   - Double-click **`Launch.bat`** (or `Launch-Minecraft-1.21.11.bat`).
   - The game will launch directly using the embedded Zulu OpenJDK 21 LTS runtime. No Java installation or Lunar Launcher required.

2. **Change Your Username**:
   - Run **`Change-Username.bat`** or edit **`username.txt`** directly.
   - Enter your desired nickname (alphanumeric, 3-16 characters).
   - Your UUID and accounts profile will automatically synchronize on launch.

3. **In-Game Settings & Mods**:
   - Press **`Right Shift`** in-game to access the Lunar Client mod menu (HUD layout, crosshair, keystrokes, CPS, toggle sprint, zoom).
   - Press **`C`** to zoom.

---

## 🚀 Key Features & Optimizations

- **Standalone Zero-Launcher**: No Electron background processes, saving over 500 MB to 1 GB of system RAM.
- **Embedded Zulu OpenJDK 21**: Pre-bundled 64-bit Java runtime tuned with optimized GC flags (`-XX:+UseG1GC`, `-Xms256m`, `-Xmx1536m`).
- **Offline / Cracked Server Bypass**: Patched authentication service allowing connection to offline/hybrid servers (`universalmc.fun`, `top.pika.host`, `mc.mineberry.org`, etc.) without "Invalid session" or "You are not logged in" errors.
- **Pre-Configured PvP Resource Packs**:
  - `Low Shield.zip` (lower shield in first-person for maximum peripheral vision)
  - `Low Fire.zip` (reduced fire screen overlay)
  - `Crystal PvP LT3 Essentials.zip` (clean particles and minimized clutter)
- **Built-in Sodium & Modern Rendering**: Smooth frame pacing, high FPS, and low memory usage.

---

## 🛠️ Requirements & Compatibility

- **OS**: Windows 10 / 11 (64-bit)
- **RAM**: Minimum 4 GB system RAM recommended (Game allocated 1.5 GB heap)
- **Graphics**: OpenGL 3.3+ capable GPU (Intel HD Graphics, NVIDIA, AMD)

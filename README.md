cat << 'EOF' > README.md
# 🎥 Batch AVI to MP4 Converter (Zenity GUI)

A fast, elegant, and user-friendly batch video converter that transforms `.avi` files into `.mp4` using `ffmpeg`. Designed to run inside a Docker container with **hardware + software acceleration** on ARMv8 platforms (e.g., Jetson, Raspberry Pi).

## ✨ Features

- 📂 GUI-based folder selection using **Zenity**
- 🔄 Real-time **progress bar** during conversion
- ⚡ Ultra-fast encoding with `ffmpeg` using `libx264` and `-preset ultrafast`
- 🐳 Dockerized and portable
- 💻 Works on ARMv8 (Jetson, Raspberry Pi 5, etc.)
- 🎨 Visually immersive and intuitive experience

---

## 🛠 Installation

### 1. Clone the repo:
```bash
git clone https://github.com/jeminai/avi-to-mp4-converter.git
cd avi-to-mp4-converter

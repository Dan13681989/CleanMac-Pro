# 🧹 CleanMac Pro

[![ShellCheck](https://github.com/Dan13681989/CleanMac-Pro/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/Dan13681989/CleanMac-Pro/actions/workflows/shellcheck.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-10.15%2B-blue)](https://apple.com/macos)
[![GitHub release](https://img.shields.io/github/v/release/Dan13681989/CleanMac-Pro)](https://github.com/Dan13681989/CleanMac-Pro/releases)

**Professional macOS optimisation suite** – interactive TUI, security scanning, Docker cleanup, and smart cache management.

![Demo placeholder](https://via.placeholder.com/800x400?text=CleanMac+Pro+Demo)  
*(Add an asciinema recording or screenshot here)*

## ✨ Features

- **Interactive Dashboard** – real-time system health and cleaning controls  
- **One‑click Cleaning** – remove caches, logs, trash, Xcode cruft, and browser data  
- **Dry‑Run Mode** – preview what will be deleted before running (`--dry-run`)  
- **Security Audit** – check firewall, SIP, SSH settings, and more  
- **Docker Cleanup** – remove unused images, containers, and volumes  
- **Homebrew Integration** – automatically cleans up old formulae  

## 🚀 Quick Install

```bash
git clone https://github.com/Dan13681989/CleanMac-Pro.git
cd CleanMac-Pro
./install.sh
After installation, add ~/CleanMac-Pro to your PATH or symlink cleanmac to /usr/local/bin.

📦 Requirements

macOS 10.15 (Catalina) or newer
Apple Silicon or Intel
Some features require sudo (system caches)
🎮 Usage

bash
# Show help
./cleanmac help

# Preview what will be deleted (safe)
./cleanmac clean --dry-run

# Actually clean
./cleanmac clean

# Launch interactive TUI dashboard
./cleanmac dashboard
🛡️ Safety First

All destructive operations show a preview with --dry-run
Nothing is deleted without your confirmation (unless you use --force)
No telemetry or external network calls – your privacy is respected
🤝 Contributing

See CONTRIBUTING.md.
Please run shellcheck on any .sh files before submitting a PR.

📄 License

MIT – see LICENSE for details.

🙏 Acknowledgements

Built with ❤️ using bash and standard macOS utilities.

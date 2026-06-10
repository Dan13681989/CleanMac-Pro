# 🧹 CleanMac Pro

[![ShellCheck](https://github.com/Dan13681989/CleanMac-Pro/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/Dan13681989/CleanMac-Pro/actions/workflows/shellcheck.yml)
[![BATS Tests](https://github.com/Dan13681989/CleanMac-Pro/actions/workflows/bats.yml/badge.svg)](https://github.com/Dan13681989/CleanMac-Pro/actions/workflows/bats.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![macOS](https://img.shields.io/badge/macOS-10.15%2B-blue)](https://apple.com/macos)
[![Homebrew](https://img.shields.io/badge/Homebrew-tap-orange)](https://github.com/Dan13681989/homebrew-cleanmac)

**Professional macOS optimisation suite** – interactive TUI, security scanning, Docker cleanup, and network toolkit.

## ✨ Features

- **System Cleaning** – remove caches, logs, trash, Xcode cruft, browser data (with `--dry-run` preview)
- **Interactive Dashboard** – real‑time system health and cleaning controls
- **Disk Analysis** – interactive usage explorer (`analyze`) and large file finder (`large-files`)
- **Docker Cleanup** – prune images, containers, volumes, and shrink `Docker.raw`
- **Security Audit** – check firewall, SIP, SSH settings, and system updates
- **Network Toolkit** – status, flush‑DNS, TCP optimisation, reset to defaults, live monitor
- **Enterprise Flags** – `--quiet`, `--json`, `--log-level`, log rotation, config file
- **Shell Completions** – bash and zsh
- **Homebrew Integration** – one‑command install

## 🍺 Installation (Recommended)

```bash
brew tap Dan13681989/cleanmac
brew install cleanmac-pro
Manual from source

bash
git clone https://github.com/Dan13681989/CleanMac-Pro.git
cd CleanMac-Pro
./install.sh
📦 Requirements

macOS 10.15 (Catalina) or newer
Apple Silicon or Intel
Some features require sudo (system caches, network optimisation)
Optional: ncdu for interactive disk analysis (brew install ncdu)
🎮 Usage

bash
cleanmac help                 # Show all commands
cleanmac clean --dry-run      # Preview cleaning
cleanmac clean                # Actually clean
cleanmac dashboard            # Launch interactive TUI
cleanmac analyze              # Disk usage (requires ncdu)
cleanmac large-files          # Find files >100MB
cleanmac docker               # Clean Docker space
cleanmac security             # Run security scan
cleanmac network status       # Show IP and DNS
cleanmac network flush-dns    # Flush DNS cache
cleanmac network optimize     # Apply DNS + TCP tuning
cleanmac network reset        # Revert TCP to macOS defaults
cleanmac network monitor      # Live network monitor
cleanmac version              # Show version
cleanmac upgrade              # Self-upgrade (git clone only)
cleanmac uninstall            # Remove everything
Global options

--quiet – suppress non‑essential output
--json – machine‑readable JSON (dry‑run only)
--log-level debug|info|error – set verbosity
⚙️ Configuration

Create ~/.cleanmac/config to set defaults:

bash
QUIET=true
LOG_LEVEL=info
🛡️ Safety First

All destructive operations show a preview with --dry-run
Nothing is deleted without your confirmation (unless you use --force)
No telemetry or external network calls (except public IP lookup)
Logs saved to ~/.cleanmac/cleanmac.log (rotated at 5MB)
🤝 Contributing

See CONTRIBUTING.md.
Please run shellcheck and bats tests before submitting a PR.

📄 License

MIT – see LICENSE for details.

🙏 Acknowledgements

Built with ❤️ using bash and standard macOS utilities.

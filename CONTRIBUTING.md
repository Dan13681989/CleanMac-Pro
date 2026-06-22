# Contributing to CleanMac Pro

Thank you for your interest! CleanMac Pro is a community-driven project.

## How to Contribute

- **Report bugs**: Open an issue with steps to reproduce.
- **Suggest features**: Use the issue tracker.
- **Submit code**: Pull requests are welcome.

## Development Setup

```bash
git clone https://github.com/Dan13681989/CleanMac-Pro.git
cd CleanMac-Pro
./install.sh          # for local testing
brew install shellcheck bats-core  # for linting and tests
Coding Standards

Bash scripts must be bash 3.2 compatible (macOS default).
Use set -euo pipefail and handle errors gracefully.
Run shellcheck before committing.
Add --dry-run support for any destructive operation.
Testing

Run BATS tests:

bash
bats tests/
Pull Request Process

Fork the repo and create a branch.
Make your changes, add tests if applicable.
Ensure shellcheck and bats pass.
Open a PR describing your changes.
License

By contributing, you agree that your code will be licensed under the MIT License.

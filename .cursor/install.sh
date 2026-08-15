#!/usr/bin/env bash
# Idempotent Cloud Agent setup for the profile README repository.
# Installs the Markdown tooling used to lint and preview README.md.
set -euo pipefail

# Markdown tooling:
#   - pymarkdownlnt: lints Markdown (see .pymarkdown.json for the ruleset)
#   - grip:          serves README.md rendered with GitHub's own Markdown
#                    pipeline, so the local preview matches the profile page.
# Installed into the user site with --break-system-packages to respect
# Ubuntu's externally-managed Python without an extra apt dependency.
python3 -m pip install --user --break-system-packages --quiet --upgrade \
  grip pymarkdownlnt

# Expose the console scripts on PATH regardless of the caller's shell.
for tool in grip pymarkdown; do
  sudo ln -sf "$HOME/.local/bin/$tool" "/usr/local/bin/$tool"
done

hash -r
grip --version
pymarkdown version
echo "Environment setup complete."

###############################################################################
# 🛠️  NixOS & System Management Commands
#
# These commands help manage the system configuration using Nix flakes.
###############################################################################

.PHONY: copy-config deploy home upgrade debug up upp test history repl clean gc-sudo gc gcboot

# 🛑 Utility function: copy ~/nixos to /etc/nixos
copy-config:
	sudo cp -r ~/nixos/* /etc/nixos/

# 🚀 Deploy the current system configuration and make it the default on boot.
# Usage: make deploy
deploy: copy-config
	sudo nixos-rebuild switch --flake /etc/nixos

# 🏡 Same as `deploy`, but with a custom flake target (e.g., for home-manager).
# Usage: make home
home: copy-config
	sudo nixos-rebuild switch --flake /etc/nixos#nixos

# ⬆️ Upgrade system packages and apply the latest flake changes.
# Usage: make upgrade
upgrade: copy-config
	sudo nixos-rebuild switch --upgrade --flake /etc/nixos

# 🐛 Like `deploy`, but with verbose logs and error traces for debugging.
# Usage: make debug
debug: copy-config
	sudo nixos-rebuild switch --flake /etc/nixos --show-trace --verbose

# 🌐 Update all flake inputs to their latest versions.
# Usage: make up
up:
	nix flake update ~/nixos

# 🔍 Update a specific flake input (e.g., `make upp i=home-manager`)
# Usage: make upp i=home-manager
upp:
	nix flake update ~/nixos/${i}

# 🧪 Test the configuration without setting it as the default boot entry.
# Usage: make test
test: copy-config
	sudo nixos-rebuild test --flake /etc/nixos

# 🕓 Show system profile history.
# Usage: make history
history:
	nix profile history --profile /nix/var/nix/profiles/system

# 💻 Launch the Nix REPL with nixpkgs from the flake.
# Usage: make repl
repl:
	nix repl -f flake:nixpkgs

# 🧹 Clean up system profile history older than 1 day.
# Usage: make clean
clean:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 1d

# 🧼 Collect and delete old garbage as root.
# Usage: make gc-sudo
gc-sudo:
	sudo nix-collect-garbage -d

# 🧽 Same as above, but for the current user.
# Usage: make gc
gc:
	nix-collect-garbage -d

# 🥾 Boot into a specific configuration without switching immediately.
# Usage: make gcboot
gcboot:
	sudo /run/current-system/bin/switch-to-configuration boot


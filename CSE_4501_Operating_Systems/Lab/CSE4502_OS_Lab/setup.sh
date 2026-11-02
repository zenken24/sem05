#!/usr/bin/env bash
# CSE 4502 OS Lab: install and check the tools on macOS (Intel or Apple Silicon).
# Needs Homebrew (https://brew.sh). Run from the CSE4502_OS_Lab directory:
#     bash setup.sh
set -e
cd "$(dirname "$0")"
. ./mcertikos/scripts/common_check.sh

if ! command -v brew >/dev/null 2>&1; then
	echo "Homebrew is not installed. Install it from https://brew.sh, then run this script again."
	exit 1
fi

echo "Installing the tools with Homebrew..."
# i686-elf-* is a cross-compiler for 32-bit x86; 'make' installs GNU Make 4
# (macOS ships the old GNU Make 3.81).
brew install i686-elf-binutils i686-elf-gcc qemu make python git
brew install i386-elf-gdb || echo "(optional) i386-elf-gdb could not be installed; you can debug without it"

# Make 'make' mean GNU Make 4 in new terminals.
GNUBIN="$(brew --prefix)/opt/make/libexec/gnubin"
RC="$HOME/.zshrc"
if ! grep -qs "$GNUBIN" "$RC"; then
	echo "export PATH=\"$GNUBIN:\$PATH\"" >> "$RC"
	echo "Added GNU Make to your PATH in $RC (open a new terminal to use it)."
fi
export PATH="$GNUBIN:$PATH"

CC_CHECK=i686-elf-gcc
check_tools

# CSE 4502 OS Lab: setup on macOS

This archive is for **macOS 12 (Monterey) or newer**, on Intel or Apple
Silicon (M1/M2/M3/M4) Macs. Using Linux or Windows? Download the archive for
your system instead.

macOS cannot compile 32-bit x86 kernels with its own compiler, so you install
a **cross-compiler** (`i686-elf-gcc`). The build finds it automatically.
macOS has no KVM, so QEMU emulates the processor: everything works, but
booting and running the tests take longer than on Linux.

## 1. Install Homebrew

If you do not have it yet, install Homebrew from <https://brew.sh> and follow
the instructions it prints at the end (adding `brew` to your PATH).

## 2. Unpack the archive

In the Terminal app:

```
mkdir -p ~/os-lab
cd ~/os-lab
tar xzf ~/Downloads/CSE4502_OS_Lab_Winter2025-26_macOS.tar.gz
cd CSE4502_OS_Lab
```

If Safari already unpacked the download into a folder, move that folder to
`~/os-lab` instead. Keep the path free of spaces.

## 3. Install the tools

```
bash setup.sh
```

The script installs `i686-elf-binutils`, `i686-elf-gcc`, QEMU, GNU Make 4,
Python and Git (and, if available, `i386-elf-gdb` for debugging), and checks
the result. It also adds GNU Make to your PATH in `~/.zshrc`, because the
`make` that ships with macOS (version 3.81) is too old. **Open a new
terminal** afterwards.

To install by hand instead:

```
brew install i686-elf-binutils i686-elf-gcc qemu make python git
brew install i386-elf-gdb        # optional, for debugging
echo 'export PATH="$(brew --prefix)/opt/make/libexec/gnubin:$PATH"' >> ~/.zshrc
```

## 4. Check that everything works

```
cd ~/os-lab/CSE4502_OS_Lab/mcertikos
make LAB=1 TEST=1
```

You should see `LAB 1 RESULT: 0 / 3 test groups passed.` (the tests fail
until you write the Lab 1 code). Exit QEMU with **Ctrl-a**, then **x**.
Without KVM, wait up to a minute for the tests; Labs 6 and 7 take longest.

## Contents

- `mcertikos/`: the project you work on for the whole course
- `CSE4502_Lab_Handout_Book.pdf`: the lab handout (Chapter 2 covers setup;
  Appendix A covers troubleshooting)

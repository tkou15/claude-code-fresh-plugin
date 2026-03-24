---
description: Open files or directories in the Fresh terminal text editor. Use when the user wants to edit files in Fresh.
disable-model-invocation: true
---

# Fresh Editor

Open files or directories in [Fresh](https://github.com/sinelaw/fresh), a modern terminal text editor.

## Usage

The user invokes this skill with `/fresh` or `/fresh <path>`.

## Instructions

1. First, check if `fresh` is installed:

```bash
which fresh
```

If not installed, show installation instructions (see bottom of this file) and stop.

2. Check if a Fresh session is already running:

```bash
fresh --cmd session list
```

3. **If a session is running**: Open the file directly via the session (no TTY needed):

```bash
fresh --cmd session open-file . $ARGUMENTS
```

If no arguments were provided, suggest the user attach to the session:
```
! fresh -a
```

4. **If no session is running**: Fresh requires a real TTY and cannot run via the Bash tool. Tell the user to run it with the `!` prefix (which executes in their shell session with full TTY access):

- If the user provided arguments: suggest `! fresh $ARGUMENTS`
- If no arguments: suggest `! fresh .` to open the current directory

Once a session is started, subsequent file opens can be done automatically via `fresh --cmd session open-file`.

## Installation instructions

**macOS/Linux (Homebrew):**
```
brew install fresh-editor
```

**npm:**
```
npm install -g fresh-editor
```

**Cargo:**
```
cargo install fresh-editor
```

**Quick install script:**
```
curl https://raw.githubusercontent.com/sinelaw/fresh/refs/heads/master/scripts/install.sh | sh
```

For more options, see: https://github.com/sinelaw/fresh#installation

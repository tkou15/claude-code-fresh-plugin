---
description: Open files or directories in the Fresh terminal text editor. Use when the user wants to edit files in Fresh.
disable-model-invocation: true
---

# Fresh Editor

Open files or directories in [Fresh](https://github.com/sinelaw/fresh), a modern terminal text editor.

## Usage

The user invokes this skill with `/fresh` or `/fresh <path>`.

## Instructions

**IMPORTANT**: Fresh is an interactive terminal editor that requires a real TTY. Do NOT run `fresh` via the Bash tool — it will fail with "Device not configured".

1. First, check if `fresh` is installed:

```bash
which fresh
```

2. If `fresh` is installed, tell the user to run it with the `!` prefix (which executes in their shell session with full TTY access):

- If the user provided arguments: suggest `! fresh $ARGUMENTS`
- If no arguments: suggest `! fresh .` to open the current directory

3. If `fresh` is NOT installed, show installation instructions:

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

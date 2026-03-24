---
name: fresh
description: Open files or directories in the Fresh terminal text editor. Use when the user wants to edit files in Fresh.
disable-model-invocation: true
allowed-tools: Bash
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

2. If `fresh` is installed, open the editor:

- If the user provided arguments: run `fresh $ARGUMENTS`
- If no arguments: run `fresh .` to open the current directory

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

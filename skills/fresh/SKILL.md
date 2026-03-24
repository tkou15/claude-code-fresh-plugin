---
description: Open files or directories in the Fresh terminal text editor. Use when the user wants to edit files in Fresh.
disable-model-invocation: true
---

# Fresh Editor

Open files or directories in [Fresh](https://github.com/sinelaw/fresh), a modern terminal text editor.

## Usage

The user invokes this skill with `/fresh` or `/fresh <path>`.

## Instructions

1. Check if `fresh` is installed:

```bash
which fresh
```

If not installed, show installation instructions (see bottom of this file) and stop.

2. Check if a Fresh session is already running and get the session name:

```bash
fresh --cmd session list
```

This outputs lines like: `/Users/ko1 (Users_ko1)` — the name in parentheses (e.g., `Users_ko1`) is the session name.

3. **If a session is running**, open files via the session using the session name:

   **a) If cmux is available** (`$CMUX_SOCKET_PATH` is set) — find the Fresh surface and send the command:

   ```bash
   cmux send --surface <fresh-surface-id> "fresh --cmd session open-file SESSION_NAME $ARGUMENTS"
   cmux send-key --surface <fresh-surface-id> Enter
   ```

   **b) Otherwise** — tell the user to run:

   ```
   ! fresh --cmd session open-file SESSION_NAME $ARGUMENTS
   ```

   **IMPORTANT**: Use the actual session name (e.g., `Users_ko1`), NOT `.` — the `.` shorthand only works when CWD matches the session directory.

4. **If no session is running**, start one:

   **a) If cmux is available** — open Fresh in a right split pane at the current working directory:

   ```bash
   cmux new-split right
   # Note the surface ID from the output (e.g., "OK surface:11")
   cmux send --surface <surface-id> "cd $(pwd) && fresh -a"
   cmux send-key --surface <surface-id> Enter
   ```

   **IMPORTANT**: Use `cd $(pwd)` to ensure Fresh starts in the same directory as Claude Code. This makes the session name match the working directory.

   Wait a moment, then open the file via the session (step 3a).

   **b) Otherwise** — tell the user:

   ```
   ! fresh $ARGUMENTS
   ```

   Or if no arguments: `! fresh .`

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

For more options, see: https://github.com/sinelaw/fresh#installation

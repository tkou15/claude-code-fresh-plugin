---
description: Review code and open findings in the Fresh editor with inline popup annotations. Use when the user wants a code review with results shown directly in Fresh.
disable-model-invocation: true
---

# Code Review with Fresh

Review code and present findings in [Fresh](https://github.com/sinelaw/fresh) using its `@"message"` popup annotation feature.

## Usage

The user invokes this skill with `/fresh-editor:review` or `/fresh-editor:review <file-or-directory>`.

## Instructions

1. **Determine the review target**:
   - If `$ARGUMENTS` is provided, review those files or directories
   - If no arguments, review recently changed files using `git diff --name-only` or the current directory

2. **Read and analyze the code**: Use the Read and Grep tools to examine the target code. Look for:
   - Security vulnerabilities (injection, XSS, etc.)
   - Bugs and logic errors
   - Performance issues
   - Error handling gaps
   - Code style and best practices violations

3. **Check if Fresh is installed and get the session name**:

```bash
which fresh && fresh --cmd session list
```

The session list outputs lines like: `/Users/ko1 (Users_ko1)` — the name in parentheses is the session name.

4. **Format findings** using Fresh's annotation syntax:

```
fresh --cmd session open-file SESSION_NAME 'path/to/file.ext:START_LINE-END_LINE@"Issue description"'
```

**IMPORTANT**: Use the actual session name (e.g., `Users_ko1`), NOT `.`.

5. **Open findings** — choose based on environment:

   **a) If cmux is available** (`$CMUX_SOCKET_PATH` is set) and a session is running:

   Send each finding directly to the Fresh pane:

   ```bash
   cmux send --surface <fresh-surface-id> "fresh --cmd session open-file SESSION_NAME 'src/db.rs:45-52@\"SQL injection risk\"'"
   cmux send-key --surface <fresh-surface-id> Enter
   ```

   If no session is running, start one first:

   ```bash
   cmux new-split right
   # Note the surface ID
   cmux send --surface <surface-id> "fresh -a"
   cmux send-key --surface <surface-id> Enter
   ```

   **b) Otherwise** — present findings as commands for the user:

   ```
   Found 3 issues:

   1. **SQL Injection** in `src/db.rs:45-52`
      ! fresh --cmd session open-file SESSION_NAME 'src/db.rs:45-52@"SQL injection risk: use prepared statements"'

   2. **Missing error handling** in `src/api.rs:23`
      ! fresh --cmd session open-file SESSION_NAME 'src/api.rs:23@"unwrap() on network call - handle the error"'
   ```

   If no session is running, suggest starting one first: `! fresh -a`

6. **Important notes**:
   - Wrap file arguments in single quotes to prevent shell expansion of `@"..."`
   - When using cmux send, escape inner double quotes with `\"`
   - Keep popup messages concise (1-2 sentences)
   - If no issues are found, inform the user that the code looks good

7. **If Fresh is NOT installed**, show installation instructions and present findings as a plain text list.

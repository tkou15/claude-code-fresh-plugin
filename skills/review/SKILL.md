---
description: Review code and open findings in the Fresh editor with inline popup annotations. Use when the user wants a code review with results shown directly in Fresh.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash(fresh:*), Bash(which:*), Bash(git diff:*), Bash(git log:*), Bash(cmux:*), Bash(*/scripts/fresh-ensure-session.sh:*), Bash(*/scripts/fresh-open-finding.sh:*)
context: fork
---

# Code Review with Fresh

**CRITICAL**: This is a READ-ONLY review skill. Do NOT edit, modify, or write to any source files. Present all findings as Fresh editor commands or text output only — never modify the source code.

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

3. **Ensure Fresh is running** by calling the helper script.

First, locate the plugin's scripts directory. Use the Glob tool to find `**/fresh-ensure-session.sh` — it will be in a `scripts/` directory inside the plugin (either under `~/.claude/plugins/` or a local dev path like `~/work/`). Save the directory path as `SCRIPT_DIR`.

Then run:
```bash
# Returns: line 1 = SESSION_NAME, line 2 = SURFACE_ID (may be empty)
"$SCRIPT_DIR/fresh-ensure-session.sh" "$(pwd)"
```

Save the output:
- `SESSION_NAME` — the Fresh session name (first line)
- `SURFACE_ID` — the cmux surface for the Fresh pane (second line, may be empty)

4. **Send each finding** using the helper script:

```bash
"$SCRIPT_DIR/fresh-open-finding.sh" SESSION_NAME 'path/to/file.ext:START_LINE-END_LINE@"Issue description"' SURFACE_ID
```

- Keep popup messages concise (1-2 sentences)
- `SURFACE_ID` is optional — omit if empty

5. **Fallback** — if the ensure-session script fails (exit code non-zero), present findings as text:

```
Found N issues:

1. **Issue title** in `src/file.rs:45-52`
   Description of the issue.

2. **Issue title** in `src/other.rs:23`
   Description of the issue.
```

If Fresh is not installed, also show: `Install with: brew install fresh-editor`

6. **If no issues are found**, inform the user that the code looks good.

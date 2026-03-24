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

3. **Check if Fresh is installed**:

```bash
which fresh
```

4. **Present findings**: For each issue found, generate a Fresh command using the `file:line-line@"message"` syntax. Format each finding as:

```
! fresh 'path/to/file.ext:START_LINE-END_LINE@"Brief description of the issue and suggested fix"'
```

Example output:

```
Found 3 issues:

1. **SQL Injection** in `src/db.rs:45-52`
   ! fresh 'src/db.rs:45-52@"SQL injection risk: use prepared statements instead of string concatenation"'

2. **Missing error handling** in `src/api.rs:23`
   ! fresh 'src/api.rs:23@"unwrap() on network call - handle the error case"'

3. **Unused import** in `src/main.rs:3`
   ! fresh 'src/main.rs:3@"Remove unused import"'
```

5. **Important notes**:
   - Do NOT run the `fresh` commands via the Bash tool — Fresh requires a real TTY
   - Always use the `! fresh` prefix so the user can run it in their shell session
   - Wrap the file argument in single quotes to prevent shell expansion of the `@"..."` syntax
   - Keep popup messages concise (1-2 sentences) — they appear as markdown popups in the editor
   - If no issues are found, inform the user that the code looks good

6. **If Fresh is NOT installed**, show installation instructions and present findings as a plain text list instead.

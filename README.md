# Fresh Editor Plugin for Claude Code

A [Claude Code](https://claude.ai/claude-code) plugin that integrates the [Fresh](https://github.com/sinelaw/fresh) terminal text editor with Claude Code.

## Prerequisites

### Fresh (required)

Install Fresh using one of the following methods:

```bash
# Homebrew (macOS/Linux)
brew install fresh-editor

# npm
npm install -g fresh-editor

# Cargo
cargo install fresh-editor
```

See the [Fresh installation guide](https://github.com/sinelaw/fresh#installation) for more options.

### cmux (optional)

When cmux is available (e.g. Claude Code desktop app), the plugin can automatically start Fresh sessions and open files in a split pane. Without cmux, start Fresh manually before using the plugin:

```bash
fresh .
```

## Installation

### Direct install

```
/install-plugin https://github.com/imk1t/claude-code-fresh-plugin
```

### Via Marketplace

```
/plugin marketplace add imk1t/claude-code-fresh-plugin
/plugin install fresh-editor@fresh-editor-marketplace
```

## Skills

### `/fresh-editor:fresh` — Open files in Fresh

```
/fresh-editor:fresh                  # Open current directory
/fresh-editor:fresh src/main.rs      # Open a specific file
/fresh-editor:fresh src/             # Open a directory
```

### `/fresh-editor:review` — Code review with Fresh annotations

Claude analyzes your code and presents findings as Fresh popup annotations. Each issue links directly to the relevant line in the editor.

```
/fresh-editor:review                 # Review recently changed files
/fresh-editor:review src/auth.rs     # Review a specific file
/fresh-editor:review src/            # Review a directory
```

Example output:

```
! fresh 'src/auth.rs:45-52@"SQL injection risk: use prepared statements"'
```

Fresh opens the file with the lines selected and a popup showing the issue description.

## License

MIT

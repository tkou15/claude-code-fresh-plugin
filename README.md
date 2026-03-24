# Fresh Editor Plugin for Claude Code

A [Claude Code](https://claude.ai/claude-code) plugin that lets you open files and directories in the [Fresh](https://github.com/sinelaw/fresh) terminal text editor.

## Prerequisites

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

## Installation

In Claude Code, install this plugin:

```
/install-plugin https://github.com/<owner>/claude-code-fresh-plugin
```

## Usage

Once installed, use the `/fresh` command in Claude Code:

```
/fresh                  # Open current directory
/fresh src/main.rs      # Open a specific file
/fresh src/             # Open a directory
```

## License

MIT

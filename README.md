# c-devbox

🚀 **Portable C development environment inside a Docker container**

c-devbox is a clean and minimal dev container for writing C projects with a fully pre-configured Neovim IDE inside. It solves the problem of cluttering your host system with dev tools and configurations. Just run the container, and you're ready to write C code anywhere.

## Features

- 🐧 Ubuntu 24.04 LTS base image
- ⚙️ Latest Neovim 0.11.0 (AppImage)
- 🛠️ Preinstalled build tools: gcc, clang, clangd, cmake, make
- 🔍 Project navigation: Telescope, nvim-tree
- 💡 LSP: clangd configured out of the box
- 📝 Syntax highlighting & Treesitter
- 🧩 Plugin management with lazy.nvim
- 🐍 Python 3 included (for Neovim plugins)
- 🔄 Auto-rebuild support via `--rebuild` flag
- 🧑‍💻 User-friendly: just run `./run.sh /path/to/your/project`

## Why?

When working on C projects, especially system-level (networking, eBPF, kernel space), you often:

- Need modern tooling (clangd, Neovim, linters, debuggers).
- Don't want to pollute your host environment with tons of dev dependencies.
- Want a portable setup to work across machines or share with your team.

**c-devbox** provides a consistent and isolated environment where you can:

- Write and navigate C code like in a modern IDE.
- Build and compile your projects easily.
- Keep your host system clean.

## Usage

### 1. Clone the repository

```bash
git clone https://github.com/your-username/c-devbox.git
cd c-devbox
```

### 2. Make the script executable

```bash
chmod +x run.sh
```

### 3. Run your project

```bash
./run.sh /absolute/path/to/your/project
```

If you don't pass a project path, it uses the current directory.

### 4. Rebuild the container manually (optional)

```bash
./run.sh --rebuild /path/to/your/project
```

### 5. Help

```bash
./run.sh --help
```

## Neovim Navigation & Shortcuts

### Basic

- `:q` — Quit Neovim
- `:w` — Save file
- `:wq` — Save and quit

### Tree Explorer (nvim-tree)

- `<leader>e` — Toggle file tree (Leader is spacebar)
- Use arrows or `h/j/k/l` to navigate, `Enter` to open file

### Fuzzy Finder (Telescope)

- `<leader>ff` — Find files in project
- `<leader>fg` — Search by text in project (live grep)

### LSP Navigation

- `gd` — Go to definition
- `gD` — Go to declaration
- `gr` — List references
- `gi` — Go to implementation
- `K` — Hover docs for symbol under cursor
- `<C-o>` — Go back to previous location

### Autocompletion

- `<C-Space>` — Trigger completion manually
- `<Tab>` — Next completion item
- `<S-Tab>` — Previous completion item
- `<CR>` (Enter) — Confirm completion

### Treesitter

- Syntax highlighting works out of the box!

## Future ideas

- Auto plugin updates on container start
- Auto setup compile_commands.json for clangd
- Optional eBPF toolchain support
- Auto code formatting on save (clang-format)

## License

MIT

---

Made with ❤️ for low-level hackers and C developers.


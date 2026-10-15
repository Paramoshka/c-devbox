# c-devbox

🚀 **Portable C development environment inside a Docker container**

c-devbox is a clean and minimal dev container for writing C projects with a fully pre-configured Neovim IDE inside. It solves the problem of cluttering your host system with dev tools and configurations. Just run the container, and you're ready to write C code anywhere.

## Features

- 🐧 Ubuntu 24.04 LTS base image
- ⚙️ Neovim 0.11.0 (AppImage)
- 🛠️ Preinstalled build tools: gcc, clang, clangd, cmake, make
- 🔍 Project navigation: Snacks picker and explorer
- 💡 LSP: clangd configured out of the box
- 📝 Syntax highlighting & Treesitter
- 🧩 Plugin management with lazy.nvim and a committed lockfile
- 🧪 Go test runner and debugger panels (Go and Delve required)
- ⎈ Helm templates (Helm and YAML language-server tools required)
- 💾 Session restore, project search/replace and task runner
- 🎨 Tokyo Night Moon with clearer panels and test/debug status
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
git clone https://github.com/Paramoshka/c-devbox.git
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

### File Explorer (Snacks)

- `<leader>e` — Toggle file tree (Leader is spacebar)
- Use arrows or `h/j/k/l` to navigate, `Enter` to open file

### File and Text Search (Snacks)

- `<leader>ff` — Find files in project
- `<leader>fg` — Search by text in project (live grep)

### LSP Navigation

- `gd` — Go to definition
- `gD` — Go to declaration
- `gr` — List references
- `gI` — Go to implementation
- `K` — Hover docs for symbol under cursor
- `<C-o>` — Go back to previous location

### Autocompletion

- `<C-Space>` — Trigger completion manually
- `<Tab>` — Next completion item
- `<S-Tab>` — Previous completion item
- `<CR>` (Enter) — Confirm completion

### Treesitter

- Syntax highlighting works out of the box!

### Tests, debugging and workflow

- `<leader>tt` / `<leader>tf` — nearest Go test / file tests
- `<leader>ts` / `<leader>to` — test tree / output
- `<leader>td` — debug nearest Go test
- `F9` / `F5` — breakpoint / continue; `F10` / `F11` / `F12` — step over / into / out
- `<leader>du` — debugger panels
- `<leader>sp` — search and replace across the project
- `<leader>qs` / `<leader>qS` — restore / select session
- `<leader>or` / `<leader>ot` — run task / task panel
- `Ctrl+/` — bottom terminal; press `Esc` twice to leave terminal input
- `<leader>gg` — Lazygit, if installed in the container

See [`nvim/README.md`](nvim/README.md) for all shortcuts, version constraints and
Helm/Ginkgo limitations. The config matches the one in
[tips](https://github.com/Paramoshka/tips/tree/main/Neovim/config).

## Optional tools and first start

The image remains a C development environment. Go, Helm, Node/npm and Lazygit
are not preinstalled. Install them in the container when you need the associated
features; host binaries are not automatically available inside Docker.
`clang-format` is also needed for C/C++ formatting. Python tools installed through
Mason require `python3-venv`.

On first start, lazy.nvim downloads the locked plugin versions and Treesitter
compiles parsers. Mason installs supported tools when their prerequisites exist.
Wait for installation to finish, then restart Neovim. Session/plugin state is
inside the container and is discarded by the current `docker run --rm` workflow.

To use the new config in an existing image, rebuild it with `./run.sh --rebuild`.

## Future ideas

- Auto plugin updates on container start
- Auto setup compile_commands.json for clangd
- Optional eBPF toolchain support

## License

MIT

---

Made with ❤️ for low-level hackers and C developers.


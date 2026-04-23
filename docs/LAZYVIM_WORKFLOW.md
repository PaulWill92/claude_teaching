# lazyvim Workflow Guide
**For Paul's Ruby Learning Journey**

A practical reference guide for using lazyvim efficiently while learning Ruby. This is a living document—we'll add to it as you discover what works.

---

## Starting a New Project

### 1. Open Project Root in nvim
```bash
cd your-project-directory
nvim .
```

This opens nvim in the directory, giving you access to file tree and fuzzy finding.

### 2. Your First View
```
┌─────────────────────────────────────┐
│ File tree (left)  │  Editor (right) │
│                   │                 │
│ - project_1.rb    │ (empty at start)│
│ - spec/           │                 │
│   - project_1_... │                 │
│ - Gemfile         │                 │
└─────────────────────────────────────┘
```

**Open the file tree**:
- `ctrl + h` or `leader + e` to toggle file tree (depends on your config)
- Navigate with `hjkl`
- Press `enter` to open file

---

## Essential Keybindings (Defaults)

### Navigation Between Files

| Action | Keys | When to Use |
|--------|------|-------------|
| Find file (fuzzy) | `leader + ff` | Know partial filename ("spec" or "project") |
| Find in text | `leader + fg` | Search for content across project |
| Switch recent | `leader + ,` (or `leader + bb`) | Jump to file you just closed |
| Go to file tree | `ctrl + h` | Browse and navigate project structure |
| Jump to definition | `leader + sw` | Go to where method/class is defined |
| Find references | `leader + sr` | See everywhere a symbol is used |

### Window & Buffer Management

| Action | Keys | When to Use |
|--------|------|-------------|
| Vertical split | `ctrl + v` | Side-by-side view (code + tests) |
| Horizontal split | `ctrl + x` | Top-bottom view |
| Move to split left | `ctrl + h` | Switch to left window |
| Move to split right | `ctrl + l` | Switch to right window |
| Move to split up | `ctrl + k` | Switch to above window |
| Move to split down | `ctrl + j` | Switch to below window |
| Close current split | `ctrl + w` then `c` | Remove split |
| Maximize current split | `ctrl + w` then `\|` | Full width for one split |
| Close all but current | `ctrl + w` then `o` | Clean up clutter |

### Code Navigation (Within File)

| Action | Keys | When to Use |
|--------|------|-------------|
| Start of line | `Home` or `0` | Jump to beginning |
| End of line | `End` or `$` | Jump to end |
| Start of file | `gg` | Jump to top |
| End of file | `G` | Jump to bottom |
| Go to line N | `:123` | Jump to specific line (shows in status bar) |
| Forward word | `w` | Skip word-by-word (fast movement) |
| Backward word | `b` | Reverse word movement |
| Search in file | `/pattern` | Find text, `n` next, `N` previous |
| Jump to matching bracket | `%` | Jump between `{` and `}` or `(` and `)` |
| Mark position | `m + a-z` | Mark a spot (e.g., `ma` marks position 'a') |
| Jump to mark | `` `a `` (backtick-a) | Return to marked position |

### Folding Code

**Why fold**: Hide sections of code to focus on what matters.

| Action | Keys | When to Use |
|--------|------|-------------|
| Fold at cursor | `zc` | Collapse function/block |
| Unfold at cursor | `zo` | Expand function/block |
| Fold all | `zM` | Collapse entire file (see structure) |
| Unfold all | `zR` | Expand everything |
| Fold level N | `z1`, `z2`, etc. | Show only top N levels of nesting |
| Toggle fold | `za` | Flip current fold state |

**Example workflow**:
```
def filter_data(data)          # Start here
  long_summaries = ...         # Line 5
  short_summaries = ...        # Line 10
  {long: long, short: short}   # Line 12
end                            # Line 13

def save_to_file(data, path)   # Line 15
  # ... 20 lines of logic
end

# Press 'zM' to see only function signatures
# Press 'zo' on one function to expand it
# Press 'zR' to expand all
```

### Editing Efficiently (No Mouse)

| Action | Keys | When to Use |
|--------|------|-------------|
| Select line | `V` (capital V) | Select entire line for cut/copy |
| Select to end of line | `shift + End` or `v$` | Select from cursor to line end |
| Select word | `viw` | Visual inner word (then `d` to delete) |
| Delete word | `dw` | Delete word under cursor |
| Delete line | `dd` | Delete entire line |
| Copy line | `yy` | Copy entire line |
| Paste | `p` | Paste after cursor |
| Paste before | `P` | Paste before cursor |
| Undo | `u` | Undo last change |
| Redo | `ctrl + r` | Redo after undo |
| Replace char | `r + char` | Replace single character (e.g., `r"` replaces with `"`) |

---

## Practical Workflows

### Workflow 1: Write Code + Tests Side-by-Side

**Setup**:
1. `nvim .` to start in project root
2. `leader + ff` → type "project_1" → open `project_1.rb` (right side)
3. `ctrl + v` to split vertically
4. `ctrl + h` to move to left split
5. `leader + ff` → type "spec" → open `spec/project_1_spec.rb` (left side)

**Now you have**:
```
┌─────────────────────────────────┐
│ Tests (left)  │  Code (right)   │
│               │                 │
│ describe(...) │ def filter(...) │
│ it '...' do   │   ...           │
│   expect      │ end             │
└─────────────────────────────────┘
```

**Navigate between splits**: `ctrl + h` and `ctrl + l`

### Workflow 2: Jump to Method Definition While Reading Code

**Situation**: You see `.select` and want to understand how it works.

1. Put cursor on `select`
2. Press `leader + sw` (go to definition)
3. nvim jumps to documentation or definition
4. Press `ctrl + o` (back to previous position)

### Workflow 3: Find All References to a Method

**Situation**: You created a method `filter_long`. Want to see everywhere it's called?

1. Put cursor on `filter_long`
2. Press `leader + sr` (search references)
3. See all locations where it's used
4. Navigate with arrow keys, press `enter` to jump

### Workflow 4: Compare Old Code with New Code

**Situation**: Refactoring Project 1 into Project 2. Want to compare.

1. `leader + ff` → open Project 1 script (right)
2. `ctrl + v` to split
3. `leader + ff` in left split → open Project 2 script
4. Scroll both simultaneously (cursor moves in active split)
5. Use `ctrl + h` / `ctrl + l` to switch active split

### Workflow 5: Run Tests Without Leaving nvim

**Situation**: Wrote code, want to run RSpec immediately.

1. In any buffer, type `:!bundle exec rspec spec/project_1_spec.rb`
2. Results show in terminal (press `q` to close)
3. Stay in editor, code is still visible

**Or add keybinding** (edit `~/.config/nvim/lua/config/keymaps.lua`):
```lua
vim.keymap.set('n', '<leader>t', ':!bundle exec rspec<CR>', { noremap = true })
```
Then press `leader + t` to run tests anytime.

### Workflow 6: Mark Spots While Exploring Code

**Situation**: Large file. Want to jump between important sections.

1. Jump to first function: `gg` (top)
2. Press `ma` (mark position 'a')
3. Jump down to third function: `jjjj...` or `G`
4. Press `mb` (mark position 'b')
5. Later, press `` `a `` to jump back to mark 'a'
6. Press `` `b `` to jump back to mark 'b'

**Marks a-z**: You can create 26 marks in one file.

---

## Common Keybinding Patterns

### The Vim Philosophy
- **hjkl**: Move (left, down, up, right)
- **w/b**: Jump word forward/back
- **$/0**: Jump to end/start of line
- **gg/G**: Jump to file start/end
- **Prefix with number**: `5w` = forward 5 words, `3j` = down 3 lines, `2d` = delete 2 lines (next operation)

### Combination Examples
- `dw` = delete word
- `5dd` = delete 5 lines
- `c$` = change from cursor to end of line
- `y5w` = copy next 5 words
- `v3j` = select 3 lines down

---

## Troubleshooting

| Problem | Solution |
|---------|----------|
| "I can't see the file tree" | Press `ctrl + h` (or check your leader key with `:nmap`) |
| "I opened too many splits" | `ctrl + w` then `c` to close current, or `o` to keep only current |
| "Code is slow/laggy" | `:LspInfo` to check if LSP is running; might need to restart nvim |
| "I can't find a file" | `leader + ff` and type more of the filename |
| "I messed up my edits" | `u` to undo, `ctrl + r` to redo |
| "My keybinding didn't work" | It might conflict; check with `:nmap` to see all normal mode bindings |

---

## Next: Customization (As We Learn)

As you work, if you find yourself:
- **Reaching for the mouse** → We'll add a keybinding
- **Repeating a command** → We'll create a shortcut
- **Wishing something was faster** → We'll optimize it

Examples to add later:
- `:W` command to save (if you typo `:w`)
- Custom keybinding to run tests
- Custom keybinding to toggle between test/code files
- Snippets for common Ruby patterns

---

## Quick Reference Card

**Print this or keep it open**:

```
NAVIGATION:         SPLITS:             EDITING:
gg = top            ctrl+v = vert       dd = delete line
G = bottom          ctrl+x = horiz      yy = copy line
0/$ = line edge     ctrl+hjkl = move    p = paste
w/b = word jump     ctrl+w c = close    u = undo
/ = search          ctrl+w o = only     . = repeat

FILE FINDING:       FOLDING:            MARKS:
leader+ff = fuzzy   zc = close          ma = mark a
leader+fg = grep    zo = open           `a = jump to a
leader+sw = define  zM = fold all       
leader+sr = refs    zR = unfold all
```

---

## Accessing Learning Repo from Any Project

### From Terminal (Anywhere)

While working on ANY project, jump to a reference without leaving the terminal:

```bash
# From your work project, access learning materials
ruby-learn              # Browse all references with fzf
ruby-study              # Quick access to study plan
ruby-conditions         # Quick access to conditionals reference
ruby-functions          # Quick access to functions reference
ruby-learn-ls           # See all available commands
```

### From Telescope (Anywhere in nvim)

If already in nvim on a different project, use Telescope to search your learning repo:

```
leader + ff ~/Documents/GitHub/learning/ruby/claude_teaching/reference/
```

Then type filename or keyword. Telescope searches and opens files from your learning repo.

### Pro Tip: Add Quick Reference Keybinding

Add this to your lazyvim config (`~/.config/nvim/lua/config/keymaps.lua`):

```lua
-- Quick access to Ruby learning repo references
vim.keymap.set('n', '<leader>rl', function()
  require('telescope.builtin').find_files({
    cwd = os.getenv('HOME') .. '/Documents/GitHub/learning/ruby/claude_teaching/reference/'
  })
end, { noremap = true, desc = 'Ruby Learning Refs' })
```

Then from ANY nvim session:
- Press `leader + rl` to open Telescope in your learning references
- Type "functions" → finds FUNCTIONS_AND_METHODS.md
- Type "test" → finds TESTING_WITH_RSPEC.md
- Type "conditionals" → finds CONDITIONALS_AND_LOGIC.md

Perfect for quick reference while coding on any project! 🚀

---

**Last updated**: 2026-04-22  
**Will evolve**: As you discover what works for your workflow

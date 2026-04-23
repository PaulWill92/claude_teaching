# Neovim and LazyVim Reference

Search keywords: nvim, keybindings, shortcuts, navigation, split, terminal, lsp, telescope, snacks, fuzzy, find, code, editing

---

## Navigation

### Basic Movement
```
h, j, k, l       # Left, down, up, right
w                # Next word
b                # Previous word
0                # Start of line
$                # End of line
gg               # Start of file
G                # End of file
:123             # Go to line 123
```

### Find in File
```
/pattern         # Search forward
?pattern         # Search backward
n                # Next match
N                # Previous match
```

---

## File Finding and Searching (Snacks)

Search keywords: find files, search text, fuzzy, picker, snacks

### Ruby Learning Shortcuts
```
<leader>frf      # Find Ruby Reference files
<leader>frt      # Search Ruby Reference text
<leader>frl      # Find Ruby Learning materials
```

### Built-in Snacks Pickers
```
<leader>ff       # Find Files
<leader>fg       # Find in Text (grep)
<leader>/        # Search in current file
<leader>sb       # Search Buffers
<leader>sc       # Search by Command
```

### Snacks Picker Keys
```
<C-.>            # Toggle hidden files
<C-i>            # Toggle ignored files
<C-x>            # Split horizontal
<C-v>            # Split vertical
<C-t>            # Open in tab
```

---

## Window and Split Management

Search keywords: split, window, resize, pane, layout

### Creating Splits
```
<C-w>s           # Split horizontally
<C-w>v           # Split vertically
<C-w>n           # New window (empty buffer)
:terminal        # Open terminal in current window
```

### Navigate Between Splits
```
<C-h>            # Move to left split
<C-j>            # Move to down split
<C-k>            # Move to up split
<C-l>            # Move to right split
```

### Resize Splits
```
<C-w>+           # Increase height
<C-w>-           # Decrease height
<C-w>>           # Increase width
<C-w><           # Decrease width
<C-w>=           # Equal size
```

### Close Windows
```
<C-w>c           # Close current window
<C-w>o           # Close all other windows
:close           # Close current split
```

---

## Terminal Mode

Search keywords: terminal, shell, command, exit, inside nvim

### Open Terminal
```
:terminal        # Open terminal in current window
<C-w>s           # Split, then :terminal
<C-w>v           # Vertical split, then :terminal
```

### Terminal Keybindings
```
<Esc>            # Enter normal mode (from insert mode in terminal)
<C-\><C-n>       # Enter normal mode (faster)
<Esc><Esc>       # Close terminal window
i                # Back to insert/terminal mode
```

### Running Commands
```
:!ruby script.rb        # Run shell command
:!bundle exec rspec     # Run tests
:!rubocop              # Run linter
```

---

## Editing and Code

Search keywords: edit, code, delete, copy, paste, undo, indent

### Basic Editing
```
i                # Insert before cursor
a                # Insert after cursor
I                # Insert at line start
A                # Insert at line end
o                # New line below
O                # New line above
```

### Delete and Copy
```
d                # Delete (combine with motion)
dd               # Delete entire line
yy               # Copy entire line
p                # Paste after
P                # Paste before
x                # Delete character
u                # Undo
<C-r>            # Redo
```

### Common Combinations
```
dw               # Delete word
d$               # Delete to end of line
ciw              # Change word (delete and insert)
yy p             # Duplicate line
dd               # Delete line
5dd              # Delete 5 lines
```

### Indentation
```
>>               # Indent line
<<               # Outdent line
>G               # Indent to end of file
=                # Auto-indent (combine with motion)
```

---

## LSP and Code Intelligence

Search keywords: lsp, autocomplete, definition, hover, diagnostics, error, refactor

### Code Features
```
K                # Hover: Show type/doc info
gd               # Go to Definition
gr               # Find References
gi               # Go to Implementation
<leader>ca       # Code Actions (refactor, fix)
<leader>cr       # Rename symbol
<leader>cd       # Show diagnostics
```

### Diagnostics and Errors
```
<leader>cd       # Show current diagnostics
]d               # Next diagnostic
[d               # Previous diagnostic
<leader>q        # Quickfix list (all errors)
```

### Autocomplete
```
<C-n>            # Next suggestion
<C-p>            # Previous suggestion
<C-y>            # Accept suggestion
<C-e>            # Cancel suggestion
```

---

## Buffers and Tabs

Search keywords: buffer, tab, file, switching, multiple files

### Buffer Management
```
<leader>bb       # Switch buffer
<leader>bn       # Next buffer
<leader>bp       # Previous buffer
<leader>bd       # Delete buffer
:buffers         # List all buffers
:b<name>         # Switch to buffer by name
```

### Tabs
```
gt               # Next tab
gT               # Previous tab
:tabnew          # New tab
:tabc            # Close tab
:tabo            # Close other tabs
```

---

## Save and Quit

Search keywords: save, quit, exit, write, close file

```
:w               # Save file
:wa              # Save all files
:q               # Quit (if saved)
:q!              # Quit without saving
:wq              # Save and quit
:x               # Save and quit (shorter)
ZZ               # Save and quit (vi style)
ZQ               # Quit without saving (vi style)
```

---

## Search and Replace

Search keywords: find and replace, substitute, regex, search

### Search
```
/pattern         # Search forward
?pattern         # Search backward
n                # Next match
N                # Previous match
*                # Search word under cursor
#                # Search word backward
```

### Replace
```
:s/old/new/      # Replace first in line
:s/old/new/g     # Replace all in line
:%s/old/new/g    # Replace all in file
:%s/old/new/gc   # Replace with confirmation
:123,456s/o/n/g  # Replace in range
```

---

## Comments

Search keywords: comment, uncomment, toggle

```
<leader>/        # Toggle line comment
<leader>bx       # Toggle block comment (with selection)
gc               # Toggle comment (with operator)
gcc              # Comment/uncomment line
```

---

## File Explorer and Sidebar

Search keywords: explorer, file tree, sidebar, navigate files

```
<leader>e        # Toggle file explorer (Neo-tree)
a                # Add new file (in explorer)
d                # Delete file
r                # Rename file
y                # Copy file
x                # Cut file
p                # Paste file
```

---

## Ruby Development Workflow

Search keywords: ruby, testing, rspec, bundle, rubocop

### Running Tests
```
:!bundle exec rspec                    # Run all tests
:!bundle exec rspec spec/file_spec.rb  # Run specific file
:!bundle exec rspec spec/file_spec.rb:12  # Run specific line
```

### Linting
```
:!bundle exec rubocop                  # Check style
:!bundle exec rubocop -a               # Auto-fix style
:!bundle exec rubocop file.rb          # Check single file
```

### Running Scripts
```
:!bundle exec ruby script.rb           # Run Ruby script
:!irb                                  # Open interactive Ruby
```

---

## Useful Workflow Tips

### Code Along Workflow (Tutorials)
```
1. Open tutorial in right split:    <C-w>v
2. Open terminal/IRB in left:       <C-w>s, :terminal, irb
3. Read code in right split
4. Copy code:                        yy (in normal mode)
5. Switch to left split:             <C-h>
6. Paste in IRB:                     i, <C-r>+ or type manually
7. Test and iterate
```

### Split Screen Development
```
<C-w>v           # Vertical split (code on left, tests on right)
<C-h>            # Jump to tests
:!bundle exec rspec   # Run tests
<C-l>            # Jump back to code
```

### Quick Search Ruby Learning
```
<leader>frf      # Find reference files
<leader>frt      # Search reference text
<C-l>            # Move to right window (reference open)
K                # Hover for more info if available
<C-h>            # Move back to code
```

---

## Common Patterns

### Search and Open File
```
<leader>ff           # Open fuzzy finder
type: reference/     # Filter to reference folder
<C-i>                # Toggle ignored files to see all
select file          # Press enter to open
```

### Terminal Workflow
```
<C-w>s               # Split horizontally
:terminal            # Open terminal
cd ~/Documents/... && irb    # Start Ruby interactive
<C-\><C-n>           # Exit terminal to normal mode
<C-w>h               # Go to code window
<C-w>j               # Go to terminal window
i                    # Back to terminal
```

### Search in Ruby References
```
<leader>frt          # Open grep search
type: loops          # Search keyword
select match         # Press enter
:wincmd w            # Switch to previous window if needed
```

---

## Advanced: Custom Keybindings

Your custom ruby search shortcuts (from ~/.config/nvim/lua/config/keymaps.lua):

```lua
<leader>frf      # Ruby reference files
<leader>frt      # Ruby reference text
<leader>frl      # Ruby learning materials
```

To add more: Edit `~/.config/nvim/lua/config/keymaps.lua`

---

## Command Reference

```
:help <topic>        # Built-in help
:e file.rb           # Open file
:w                   # Save
:q                   # Quit
:%s/old/new/g        # Find and replace all
:set number          # Show line numbers
:set nonumber        # Hide line numbers
:map                 # Show all keybindings
:nmap                # Show normal mode bindings
```

---

## Plugin Management

```
:Lazy               # Lazy plugin manager
:Lazy sync          # Sync all plugins
:Lazy update        # Update all plugins
```

---

See also: [FILE_IO_AND_WEB.md](./FILE_IO_AND_WEB.md), [LOOPS_AND_ITERATION.md](./LOOPS_AND_ITERATION.md)

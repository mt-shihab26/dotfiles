# intermediate

## 1. Window, Buffer, and Tab Management

### Splits (Windows)

- `:split` or `:sp` / `:vsplit` or `:vsp` – Horizontal / Vertical split
- `Ctrl-w` + `h/j/k/l` – Move between splits
- `Ctrl-w` + `q` – Close current split
- `Ctrl-w` + `=` – Equalize window sizes

### Buffers

- `:e filename` – Open file in buffer
- `:ls` – List buffers
- `:bnext`, `:bprev` – Next/previous buffer
- `:bd` – Delete (close) buffer

### Tabs

- `:tabnew` – Open new tab
- `:tabnext`, `:tabprev`, `:tabclose` – Navigate/manage tabs
- `gt`, `gT` – Tab next / tab previous

---

## 2. Efficient Editing Techniques

### Text Objects & Motions

- `ci"` – Change inside quotes
- `di]`, `da(` – Delete inside brackets/around parentheses
- `yap`, `dip` – Yank/delete paragraph
- Combine with `v` for visual mode

### Macros

- `qa` – Record macro to register `a`
- Perform actions
- `q` – Stop recording
- `@a` – Play macro
- `@@` – Repeat last macro

---

## 🔍 3. Search and Replace

```vim
:%s/old/new/gc
```

- `g` – global
- `c` – confirm each change
- `n` = next, `y` = yes, `a` = all, `q` = quit

---

## 📌 4. Marks and Jumps

- `ma` – Set mark `a`
- `'a` – Jump to line of mark
- `` `a `` – Jump to exact cursor position

---

## 📋 5. Registers

- `"0` – Last yank
- `"*` / `"+` – System clipboard (if supported)
- `"a`, `"b`, ... – Named registers
- `"ap` – Paste from register a

Check all: `:registers`

---

## 🧠 6. Command-Line Mode Shortcuts

- `q:` – Open command history
- `q/` – Open search history
- `:history` – Show command history
- Use `<Up>` / `<Down>` to cycle through commands

---

## 🔲 7. Visual Block Mode (Column Editing)

- `Ctrl-v` – Start block mode
- Use `hjkl` to select
- Press `I` (insert) or `d` (delete)
- Press `ESC` twice to apply

---

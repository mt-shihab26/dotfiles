# basics

## 1. Opening Neovim

```bash
nvim filename.txt
nvim .
```

---

## 2. Modes in Neovim

| Mode         | How to Enter       | Description               |
| ------------ | ------------------ | ------------------------- |
| Normal       | `ESC`              | Navigate, delete, copy    |
| Insert       | `i`, `a`, `o`      | Type like in any editor   |
| Visual       | `v`, `V`, `Ctrl+v` | Select text               |
| Command-line | `:`                | Run commands (`:w`, `:q`) |

---

## 3. Basic Commands

- `i` – Insert before cursor
- `a` – Insert after cursor
- `o` – Open new line below
- `ESC` – Exit insert/visual mode

---

## 4. File Commands (in command mode `:`)

- `:w` – Save file
- `:q` – Quit
- `:wq` – Save and quit
- `:q!` – Quit without saving
- `:e filename` – Open another file

---

## 5. Moving Around

- `h` – Left
- `l` – Right
- `j` – Down
- `k` – Up
- (Arrow keys also work)

---

## 6. Editing Text

- `x` – Delete character
- `dd` – Delete line
- `yy` – Copy line
- `p` – Paste after cursor
- `u` – Undo
- `Ctrl+r` – Redo

---

## 7. Searching

- `/word` – Search forward
- `?word` – Search backward
- `n` – Next match
- `N` – Previous match

---

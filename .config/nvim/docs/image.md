# Image viewer

Opening an image file shows it in the buffer through snacks.nvim (kitty graphics protocol).
The image is centered in the window inside a border and scaled up or down to fill it.
`lua/lib/image.lua` adds the keymaps below on top of snacks.

## Keymaps

These work in normal mode in an image buffer.

| Key                        | Action                                                     |
| -------------------------- | ---------------------------------------------------------- |
| `+` (shift `=`)            | Zoom in                                                    |
| `_` (shift `-`)            | Zoom out                                                   |
| Scroll wheel up / down     | Zoom in / out the image under the mouse                    |
| `h` / `l`                  | Move a zoomed image left / right by a tenth of the window  |
| `k` / `j`                  | Move a zoomed image up / down by a tenth of the window     |
| Left click and drag        | Move a zoomed image with the mouse                         |
| `r`                        | Reset the zoom and position                                |

`hjkl` take a count, so `3l` moves three steps right.

## Notes

- The scroll wheel zooms whichever image is under the mouse, even when its window isn't
  focused. Over anything else it scrolls as usual. `+`, `_`, `hjkl` and dragging only work
  in the focused image window.
- Clicks and drags that don't start on the image (like resizing a window) work as usual.
- While dragging, the mouse pointer changes to a grabbing hand (kitty, through tmux passthrough).
- Moving stops at the image's edges, and zooming keeps the same part of the image in the
  middle of the window.
- Zooming in stops once the image is 297 cells wide or tall, the most snacks can encode.
  In a full-size window that is around 2.5x.
- Zoom and position are kept per image and reset when the image is reopened.

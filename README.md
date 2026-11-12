# My First Game

A small 2D leaf-collecting game made with [Godot 4](https://godotengine.org/). You play as a capybara in a forest: pick up the leaves scattered around and carry them to the basket, one at a time.

## How to play

| Action | Keys |
| --- | --- |
| Move | Arrow keys |

- Walk over a leaf to pick it up. The capybara can carry **one leaf at a time**.
- Bring the leaf to the basket to drop it in. The counter in the top-right corner goes up by one.
- There are 6 leaves in the forest.

## Running the game

### In the Godot editor

1. Install **Godot 4.7** or later. The project uses the GL Compatibility renderer.
2. Open Godot, click **Import**, and select this folder's `project.godot`.
3. Press **F5** (or the ▶ Play button) to run. The main scene is `main.tscn`.

### In a browser (web export)

The `export/` folder holds a web build (`index.html`, `index.wasm`, `index.pck`, …). Browsers won't load it from `file://`, so serve it with a local web server:

```sh
cd export
python3 -m http.server 8000
```

Then open <http://localhost:8000> in your browser.

The build has thread support turned off, so it doesn't need special cross-origin isolation headers. It can be hosted on any static host (for example itch.io, GitHub Pages or Netlify).

## Project structure

```
.
├── project.godot      # Godot project settings
├── main.tscn          # Main scene: forest background, player, basket, leaves, score label
├── leaf.tscn          # Reusable leaf scene (Area2D in the "leaf" group)
├── player.gd          # Player movement plus leaf pickup and drop-off logic
├── capybara.png       # Player sprite
├── leave.png          # Leaf sprite
├── basket.png         # Basket sprite
├── forest.jpg         # Background
├── icon.svg           # Project icon
└── export/            # Web (HTML5) export and export preset
```

## How it works

- **Player** (`CharacterBody2D`): reads the arrow keys through `Input.get_vector`, moves at 400 px/s and calls `move_and_slide()`.
- **PickupArea** (`Area2D` on the player): its `area_entered` signal calls `_on_pickup_area_area_entered` in `player.gd`.
  - Entering an area in the `leaf` group while empty-handed removes that leaf and shows the `HeldLeaf` sprite.
  - Entering the `basket` group while holding a leaf hides `HeldLeaf`, increases `leaf_count` and updates the `Leaves: N` label.
- **Groups**: `leaf` and `basket` are global groups defined in `project.godot`, which is how the script tells the two kinds of area apart.

### Adding more leaves

Drag `leaf.tscn` into `main.tscn` from the FileSystem dock and position it. Each instance is in the `leaf` group already, so it works without further setup.

## Ideas for next steps

- Add a win screen when all leaves are collected.
- Keep the player inside the screen (clamp the position or add wall colliders).
- Add sound effects for pickup and drop-off.
- Spawn leaves at random positions, or add a timer for a score-attack mode.

## Exporting

1. In Godot, go to **Project → Export…**.
2. Select the **Web** preset, or add a preset for Windows, macOS or Linux. Download the export templates if Godot asks for them.
3. Click **Export Project** and choose an output folder.

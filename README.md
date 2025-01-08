![Racket Logo]([https://upload.wikimedia.org/wikipedia/en/c/c3/Racket_%28programming_language%29_logo.png](https://racket-lang.org/img/racket-logo.svg))

A functional Racket implementation of the classic [2048 game](https://en.wikipedia.org/wiki/2048_(video_game)), created as a personal side project to explore functional programming concepts in Racket.

## Table of Contents
1. [Overview](#overview)  
2. [Features](#features)  
3. [Prerequisites](#prerequisites)  
4. [Installation & Running](#installation--running)  
5. [How to Play](#how-to-play)  
6. [License](#license)  
7. [Author](#author)  

## Overview

This project demonstrates how to use purely functional techniques (no in-place mutation) to implement:
- A 4x4 board represented by lists of lists
- Tile merging when two values are the same
- Random tile generation (2 or 4)
- Win condition (reaching 2048)
- Lose condition (no more valid moves)

The entire game loop is driven by user inputs in the Racket REPL or DrRacket environment.

## Features

- **Functional Board Updates** – Uses immutable data structures; each move results in a new board.  
- **Pure Functions** – Key operations (e.g., merging tiles, transposing the board, random tile placement) are all handled by composable functions.  
- **CLI/REPL Interaction** – No fancy GUI; just type the direction of movement in the console.  
- **Simple Logic** – Win checking (for 2048) and lose checking (no empty spaces or moves left).

## Prerequisites

- [Racket](https://racket-lang.org/) (v7.0 or newer recommended)  
- A working internet connection if you’d like to clone the repo directly from GitHub

## Installation & Running

1. **Clone the Repository**  
   ```bash
   git clone https://github.com/weaver20/2048Racket.git
   cd 2048Racket
   ```
2. **Open in DrRacket (Recommended).**
   - Launch [Racket](https://racket-lang.org/).
   - Open the file `2048.rkt` (or whichever `.rkt` file contains your main code).
   - Click **Run** to load the definitions.
   - In the interactive REPL (below), type:
     ```bash
     (2048Game)
     ```
   - Follow the on-screen prompts to play.
**OR**
3. **Run from Terminal/Command Line:**
   ```bash
   racket 2048.rkt
   ```
   - Once the file is loaded, type:
     ```bash
     (2048Game)
     ```
   - Follow the on-screen prompts to play.

## How to Play

1. **Game Start**  
   - You’ll see a 4x4 board with some `0`s (empty spaces) and one or two tiles (2 or 4).

2. **Controls**  
   - You’ll be asked to enter a direction for each move:
     - `U` for Up
     - `D` for Down
     - `L` for Left
     - `R` for Right
   - Press **Enter** after typing a direction.

3. **Merging Tiles**  
   - When two tiles with the same value collide in the chosen direction, they merge into one tile whose value is the sum of both.

4. **Winning & Losing**  
   - **Win:** If a tile reaches `2048`, the game declares **Win**.  
   - **Lose:** If the board has no zeroes left and no valid moves remain, the game declares **Lose**.

5. **Continuing**  
   - You can keep playing even after creating the `2048` tile if you want to chase higher values; just continue entering moves.

## License

This project is licensed under the [MIT License](LICENSE).  
Feel free to fork, modify, and distribute this code as you like, but please maintain the license and attributions.

## Author

- **Noam Chen** | [Email](mailto:noamchn75@gmail.com) | [GitHub](https://github.com/weaver20)

*Thanks for checking out this project! If you have any questions, feel free to open an issue or contact me directly.*


# odin-mastermind

A Ruby implementation of the classic [Mastermind game](https://en.wikipedia.org/wiki/Mastermind_(board_game%29), created as part of [The Odin Project](https://www.theodinproject.com/about).

## Game Overview

Mastermind is a code-breaking game where one player (the codemaker) sets a code and another player (the codebreaker) tries to guess it within a limited number of attempts.

## Features

- **Configurable Gameplay:** Adjust the number of attempts and available colors by modifying `ATTEMPTS` and `COLORS` constants.
- **Colorful Terminal Output:** Enhances visual experience with terminal colors.
- **Two Modes:** Play as either the codemaker or the codebreaker.
- **Feedback System:** Provides hints to improve your guesses.

## Installation

1. Ensure Ruby is installed on your system.
2. Clone the repository:
   ```bash
   git clone https://github.com/your-username/mastermind-game.git
   ```
3. Navigate to the project directory:
  ```bash
  cd odin-mastermind
  ```
4. Run the game:
   ```bash
   ruby mastermind.rb
   ```

## How to Play

1. Start the Game: Run the command above and choose to be the codemaker or the codebreaker.
   - As the Codemaker: Choose a pattern of four colors. The computer will attempt to guess it.
   - As the Codebreaker: The computer sets a pattern. Guess it using main letters or whole color names (e.g., R G B Y or Red Green Blue Yellow).
2. Feedback:
   - Black (B): Correct color in the correct position.
   - White (W): Correct color in the wrong position.
3. Game End: The game ends when you guess the pattern or run out of attempts. Choose to play again if desired.

## Default Colors

- White
- Black
- Red
- Green
- Blue
- Yellow
- Magenta
- Cyan

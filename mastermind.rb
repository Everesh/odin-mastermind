class Mastermind
  @code = Array.new(4)
  @history = [] # Im thinking 3d array of [x][2][4], where x is the number of guesses
  COLORS = %w[white black red green blue yellow orange purple].freeze # 8 colors total
  ATTEMPTS = 8

  def initialize
    puts ' ███▄ ▄███▓ ▄▄▄        ██████ ▄▄▄█████▓▓█████  ██▀███   ███▄ ▄███▓ ██▓ ███▄    █ ▓█████▄ '
    puts '▓██▒▀█▀ ██▒▒████▄    ▒██    ▒ ▓  ██▒ ▓▒▓█   ▀ ▓██ ▒ ██▒▓██▒▀█▀ ██▒▓██▒ ██ ▀█   █ ▒██▀ ██▌'
    puts '▓██    ▓██░▒██  ▀█▄  ░ ▓██▄   ▒ ▓██░ ▒░▒███   ▓██ ░▄█ ▒▓██    ▓██░▒██▒▓██  ▀█ ██▒░██   █▌'
    puts '▒██    ▒██ ░██▄▄▄▄██   ▒   ██▒░ ▓██▓ ░ ▒▓█  ▄ ▒██▀▀█▄  ▒██    ▒██ ░██░▓██▒  ▐▌██▒░▓█▄   ▌'
    puts '▒██▒   ░██▒ ▓█   ▓██▒▒██████▒▒  ▒██▒ ░ ░▒████▒░██▓ ▒██▒▒██▒   ░██▒░██░▒██░   ▓██░░▒████▓ '
    puts '░ ▒░   ░  ░ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░  ▒ ░░   ░░ ▒░ ░░ ▒▓ ░▒▓░░ ▒░   ░  ░░▓  ░ ▒░   ▒ ▒  ▒▒▓  ▒ '
    new_game
  end

  private

  attr_accessor :code, :history

  def new_game
    puts 'Computer mastermind? [Y/n]'
    if gets.chr.downcase == 'n'
      computer_mastermind
    else
      player_mastermind
    end
  end

  def new_game?
    puts 'Care for a rematch? [Y/n]'
    if gets.chr.downcase == 'n'
      false
    else
      true
    end
  end

  def computer_mastermind
    code.map! { COLORS[rand(COLORS.lenght)] }
    ATTEMPTS.times { break if guessed? }
    print_state
    if matching?
      puts 'You did it, you won! The computer got mastered or something'
    else
      puts 'Shucks, better luck next time'
    end
    new_game if new_game?
  end

  def guessed?
    print_state
    take_guess
    feedback
    true if matching?
    false
  end

  def take_guess
    # TO DO
  end

  def feedback
    # TO DO
  end

  def matching?
    # TO DO
  end

  def player_mastermind
    # TO DO
    new_game if new_game?
  end

  def print_state
    # TO DO
  end
end

Mastermind.new
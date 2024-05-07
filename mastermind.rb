class Mastermind
  @code = Array.new(4)
  @history = [] # Im thinking 3d array of [x][2][4], where x is the number of guesses

  def initialize
    puts ' ███▄ ▄███▓ ▄▄▄        ██████ ▄▄▄█████▓▓█████  ██▀███   ███▄ ▄███▓ ██▓ ███▄    █ ▓█████▄ '
    puts '▓██▒▀█▀ ██▒▒████▄    ▒██    ▒ ▓  ██▒ ▓▒▓█   ▀ ▓██ ▒ ██▒▓██▒▀█▀ ██▒▓██▒ ██ ▀█   █ ▒██▀ ██▌'
    puts '▓██    ▓██░▒██  ▀█▄  ░ ▓██▄   ▒ ▓██░ ▒░▒███   ▓██ ░▄█ ▒▓██    ▓██░▒██▒▓██  ▀█ ██▒░██   █▌'
    puts '▒██    ▒██ ░██▄▄▄▄██   ▒   ██▒░ ▓██▓ ░ ▒▓█  ▄ ▒██▀▀█▄  ▒██    ▒██ ░██░▓██▒  ▐▌██▒░▓█▄   ▌'
    puts '▒██▒   ░██▒ ▓█   ▓██▒▒██████▒▒  ▒██▒ ░ ░▒████▒░██▓ ▒██▒▒██▒   ░██▒░██░▒██░   ▓██░░▒████▓ '
    puts '░ ▒░   ░  ░ ▒▒   ▓▒█░▒ ▒▓▒ ▒ ░  ▒ ░░   ░░ ▒░ ░░ ▒▓ ░▒▓░░ ▒░   ░  ░░▓  ░ ▒░   ▒ ▒  ▒▒▓  ▒ '
    computer_mastermind? ? init_computer_mastermind : init_player_mastermind
  end

  private

  def computer_mastermind?
    puts 'Computer mastermind? [Y/n]'
    return true unless gets.chr.downcase == 'n'

    false
  end

  def init_computer_mastermind
    # TO DO
  end

  def init_player_mastermind
    # TO DO
  end
end

Mastermind.new

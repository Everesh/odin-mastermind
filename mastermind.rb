class Mastermind
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
    @code = Array.new(4)
    @history = Array.new(ATTEMPTS) { Array.new(2) { Array.new(4, ' ') } } # [Attempt no.][0-guess / 1-feedback][values]
    puts 'Computer mastermind? [Y/n]'
    if gets.chr.downcase == 'n'
      player_mastermind
    else
      computer_mastermind
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
    code.map! { COLORS[rand(COLORS.size)] }
    ATTEMPTS.times { break if guessed? }
    print_state_guesser
    if matching?
      puts 'You did it, you won! The computer got mastered or something'
    else
      puts 'Shucks, better luck next time'
    end
    new_game if new_game?
  end

  def guessed?
    print_state_guesser
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

  def print_state_guesser
    puts "Available colors: #{COLORS.map { |color| color }.join(', ')}"
    puts "Attempts left: #{history.reduce(0) { |attempt| attempt[0][0] == ' ' ? 1 : 0 }}"
    puts '+---+---+---+---+'
    puts '| ? | ? | ? | ? |'
    puts '+---+---+---+---+-+---+---+---+---+'
    history.each do |attempt|
      print "| #{attempt[0][0]} | #{attempt[0][1]} | #{attempt[0][2]} | #{attempt[0][3]} |"
      puts " | #{attempt[1][0]} | #{attempt[1][1]} | #{attempt[1][2]} | #{attempt[1][3]} |"
      puts '+---+---+---+---+-+---+---+---+---+'
    end
  end

  def player_mastermind
    # TO DO
    new_game if new_game?
  end

end

Mastermind.new
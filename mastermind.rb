class Mastermind
  COLORS = ["\e[47m\e[30m\e[4mW\e[0m\e[47mhite\e[0m", "\e[40m\e[37m\e[4mB\e[0m\e[40mlack\e[0m",
            "\e[41m\e[4mR\e[0m\e[41med\e[0m", "\e[42m\e[4mG\e[0m\e[42mreen\e[0m",
            "\e[44mbl\e[4mU\e[0m\e[44me\e[0m", "\e[43m\e[4mY\e[0m\e[43mellow\e[0m",
            "\e[45m\e[4mM\e[0m\e[45magenta\e[0m", "\e[46m\e[4mC\e[0m\e[46myan\e[0m"].freeze # 8 colors total
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

  attr_accessor :code, :history, :round, :trunked_colors

  def new_game
    @code = Array.new(4)
    @history = Array.new(ATTEMPTS) { Array.new(2) { Array.new(4, ' ') } } # [Attempt no.][0-guess / 1-feedback][values]
    @round = -1
    @trunked_colors = COLORS.map { |color| color.match(/\e\[4.m/)[0].concat(color.match(/\e\[4m(.\e\[0m)/)[1]) }
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
    if code == history[round][0]
      puts 'You did it, you won! The computer got mastered or something'
    else
      puts 'Shucks, better luck next time'
    end
    new_game if new_game?
  end

  def guessed?
    self.round += 1
    print_state_guesser
    take_guess
    feedback
    return true if code == history[round][0]

    false
  end

  def take_guess
    puts 'Give me your best guess! (colors separated by space)'
    begin
      guess = gets.split(' ')
      raise StandardError unless guess.size == 4

      guess.each.with_index do |color, index|
        lead = color.chr.upcase
        raise StandardError unless trunked_colors.any? { |color_reference| color_reference.match(/[A-Z]/)[0] == lead }

        (lead = 'U' if lead == 'B' && guess[index][2].upcase == 'U') if guess[index].size > 2
        trunked_colors.each do |color_reference|
          history[round][0][index] = color_reference if color_reference.match(/[A-Z]/)[0] == lead
        end
      end
    rescue StandardError
      puts 'Invalid Input!'
      retry
    end
  end

  def feedback
    # TO DO
  end

  def print_state_guesser
    puts "Available colors: #{COLORS.map { |color| color }.join(', ')}"
    puts "Attempts left: #{history.reduce(0) { |acc, attempt| attempt[0][0] == ' ' ? acc + 1 : acc }}"
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

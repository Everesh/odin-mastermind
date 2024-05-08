class Mastermind
  COLORS = ["\e[47m\e[30m\e[4mW\e[0m\e[47m\e[30mhite\e[0m", "\e[40m\e[37m\e[4mB\e[0m\e[40mlack\e[0m",
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
    @trunked_colors = COLORS.map do |color|
      color.match(/((?:\e\[\d+m)+)(?=[^\e]*?\e\[4m)/)[0].concat(color.match(/\e\[4m(.\e\[0m)/)[1])
    end
    print 'Computer mastermind? [Y/n] '
    gets.chr.downcase == 'n' ? player_mastermind : computer_mastermind
  end

  def new_game?
    print 'Care for a rematch? [Y/n] '
    gets.chr.downcase != 'n'
  end

  def computer_mastermind
    code.map! { trunked_colors[rand(trunked_colors.size)] }
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
      raise StandardError unless guess.size == 4 || guess[0].length == 4

      guess = guess[0].split('') if guess[0].length == 4
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
    code_left = right_guesses
    history[round][0].each.with_index do |guess, column|
      next unless history[round][1][column] == ' '

      if code_left.include?(guess)
        history[round][1][column] = trunked_colors[0]
        code_left.delete_at(code_left.index(guess))
      end
    end
  end

  def right_guesses
    code_left = code.dup
    history[round][0].each.with_index do |guess, column|
      if guess == code[column]
        history[round][1][column] = trunked_colors[1]
        code_left.delete_at(code_left.index(guess))
      end
    end
    code_left
  end

  def print_state_guesser
    attempt_left = history.reduce(0) { |acc, attempt| attempt[0][0] == ' ' ? acc + 1 : acc }
    puts "Available colors: #{COLORS.map { |color| color }.join(', ')}"
    puts "Attempts left: #{attempt_left}"
    puts '+---+---+---+---+'
    if code == history[round][0] || attempt_left.zero?
      puts "| #{code[0]} | #{code[1]} | #{code[2]} | #{code[3]} |"
    else
      puts '| ? | ? | ? | ? |'
    end
    puts '+---+---+---+---+-+---+---+---+---+'
    history.each do |attempt|
      print "| #{attempt[0][0]} | #{attempt[0][1]} | #{attempt[0][2]} | #{attempt[0][3]} |"
      puts " | #{attempt[1][0]} | #{attempt[1][1]} | #{attempt[1][2]} | #{attempt[1][3]} |"
      puts '+---+---+---+---+-+---+---+---+---+'
    end
  end

  def player_mastermind
    create_code
    ATTEMPTS.times { break if computer_guessed? }
    print_state_guesser
    if code == history[round][0]
      puts 'Pff, punny code. Make a better one!'
    else
      puts "Oh damn, it's impenetrable!"
    end
    new_game if new_game?
  end

  def create_code
    puts 'Have a code in mind? Great, gimme! (colors separated by space)'
    begin
      new_code = gets.split(' ')
      raise StandardError unless new_code.size == 4 || new_code[0].length == 4

      new_code = new_code[0].split('') if new_code[0].length == 4
      new_code.each.with_index do |color, index|
        lead = color.chr.upcase
        raise StandardError unless trunked_colors.any? { |color_reference| color_reference.match(/[A-Z]/)[0] == lead }

        (lead = 'U' if lead == 'B' && new_code[index][2].upcase == 'U') if new_code[index].size > 2
        trunked_colors.each do |color_reference|
          code[index] = color_reference if color_reference.match(/[A-Z]/)[0] == lead
        end
      end
    rescue StandardError
      puts 'Invalid Input!'
      retry
    end
  end

  def computer_guessed?
    self.round += 1
    print_state_guesser
    computer_guess
    feedback
    return true if code == history[round][0]

    false
  end
end

Mastermind.new

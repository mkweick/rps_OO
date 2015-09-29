class Choice
  include Comparable
  attr_reader :choice
  
  def initialize(choice)
    @choice = choice
  end
  
  def <=>(opponent_choice)
    if @choice == opponent_choice.choice
      0
    elsif (@choice == 'R' && opponent_choice.choice == 'S') ||
          (@choice == 'P' && opponent_choice.choice == 'R') ||
          (@choice == 'S' && opponent_choice.choice == 'P')
      1
    else
      -1
    end
  end
end

class Player
  attr_accessor :name, :selection
  CHOICES = { 'R' => "Rock", 'P' => "Paper", 'S' => "Scissors" }
  
  def initialize(n)
    @name = n
  end
  
  def to_s
    "#{name} threw #{CHOICES[self.selection.choice]}"
  end
  
  def print_winning_message
    case @choice
    when 'R'
      puts "Rock breaks Scissors!"
    when 'P'
      puts "Paper covers Rock!"
    when 'S'
      puts "Scissors cut Paper!"
    end
  end
end

class Human < Player
  def get_name
    system 'clear'
    puts "Rock, Paper, Scissors Game \nWhat's your name?"
    self.name = gets.chomp.capitalize
    while (0..9).any? { |num| name.include? num.to_s } || name.empty?
      puts "Name can't contain numbers or be blank, try again:"
      self.name = gets.chomp.capitalize
    end
  end
  
  def get_choice
    player_choice = gets.chomp.upcase
    while CHOICES.keys.none? { |letter| letter == player_choice }
      puts "You must select either Rock (R), Paper (P) or Scissors (S). Try again:"
      player_choice  = gets.chomp.upcase
    end
    self.selection = Choice.new(player_choice)
  end
end

class Computer < Player
  def get_choice
    self.selection = Choice.new(CHOICES.keys.sample)
    system 'clear'
  end
end

class Rps
  attr_reader :human, :computer
  
  def initialize
    @human = Human.new("")
    @computer = Computer.new("Computer")
  end
  
  def shoot
    system 'clear'
    puts "Rock......."
    sleep 1
    puts "Paper......"
    sleep 1
    puts "Scissors..."
    sleep 1
    puts "SHOOT! (R/P/S):"
  end
  
  def compare_choices
    if human.selection == computer.selection
      puts "It's a tie!"
    elsif human.selection > computer.selection
      human.print_winning_message
      puts "#{human.name} Wins!"
    else
      computer.print_winning_message
      puts "#{computer.name} wins. #{human.name} you lose."
    end
  end
  
  def play_again?
    puts "Play again? (Y/N):"
    play_again = gets.chomp.upcase
    while ['Y', 'N'].none? { |letter| letter == play_again }
      puts "You must select either 'Y' or 'N'. Play again?"
      play_again = gets.chomp.upcase
    end
    play_again
  end
  
  def play
    human.get_name
    loop do
      shoot
      human.get_choice
      computer.get_choice
      puts human
      puts computer
      compare_choices
      break if play_again? == 'N'
      system 'clear'
    end
  end
end

Rps.new.play
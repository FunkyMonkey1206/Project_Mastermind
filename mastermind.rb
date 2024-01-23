# frozen_string_literal: true

# This code will allow players to play Mastermind
class Mastermind
  attr_accessor :code, :secret_code, :guess_code, :guess_score, :role, :playing

  def initialize
    @code = %w[A B C D]
    @secret_code = ''
    @guess_code = ''
    @guess_score = 0
    @role = ''
    @playing = ''
  end

  def start_game
    @guess_score = 0
    select_role
    if @role == 2
      @playing = 'Computer'
      set_code if secret_code == ''
      puts "-----the secret code is #{secret_code.join}-----"
      com_plays
    elsif @role == 1
      @playing = 'Human'
      com_set_code if secret_code == ''
      puts "-----the secret code is #{secret_code.join}-----"
      player_plays
    end
  end

  def com_plays
    com_guess
    check
    feedback
  end

  def player_plays
    guess
    check
    feedback
  end

  def select_role
    puts 'Enter 1 to play or Enter 2 to become the mastermind'
    player_input = gets.chomp
    @role = player_input.to_i
    @role == 1 ? 'You are the player' : 'you are now the Mastermind!'
  end

  def com_set_code
    @secret_code = @code.shuffle
  end

  def set_code
    puts 'Please enter the secret code with any combination of [ABCD]'
    player_input = gets.chomp
    @secret_code = player_input.split("")
  end

  def guess
    puts "Please input your guess with any combination of #{@code.join}"
    player_input = gets.chomp
    @guess_code = player_input.chars
  end

  def com_guess
    @guess_code = @code.shuffle
  end

  def check
    puts "you guessed #{@guess_code.join}"
    @secret_code.each_with_index do |s, i|
      @guess_score += 1 if s == @guess_code[i]
    end
  end

  def feedback
    case @guess_score
    when 0
      puts "#{playing} got nothing right - please do better. Try again"
    when 1
      puts "#{playing} got one of the code correct! - keep trying! Try again"
    when 2
      puts "#{playing} got two of the code correct! - Halfway there! Try again"
    when 3
      puts "#{playing} got three of the code correct! - Just one more! Try again"
    else
      puts "#{playing} got the correct code! Congratulations!"
    end
    @guess_score == 4 ? return : try_again
  end

  def try_again
    @role == 2 ? com_plays : player_plays
  end
end

new_game = Mastermind.new
new_game.start_game

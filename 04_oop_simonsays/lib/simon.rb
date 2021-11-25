class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    until game_over
      take_turn
    end

    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    require_sequence
    if !game_over
      self.sequence_length += 1
      round_success_message
    end
  end

  def show_sequence
    add_random_color

    seq.each do |color|
      system("clear")
      puts color
      sleep(1)
      system("clear")
      puts " "
      sleep(0.1)
      system("clear")
    end
  end

  def require_sequence
    puts "Please enter sequence:"
    seq.each do |color|
      if gets.chomp != color
        self.game_over = true
        break
      end
    end
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    puts "Round passed!"
    sleep(2)
  end

  def game_over_message
    puts "Sorry, you were bested by a sequence length of #{sequence_length}"
  end

  def reset_game
    self.sequence_length = 1
    self.seq = []
    self.game_over = false
  end
end

if __FILE__ == $PROGRAM_NAME
  Simon.new.play
end

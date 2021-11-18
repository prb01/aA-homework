class Board
  attr_accessor :cups
  attr_reader :name1, :name2

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { [] }

    place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    @cups.each_with_index { |cup, i| 4.times { cup << :stone } if ![6,13].include?(i) }
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if !(0..13).to_a.include?(start_pos)
    raise "Starting cup is empty" if cups[start_pos].count == 0
  end

  def make_move(start_pos, current_player_name)
    pos = (1..6).include?(start_pos) ? (start_pos - 1) : start_pos
    stones = cups[pos].count
    cups[pos] = []

    stones.times do |i|
      pos = (pos + 1) % 14
      if ![6,13].include?(pos) || 
        (current_player_name == name1 && pos == 6) ||
        (current_player_name == name2 && pos == 13)
        
        cups[pos] << :stone
      else
        pos = (pos + 1) % 14
        cups[pos] << :stone
      end
    end

    render
    next_turn(pos)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    return :prompt if [6,13].include?(ending_cup_idx)
    return :switch if cups[ending_cup_idx].count == 1
    ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    if cups[0..5].flatten.count == 0 || cups[7..12].flatten.count == 0
      return true
    else
      return false
    end
  end

  def winner
    return :draw if cups[6].count == cups[13].count
    return name1 if cups[6].count > cups[13].count
    return name2 if cups[6].count < cups[13].count
    nil
  end
end

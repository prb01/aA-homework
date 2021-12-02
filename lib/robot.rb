class Robot
  attr_reader :position, :items, :items_weight, :health
  attr_accessor :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @items_weight = 0
    @health = 100
    @equipped_weapon = nil
  end

  def move_left
    x, y = position
    @position = [x-1, y]
  end

  def move_right
    x, y = position

    @position = [x+1, y]
  end

  def move_up
    x, y = position
    @position = [x, y+1]
  end

  def move_down
    x, y = position
    @position = [x, y-1]
  end

  def pick_up(item)
    new_weight = items_weight + item.weight
    raise ArgumentError if new_weight > 250
    
    @items << item
    @items_weight = new_weight
  end

  def wound(damage)
    new_health = health - damage
    @health = new_health < 0 ? 0 : new_health
  end

  def heal(amt)
    new_health = health + amt
    @health = new_health > 100 ? 100 : new_health
  end

  def attack(enemy, damage = 5)
    if equipped_weapon
      equipped_weapon.hit(enemy)
    else
      enemy.wound(damage)
    end
  end
end

class Item
  attr_reader :name, :weight
  def initialize(name, weight)
    @name = name
    @weight = weight
  end

  def feed(robot)
    robot.heal(weight)
  end
end

class Bolts < Item
  def initialize
    super("bolts", 25)
  end
end

class Weapon < Item
  attr_reader :name, :weight, :damage

  def initialize(name, weight, damage)
    @name = name
    @weight = weight
    @damage = damage
  end

  def hit(robot)
    robot.wound(damage)
  end
end

class Laser < Weapon
  def initialize
    super("laser", 125, 25)
  end
end

class PlasmaCannon < Weapon
  def initialize
    super("plasma_cannon", 200, 55)
  end
end
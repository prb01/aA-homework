class Map
  def initialize
    @map = []
  end

  def set(key, value)
    @map.each do |sets| 
      if sets[0] == key
        sets[1] = value
        return sets
      end
    end
    @map << [key, value]
  end

  def get(key)
    @map.each do |sets|
      return sets[1] if sets[0] == key
    end
    nil
  end

  def delete(key)
    @map.delete_if { |sets| sets[0] == key }
  end

  def show
    @map
  end
end
def sluggish(arr)
  longest_fish = nil

  arr.each do |fish|
    arr.each do |fish2|
      longest_fish = fish if !longest_fish || fish.length > fish2.length
    end
  end

  longest_fish
end

def dominant(arr)
  merge_sort(arr)[0]
end

def merge_sort(arr)
  return arr if arr.length <= 1

  middle = arr.length / 2
  lower_half = arr[0...middle]
  upper_half = arr[middle..-1]

  merge(merge_sort(lower_half), merge_sort(upper_half))
end

def merge(arr_1, arr_2)
  new_arr = []

  while arr_1.length > 0 || arr_2.length > 0
    if !arr_2[0] || (arr_1[0] && arr_1[0].length > arr_2[0].length)
      new_arr << arr_1.shift
    else
      new_arr << arr_2.shift
    end
  end

  new_arr
end

def clever(arr)
  longest_fish = arr[0]
  arr.each do |fish|
    longest_fish = fish if longest_fish.length < fish.length
  end
  longest_fish
end

arr = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
puts sluggish(arr)
puts dominant(arr)
puts clever(arr)


#-----------------------------------------------------------------------------

def slow_dance(direction, tiles_array)
  tiles_array.each_with_index do |tile, idx|
    return idx if direction == tile
  end
end

def constant_dance(direction, new_tiles_data_structure)
  return new_tiles_data_structure[direction]
end

tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
puts slow_dance("up", tiles_array)
puts slow_dance("right-down", tiles_array)

new_tiles_data_structure = {
  "up" => 0, 
  "right-up" => 1, 
  "right" => 2, 
  "right-down" => 3, 
  "down" => 4, 
  "left-down" => 5, 
  "left" => 6,  
  "left-up" => 7
}
puts constant_dance("up", new_tiles_data_structure)
puts constant_dance("right-down", new_tiles_data_structure)
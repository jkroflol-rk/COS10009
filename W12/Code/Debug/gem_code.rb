require './input_functions'
#require './input_functions_modified'

class Gem_record
  attr_accessor :id, :description, :weight, :price
end

def read_gem
  gem = Gem_record.new()
  gem.id = read_integer("Enter ID: ")
  gem.description = read_string("Enter Description: ")
  gem.weight = read_float("Enter Weight: ")
  gem.price = read_float("Enter Price: ")
  return gem
end

def display_gem gem
  puts('Gem information is: ')
  puts gem.id
  puts gem.description
  puts gem.weight
  puts gem.price
end

def read_gems
  count = read_integer("Enter Number of Gems: ")
  puts "Count is: " + count.to_s
  gems = Array.new
  index = 0
  while (index < count)
    gems << read_gem
    index += 1
  end
  return gems
end

def display_gems gems
  index = 0
  while (index < gems.length)
    display_gem(gems[0])
    index += 1
  end
  return gems
end

def main
  gems = read_gems
  display_gems(gems)
end

main

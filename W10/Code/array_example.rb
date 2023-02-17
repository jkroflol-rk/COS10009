

def print_array(array)
  index = 0
  while index < array.length
      puts array[index]
      index += 1
  end
  index
end

def main
  array = [10, 2, 5, 7, 6]
  count = print_array(array)
  puts "The array contained " + count.to_s + " elements."
end

main

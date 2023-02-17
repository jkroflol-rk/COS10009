
def main
  array = ["Fred", "Sam", "Jill", "Jenny"]

  name1, name2, name3, name4 = *array

  puts "Name 1: " + name1
  puts "Name 2: " + name2
  puts "Name 3: " + name3
  puts "Name 4: " + name4
  puts "Array: " + array.to_s
  list = *array
  puts "List: " + list.to_s
end

main



# Print list recursively

def print_list_recursive_with_count(list)
  if (list.length == 0)
    return 0
  end

  puts " List Element is: " + list[0].to_s
  return print_list_recursive_with_count(list[1..list.size]) + 1
end

def main
  list = ["a", "b", "c", "d", "e", "f"]
  count = print_list_recursive_with_count(list)
  puts "The list contained " + count.to_s + " elements."
end

main

def find_tea(my_fruits, str)
    index = 0
    found_index = -1
    while (index < my_fruits.length)
        if my_fruits[index] == str
            found_index = index
        end
        index += 1
    end
    return found_index
end

puts ("Enter fruit name:")
str = gets.chomp
my_fruits = Array.new
my_fruits << "apple"
my_fruits << "pear"
my_fruits << "orange"
print(my_fruits)
puts
found_index = find_tea(my_fruits, str)
puts("The found index for " + str + " is " + found_index.to_s)
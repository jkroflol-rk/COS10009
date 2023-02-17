list = [2,4,5,6,8]

=begin
j = 0
list.each do |number|
    j += 1
    puts "Item #{j} is #{number}"
    if number == 5
        puts("--> There is a number 5 in the list")
    end
end
=end

new_list = list.reject do |number|
    if number > 4
        true
    else
        false
    end
end

print(new_list)




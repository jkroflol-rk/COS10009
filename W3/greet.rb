=begin
puts("Enter number of times to repeat: ")
count = gets.chomp.to_i

count.times do |i|
    puts("Person " + i.to_s + ". Enter your name!")
    name = gets.chomp.to_s
    puts("The entered name is " + name)
end
=end

def main 
    1.upto(5) do |i|
        puts("Student number " + i.to_s + ". Enter your name")
        name = gets.chomp.to_s
        puts("The entered student name is " + name)
        points = 0 
        1.upto(3) do |j|
            puts("Unit number " + j.to_s + " is ")
            points += gets.chomp.to_i 
        end
        puts("The total point is " + points.to_s)
    end
end

main


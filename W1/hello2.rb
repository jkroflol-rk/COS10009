def main()
    puts ("Enter number a: ")
    a = gets.chomp.to_f
    puts ("Enter number b")
    b = gets.chomp.to_f
    
    addition = a + b
    subtraction = a - b 
    multiplication = a * b 
    division = a / b 
    
    print ("\n")
    print ("a + b = ")
    puts (addition)
    print ("a - b = ")
    puts (subtraction)
    print ("a * b = ")
    puts (multiplication)
    print ("a / b = ")
    puts (division)
end

main()


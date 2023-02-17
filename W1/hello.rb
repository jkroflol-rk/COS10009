def main()
    puts ("Enter appetizer price:")
    appetizer_price = gets.chomp.to_f()

    puts ("Enter dessert price:")
    dessert_price = gets.chomp.to_f()

    puts ("Enter main price:")
    main_price = gets.chomp.to_f()

    total_price = appetizer_price + dessert_price + main_price 
    puts ("The total price is :")
    print ("$")
    printf("%.2f" , total_price)
    print ("\n")
end

main()



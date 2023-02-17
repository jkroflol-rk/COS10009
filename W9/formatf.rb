printf('%2f', "1")
#=> "1.000000"
# Here I'm only specifying that the length is 'at least 2'.
print ("\n")
printf('%2.0f', "1")
#=> " 1"
# min-width of 2, precision of zero, and padding with whitespace
print ("\n")
printf('%.2f', "1")
#=> "1.00"
# just set precision, don't set min-width
print ("\n")
printf('%02.0f', "1")
#=> "01"
# min-width of 2, precision of zero, and padding with zeroes
print ("\n")
printf('%-2.0f', "1")
#=> "1 "
# using a dash to right pad
print ("\n")
printf('%-02.0f', "1")
#=> "1 "
# when '-' is used the 0 flag will still pad with whitespace
print ("\n")
printf('%2.2f', "1")
#=> "1.00"
# min-width of 2 and precision of 2
print ("\n")
printf('%5.2f', "1")
#> " 1.00"
# min-width of 5, precision of 2, padding with whitespace
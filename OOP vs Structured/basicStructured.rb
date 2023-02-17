def get_name()
    puts("Enter a name:")
    name = gets.chomp()
    return name
end

def print_name(name)
    puts("The name you entered was " + name)
end

def main()
    name = get_name()
    print_name(name)
end


main()
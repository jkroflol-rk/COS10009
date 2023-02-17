class NameHandler

    def get_name()
        puts("Enter a name:")
        @name = gets.chomp()
    end

    def print_name()
        puts("The name entered was " + @name)
    end
end

handler  = NameHandler.new()
handler.get_name()
handler.print_name()

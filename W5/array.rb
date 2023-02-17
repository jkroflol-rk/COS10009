=begin
def main
    music_array = ["Pop", "Classic", "Jazz", "Rock"]

    puts("The length is " + music_array.length.to_s)
    puts("Array is =======")
    #puts(music_array)

    index = 0
    while (index < music_array.length)
        puts("[#{index}] = " + music_array[index])
        if music_array[index] == "Classic"
            puts("=> I love this music")
        end
        index += 1
    end
end

main

require './input_functions.rb'

def main
    name_array = Array.new()
    count = read_integer("Enter the length of student name array: ")
    index = 0
    while (index < count)
        name_array[index] = read_string("Enter the student name #{index}")
        index += 1
    end
    puts("The student name array is ======")
    #puts(name_array)
    index = 0
    while (index < count)
        puts("[#{index}] = " + name_array[index])
        index += 1
    end
end

main
=end
require './input_functions.rb'

def print_array(table_array, row_count,col_count)
    puts("The table array is =========")
    row_index = 0
    while (row_index < row_count)
        col_index = 0
        while (col_index < col_count)
            puts("[" + row_index.to_s + "]" + "[" + col_index.to_s + "] = " + table_array[row_index][col_index])
            col_index += 1
        end
        row_index += 1
    end
end

def main
    col_count = read_integer("Enter number of column: ")
    row_count = read_integer("Enter number of row : ")
    table_array = Array.new(row_count)
    row_index = 0
    while (row_index < row_count)
        table_array[row_index] = Array.new(col_count)
        col_index = 0
        while (col_index < col_count)
            table_array[row_index][col_index] = "a"
            col_index += 1
        end
        row_index += 1
    end

    print_array(table_array, row_count, col_count)
end

main

=begin 

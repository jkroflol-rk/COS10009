def read_string prompt
    puts prompt
    value = gets.chomp
end

def read_integer prompt
    value = read_string(prompt)
    value.to_i
end

@col_count = read_integer("Enter number of column: ")
@row_count = read_integer("Enter number of row : ")

def print_array(table_array)
    row_index = 0
    while (row_index < @row_count)
        col_index = 0
        while (col_index < @col_count)
            puts("[" + row_index.to_s + "]" + "[" + col_index.to_s + "] = " + table_array[row_index][col_index])
            col_index += 1
        end
        row_index += 1
    end
end

def main
    table_array = Array.new(@row_count)
    row_index = 0
    while (row_index < @row_count)
        table_array[row_index] = Array.new(@col_count)
        col_index = 0
        while (col_index < @col_count)
            table_array[row_index][col_index] = "a"
            col_index += 1
        end
        row_index += 1
    end

    print_array(table_array)
end

main
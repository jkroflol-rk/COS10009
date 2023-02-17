@tracks = ["obama", "trump", "biden"]

def search_for_track_name()
    puts ("Enter string: ")
    search_string = gets.chomp
    index = 0
    found_index = -1
    while index < @tracks.length
        if (@tracks[index] == search_string)
            found_index = index
        end
    index += 1 
    end
    puts found_index
end

search_for_track_name()



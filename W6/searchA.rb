require './input_functions'

# Task 6.1 T - use the code from 5.1 to help with this

class Track
	attr_accessor :name, :location

	def initialize (name, location)
		@name = name
		@location = location
	end
end

# Reads in and returns a single track from the given file

def read_track(music_file)
    name = music_file.gets()
    location = music_file.gets()
    t = Track.new(name, location)
end

# Returns an array of tracks read from the given file

def read_tracks(music_file)
	
	count = music_file.gets().to_i()
  	tracks = Array.new()

  # Put a while loop here which increments an index to read the tracks

    while count > 0
        track = read_track(music_file)
        tracks << track
        count -= 1
    end
    
	return tracks
end

# Takes an array of tracks and prints them to the terminal

def print_tracks(tracks)
	count = tracks.length
    i = 0
    while i < count 
        puts(tracks[i].name)
        puts(tracks[i].location)
        i += 1
    end
  # Print each track use: tracks[index] to get each track record
end

# Takes a single track and prints it to the terminal
def print_track(track)
  	puts('Track title is: ' + track.title)
	puts('Track file location is: ' + track.file_location)
end


# search for track by name.
# Returns the index of the track or -1 if not found
def search_for_track_name(tracks, search_string)
    index = 0
    found_index = -1
    while index < tracks.length
        if (tracks[index].name.chomp == search_string)
            found_index = index
        end
    index += 1 
    end
    return found_index
end

# Reads in an Album from a file and then prints all the album
# to the terminal

def main()
  	music_file = File.new("album.txt", "r")
	tracks = read_tracks(music_file)
  	music_file.close()

    print_tracks(tracks)

  	search_string = read_string("Enter the track name you wish to find: ")
  	index = search_for_track_name(tracks, search_string)
  	if index > -1
        puts ("Found " + tracks[index].name + " at " + index.to_s())
  	else
    	puts "Entry not Found"
  	end
end

main()

#
#
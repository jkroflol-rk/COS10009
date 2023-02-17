require './input_functions'

# It is suggested that you put together code from your 
# previous tasks to start this. eg:
# TT3.2 Simple Menu Task
# TT5.1 Music Records
# TT5.2 Track File Handling
# TT6.1 Album file handling

module Genre
    POP, CLASSIC, JAZZ, ROCK = *1..4
end
  
$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
    attr_accessor :artist, :title, :year, :genre, :tracks

    def initialize (artist, title, year, genre, tracks)
        @artist = artist 
        @title = title 
        @year = year
        @genre = genre
        @tracks = tracks
    end
end

class Track
    attr_accessor :name, :location
  
    def initialize (name, location)
        @name = name
        @location = location
    end
end

def read_track(music_file)
    name = music_file.gets()
    location = music_file.gets()
    t = Track.new(name, location)
end
  
def read_tracks(music_file)
      
    count = music_file.gets().to_i()
    tracks = Array.new()

    while count > 0
        track = read_track(music_file)
        tracks << track
        count -= 1
    end
  
    return tracks
end

def print_tracks(tracks)
    count = tracks.length
    i = 0
    while i < count 
        puts(tracks[i].name)
        puts(tracks[i].location)
        i += 1
    end  
end

def read_album(music_file)
    album_artist = music_file.gets()
    album_title = music_file.gets()
    album_year = music_file.gets()
    album_genre = music_file.gets().to_i
    album_tracks = read_tracks(music_file)
    album = Album.new(album_artist, album_title, album_year, album_genre, album_tracks)
    album.artist = album_artist
    album.title = album_title
    album.year = album_year
    album.genre = album_genre
    album.tracks = album_tracks
    return album
end

def read_albums(music_file)
    count =  music_file.gets().to_i()
    albums = Array.new()

    while count > 0
        album = read_album(music_file)
        albums << album
        count -= 1
    end

    return albums
end

def print_album(id, albums)
    puts ("\n[Album ID: " + (id + 1).to_s + "]")
    puts("Genre: -==" + $genre_names[albums[id].genre] + "==-")
    puts(albums[id].title.upcase.chomp + " by " + albums[id].artist)
    puts("Release date:" + albums[id].year + "\n")
end

def print_albums(albums)
    count = albums.length
    id = 0
    while id < count
        print_album(id, albums)
        id += 1
    end
end

def print_genre(albums)
    puts("Select Genre: (if the selected genre is empty, no album will be displayed)")
    puts("1. Pop")
    puts("2. Classic")
    puts("3. Jazz")
    puts("4. Rock")
    
    genre = read_integer_in_range("Option:", 1, 4)

	# id = 0
    # if albums[id].genre == 
	# 	puts("test ok")
	# end
	for id in 0..albums.length - 1
        if albums[id].genre == genre
            print_album(id, albums)
        end
    end
end

def read_in_albums()
    finished = false
    begin
        filename = read_string("Please enter file name:")
        if File.exist?(filename) == true
            music_file = File.new(filename, "r")
            finished = true
            read_string("Music Library Loaded. Press ENTER...")
        else
            read_string("No such file exists. Press ENTER.")
        end
    end until finished
    return music_file
end

def display_album(albums)
    if (!albums)
        puts("There is no album")
        return
    end

    finished = false
    begin 
        puts("Select display options:")
        puts("1. Display all")
        puts("2. Display Genre")
        puts("3. Exit")
        choice = read_integer_in_range("Option:", 1, 3)
        case choice
        when 1
            print_albums(albums)
        when 2
            print_genre(albums)
        when 3
            finished = true
        end
    end until finished
end

def play_by_id(albums)
    notes = "\u266B"

    if (!albums)
        puts("There is no album")
        return
    end

    id = read_integer_in_range("Album ID:", 1, albums.length)
    track_count = albums[id-1].tracks.length

    if track_count <= 0
        puts("This album has no track.")
        return
    end

    puts("\n" + albums[id-1].title.upcase.chomp + " by " + albums[id-1].artist.chomp)
    puts("\nTrack list:")
    puts("\n")

    for i in 0..albums[id-1].tracks.length-1
        puts (i + 1).to_s + "." + albums[id-1].tracks[i].name
    end

    puts("\n")
    choice = read_integer_in_range("Play track:", 1, track_count)
    puts(notes.encode("utf-8").chomp + " Playing " + albums[id-1].tracks[choice-1].name.chomp + " " + notes.encode("utf-8").chomp)
    puts("wait for 5 second before you can exit to the main menu...")
    sleep 5

    puts("Returning to the main menu.")
    sleep 0.8
end

def fake_update(albums)

    if (!albums)
        puts("There is no album")
        return
    end

    print_albums(albums)

    fake_ID = read_integer_in_range("Choose album ID to update:", 1, 4)

    fake_title = read_string("Enter new title:")
    
    puts("Genre list:")

    for i in 1..4
        puts(i.to_s + ". " + $genre_names[i])
    end

    fake_genre = read_integer_in_range("Select a genre:", 1, 4)
    
    puts("New album updated:")
    puts ("\n[Album ID: " + (fake_ID + 1).to_s + "]")
    puts("Genre: -==" + $genre_names[fake_genre] + "==-")
    puts(fake_title.upcase.chomp + " by " + albums[fake_ID].artist)
    puts("Release date:" + albums[fake_ID].year + "\n")

    read_string("Press ENTER to continue")
end

def main()
    finished = false
    albums = nil
    begin
        puts('Main Menu:')
        puts('1. Read in Albums')
        puts('2. Display Albums')
        puts('3. Select an Album to play')
        puts('4. Update an existing Album')
        puts('5. Exit the application')
        choice = read_integer_in_range("Please enter your choice:", 1, 5)
        case choice
        when 1
            music_file = read_in_albums()
            albums = read_albums(music_file)
            music_file.close()
        when 2
            display_album(albums)
        when 3
            play_by_id(albums)
        when 4
            fake_update(albums)
        when 5
            finished = true
            puts("THANK YOU FOR USING! SEE YOU NEXT TIME!")
        end
    end until finished
end

main()

#def main()
#     music_file = File.new("album.txt", "r")
#     albums = read_albums(music_file)
#     music_file.close
#     print_albums(albums)
# end

# main()

# def play_album(albums)
#     if (!albums)
#         puts("There is no album")
#         return
#     end

#     finished = false 
#     begin 
#         puts("1. Play by ID")
#         puts("2. Search by name")
#         choice = read_integer_in_range("Option:", 1, 2)
#         case choice
#         when 1
#             play_by_id(albums)
#         when 2
#             ...
#         end
#     end until finished
# end

# def display_genre(genre, albums)
#     for id in 0..albums.length - 1
#         if albums[id].genre == genre
#             print_album(id, albums)
#         end
#     end
# end

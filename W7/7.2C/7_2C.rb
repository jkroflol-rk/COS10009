require 'rubygems'
require 'gosu'

TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

GENRE_NAMES = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class ArtWork
	attr_accessor :bmp

	def initialize (file)
		@bmp = Gosu::Image.new(file)
	end
end

# Put your record definitions here

class Album
    attr_accessor :title, :artist, :artwork, :tracks

    def initialize (title, artist, artwork, tracks)
        @artist = artist 
        @artwork = artwork
        @title = title 
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

class MusicPlayerMain < Gosu::Window

	def initialize
	    super 800, 600
	    self.caption = "Music Player"
      @track_font = Gosu::Font::new(25)
      @album = read_album()
      @track_playing = 0
      @clicked = false
      # playTrack(@track_playing, @album)
      @ypos = 50
		# Reads in an array of albums from a file and then prints all the albums in the
		# array to the terminal
	end

  # Put in your code here to load albums and tracks

  def read_track(music_file)
    name = music_file.gets.chomp  
    location = music_file.gets.chomp  
    t = Track.new(name, location)
    return t
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

  def read_album()
		music_file = File.new("kfp.txt", "r")
		title = music_file.gets.chomp
		artist = music_file.gets.chomp
		artwork = ArtWork.new(music_file.gets.chomp)
		tracks = read_tracks(music_file)
		album = Album.new(title, artist, artwork.bmp, tracks)
		music_file.close()
		return album
	end

  def draw_albums(album)
    album.artwork.draw(50, 50 , z = ZOrder::PLAYER, 0.6, 0.6)
    @track_font.draw_markup(album.title, 50, 370, ZOrder::PLAYER, 1.2, 1.2, Gosu::Color::YELLOW)
    @track_font.draw(album.artist, 50, 400, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::RED)
  end

  def area_hovered(leftX, topY, rightX, bottomY)
    if mouse_x >= leftX && mouse_x <= rightX && mouse_y >= topY && mouse_y <= bottomY
      true
    else 
      false
    end
  end

  def display_track(title, ypos)
  	@track_font.draw(title, 450, ypos, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::WHITE)
  end

  def display_tracks(album)
    if @clicked == true
      ypos = 50
      album.tracks.each do |track|
        display_track(track.name, ypos)
        ypos += 50
      end
    end
  end

  def playTrack(track, album)
    if @clicked == true
      @song = Gosu::Song.new(album.tracks[track].location)
      @song.play(false)
    end
  end

	def draw_background
    Gosu.draw_quad(0, 0, TOP_COLOR, 0, 600, TOP_COLOR, 800, 0, BOTTOM_COLOR, 800, 600, BOTTOM_COLOR, z = ZOrder::BACKGROUND)
	end

	def update
    if @clicked == true
      if @song.playing? == false && @track_playing < 4
          @track_playing += 1 
          @ypos += 50
          playTrack(@track_playing, @album)
      end 
    end
  end

  def draw
    draw_albums(@album)
		draw_background()
    display_tracks(@album)
    if @clicked == true 
      Gosu.draw_rect(430, @ypos, 5, 20, Gosu::Color::RED, z = ZOrder::PLAYER)
    end
	end

 	def needs_cursor?; true; end

	def button_down(id)
		case id
	    when Gosu::MsLeft
          if area_hovered(50, 50, 50 + 298, 50 + 298)
            @clicked = true
            @track_playing = 0
            @ypos = 50
            playTrack(@track_playing, @album)
          end 
	    end
	end

end

# Show is a method that loops through update and draw

MusicPlayerMain.new.show if __FILE__ == $0
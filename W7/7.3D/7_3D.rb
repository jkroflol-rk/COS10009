require 'rubygems'
require 'gosu'

TOP_COLOR = Gosu::Color.new(0xFF404040)
MID_COLOR = Gosu::Color.new(0xFF606060)
BOTTOM_COLOR = Gosu::Color.new(0xFF808080)

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

GENRE_NAMES = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Dimension
	attr_accessor :leftX, :topY, :rightX, :bottomY

	def initialize(leftX, topY, rightX, bottomY)
		@leftX = leftX
		@topY = topY
		@rightX = rightX
		@bottomY = bottomY
	end
end

class ArtWork
	attr_accessor :bmp, :dimension

	def initialize(file, leftX, topY)
		@bmp = Gosu::Image.new(file)
		@dimension = Dimension.new(leftX, topY, leftX + @bmp.width(), topY + @bmp.height())
	end
end

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
  attr_accessor :name, :location, :dimension

  def initialize (name, location, dimension)
      @name = name
      @location = location
      @dimension = dimension
  end
end

class MusicPlayerMain < Gosu::Window

	def initialize
	    super 1200, 800
	    self.caption = "Music Player"
      @track_font = Gosu::Font::new(self, "./font/Montserrat-Regular.ttf", 25)
      @track_font_b = Gosu::Font::new(self, "./font/Montserrat-Bold.ttf", 30)
      @albums = read_albums()
      @current_track = nil
      @current_album = nil
      @autoplay = false
      @loop = false
	end

  def read_track(music_file, id)
    name = music_file.gets.chomp  
    location = music_file.gets.chomp  
    leftX = 750
    topY = 50 * id + 50
    rightX = leftX + @track_font.text_width(name)
    bottomY = topY + @track_font.height()
    dimension = Dimension.new(leftX, topY, rightX, bottomY)
    t = Track.new(name, location, dimension)
    return t
  end

  def read_tracks(music_file)
    music_file = music_file
    count = music_file.gets().to_i()
    tracks = Array.new()

    id = 0
    while id < count
        track = read_track(music_file, id)
        tracks << track
        id += 1
    end
  
    return tracks
  end

  def read_album(music_file, id)
		title = music_file.gets.chomp
		artist = music_file.gets.chomp
    if id % 2 == 0
      leftX = 50
    else
      leftX = 375
    end
    if id < 2
      topY = 50
    else
      topY = 375
    end
		artwork = ArtWork.new(music_file.gets.chomp, leftX, topY)
		tracks = read_tracks(music_file)
		album = Album.new(title, artist, artwork, tracks)
		return album
	end

  def read_albums()
      music_file = File.new("albums_D.txt", "r")
      count = music_file.gets().to_i()
      albums = Array.new()

      id = 0
      while id < count
          album = read_album(music_file, id)
          albums << album
          id += 1
      end

      return albums
  end

  def draw_albums(albums)
    albums.each do |album|
			album.artwork.bmp.draw(album.artwork.dimension.leftX, album.artwork.dimension.topY , z = ZOrder::PLAYER)
      if area_hovered(album.artwork.dimension.leftX, album.artwork.dimension.topY, album.artwork.dimension.rightX, album.artwork.dimension.bottomY)
        @track_font_b.draw_text(album.title, 50, 700, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::RED)
        @track_font.draw_text(album.artist, 50, 730, ZOrder::PLAYER, 1.0, 1.0, Gosu::Color::FUCHSIA)
        draw_rect(album.artwork.dimension.leftX - 3, album.artwork.dimension.topY - 3, album.artwork.bmp.width + 6, album.artwork.bmp.height + 6, Gosu::Color::WHITE, ZOrder::BACKGROUND)
      end
		end
  end

  def area_hovered(leftX, topY, rightX, bottomY)
    if mouse_x >= leftX && mouse_x <= rightX && mouse_y >= topY && mouse_y <= bottomY
      true
    else 
      false
    end
  end

  def display_track(title, leftX, topY)
  	@track_font.draw_text(title, leftX, topY, ZOrder::PLAYER, 1.1, 1.1, Gosu::Color::AQUA)
  end

  def display_tracks(album)
    id = 1
    album.tracks.each do |track|
      display_track(id.to_s + "." + track.name, track.dimension.leftX, track.dimension.topY)
      id += 1
    end
  end 

  def playTrack(track, album)
    @song = Gosu::Song.new(album.tracks[track].location)
    @song.play(false)
  end

	def draw_background
    draw_quad(0, 0, TOP_COLOR, 0, 800, MID_COLOR, 1200, 0, MID_COLOR, 1200, 800, BOTTOM_COLOR, z = ZOrder::BACKGROUND)
	end

	def update
    if @autoplay == true && @song != nil
      if @song.playing? == false && @current_album != nil && @song.paused? == false
        if @current_track < @albums[@current_album].tracks.length - 1
          @current_track += 1 
        else
          @current_track = 0
        end
        @song.volume = 0.6
        playTrack(@current_track, @albums[@current_album])
      end
    end 
  end

	def draw
		draw_background()
    draw_albums(@albums)
    if @current_album != nil
			display_tracks(@albums[@current_album])
			draw_rect(@albums[@current_album].tracks[@current_track].dimension.leftX - 10, @albums[@current_album].tracks[@current_track].dimension.topY, 5, @track_font.height(), Gosu::Color::BLUE, z = ZOrder::PLAYER)
      draw_rect(@albums[@current_album].artwork.dimension.leftX - 3, @albums[@current_album].artwork.dimension.topY - 3, @albums[@current_album].artwork.bmp.width + 6, @albums[@current_album].artwork.bmp.height + 6, Gosu::Color::YELLOW, ZOrder::BACKGROUND)
    end
    # easier for locating coordinate for albums and tracks x/y location
    @track_font.draw_text("Mouse X: #{mouse_x}", 0, 780, ZOrder::UI, 0.5, 0.5, Gosu::Color::BLACK)
    @track_font.draw_text("Mouse Y: #{mouse_y}", 100, 780, ZOrder::UI, 0.5, 0.5, Gosu::Color::BLACK)
    @track_font.draw_text("Hover on album for info. Click to play album/songs. SPACE to play/pause", 50, 15, ZOrder::UI, 0.93, 0.93, Gosu::Color::YELLOW)
    if @song != nil
      @track_font.draw_text("Volume: " + (@song.volume * 100).to_i.to_s + "% (Up/Down keys)", 750, 510, z = 2, 1, 1, Gosu::Color::WHITE)
      @track_font.draw_text("Left/Right Arrow to skip track", 750, 615, z = 2, 1, 1, Gosu::Color::YELLOW)
      @track_font.draw_text("Use -/+ to skip album. ESC to close.", 750, 650, z = 2, 1, 1, Gosu::Color::YELLOW)
      if @song.playing?
        @track_font.draw_text("Status: PLAYING", 750, 475, z = 2, 1, 1, Gosu::Color::WHITE)
      elsif @song.playing? == false && @song.paused? == false
        @track_font.draw_text("Status: ENDED", 750, 475, z = 2, 1, 1, Gosu::Color::WHITE)
      elsif @song.paused?
        @track_font.draw_text("Status: PAUSED", 750, 475, z = 2, 1, 1, Gosu::Color::WHITE)
      end
      if @loop 
        @track_font.draw_text("Loop: ON (L to toggle)", 750, 545, z = 2, 1, 1, Gosu::Color::BLUE)
      elsif @loop == false
        @track_font.draw_text("Loop: OFF (L to toggle)", 750, 545, z = 2, 1, 1, Gosu::Color::BLUE)
      end
    end 
    if @autoplay == true && @song != nil
      @track_font.draw_text("Autoplay: ON (J=OFF, K=ON)", 750, 580, z = 2, 1, 1, Gosu::Color::BLUE)
    elsif @autoplay == false && @song != nil
      @track_font.draw_text("Autoplay: OFF (J=OFF, K=ON)", 750, 580, z = 2, 1, 1, Gosu::Color::BLUE)
    end 
	end

 	def needs_cursor?; true; end

	def button_down(id)
		case id
      when Gosu::KB_ESCAPE
        close
      when Gosu::KB_SPACE
        if @song.paused?
          @song.play(false)
        elsif @song.playing?
          @song.pause
        end
      when Gosu::KB_UP
        if @song != nil
          @song.volume += 0.1
        end
      when Gosu::KB_DOWN
        if @song != nil
          @song.volume -= 0.1
        end
      when Gosu::KB_LEFT
        if @current_album != nil && 
          if @current_track > 0
            @current_track -= 1
          else 
            @current_track = @albums[@current_album].tracks.length - 1
          end
          playTrack(@current_track, @albums[@current_album])
          @song.volume = 0.6
        end
      when Gosu::KB_RIGHT
        if @current_album != nil 
          if @current_track < @albums[@current_album].tracks.length - 1
            @current_track += 1
          else 
            @current_track = 0
          end
          playTrack(@current_track, @albums[@current_album])
          @song.volume = 0.6
        end
      when Gosu::KB_MINUS
        if @current_album != nil
          if @current_album > 0 
            @current_album -= 1
          else 
            @current_album = @albums.length - 1
          end
          @current_track = 0
          playTrack(@current_track, @albums[@current_album])
          @song.volume = 0.6
        end
      when Gosu::KB_EQUALS 
        if @current_album != nil
          if @current_album < @albums.length - 1
            @current_album += 1
          else 
            @current_album = 0
          end
          @current_track = 0
          playTrack(@current_track, @albums[@current_album])
          @song.volume = 0.6
        end
      when Gosu::KB_K 
        @autoplay = true
      when Gosu::KB_J
        @autoplay = false
      when Gosu::KB_L
        if @song.playing? && @loop == false
          @song.play(true)
          @loop = true
        elsif @song.playing? && @loop == true 
          @song.play(false)
          @loop = false
        end
      when Gosu::MsLeft 
        for id in 0...@albums.length
          if area_hovered(@albums[id].artwork.dimension.leftX, @albums[id].artwork.dimension.topY, @albums[id].artwork.dimension.rightX, @albums[id].artwork.dimension.bottomY)
            @current_album = id
            @current_track = 0
            @song = nil
            playTrack(0, @albums[@current_album])
            @song.volume = 0.6
          end
        end

        if @current_album != nil
          for id in 0...@albums[@current_album].tracks.length
            if area_hovered(@albums[@current_album].tracks[id].dimension.leftX, @albums[@current_album].tracks[id].dimension.topY, @albums[@current_album].tracks[id].dimension.rightX, @albums[@current_album].tracks[id].dimension.bottomY)
			    		playTrack(id, @albums[@current_album])
			    		@current_track = id
              @song.volume = 0.6
            end
			    end
        end
    end   
	end

end

MusicPlayerMain.new.show if __FILE__ == $0
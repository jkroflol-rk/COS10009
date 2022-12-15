require 'rubygems'
require 'gosu'

TOP_COLOR = Gosu::Color.new(0xFF404040)
MID_COLOR = Gosu::Color.new(0xFF606060)
BOTTOM_COLOR = Gosu::Color.new(0xFF808080)

GENRE_NAMES = ['Null', 'Pop', 'Folk', 'EDM', 'Rock', 'Rap']

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
	attr_accessor :bmp, :dim

	def initialize(file, leftX, topY)
		@bmp = Gosu::Image.new(file)
		@dim = Dimension.new(leftX, topY, leftX + @bmp.width(), topY + @bmp.height())
	end
end

class Album
  attr_accessor :title, :artist, :genre, :year, :artwork, :tracks

  def initialize (title, artist, genre, year, artwork, tracks)
      @artist = artist 
      @artwork = artwork
      @genre = genre
      @year = year
      @title = title 
      @tracks = tracks
  end
end

class Track
  attr_accessor :name, :location, :dim

  def initialize(name, location, dim)
      @name = name
      @location = location
      @dim = dim
  end
end

class Text_button
  attr_accessor :text, :dim 

  def initialize(text, leftX, topY)
    @font = Gosu::Font::new(25, option = {:name => "./font/Montserrat-Regular.ttf"})
    @text = text
    @dim = Dimension.new(leftX, topY, leftX + @font.text_width(@text), topY + @font.height())
  end
end

ONE = ArtWork.new("downloads/1.png", 590, 800)
AUTOPLAY = ArtWork.new("downloads/autoplay.png", 590, 800)
DOWN = ArtWork.new("downloads/down.png", 1020, 810)
UP = ArtWork.new("downloads/up.png", 1286, 810)
LOOP = ArtWork.new("downloads/loop.png", 590, 800)
FWD = ArtWork.new("downloads/next.png", 850, 800)
PAUSE = ArtWork.new("downloads/pause.png", 770, 800)
PLAY = ArtWork.new("downloads/play.png", 770, 800)
PREV = ArtWork.new("downloads/prev.png", 690, 800)
VOL = ArtWork.new("downloads/vol.png", 950, 800)
EXIT = Text_button.new("<<EXIT TO MENU", 375, 820)
X1Y1 = 50
X2Y2 = 375

class MusicPlayerMain < Gosu::Window

	def initialize
	    super 1600, 900
	    self.caption = "I am not just a music player, I am THE Music Player B) jk flipflop jk roflol"
      @bg = Gosu::Image.new("images/bg.jpg")
      @bg1 = Gosu::Image.new("images/bg1.jpg")
      @bg2 = Gosu::Image.new("images/bg2.png")
      @bg3 = Gosu::Image.new("images/bg3.jpg") 
      @font = Gosu::Font::new(25, option = {:name => "./font/Montserrat-Regular.ttf"})
      @font_b = Gosu::Font::new(30, option = {:name => "./font/Montserrat-Bold.ttf"})
      @albums = read_albums()
      @current_track = nil
      @current_album = nil
      @autoplay = false
      @loop = false
      @menu1 = false
      @menu2 = false
      @menu3 = false
      @ui = false
      @year_sort = false
      @genre_sort = false
      @temp_year_sort = false
      @temp_genre_sort = false
      @next_page = false
      @lol = false
      @debug = false
      @case = 0
      @volume = 0.6
	end

  def read_track(music_file, id)
    name = music_file.gets.chomp  
    location = music_file.gets.chomp  
    leftX = 1250
    topY = 50 * id + 50
    rightX = leftX + @font.text_width(name) + 20
    bottomY = topY + @font.height()
    dim = Dimension.new(leftX, topY, rightX, bottomY)
    t = Track.new(name, location, dim)
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
    genre = music_file.gets.chomp.to_i
    year = music_file.gets.chomp
    if id % 2 == 0 
      leftX = X1Y1
    else
      leftX = X2Y2
    end
    if id < 2 || id == 5 || id == 4
      topY = X1Y1
    else
      topY = X2Y2
    end
		artwork = ArtWork.new(music_file.gets.chomp, leftX, topY)
		tracks = read_tracks(music_file)
		album = Album.new(title, artist, genre, year, artwork, tracks)
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
    if @menu1 && !@year_sort && !@genre_sort
      if !@next_page
        for i in 0..3
          albums[i].artwork.bmp.draw(albums[i].artwork.dim.leftX, albums[i].artwork.dim.topY , z = 1)
          if area_hovered(albums[i].artwork.dim.leftX, albums[i].artwork.dim.topY, albums[i].artwork.dim.rightX, albums[i].artwork.dim.bottomY) 
            @font_b.draw_text(albums[i].title, 50, 700, 1, 1.0, 1.0, Gosu::Color::RED)
            @font.draw_text(albums[i].artist, 50, 730, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)
            draw_rect(albums[i].artwork.dim.leftX - 3, albums[i].artwork.dim.topY - 3, albums[i].artwork.bmp.width + 6, albums[i].artwork.bmp.height + 6, Gosu::Color::WHITE, 0)
          end
        end
      elsif @next_page
        for i in 4..5
          albums[i].artwork.bmp.draw(albums[i].artwork.dim.leftX, albums[i].artwork.dim.topY , z = 1)
          if area_hovered(albums[i].artwork.dim.leftX, albums[i].artwork.dim.topY, albums[i].artwork.dim.rightX, albums[i].artwork.dim.bottomY) 
            @font_b.draw_text(albums[i].title, 50, 700, 1, 1.0, 1.0, Gosu::Color::RED)
            @font.draw_text(albums[i].artist, 50, 730, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)
            draw_rect(albums[i].artwork.dim.leftX - 3, albums[i].artwork.dim.topY - 3, albums[i].artwork.bmp.width + 6, albums[i].artwork.bmp.height + 6, Gosu::Color::WHITE, 0)
          end
        end
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
  	@font.draw_text(title, leftX, topY, 1, 1.1, 1.1, Gosu::Color::AQUA)
  end

  def display_tracks(album)
    id = 1
    album.tracks.each do |track|
      display_track(id.to_s + "." + track.name, track.dim.leftX, track.dim.topY)
      id += 1
    end
  end 

  def sort
    @y_array = []
    @g_array = []
    
    for i in 0...@albums.length
      year_array_t = @albums[i].year
      @y_array << year_array_t
      genre_array_t = @albums[i].genre
      @g_array << genre_array_t
    end 

    @y_array = @y_array.uniq
    @g_array = @g_array.uniq

    y_pos = 50
    @year_array = []

    for i in 0...@y_array.length
      a = Text_button.new(@y_array[i], 740, y_pos)
      @year_array << a
      y_pos += 100
    end

    y_pos = 50
    @genre_array = []

    for i in 0...@g_array.length
      a = Text_button.new(@g_array[i], 740, y_pos)
      @genre_array << a
      y_pos += 100
    end
  end

  def sort_year(albums) 
    if @year_sort == true && @menu1 == true
      albums.each do |album|
        album.artwork.bmp.draw(album.artwork.dim.leftX, album.artwork.dim.topY , z = 1)
        if area_hovered(album.artwork.dim.leftX, album.artwork.dim.topY, album.artwork.dim.rightX, album.artwork.dim.bottomY) 
          @font_b.draw_text(album.title, 50, 700, 1, 1.0, 1.0, Gosu::Color::RED)
          @font.draw_text(album.artist, 50, 730, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)
          draw_rect(album.artwork.dim.leftX - 3, album.artwork.dim.topY - 3, album.artwork.bmp.width + 6, album.artwork.bmp.height + 6, Gosu::Color::WHITE, 0)
        end
      end
    end
  end

  def sort_genre(albums) 
    if @genre_sort == true && @menu1 == true
      albums.each do |album|
        album.artwork.bmp.draw(album.artwork.dim.leftX, album.artwork.dim.topY , z = 1)
        if area_hovered(album.artwork.dim.leftX, album.artwork.dim.topY, album.artwork.dim.rightX, album.artwork.dim.bottomY) 
          @font_b.draw_text(album.title, 50, 700, 1, 1.0, 1.0, Gosu::Color::RED)
          @font.draw_text(album.artist, 50, 730, 1, 1.0, 1.0, Gosu::Color::FUCHSIA)
          draw_rect(album.artwork.dim.leftX - 3, album.artwork.dim.topY - 3, album.artwork.bmp.width + 6, album.artwork.bmp.height + 6, Gosu::Color::WHITE, 0)
        end
      end
    end
  end

  def playTrack(track, album)
    @song = Gosu::Song.new(album.tracks[track].location)
    @song.play(false)
  end

  def draw_UI
    if @menu1 
      @exit = Text_button.new("<<EXIT TO MENU", 375, 840)
      if area_hovered(@exit.dim.leftX, @exit.dim.topY, @exit.dim.rightX, @exit.dim.bottomY)
        @font.draw_text(@exit.text, @exit.dim.leftX - 2, @exit.dim.topY - 2, 2, 1.1, 1.1, Gosu::Color::YELLOW)
      else
        @font.draw_text(@exit.text, @exit.dim.leftX, @exit.dim.topY, 2, 1, 1, Gosu::Color::YELLOW)
      end
      draw_quad(0, 765, 0x88ffffff, 0, 900, 0x88ffffff, 1600, 765, 0x88ffffff, 1600, 900, 0x88ffffff, 1)
      if (@menu1 && !@song) || (@song && @song.paused?)
        if area_hovered(PLAY.dim.leftX, PLAY.dim.topY, PLAY.dim.rightX, PLAY.dim.bottomY)
          PLAY.bmp.draw(PLAY.dim.leftX - 2, PLAY.dim.topY - 2, 2, 1.1, 1.1)
        else
          PLAY.bmp.draw(PLAY.dim.leftX, PLAY.dim.topY, 2)
        end
      elsif @menu1 
          if @song != nil 
            if !@song.paused? 
              if area_hovered(PLAY.dim.leftX, PLAY.dim.topY, PLAY.dim.rightX, PLAY.dim.bottomY)
                PAUSE.bmp.draw(PAUSE.dim.leftX - 2, PAUSE.dim.topY - 2, 2, 1.1, 1.1)
              else
                PAUSE.bmp.draw(PAUSE.dim.leftX, PAUSE.dim.topY, 2)
              end
            end
          end
      end
      if area_hovered(FWD.dim.leftX, FWD.dim.topY, FWD.dim.rightX, FWD.dim.bottomY)
        FWD.bmp.draw(FWD.dim.leftX - 2, FWD.dim.topY - 2, 2, 1.1, 1.1)
      else
        FWD.bmp.draw(FWD.dim.leftX, FWD.dim.topY, 2)
      end
      if area_hovered(PREV.dim.leftX, PREV.dim.topY, PREV.dim.rightX, PREV.dim.bottomY)
        PREV.bmp.draw(PREV.dim.leftX - 2, PREV.dim.topY - 2, 2, 1.1, 1.1)
      else
        PREV.bmp.draw(PREV.dim.leftX, PREV.dim.topY, 2)
      end
      if @loop
        LOOP.bmp.draw(LOOP.dim.leftX, LOOP.dim.topY, 2)
      elsif @autoplay
        AUTOPLAY.bmp.draw(AUTOPLAY.dim.leftX, AUTOPLAY.dim.topY, 2)
      else 
        ONE.bmp.draw(ONE.dim.leftX, ONE.dim.topY, 2)
      end
      VOL.bmp.draw(VOL.dim.leftX, VOL.dim.topY, 2)
      draw_rect(1074, 820, 200, 20, Gosu::Color::BLACK, 2)
      UP.bmp.draw(UP.dim.leftX, UP.dim.topY, 2, 0.7, 0.7)
      DOWN.bmp.draw(DOWN.dim.leftX, DOWN.dim.topY, 2, 0.7, 0.7)
      if @song
        draw_rect(1074, 820, (@song.volume * 200).to_i, 20, Gosu::Color::RED, 2)
      end
      @year_sort_b = Text_button.new("Sort by year", 1370, 780)
      @font.draw_text(@year_sort_b.text, @year_sort_b.dim.leftX, @year_sort_b.dim.topY, 2, 1, 1, Gosu::Color::BLACK)
      @genre_sort_b = Text_button.new("Sort by genre", 1370, 810)
      @font.draw_text(@genre_sort_b.text, @genre_sort_b.dim.leftX, @genre_sort_b.dim.topY, 2, 1, 1, Gosu::Color::BLACK)
      @stop_sort = Text_button.new("No sort", 1370, 840)
      @font.draw_text(@stop_sort.text, @stop_sort.dim.leftX, @stop_sort.dim.topY, 2, 1, 1, Gosu::Color::BLACK)
      if @year_sort
        @font.draw_text("Year:", 740, 20, 2, 1, 1, Gosu::Color::WHITE)
        for i in 0...@year_array.length
          @font.draw_text(@year_array[i].text, @year_array[i].dim.leftX, @year_array[i].dim.topY, 2, 1, 1, Gosu::Color::GREEN)
        end
      end
      if @genre_sort
        @font.draw_text("Genre:", 740, 20, 2, 1, 1, Gosu::Color::WHITE)
        for i in 0...@genre_array.length
          @font.draw_text(GENRE_NAMES[@genre_array[i].text], @genre_array[i].dim.leftX, @genre_array[i].dim.topY, 2, 1, 1, Gosu::Color::GREEN)
        end
      end
    end
    if @menu1 && !@year_sort && !@genre_sort
      draw_rect(574, 700, 148, 26, Gosu::Color::BLACK, 1)
      if !@next_page
        @page = Text_button.new("NEXT PAGE>>", 575, 700)
        @font.draw_text(@page.text, @page.dim.leftX, @page.dim.topY, 2, 1, 1, Gosu::Color::YELLOW)
      elsif @next_page
        @page = Text_button.new("<<PREV PAGE", 575, 700)
        @font.draw_text(@page.text, @page.dim.leftX, @page.dim.topY, 2, 1, 1, Gosu::Color::YELLOW)
      end
    end
  end

  def main_menu
    if !@menu1 
      @font_b.draw("Welcome to the HD Music Player!", 580, 100, 1, 1, 1, Gosu::Color::WHITE)
      draw_rect(0, 170, 1600, 100, 0x88ffffff, 1)
      if area_hovered(0, 170, 1600, 270)
        @font_b.draw("ALBUM", 772.5, 210, 2, 1.0, 1.0, Gosu::Color::BLACK)
      else
        @font.draw("ALBUM", 772.5, 210, 2, 1.0, 1.0, Gosu::Color::BLACK)
      end
      draw_rect(0, 300, 1600, 100, 0x88ffffff, 1)
      if area_hovered(0, 300, 1600, 400)
        @font_b.draw("HELP", 780, 340, 2, 1.0, 1.0, Gosu::Color::BLACK)
      else
        @font.draw("HELP", 780, 340, 2, 1.0, 1.0, Gosu::Color::BLACK)
      end
      draw_rect(0, 430, 1600, 100, 0x88ffffff, 1)
      if area_hovered(0, 430, 1600, 530)
        @font_b.draw("CHANGE BACKGROUND", 670, 470, 2, 1.0, 1.0, Gosu::Color::BLACK)
      else
        @font.draw("CHANGE BACKGROUND", 670, 470, 2, 1.0, 1.0, Gosu::Color::BLACK)
      end
    end
  end 

  def help_menu
    if @menu2 == true
      help_page = ArtWork.new("images/help.jpg", 0, 560)
      help_page.bmp.draw(help_page.dim.leftX, help_page.dim.topY, 2)
    end
  end

  def bg_menu
    if @menu3 == true
      @bg.draw(128, 600, 1, 0.2, 0.2)
      @bg1.draw(469, 600, 1, 0.2, 0.2)
      @bg2.draw(810, 600, 1, 0.2, 0.2)
      @bg3.draw(1152, 600, 1, 0.2, 0.2)
    end
  end

  def draw_current_playing
    if @current_album != nil && @year_sort == false && @genre_sort == false
      @font.draw_text("Now playing:", 50, 780, 2, 1, 1, Gosu::Color::BLACK)
      @font.draw_text("Album:", 50, 810, 2, 1, 1, Gosu::Color::BLACK)
      @font.draw_text("Artist:", 50, 840, 2, 1, 1, Gosu::Color::BLACK)
      @font.draw_text(@albums[@current_album].tracks[@current_track].name, 190, 780, 2, 1, 1, Gosu::Color::BLUE)
      @font.draw_text(@albums[@current_album].title, 130, 810, 2, 1, 1, Gosu::Color::RED)
      @font.draw_markup(@albums[@current_album].artist, 116, 840, 2, 1, 1, Gosu::Color::FUCHSIA)
    elsif @sorted_albums != nil && ( @year_sort == true || @genre_sort == true ) && @current_album != nil 
      @font.draw_text("Now playing:", 50, 780, 2, 1, 1, Gosu::Color::BLACK)
      @font.draw_text("Album:", 50, 810, 2, 1, 1, Gosu::Color::BLACK)
      @font.draw_text("Artist:", 50, 840, 2, 1, 1, Gosu::Color::BLACK)
      @font.draw_text(@sorted_albums[@current_album].tracks[@current_track].name, 190, 780, 2, 1, 1, Gosu::Color::BLUE)
      @font.draw_text(@sorted_albums[@current_album].title, 130, 810, 2, 1, 1, Gosu::Color::RED)
      @font.draw_markup(@sorted_albums[@current_album].artist, 116, 840, 2, 1, 1, Gosu::Color::FUCHSIA)
    end
  end
      
	def update
    if @autoplay == true && @song != nil && @menu1 == true 
      if @song.playing? == false && @current_album != nil && @song.paused? == false
        if @current_track < @albums[@current_album].tracks.length - 1
          @current_track += 1 
        else
          @current_track = 0
        end
        playTrack(@current_track, @albums[@current_album])
      end
    end 
    if !@menu1
      @current_track = nil
      @current_album = nil
      @autoplay = false
      @loop = false
      @ui = false
    end
    if @song != nil
      @song.volume = @volume 
    end 
  end
  
	def draw
    if @lol
      @font.draw(@genre_array[1].text, 100, 100, 1, 1, 5, Gosu::Color::RED)
    end
    if @case == 0
      @bg.draw(0, 0, -3)
    elsif @case == 1
      @bg1.draw(0, 0, -2)
    elsif @case == 2
      @bg2.draw(0, 0, -1)
    elsif @case == 3
      @bg3.draw(0, 0, 0)
    end
    main_menu()
    help_menu()
    bg_menu()
    draw_UI()
    draw_current_playing()
    draw_albums(@albums)
    if @sorted_albums != nil
      if @year_sort == true 
        sort_year(@sorted_albums)
      elsif @genre_sort == true
        sort_genre(@sorted_albums)
      end
    end
    if @current_album != nil && @menu1 && !@year_sort && !@genre_sort
			display_tracks(@albums[@current_album])
			draw_rect(@albums[@current_album].tracks[@current_track].dim.leftX - 10, @albums[@current_album].tracks[@current_track].dim.topY, 5, @font.height(), Gosu::Color::BLUE, z = 1)
    end
    if (@year_sort || @genre_sort) && @current_album != nil
      display_tracks(@sorted_albums[@current_album])
			draw_rect(@sorted_albums[@current_album].tracks[@current_track].dim.leftX - 10, @sorted_albums[@current_album].tracks[@current_track].dim.topY, 5, @font.height(), Gosu::Color::BLUE, z = 1)
    end
    # easier for locating coordinate for albums and tracks x/y location
    if @debug
      @font.draw_text("Mouse X: #{mouse_x}", 0, 0, 3, 0.7, 0.7, Gosu::Color::WHITE)
      @font.draw_text("Mouse Y: #{mouse_y}", 0, 20, 3, 0.7, 0.7, Gosu::Color::WHITE)
      @font.draw_text("FPS: #{Gosu.fps}", 300, 0, 3, 0.7, 0.7, Gosu::Color::WHITE)
    end
	end

 	def needs_cursor?; true; end

	def button_down(id)
		case id
      when Gosu::KB_F2
        if !@debug
          @debug = true
        else
          @debug = false
        end
      when Gosu::KB_Q 
        @menu1 = false
        if @song
          @song.stop 
        end
      when Gosu::KB_ESCAPE
        close
      when Gosu::KB_SPACE
        if @song != nil
          if @song.paused?
            @song.play(false)
          elsif @song.playing?
            @song.pause
          end
        end
      when Gosu::KB_LEFT
        if @song != nil
          @volume -= 0.1
        end
      when Gosu::KB_RIGHT
        if @song != nil
          @volume += 0.1
        end
      when Gosu::KB_UP
        if @current_album != nil 
          if @year_sort == true or @genre_sort == true
            if @current_track > 0
              @current_track -= 1
            else 
              @current_track = @sorted_albums[@current_album].tracks.length - 1
            end
            playTrack(@current_track, @sorted_albums[@current_album])
          else            
            if @current_track > 0
              @current_track -= 1
            else 
              @current_track = @albums[@current_album].tracks.length - 1
            end
            playTrack(@current_track, @albums[@current_album])
          end
        end
      when Gosu::KB_DOWN
        if @current_album != nil 
          if @year_sort == true or @genre_sort == true
            if @current_track < @sorted_albums[@current_album].tracks.length - 1
              @current_track += 1
            else 
              @current_track = 0
            end
            playTrack(@current_track, @sorted_albums[@current_album])
          else
            if
              if @current_track < @albums[@current_album].tracks.length - 1
                @current_track += 1
              else 
                @current_track = 0
              end
              playTrack(@current_track, @albums[@current_album])
            end
          end
        end
      when Gosu::KB_L
        if @song && @song.playing? && @loop == false && @autoplay == false
          @song.play(true)
          @loop = true
        elsif @song && @song.playing? && @loop == true && @autoplay == false 
          @song.play(false)
          @loop = false
          @autoplay = true
        elsif @song && @song.playing? && @loop == false && @autoplay == true
          @autoplay = false
        end
      when Gosu::MsLeft 
        if @menu3
          if area_hovered(128, 600, 128 + 320, 600 + 180)
            @case = 0
          elsif area_hovered(469, 600, 469 + 320, 600 + 180)
            @case = 1
          elsif area_hovered(810, 600, 810 + 320, 600 + 180)
            @case = 2
          elsif area_hovered(1152, 600, 1152 + 320, 600 + 180)
            @case = 3
          end
        end
        if @menu1
          if @year_sort == false && @genre_sort == false && @current_album != nil
            for id in 0...@albums[@current_album].tracks.length
              if area_hovered(@albums[@current_album].tracks[id].dim.leftX, @albums[@current_album].tracks[id].dim.topY, @albums[@current_album].tracks[id].dim.rightX, @albums[@current_album].tracks[id].dim.bottomY)
                playTrack(id, @albums[@current_album])
                @current_track = id
              end
            end
          end
          if !@next_page
            if @year_sort == false && @genre_sort == false
              for id in 0...@albums.length - 2
                if area_hovered(@albums[id].artwork.dim.leftX, @albums[id].artwork.dim.topY, @albums[id].artwork.dim.rightX, @albums[id].artwork.dim.bottomY)
                  @current_album = id
                  @current_track = 0
                  @song = nil
                  playTrack(0, @albums[@current_album])
                end
              end
            end
          elsif @next_page
            if @year_sort == false && @genre_sort == false
              for id in 4..@albums.length - 1
                if area_hovered(@albums[id].artwork.dim.leftX, @albums[id].artwork.dim.topY, @albums[id].artwork.dim.rightX, @albums[id].artwork.dim.bottomY)
                  @current_album = id
                  @current_track = 0
                  @song = nil
                  playTrack(0, @albums[@current_album])
                end
              end
            end
          end

        if area_hovered(ONE.dim.leftX, ONE.dim.topY, ONE.dim.rightX, ONE.dim.bottomY)
          if @song && @song.playing? && @loop == false && @autoplay == false
            @song.play(true)
            @loop = true
          elsif @song && @song.playing? && @loop == true && @autoplay == false 
            @song.play(false)
            @loop = false
            @autoplay = true
          elsif @song && @song.playing? && @loop == false && @autoplay == true
            @autoplay = false
          end
        end
        if area_hovered(PLAY.dim.leftX, PLAY.dim.topY, PLAY.dim.rightX, PLAY.dim.bottomY)
          if @song && @song.paused?
            @song.play(false)
          elsif @song && @song.playing?
            @song.pause
          end
        end
        if area_hovered(DOWN.dim.leftX, DOWN.dim.topY, DOWN.dim.rightX, DOWN.dim.bottomY)
          if @song != nil
            @volume -= 0.1
          end
        end
        if area_hovered(UP.dim.leftX, UP.dim.topY, UP.dim.rightX, UP.dim.bottomY)
          if @song != nil
            @volume += 0.1
          end
        end
        if area_hovered(PREV.dim.leftX, PREV.dim.topY, PREV.dim.rightX, PREV.dim.bottomY)
          if @current_album != nil 
            if @current_track > 0
              @current_track -= 1
            else 
              @current_track = @albums[@current_album].tracks.length - 1
            end
            playTrack(@current_track, @albums[@current_album])
          end
        end
        if area_hovered(FWD.dim.leftX, FWD.dim.topY, FWD.dim.rightX, FWD.dim.bottomY)
          if @current_album != nil 
            if @current_track < @albums[@current_album].tracks.length - 1
              @current_track += 1
            else 
              @current_track = 0
            end
            playTrack(@current_track, @albums[@current_album])
          end
        end
        if area_hovered(@exit.dim.leftX, @exit.dim.topY, @exit.dim.rightX, @exit.dim.bottomY)
          @menu1 = false
          @main = true
          @menu2 = false
          if @song
            @song.stop 
          end
        end
        if area_hovered(@year_sort_b.dim.leftX, @year_sort_b.dim.topY, @year_sort_b.dim.rightX, @year_sort_b.dim.bottomY)
          @year_sort = true
          @genre_sort = false
          @current_album = nil
          @current_track = nil
          if @song
            @song.stop
          end
        end
        if area_hovered(@genre_sort_b.dim.leftX, @genre_sort_b.dim.topY, @genre_sort_b.dim.rightX, @genre_sort_b.dim.bottomY)
          @genre_sort = true
          @year_sort = false
          @current_album = nil
          @current_track = nil
          if @song
            @song.stop
          end
        end
        if area_hovered(@stop_sort.dim.leftX, @stop_sort.dim.topY, @stop_sort.dim.rightX, @stop_sort.dim.bottomY)
          @year_sort = false
          @genre_sort = false
          @current_album = nil
          @current_track = nil
          if @song
            @song.stop
          end
        end
        if area_hovered(@page.dim.leftX, @page.dim.topY, @page.dim.rightX, @page.dim.bottomY)
          if !@next_page
            @next_page = true
          elsif @next_page
            @next_page = false
          end
        end
      end

      if @year_sort == true && @menu1 == true 
        sort()
        for i in 0...@year_array.length
          if area_hovered(@year_array[i].dim.leftX, @year_array[i].dim.topY, @year_array[i].dim.rightX, @year_array[i].dim.bottomY)
            if @song != nil 
              @song.stop 
            end
            @current_album = nil
            @sorted_albums = []
            for j in 0...@albums.length
              if @albums[j].year.to_s == @year_array[i].text
                @sorted_albums << @albums[j]
                @temp_year_sort = true
              end
            end
          end
        end
        if @sorted_albums != nil
          for id in 0...@sorted_albums.length
            if area_hovered(@sorted_albums[id].artwork.dim.leftX, @sorted_albums[id].artwork.dim.topY, @sorted_albums[id].artwork.dim.rightX, @sorted_albums[id].artwork.dim.bottomY)
              @current_album = id
              @current_track = 0
              @song = nil
              playTrack(0, @sorted_albums[@current_album])
            end
          end
          if @current_album != nil 
            for id in 0...@sorted_albums[@current_album].tracks.length
              if area_hovered(@sorted_albums[@current_album].tracks[id].dim.leftX, @sorted_albums[@current_album].tracks[id].dim.topY, @sorted_albums[@current_album].tracks[id].dim.rightX, @sorted_albums[@current_album].tracks[id].dim.bottomY)
                playTrack(id, @sorted_albums[@current_album])
                @current_track = id
              end
            end
          end
        end
      end

      if @genre_sort == true && @menu1 == true 
        sort()
        for i in 0...@genre_array.length
          if area_hovered(@genre_array[i].dim.leftX, @genre_array[i].dim.topY, @genre_array[i].dim.rightX + 30, @genre_array[i].dim.bottomY)
            if @song != nil 
              @song.stop
            end
            @current_album = nil
            @sorted_albums = []            
            for j in 0...@albums.length
              if @albums[j].genre.to_s == @genre_array[i].text.to_s
                @sorted_albums << @albums[j]
                @temp_genre_sort = true
              end
            end
          end
        end
        if @sorted_albums != nil
          for id in 0...@sorted_albums.length
            if area_hovered(@sorted_albums[id].artwork.dim.leftX, @sorted_albums[id].artwork.dim.topY, @sorted_albums[id].artwork.dim.rightX, @sorted_albums[id].artwork.dim.bottomY)
              @current_album = id
              @current_track = 0
              @song = nil
              playTrack(0, @sorted_albums[@current_album])
            end
          end
          if @current_album != nil
            for id in 0...@sorted_albums[@current_album].tracks.length
              if area_hovered(@sorted_albums[@current_album].tracks[id].dim.leftX, @sorted_albums[@current_album].tracks[id].dim.topY, @sorted_albums[@current_album].tracks[id].dim.rightX, @sorted_albums[@current_album].tracks[id].dim.bottomY)
                playTrack(id, @sorted_albums[@current_album])
                @current_track = id
              end
            end
          end
        end
      end
            
      if area_hovered(0, 170, 1600, 270)
        if !@menu1 && !@menu2 && !@menu3
          @menu1 = true
        end
      end
      if area_hovered(0, 300, 1600, 400)
        if !@menu1 && !@menu2 && !@menu3 
          @menu2 = true
        elsif @menu2 
          @menu2 = false
        end
      end
      if area_hovered(0, 430, 1600, 530)
        if !@menu1 && !@menu2 && !@menu3
          @menu3 = true
        elsif @menu3
          @menu3 = false
        end
      end
    end   
	end

end

MusicPlayerMain.new.show if __FILE__ == $0
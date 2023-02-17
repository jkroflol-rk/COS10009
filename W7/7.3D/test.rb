#this is a test file to run some code.
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
    @temp_year_sort = false
    @temp_genre_sort = false
    @current_album = nil
    @current_track = nil
    if @song
      @song.stop
    end
  end
  if area_hovered(@stop_sort.dim.leftX, @stop_sort.dim.topY, @stop_sort.dim.rightX, @stop_sort.dim.bottomY)
    @year_sort = false
    @genre_sort = false
    @temp_year_sort = false
    @temp_genre_sort = false
    @current_album = nil
    @current_track = nil
    if @song
      @song.stop
    end
  end
require "gosu";
require "./settings";

class Scrollbar
    attr_writer(:content_height);
    attr_accessor(:offset); ###########

    def initialize(viewport_topleft_x, viewport_topleft_y, viewport_width, viewport_height, content_height)
        @viewport_topleft_x = viewport_topleft_x;
        @viewport_topleft_y = viewport_topleft_y;
        @viewport_width = viewport_width;
        @viewport_height = viewport_height;
        @content_height = content_height;
        @offset = 0;
        @scrollbar_focused = false;
        @mouse_click_y = 0;
    end    

	def calculate_offset_y()
		offset_y_min = @viewport_topleft_y + @viewport_height - @content_height;
		offset_y_max = @viewport_topleft_y;
		return offset_y_min + (offset_y_max - offset_y_min) * (1 - @offset);
	end

    def to_top()
        @offset = 0;
    end

    def draw()
        scale = @viewport_height.to_f() / @content_height;
        if (scale >= 1)
            return;
        end
        Gosu.draw_rect(@viewport_topleft_x + @viewport_width - 5, @viewport_topleft_y + @offset * @viewport_height * (1 - scale), 5, scale * @viewport_height, Settings::HIGHLIGHT_COLOR, Settings::ZOrder::LIB_UNHIDEABLE);
    end

    def ms_middle_down(mouse_x, mouse_y)
        if (!mouse_over_viewport(mouse_x, mouse_y))
            return;
        end
        if (@content_height <= @viewport_height)
            return;
        end
        @offset = (@offset + 0.1).clamp(0, 1);
    end

    def ms_middle_up(mouse_x, mouse_y)
        if (!mouse_over_viewport(mouse_x, mouse_y))
            return;
        end
        @offset = (@offset - 0.1).clamp(0, 1);
    end

    def ms_left_down(mouse_x, mouse_y)
        if (mouse_over_scrollbar(mouse_x, mouse_y))
            @scrollbar_focused = true;
            @mouse_click_y = mouse_y;
        end
    end

    def ms_left_up()
        @scrollbar_focused = false;
    end

    def update(mouse_y)
        if (!@scrollbar_focused)
            return;
        end
        @offset = (@offset + (mouse_y - @mouse_click_y).to_f() / @viewport_height * Settings::SCROLLBAR_SENSITIVITY).clamp(0, 1);
        @mouse_click_y = mouse_y;
    end

    def button_down(id, mouse_x, mouse_y)
        case (id)
        when Gosu::MS_LEFT
            ms_left_down(mouse_x, mouse_y);
        when Gosu::MS_WHEEL_DOWN
            ms_middle_down(mouse_x, mouse_y);
        when Gosu::MS_WHEEL_UP
            ms_middle_up(mouse_x, mouse_y);
        end
    end

    def button_up(id)
        if (id == Gosu::MS_LEFT)
            ms_left_up();
        end
    end

    def mouse_over_scrollbar(mouse_x, mouse_y)
        scale = @viewport_height.to_f() / @content_height;
        if (scale >= 1)
            return false;
        end
        return mouse_x >= @viewport_topleft_x + @viewport_width - 5 && mouse_x <= @viewport_topleft_x + @viewport_width && mouse_y >= @viewport_topleft_y + @offset * @viewport_height * (1 - scale) && mouse_y <= @viewport_topleft_y + @offset * @viewport_height * (1 - scale) + scale * @viewport_height;
    end

    def mouse_over_viewport(mouse_x, mouse_y)
        return mouse_x >= @viewport_topleft_x && mouse_x <= @viewport_topleft_x + @viewport_width && mouse_y >= @viewport_topleft_y && mouse_y <= @viewport_topleft_y + @viewport_height;
    end
end
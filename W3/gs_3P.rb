require 'rubygems'
require 'gosu'
require './circle'

module ZOrder
  BACKGROUND, MIDDLE, TOP = *0..2
end

class DemoWindow < Gosu::Window
  def initialize
    super(640, 400, false)
    self.caption = "3P task"
  end

  def draw
    draw_quad(0, 0, Gosu::Color::BLACK, 640, 0, Gosu::Color::BLACK, 0, 400, Gosu::Color::WHITE, 640, 400, Gosu::Color::WHITE, ZOrder::BACKGROUND)
    draw_quad(0, 350, Gosu::Color::GREEN, 640, 350, Gosu::Color::GREEN, 0, 400, Gosu::Color::GREEN, 640, 400, Gosu::Color::GREEN, ZOrder::MIDDLE)
    draw_triangle(320, 100, Gosu::Color::GREEN, 200, 200, Gosu::Color::GREEN, 440, 200, Gosu::Color::GREEN, ZOrder::MIDDLE, mode=:default)
    Gosu.draw_rect(300, 250, 40, 100, Gosu::Color::RED, ZOrder::TOP, mode=:default)
    Gosu.draw_rect(220, 200, 200, 150, Gosu::Color::BLUE, ZOrder::MIDDLE, mode=:default)
    
    img2 = Gosu::Image.new(Circle.new(50))
    img2.draw(520, 10, ZOrder::TOP, 1.0, 1.0, Gosu::Color::YELLOW)
    
  end
end

DemoWindow.new.show
require "cray"
require "cray_raygui"

LibRay.init_window 800, 600, "Test window"
LibRay.set_target_fps 60

r = LibRay

pressed = false


rect = LibRay::Rectangle.new(
	x: 33,
	y: 33,
	width: 100,
	height: 25
)

win = LibRay::Rectangle.new(
	x:200,
	y:10,
	width: 100,
	height: 100
)

class ColorSelector
  @colors : Iterator(LibRay::Color)  
  def initialize
    @colors = [LibRay::BLUE, LibRay::GREEN, LibRay::RED].each.cycle
  end
    
  def next
   	r = @colors.next
   	if r.is_a? LibRay::Color
     	r
     else 
       LibRay::BLACK
   	end
  end
end

color = ColorSelector.new
bg = color.next

def draw_circle
	LibRay.draw_circle LibRay.get_mouse_x, LibRay.get_mouse_y, 3, LibRay::BLUE
end

while !r.window_should_close?
  r.begin_drawing
	r.clear_background bg
	r.draw_fps 90, 90
	draw_circle
	
	pressed = LibRaygui.button rect , "Hello World"
	bg = color.next if pressed


	w = LibRaygui.window_box win, "Yolo"
	if w
  	LibRay.draw_text "FOOBAR",  300, 300, 14, LibRay::RED
	end
	
  r.end_drawing
end

r.close_window

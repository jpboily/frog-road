# This class is an inspired by the Camera class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class Camera
  attr_accessor :x, :y, :zoom

  def initialize
    @x, @y = $window.width / 2, $window.height / 2
    @zoom = 1.5
  end

  def target=(target)
    @target = target
  end

  def update
    # TODO - Update camera if level has a height bigger than the window
  end

  def to_s
    "FPS: #{Gosu.fps}. " <<
      "#{@x}:#{@y} @ #{'%.2f' % @zoom}. " <<
      'WASD to move, arrows to zoom.'
  end

  def viewport
    x0 = @x - ($window.width / 2)  / @zoom
    x1 = @x + ($window.width / 2)  / @zoom
    y0 = @y - ($window.height / 2) / @zoom
    y1 = @y + ($window.height / 2) / @zoom
    [x0, x1, y0, y1]
  end

end

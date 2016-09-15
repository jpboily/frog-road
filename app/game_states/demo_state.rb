# This class is an inspired by the DemoState class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class DemoState < PlayState
  attr_accessor :player

  def enter
    # Prevent reactivating HUD
  end

  def update
    super
    @score_display = ScoreDisplay.new(
      object_pool, 20)
  end

  def draw
    super
    @score_display.draw_top_right
  end

end

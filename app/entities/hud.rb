# This class is an inspired by the HUD class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class HUD
  attr_accessor :active

  def initialize(frog)
    @frog = frog
  end

  def player=(frog)
    @frog = frog
  end

  def update
  end

  def health_image
    if @lives.nil? || @frog.lives.lives != @lives
      @lives = @frog.lives.lives
      @health_image = Gosu::Image.from_text(
          $window, "Health: #{@lives} lives", Utils.main_font, 20) # TODO use hearth image for lives
    end
    @health_image
  end

  def stats_image
    stats = @frog.input.stats
    if @stats_image.nil? || stats.changed_at <= Gosu.milliseconds
      @stats_image = Gosu::Image.from_text(
        $window, "Score: #{stats.score}", Utils.main_font, 20)
    end
    @stats_image
  end

  def draw
    offset = 20
    health_image.draw(20, offset, 1000)
    stats_image.draw(20, offset += 30, 1000)
  end
end

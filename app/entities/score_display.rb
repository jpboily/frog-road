# This class is an inspired by the ScoreDisplay class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class ScoreDisplay
  def initialize(frog, font_size=30)
    @frog = frog
    @font_size = font_size
    stats = @frog.input.stats
    create_stats_image(stats)
  end

  def create_stats_image(stats)
    @stats_image = Gosu::Image.from_text(
      $window, stats.to_s, Utils.main_font, @font_size)
  end

  def draw
    @stats_image.draw(
      $window.width / 2 - @stats_image.width / 2,
      $window.height / 4 + 30,
      1000)
  end

  def draw_top_right
    @stats_image.draw(
      $window.width - @stats_image.width - 20,
      20,
      1000)
  end
end

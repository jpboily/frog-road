# This class is an inspired by the Stats class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class Stats
  # TODO - Add stats for completed levels
  attr_reader :score, :changed_at
  def initialize()
    @score = 0
    changed
  end

  def inscrease_score(points)
    @score += points
  end

  def to_s
    "Score: #{@score}"
    # "[kills: #{@kills}, " \
    #   "deaths: #{@deaths}, " \
    #   "shots: #{@shots}, " \
    #   "damage: #{damage}, " \
    #   "damage_dealt: #{damage_dealt}]"
  end

  private

  def changed
    @changed_at = Gosu.milliseconds
  end
end

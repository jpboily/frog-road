# This class is an inspired by the Stats class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class Stats
  # TODO - Add stats for completed levels
  attr_reader :name, :score, :changed_at, :high_score
  def initialize(name)
    @score = 0
    @high_score = 0
    @name = name # Might be useful to keep high score leaderboard
    changed
  end

  def inscrease_score(points)
    @score += points
    @high_score = @score if @score > @high_score
  end

  def to_s
    "Score: " \
    "#{@name}: #{@score}"
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

# This class is an inspired by the Tank class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class Frog < GameObject
  attr_accessor :sounds, :physics, :graphics, :health, :input

  def initialize(object_pool, input)
    x, y = object_pool.map.spawn_point
    super(object_pool, x, y)
    @input = input
    @input.control(self)
    # @physics = FrogPhysics.new(self, object_pool)
    # @sounds = FrogSounds.new(self, object_pool)
    @health = FrogHealth.new(self, object_pool)
    # @graphics = FrogGraphics.new(self)
  end

  def box
    @physics.box
  end

  def on_collision(object)
    return unless object
    # Avoid recursion
    if object.class == Frog
      # Inform AI about hit
      object.input.on_collision(object)
    else
      # Call only on non-Frogs to avoid recursion
      object.on_collision(self)
    end
  end

  def to_s
    "Frog [#{@health.health}@#{@x}:#{@y}@#{@physics.speed.round(2)}px/tick]#{@input.stats}"
  end

end

class Frog < GameObject
  attr_accessor :moving, :direction,
                :sounds, :physics, :life, :graphics, :player, :safe

  def initialize(object_pool)
    x, y = object_pool.map.spawn_point
    super(object_pool, x, y)
    @physics = FrogPhysics.new(self, object_pool)
    @sounds = FrogSounds.new(self, object_pool)
    @life = FrogLife.new(self, object_pool)
    @graphics = FrogGraphics.new(self)
    @direction = 0
    @safe = false
  end

  def box
    # @physics.box
  end

  def on_collision(object)
    return unless object
    # Avoid recursion
    if object.class == Foe # or is water # TODO - Create Foe class (car or animal)
      @life.kill
      @player.life.kill
    else
      # Call only on non-tanks to avoid recursion
      object.on_collision(self)
    end
  end

  def safe?
    @safe
  end

  def on_arrival
    @safe = true
  end
end

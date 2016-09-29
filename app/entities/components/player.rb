class Player < Component
  # Dark green
  NAME_COLOR = Gosu::Color.argb(0xee084408)
  attr_reader :stats

  def initialize(name, camera, object_pool)
    super(nil)
    @name = name
    @stats = Stats.new(name)
    @camera = camera
    @object_pool = object_pool
    @life = Life.new(self, object_pool, 3)
    control(Frog.new(object_pool))
  end

  def control(obj)
    self.object = obj
    obj.components << self
  end

  def update
    return respawn if object.life.dead? or object.safe?
    motion_buttons = [Gosu::KbUp, Gosu::KbDown, Gosu::KbLeft, Gosu::KbRight]

    if any_button_down?(*motion_buttons)
      object.moving = true
      object.physics.change_direction(
        change_angle(object.direction, *motion_buttons))
    else
      object.moving = false
    end
  end

  private

  def respawn
    return unless @life.dead? or object.safe?
    control(Frog.new(@object_pool))
    @camera.x, @camera.y = x, y
    PlayerSounds.respawn(object, @camera)
  end

  def any_button_down?(*buttons)
    buttons.each do |b|
      return true if Utils.button_down?(b)
    end
    false
  end

  def change_angle(previous_angle, up, down, right, left)
    if Utils.button_down?(up)
      angle = 0.0
    elsif Utils.button_down?(down)
      angle = 180.0
    elsif Utils.button_down?(left)
      angle = 90.0
    elsif Utils.button_down?(right)
      angle = 270.0
    end
    angle = (angle + 360) % 360 if angle && angle < 0
    (angle || previous_angle)
  end

end

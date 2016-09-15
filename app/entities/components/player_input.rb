# This class is an inspired by the PlayerInput class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class PlayerInput < Component
  attr_reader :stats

  def initialize(name, camera, object_pool)
    super(nil)
    @name = name
    @stats = Stats.new()
    @camera = camera
    @object_pool = object_pool
  end

  def control(obj)
    self.object = obj
    obj.components << self
  end

  def on_collision(with)
    # TODO - Kill Frog
    object.health.kill
  end

  def update
    # return respawn if object.health.dead?
    # d_x, d_y = @camera.target_delta_on_screen
    # atan = Math.atan2(($window.width / 2) - d_x - $window.mouse_x,
    #                   ($window.height / 2) - d_y - $window.mouse_y)
    # object.gun_angle = -atan * 180 / Math::PI
    # motion_buttons = [Gosu::KbW, Gosu::KbS, Gosu::KbA, Gosu::KbD]
    #
    # if any_button_down?(*motion_buttons)
    #   object.throttle_down = true
    #   object.physics.change_direction(
    #     change_angle(object.direction, *motion_buttons))
    # else
    #   object.throttle_down = false
    # end
    #
    # if Utils.button_down?(Gosu::MsLeft)
    #   object.shoot(*@camera.mouse_coords)
    # end
  end

  def draw(viewport)
  end

  private

  def respawn
    if object.health.should_respawn?
      object.health.restore
      object.move(*@object_pool.map.spawn_point)
      @camera.x, @camera.y = x, y
      PlayerSounds.respawn(object, @camera)
    end
  end

  def any_button_down?(*buttons)
    buttons.each do |b|
      return true if Utils.button_down?(b)
    end
    false
  end

end

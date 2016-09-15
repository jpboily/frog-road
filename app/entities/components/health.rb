class Health < Component
  attr_accessor :health

  def initialize(object, object_pool, health, explodes)
    super(object)
    @object_pool = object_pool
    @initial_health = @health = health
    @health_updated = true
  end

  # Might be useful to add powerups
  def increase(amount)
    @health = [@health + 25, @initial_health * 2].min
    @health_updated = true
  end

  def dead?
    @health < 1
  end

  def update
    update_image
  end

  def kill()
    if @health > 0
      @health_updated = true
      @health -= 1
      after_death() if dead?
    end
  end

  def draw(viewport)
    return unless draw?
    @image && @image.draw(
      x - @image.width / 2,
      y - object.graphics.height / 2 -
      @image.height, 100)
  end

  protected

  def draw?
    $debug
  end

  def update_image
    return unless draw?
    if @health_updated
      text = @health.to_s
      font_size = 18
      @image = Gosu::Image.from_text(
          $window, text,
          Gosu.default_font_name, font_size)
      @health_updated = false
    end
  end

  def after_death()
    object.mark_for_removal
  end
end

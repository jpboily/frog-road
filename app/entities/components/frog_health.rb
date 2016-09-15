class FrogHealth < Health
  RESPAWN_DELAY = 1000
  attr_accessor :health

  def initialize(object, object_pool)
    super(object, object_pool, 5, true)
  end

  def should_respawn?
    if @death_time && !dead?
      Gosu.milliseconds - @death_time > RESPAWN_DELAY
    end
  end

end

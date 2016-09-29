class Life
  attr_accessor :lives

  def initialize(object, object_pool, lives)
    @object_pool = object_pool
    @initial_lives = @lives = lives
    @life_updated = true
  end

  def restore
    @lives = @initial_lives
    @life_updated = true
  end

  def increase(amount)
    @lives += 1
    @life_updated = true
  end

  def dead?
    @lives < 1
  end

  def update
  end

  def kill
    if @lives > 0
      @life_updated = true
      @lives = [@lives - 1, 0].max
      after_death if dead?
    end
  end

  def draw(viewport)
  end

  protected

  def draw?
    $debug
  end

  def update_image
    return unless draw?
  end

  def after_death
    object.mark_for_removal
  end
end

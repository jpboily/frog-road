class FrogLife < Life
  attr_accessor :life
  def initialize(object, object_pool)
    super(object, object_pool, 1) # Each frog has its own life, but only one
  end
end
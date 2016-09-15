# This class is an inspired by the Component class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class Component
  attr_reader :object # better performance

  def initialize(game_object = nil)
    self.object = game_object
  end

  def update
    # override
  end

  def draw(viewport)
    # override
  end

  protected

  def object=(obj)
    if obj
      @object = obj
      obj.components << self
    end
  end

  def x
    @object.x
  end

  def y
    @object.y
  end
end

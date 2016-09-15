# This class is an inspired by the GameState class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class GameState

  def self.switch(new_state)
    $window.state && $window.state.leave
    $window.state = new_state
    new_state.enter
  end

  def enter
  end

  def leave
  end

  def draw
  end

  def update
  end

  def needs_redraw?
    true
  end

  def button_down(id)
  end
end

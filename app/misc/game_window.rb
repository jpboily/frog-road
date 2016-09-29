# This class is an inspired by the GameWindow class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class GameWindow < Gosu::Window
  attr_accessor :state

  def initialize
    # TODO - Set from configuration
    super((ENV['w'] || 1024).to_i,
          (ENV['h'] || 768).to_i,
          (ENV['fs'] ? true : false))
  end

  def update
    Utils.track_update_interval
    @state.update
  end

  def draw
    @state.draw
  end

  def needs_redraw?
    @state.needs_redraw?
  end

  def needs_cursor?
    Utils.update_interval > 200
  end

  def button_down(id)
    @state.button_down(id)
  end
end

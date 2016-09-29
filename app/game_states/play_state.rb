# This class is an inspired by the PlayState class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class PlayState < GameState
  attr_accessor :update_interval, :object_pool, :player

  def initialize
    @object_pool = ObjectPool.new(Map.bounding_box)
    @map = Map.new(@object_pool)
    @map.load_map_from_json('level-map.json')
    @camera = Camera.new
    @object_pool.camera = @camera
    @player = Player.new('Player', @camera, @object_pool)
  end

  def update
    StereoSample.cleanup
    @object_pool.update_all
    @camera.update
    # @hud.update
    update_caption
  end

  def draw
    cam_x = @camera.x
    cam_y = @camera.y
    off_x =  $window.width / 2 - cam_x
    off_y =  $window.height / 2 - cam_y
    viewport = @camera.viewport
    x1, x2, y1, y2 = viewport
    box = AxisAlignedBoundingBox.new(
          [x1 + (x2 - x1) / 2, y1 + (y2 - y1) / 2],
          [x1 - Map::TILE_SIZE, y1 - Map::TILE_SIZE])
    $window.translate(off_x, off_y) do
      zoom = @camera.zoom
      $window.scale(zoom, zoom, cam_x, cam_y) do
        @map.draw(viewport)
        @object_pool.objects.each do |o|
          o.draw(viewport)
        end
      end
    end
    # @hud.draw
  end

  def button_down(id)
    if id == Gosu::KbEscape
      pause = PauseState.instance
      pause.play_state = self
      GameState.switch(pause)
    end
    if id == Gosu::KbF1
      $debug = !$debug
    end
    if id == Gosu::KbF2
      toggle_profiling
    end
  end

  def leave
    StereoSample.stop_all
    if @profiling_now
      toggle_profiling
    end
    # @hud.active = false
  end

  def enter
    # @hud.active = true
  end

  private

  def create_player()
    # @frog = Frog.new(@object_pool,
    #   PlayerInput.new('Player', @camera, @object_pool))
    #
    # @hud = HUD.new(@frog)
  end

  def toggle_profiling
    require 'ruby-prof' unless defined?(RubyProf)
    if @profiling_now
      result = RubyProf.stop
      printer = RubyProf::FlatPrinter.new(result)
      printer.print(STDOUT, min_percent: 0.01)
      @profiling_now = false
    else
      RubyProf.start
      @profiling_now = true
    end
  end

  def update_caption
    now = Gosu.milliseconds
    if now - (@caption_updated_at || 0) > 1000
      # TODO - Set tile from config
      $window.caption = 'Frog Road. ' <<
        "[FPS: #{Gosu.fps}. "
      @caption_updated_at = now
    end
  end
end

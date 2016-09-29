# This class is an inspired by the Map class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class Map
  MAP_WIDTH = 11
  MAP_HEIGHT = 13
  TILE_SIZE = 32

  def self.bounding_box
    # We need to add the map position in the game window to the box since the
    # map can be smaller than the window
    center = [$window.width / 2, $window.height / 2]
    half_dimension = [center[0] + (MAP_WIDTH * TILE_SIZE) / 2,
                      center[1] + (MAP_HEIGHT * TILE_SIZE) / 2]
    AxisAlignedBoundingBox.new(center, half_dimension)
  end

  def self.offy(y1=0, map_height)
      off_y ||= ($window.height < map_height) ? y1 : -(($window.height - map_height) / 2).floor
  end

  def self.offx(x1=0, map_width)
    off_x ||= ($window.width < map_width) ? x1 : -(($window.width - map_width) / 2).floor
  end

  def initialize(object_pool)
    # TODO - Load level
    @object_pool = object_pool
    object_pool.map = self
  end

  def spawn_point()
    # TODO - Find spawn point from level info. For now, start at the bottom
    # of the map in the middle of the screen.
    box = Map.bounding_box
    cx, cy = box.center
    hx, hy = box.half_dimension
    dhy = (hy - cy).abs
    x = cx
    y = cy + dhy
    return [x-TILE_SIZE/2, y-TILE_SIZE]
  end

  def can_move_to?(x, y)
    tile_at?(x, y)
  end

  def draw(viewport)
    return unless @map

    x1, x2, y1, y2 = viewport
    off_x = Map.offx(x1, @map.width)
    off_y = Map.offy(y1, @map.height)
    @map.draw(off_x, off_y)
  end

  def load_map_from_json(map_file)
    @map = Gosu::Tiled.load_json($window, Utils.level_path(map_file))
  end

  def width()
    MAP_WIDTH * TILE_SIZE
  end

  def height()
    MAP_HEIGHT * TILE_SIZE
  end

  def tile_size()
    TILE_SIZE
  end

  private

  def tile_at?(x, y)
    box = Map.bounding_box
    return false if (x+TILE_SIZE > (box.half_dimension[0]))
    return false if (y+TILE_SIZE > (box.half_dimension[1]))
    Map.bounding_box.contains?([x, y])
  end

end

# This class is an inspired by the Map class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class Map
  MAP_WIDTH = 6
  MAP_HEIGHT = 4
  TILE_SIZE = 128

  def self.bounding_box
    center = [MAP_WIDTH * TILE_SIZE / 2,
              MAP_HEIGHT * TILE_SIZE / 2]
    half_dimension = [MAP_WIDTH * TILE_SIZE,
                      MAP_HEIGHT * TILE_SIZE]
    AxisAlignedBoundingBox.new(center, half_dimension)
  end

  def initialize(object_pool)
    # TODO - Load level
    @object_pool = object_pool
    object_pool.map = self
  end

  def spawn_point()
    # TODO - Find spawn point from level info. For now, start at the bottom
    # of the map in the middle of the screen.
    x = MAP_WIDTH * TILE_SIZE / 2
    y = MAP_HEIGHT * TILE_SIZE
    return [x, y]
  end

  def draw(viewport)
    viewport = viewport.map { |p| p / TILE_SIZE }
    x0, x1, y0, y1 = viewport.map(&:to_i)
    (x0-1..x1).each do |x|
      (y0-1..y1).each do |y|
        Gosu::Image.from_text(
                  $window, "#{x}:#{y}",
                  Utils.main_font, 15).draw(x, y, 0)
      end
    end
  end

  private

  def tile_at(x, y)
    t_x = ((x / TILE_SIZE) % TILE_SIZE).floor
    t_y = ((y / TILE_SIZE) % TILE_SIZE).floor
    row = @map[t_x]
    row ? row[t_y] : @water
  end

  def load_tiles
    # tiles = Gosu::Image.load_tiles(
    #   $window, Utils.texture_path('ground.png'),
    #   128, 128, true)
  end

  # def generate_map
  #   noises = Perlin::Noise.new(2)
  #   contrast = Perlin::Curve.contrast(
  #     Perlin::Curve::CUBIC, 2)
  #   map = {}
  #   MAP_WIDTH.times do |x|
  #     map[x] = {}
  #     MAP_HEIGHT.times do |y|
  #       n = noises[x * 0.1, y * 0.1]
  #       n = contrast.call(n)
  #       map[x][y] = choose_tile(n)
  #     end
  #   end
  #   map
  # end
  #
  # def generate_trees
  #   noises = Perlin::Noise.new(2)
  #   contrast = Perlin::Curve.contrast(
  #     Perlin::Curve::CUBIC, 2)
  #   trees = 0
  #   target_trees = rand(1500..1500)
  #   while trees < target_trees do
  #     x = rand(0..MAP_WIDTH * TILE_SIZE)
  #     y = rand(0..MAP_HEIGHT * TILE_SIZE)
  #     n = noises[x * 0.001, y * 0.001]
  #     n = contrast.call(n)
  #     if tile_at(x, y) == @grass && n > 0.5
  #       Tree.new(@object_pool, x, y, n * 2 - 1)
  #       trees += 1
  #     end
  #   end
  # end
  #
  # def generate_boxes
  #   boxes = 0
  #   target_boxes = rand(50..200)
  #   while boxes < target_boxes do
  #     x = rand(0..MAP_WIDTH * TILE_SIZE)
  #     y = rand(0..MAP_HEIGHT * TILE_SIZE)
  #     if tile_at(x, y) != @water
  #       Box.new(@object_pool, x, y)
  #       boxes += 1
  #     end
  #   end
  # end
  #
  # def generate_powerups
  #   pups = 0
  #   target_pups = rand(20..30)
  #   while pups < target_pups do
  #     x = rand(0..MAP_WIDTH * TILE_SIZE)
  #     y = rand(0..MAP_HEIGHT * TILE_SIZE)
  #     if tile_at(x, y) != @water &&
  #         @object_pool.nearby_point(x, y, 150).empty?
  #       random_powerup.new(@object_pool, x, y)
  #       pups += 1
  #     end
  #   end
  # end

  # def random_powerup
  #   [HealthPowerup,
  #    RepairPowerup,
  #    FireRatePowerup,
  #    TankSpeedPowerup].sample
  # end

  # def choose_tile(val)
  #   case val
  #   when 0.0..0.3 # 30% chance
  #     @water
  #   when 0.3..0.5 # 20% chance, water edges
  #     @sand
  #   else # 50% chance
  #     @grass
  #   end
  # end

end

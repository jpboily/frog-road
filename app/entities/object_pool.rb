# This class is an inspired by the ObjectPool class created by Tomas Varaneckas
# in his book "Developing Games with Ruby"
# Source: https://github.com/spajus/ruby-gamedev-book-examples
#
class ObjectPool
  attr_accessor :map, :camera, :objects

  def size
    @objects.size
  end

  def initialize(box)
    @tree = QuadTree.new(box)
    @objects = []
  end

  def add(object)
    @objects << object
    @tree.insert(object)
  end

  def tree_remove(object)
    @tree.remove(object)
  end

  def tree_insert(object)
    @tree.insert(object)
  end

  def update_all
    @objects.each(&:update)
    @objects.reject! do |o|
      if o.removable?
        @tree.remove(o)
        true
      end
    end
  end

  def nearby_point(cx, cy, max_distance, object = nil)
    hx, hy = cx + max_distance, cy + max_distance
    # Fast, rough results
    results = @tree.query_range(
      AxisAlignedBoundingBox.new([cx, cy], [hx, hy]))
    # Sift through to select fine-grained results
    results.select do |o|
      o != object &&
        Utils.distance_between(
          o.x, o.y, cx, cy) <= max_distance
    end
  end

  def nearby(object, max_distance)
    cx, cy = object.location
    nearby_point(cx, cy, max_distance, object)
  end

  def query_range(box)
    @tree.query_range(box)
  end
end

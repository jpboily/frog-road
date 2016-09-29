class FrogGraphics < Component
  FN_POS = 45
  FS_POS =  9
  FW_POS = 21
  FE_POS = 33
  FSAFE_POS = 11

  def initialize(game_object)
    super(game_object)
    @normal_frog = units[FN_POS]
    @safe_frog = units[FSAFE_POS]
    update
  end

  def update
    if object && object.safe?
      @image = @safe_frog
    else
      @image = @normal_frog
    end
  end

  def draw(viewport)
    @image.draw(x, y, 1000)
    Utils.mark_corners(object.box) if $debug
  end

  def width
    @image.width
  end

  def height
    @image.height
  end

  private

  def units
    @@units = Gosu::Image.load_tiles(
      $window, Utils.img_path('animales2.png'), 32, 32, false)
  end
end

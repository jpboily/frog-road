class FrogGraphics < Component
  FROG_UP_POS = 45
  FROG_DOWN_POS =  9
  FROG_LEFT_POS = 21
  FROG_RIGHT_POS = 33
  FROG_SAFE_POS = 11

  def initialize(game_object)
    super(game_object)
    @up_frog = units[FROG_UP_POS]
    @up_jump_frog = units[FROG_UP_POS+1]
    @down_frog = units[FROG_DOWN_POS]
    @down_jump_frog = units[FROG_DOWN_POS+1]
    @left_frog = units[FROG_LEFT_POS]
    @left_jump_frog = units[FROG_LEFT_POS+1]
    @right_frog = units[FROG_RIGHT_POS]
    @right_jump_frog = units[FROG_RIGHT_POS+1]
    @safe_frog = units[FROG_SAFE_POS]
    update
  end

  def update
    if object && object.safe?
      @image = @safe_frog
    else
      case object.direction
      when 0
        @image = (x % 32 == 0) ? @up_frog : @up_jump_frog
      when 90
        @image = (x % 32 == 0) ? @right_frog : @right_jump_frog
      when 180
        @image = (x % 32 == 0) ? @down_frog : @down_jump_frog
      when 270
        @image = (x % 32 == 0) ? @left_frog : @left_jump_frog
      end
      @image ||= @up_frog
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

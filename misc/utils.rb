module Utils
  # Allow to load any media file located in the media directory
  # using only relative path to the media directory anywhere in the game.
  #
  # e.g. Utils.media_path('sounds/frog/jump.ogg')
  #
  def self.media_path(file)
    File.join(File.dirname(File.dirname(File.dirname(
      __FILE__))), 'media', file)
  end

end
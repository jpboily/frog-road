#!/usr/bin/env ruby

require 'gosu'
require 'gosu_texture_packer'
require 'perlin_noise'

root_dir = File.join(File.dirname(__FILE__), 'app/')
require_pattern = File.join(root_dir, '**/*.rb')
@failed = []

# Dynamically require everything
Dir.glob(require_pattern).each do |f|
  next if f.end_with?('_spec.rb')
  begin
    require_relative f.gsub("#{root_dir}/", '')
  rescue
    # May fail if parent class not required yet
    @failed << f
  end
end

# Retry unresolved requires
@failed.each do |f|
  require_relative f.gsub("#{root_dir}/", '')
end

$debug = false

# Create a new State for level edition and an editor menu state
# $window = GameWindow.new
# GameState.switch(MenuState.instance)
# $window.show

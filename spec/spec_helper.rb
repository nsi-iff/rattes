require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'rattes'))
require 'pry-rails'

Dir[File.join(File.dirname(__FILE__), 'support', '**', '*.rb')].each do |f|
  require f
end

RSpec.configure do |config|
  config.include Rattes::Test::Resources
end
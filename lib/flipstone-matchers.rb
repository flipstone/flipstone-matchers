require "rspec"
require "flipstone-matchers/version"

Dir[File.join(File.dirname(__FILE__), 'flipstone-matchers/**/*.rb')].each do |file|
  require file
end

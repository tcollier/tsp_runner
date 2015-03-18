$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tsp_runner'

require 'factory_girl'
require 'faker'
require 'pry'

Dir.glob(File.join(File.dirname(__FILE__), 'factories', '*')).each do |file|
  require file
end

RSpec.configure do |config|
  # Mock Framework
  config.mock_with :mocha

  # Allow calls to #create and #build without typing FactoryGirl. Example:
  # user = create(:user, email: 'foo@bar.com')
  config.include FactoryGirl::Syntax::Methods
end

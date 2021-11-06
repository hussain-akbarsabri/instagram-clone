# frozen_string_literal: true

require_relative 'controller_macros'

RSpec.configure do |config|
  config.extend ControllerMacros, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Devise::Test::ControllerHelpers, type: :view
end

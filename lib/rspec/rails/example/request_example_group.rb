require 'action_dispatch'
require 'webrat'

module RequestExampleGroupBehaviour
  include ActionDispatch::Assertions
  include ActionDispatch::Integration::Runner
  include Webrat::Matchers
  include Webrat::Methods
  Rails.application.routes.install_helpers(self)

  def app
    Rails.application
  end

  Webrat.configure do |config|
    config.mode = :rack
  end

  def last_response
    response
  end
  
  Rspec.configure do |c|
    c.include self, :example_group => { :file_path => /\bspec\/requests\// }
  end
end

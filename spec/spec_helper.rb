require 'piwik'

RSpec.configure do |config|
  require 'factory_girl'
  Dir[File.join(File.dirname(__FILE__),'spec','support''**','*.rb')].each {|f| require f}
  config.mock_with :rspec
  config.order = "random"
  config.include FactoryGirl::Syntax::Methods
  FactoryGirl.find_definitions
end

def stub_rails_env &block
  Object.const_set("RAILS_ROOT", File.join(File.dirname(__FILE__),"files"))
  yield
  Object.const_set("RAILS_ROOT",nil)
end

def success_response
  File.join(File.dirname(__FILE__),'files',"success.xml")
end

def failure_response
  File.join(File.dirname(__FILE__),'files',"failure.xml")
end

def stub_api_calls
  # Stubbing the main API call method. Methods without a specific stub
  # will always return a success response
  Piwik::Base.stub(:call) do |method,params,piwik_url,auth_token|
    resp_file = File.join(File.dirname(__FILE__),'files',"#{method}.xml")
    xml = if File.exists?(resp_file)
      File.read resp_file
    else
      File.read File.join(success_response)
    end

    if xml =~ /error message=/
      result = XmlSimple.xml_in(xml, {'ForceArray' => false})
      raise Piwik::ApiError, result['error']['message'] if result['error']
    end
    xml
  end
end

PIWIK_URL = 'http://piwik.test'
PIWIK_TOKEN = 'testtoken'
require 'capybara/rspec'

Capybara.register_driver :remote_chrome do |app|
  url = ENV['SELENIUM_DRIVER_URL']

  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--no-sandbox')
  options.add_argument('--headless')

  Capybara::Selenium::Driver.new(app, browser: :remote, url: url, options: options)
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :remote_chrome
    Capybara.server_host = IPSocket.getaddress(Socket.gethostname)
    Capybara.server_port = 4444
    Capybara.app_host = "http://#{Capybara.server_host}:#{Capybara.server_port}"
  end
end

# config/initializers/web_rake.rb

if Rails.env.development? || Rails.env.tes?
  WebRake.configure do |config|
    config.username = 'Loveis1988'
    config.password = 'Loveis1988'
  end
end

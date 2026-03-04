# config/initializers/web_rake.rb

if Rails.env.development? || Rails.env.tes?
  WebRake.configure do |config|
    config.username = 'custom_username'
    config.password = 'custom_password'
  end
end

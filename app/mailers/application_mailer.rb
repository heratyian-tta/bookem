class ApplicationMailer < ActionMailer::Base
  
  # Default sender address for all emails
  default from: "help@bookem.com"
  
  # Default layout for email templates
  layout "mailer"
  
  # Helper methods available in all mailers
  helper :application
  
  # Add common headers to all emails
  default "X-Application-Name" => "MyApp",
          "X-Mailer" => "Rails Action Mailer"
end

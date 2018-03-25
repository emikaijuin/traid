Rails.application.config.middleware.use OmniAuth::Builder do
 provider :facebook, ENV['FACEBOOK_APP_KEY'], ENV['FACEBOOK_APP_SECRET'], scope: 'email', info_fields: 'email, first_name, last_name'
  provider :google_oauth2, ENV['GOOGLE_APP_ID'], ENV['GOOGLE_APP_SECRET'], {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}

end
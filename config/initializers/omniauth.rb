Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, Rails.application.credentials.facebook[:app_id], Rails.application.credentials.facebook[:app_secret]
    provider :google_oauth2, Rails.application.credentials.google[:client_id], Rails.application.credentials.google[:client_secret]
    provider :twitter, Rails.application.credentials.twitter[:api_key], Rails.application.credentials.twitter[:api_secret_key]
    provider :github, Rails.application.credentials.github[:client_id], Rails.application.credentials.github[:client_secret]
end
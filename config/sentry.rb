Raven.configure do |config|
  config.dsn = 'https://be371897990b45c8946172ede69a1d37:43c72917559a4230b19557b10db8734c@sentry.io/1781153'
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end
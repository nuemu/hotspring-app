Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://www.yutellite.com'
    resource '*', headers: :any, methods: [:get, :post, :delete, :patch, :put], expose: ['X-CSRF-Token'], credentials: true
  end
end

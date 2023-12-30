Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins Settings.front_domain, Settings.front_domain_next

    resource "*",
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
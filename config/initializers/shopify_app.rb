ShopifyApp.configure do |config|
  config.application_name = "BACK IN STOCK App"
  config.api_key = ENV["API_KEY"]
  config.secret = ENV["API_SECRET"]
  config.scope = "read_products,read_script_tags, write_script_tags"
  config.embedded_app = true
  config.webhooks=[
        {topic: 'products/update', address: "#{ENV['DOMAIN']}/webhooks/products_update", format: 'json'},
        {topic: 'app/uninstalled', address: "#{ENV['DOMAIN']}/webhooks/app_uninstalled", format:'json'}
        ]   
  config.after_authenticate_job = false
  config.session_repository = Shop
end

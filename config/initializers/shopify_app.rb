ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.api_key = ENV["API_KEY"]
  config.secret = ENV["API_SECRET"]
  config.scope = "read_orders, read_products,write_products,read_themes,
                  write_themes,read_customers,write_customers,write_customers,
                  read_customers,read_script_tags, write_script_tags"
  config.embedded_app = true
  config.webhooks=[
        {topic: 'products/update', address: 'https://pwa.serveo.net/webhooks/products_update', format: 'json'},
        {topic: 'app/uninstalled', address: 'https://pwa.serveo.net/webhooks/app_uninstalled', format:'json'}
        ]   
  config.after_authenticate_job = false
  config.session_repository = Shop
end

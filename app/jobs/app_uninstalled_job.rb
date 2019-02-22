class AppUninstalledJob < ApplicationJob
  queue_as :default

  def perform(shop_domain: , webhook:)
    
    shop_data=Shop.find_by_shopify_domain(shop_domain)
    shop_data.with_shopify_session do
    shop_data.destroy
    end
  end
end

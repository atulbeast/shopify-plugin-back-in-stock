class ProductsUpdateJob < ApplicationJob
  queue_as :default

  def perform(shop_domain:, webhook:)
    shop = Shop.find_by(shopify_domain: shop_domain)
    shop.with_shopify_session do
       variants=[]
        webhook["variants"].each do |item|
          variants.push({id:item["id"],quantity: item["inventory_quantity"] })
        end
     
        button=Button.find_by(shop_id:shop.id)
        variants.each do |item|
          product_model= shop.accounts.where(variant_id:item[:id], active:true).first
         if (product_model.present? && item[:quantity] > 0)
          if product_model.contact.present?
            TwilioTextMessenger.new("#{button.text_msg} #{product_model.product} is back in stock",product_model.contact).call
          end
          
          UserMailer.notify(product_model,button.mail_msg,shop_domain).deliver_now     
          product_model.active=false
          product_model.save
         end
        end
    end
    
  end
end

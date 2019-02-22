require './lib/url_api.rb'
class HomeController < ShopifyApp::AuthenticatedController
  def index
    shop_name=session[:shopify_domain]
    shop_obj=Shop.find_by_shopify_domain(shop_name) 
    if shop_obj.present?
      unless shop_obj.install
        url_obj=UrlApi.new(shop_obj.shopify_domain)
        url_obj.add_script(shop_obj.shopify_token)
        shop_obj.install=true
        shop_obj.save!
      end
    end
  end


  def settings
    shop_name=session[:shopify_domain]
    shop_obj=Shop.find_by_shopify_domain(shop_name) 
    if shop_obj.present?
      if shop_obj.button.present?
         @button= shop_obj.button
      else
        @button=Button.new
        @button.shop_id=shop_obj.id
      end
    end
  end

  def settings_post
    if button_params[:shop_id].present?
       shop_obj= Shop.find_by_id(button_params[:shop_id])
       @shop_name=shop_obj.shopify_domain
       record= Button.find_by(shop_id: icon_params[:shop_id])
     if record.present?
         record.update(icon_params)
     else
       record=Icon.new(icon_params)
       record.save
     end
    end
    redirect_to action: 'index', shop: @shop_name
  end

  def  user_requests
    shop_name=session[:shopify_domain]
    shop=Shop.find_by_shopify_domain(shop_name)
    @list=[]
    if(shop.present?)
     @list=shop.accounts 
    end

  end



end

require './lib/url_api.rb'
class HomeController < ShopifyApp::AuthenticatedController
  
  def index
    @shop_name=session[:shopify_domain]
    shop_obj=Shop.find_by_shopify_domain(@shop_name) 
    if shop_obj.present?
      @total_chart = Account.totals_by_year_month
      @shop_chart = Account.shop_by_year_month(shop_obj.id)
      @variant_chart=Account.variant_by_year_month(shop_obj.id)
      unless shop_obj.install
        url_obj=UrlApi.new(shop_obj.shopify_domain)
        url_obj.add_script(shop_obj.shopify_token)
        shop_obj.install=true
        shop_obj.save!
      end
    end
  end


  def settings
    shop_name=params[:s_domain]
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

 

  def delete_notification
        account=Account.find(params[:id])
        account.destroy
        render 'index'
  end

  def edit
     @account= Account.find(params[:id])
  end

  

  def  user_requests
    shop_name=session[:s_domain]
    shop=Shop.find_by_shopify_domain(shop_name)
    @list=[]
    if(shop.present?)
     @list=shop.accounts 
    end

  end

private 
def account_params
  params.require(:account).permit(:email, :contact,  :variant_id, :product,:shop_id,:id,:active)
end 
def button_params
  params.require(:button).permit(:id, :button_name,:notify_message,:form_title,:shop_id, :mail_msg,:text_msg)
end
end

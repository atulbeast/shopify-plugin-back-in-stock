class ManageController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :initialize_shop

    def saveacc 
        
        if params[:shop].present?
            acc=Account.new(acc_params)  
             shop=  Shop.find_by_shopify_domain params[:shop]
             if shop.present?
                acc.shop_id=shop.id
                acc.save
                render json: {}, status: 200
            end
        else
            render json: {}, status: 401
        end
    end


    

private
    def acc_params
       params.require(:account).permit(:email, :contact,  :variant_id, :product)
    end
    def initialize_shop
        @shop_name=params[:shop]
    end
end

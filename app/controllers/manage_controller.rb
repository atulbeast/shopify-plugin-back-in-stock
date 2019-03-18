class ManageController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :initialize_shop

    def saveacc 
        if params[:shop].present?
            shop=Shop.find_by_shopify_domain(params[:shop])
            acc=Account.new(acc_params)  
            
             if shop.present?
                acc.shop_id=shop.id
                acc.save
                render json: {}, status: 200
            end
        else
            render json: {}, status: 401
        end
    end
    def settings_post
        if button_params[:shop_id].present?
           shop_obj= Shop.find_by_id(button_params[:shop_id])
           @shop_name=shop_obj.shopify_domain
           record= Button.find_by(shop_id: shop_obj.id)
         if record.present?
             record.update(button_params)
         else
           record=Button.new(button_params)
           record.save
         end
        end
        redirect_to "/"
      end


    def delete_acc
        
        account=Account.find(params[:id])
        msg="successfully deleted"
          if  account.present?
            account.destroy
            msg="record doesn't exist"
          end
        shop=Shop.find_by_shopify_domain session[:shopify_domain]
        render :json => {list: shop.accounts, msg: msg  }
    end

    def update_record
        
        if account_params[:id].present?
          account_info=Account.find(account_params[:id])
          account_info.update(account_params)
        end
        redirect_to user_requests_url
    end

    def notification
        shop=  Shop.find_by_shopify_domain params[:shop]
        if shop.present?
            if shop.button.present?
                @btn_name=shop.button.button_name
                @form_title=shop.button.form_title
                @notify_msg=shop.button.notify_message
            else
                @btn_name=I18n.t('bname')
                @form_title=I18n.t('emailstock')
                @notify_msg=I18n.t('rsuccess')
            end

        end
    end

    


    

private
    def acc_params
        params.require(:account).permit(:email, :contact,  :variant_id, :product)
    end
    def account_params
        params.require(:account).permit(:email, :contact,  :variant_id, :product,:shop_id,:id,:active)
      end 
    def initialize_shop
        @shop_name=params[:shop]
    end
    def button_params
        params.require(:button).permit(:id, :button_name,:notify_message,:form_title,:shop_id, :mail_msg,:text_msg)
    end
end

require 'httparty'

class UrlApi
 
  def initialize(shop)
   @script_url="https://#{shop}/admin/script_tags.json"
   @shop_name="https://#{shop}"
   @script_delete_url="https://#{shop}/admin/script_tags"
   @charge_url="https://#{shop}/admin/recurring_application_charges.json"
  end



  def add_script(token)
    HTTParty.post(@script_url,headers: {"X-Shopify-Access-Token" =>token },:query => payload_data("notification"))
    HTTParty.post(@charge_url,headers: {"X-Shopify-Access-Token" =>token },:query => payload_charge)
  end

  def payload_data(file_name)
    {
  "script_tag": {
    "event": "onload",
    "src": "#{@shop_name}/apps/stock-app/js/#{file_name}"
          }
      }   
  end

  def remove_script(id,token)
    HTTParty.delete("#{@script_delete_url}/#{id}.json",headers: {"X-Shopify-Access-Token" =>token})
  end

  def get_script(token)
    HTTParty.get(@script_url,headers: {"X-Shopify-Access-Token" =>token })
  end
  def payload_charge
    {
      "recurring_application_charge": {
        "name": "Super Duper Plan",
        "price": 10.0,
        "return_url": @shop_name,
        "trial_days": 5
      }
    }   
  end

  
end
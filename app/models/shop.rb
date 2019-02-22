class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_many :accounts, dependent: :destroy
end

class Shop < ActiveRecord::Base
  include ShopifyApp::SessionStorage
  has_many :accounts, dependent: :destroy
  has_one :button, dependent: :destroy
end

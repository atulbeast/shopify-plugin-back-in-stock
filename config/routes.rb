Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  post 'myshopapp/saveacc'=> 'manage#saveacc'
  get 'myshopapp/js/notification'=> 'manage#notification'
  get 'user_requests'=> 'home#user_requests'
  get 'myshopapp/pagesetup'=> 'home#settings'
  post 'settings_post'=>'manage#settings_post'
  post 'update' => 'manage#update_record'
  get 'edit'=> 'home#edit'
  get 'delete'=> 'home#delete_notification'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

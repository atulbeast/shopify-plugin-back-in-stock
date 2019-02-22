Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  post 'myshopapp/saveacc'=> 'manage#saveacc'
  get 'myshopapp/js/notification'=> 'manage#notification'
  get 'user_requests'=> 'home#user_requests'
  get 'settings'=> 'home#settings'
  post 'settings_post'=>'home#settings_post'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

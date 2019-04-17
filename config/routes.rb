Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  post 'stock-app/saveacc'=> 'manage#saveacc'
  post 'stock-app/settings_post'=>'manage#settings_post'
  post 'stock-app/update' => 'manage#update_record'
  get 'stock-app/js/notification'=> 'manage#notification'
  get 'stock-app/notification/delete'=>'manage#delete_acc'
  get 'stock-app/user/requests'=> 'home#user_requests'
  get 'stock-app/test'=>'home#test'
  get 'stock-app/pagesetup'=> 'home#settings'
  get 'edit'=> 'home#edit'
  get 'delete'=> 'home#delete_notification'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'pair/(:token)' => 'landing#pair'
  root 'landing#index'
end

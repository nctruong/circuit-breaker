Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/', to: 'home#index'
  get '/without-timeout', to: 'home#without_timeout'
  get '/with-timeout', to: 'home#with_timeout'
  get '/default-cb', to: 'home#default_circuit_breaker'
  get '/custom-cb', to: 'home#custom_circuit_breaker'
  get '/recover-cb', to: 'home#recover_cb'
end

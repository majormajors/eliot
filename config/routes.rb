Eliot::Application.routes.draw do
  resources :servers
  resources :reports do
    resources :metrics
  end
  root :to => 'servers#index'
end

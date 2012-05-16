Eliot::Application.routes.draw do
  resources :servers do
    resources :reports
  end
  root :to => 'servers#index'
end

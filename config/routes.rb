# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
resources :issues, only: [] do
  resources :interventions
end
Lunchomizer::Application.routes.draw do
  root :to => 'lunch#index'
  match '/:controller(/:action(/:id))'
end

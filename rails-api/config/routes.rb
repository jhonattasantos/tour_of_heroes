Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, as: '' do
    resources :heros
  end
end

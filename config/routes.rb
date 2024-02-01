Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  post "/graphql", to: "graphql#execute"
  root to: proc { [200, {}, ['API is live and well to use.']] }

  mount_devise_token_auth_for 'User', at: 'api/v1/auth', controllers: {
    sessions:      'api/v1/auth/sessions',
    passwords:     'api/v1/auth/passwords',
    registrations: 'api/v1/auth/registrations',
    confirmations: 'api/v1/auth/confirmations'
  }, skip: [:omniauth_callbacks]

  # Since heroku runs in prod, we need to enable graphql engine there as well, we can disable later on
  # unless Rails.env.production?
    post '/graphql_dev', to: 'api/v1/graphql#execute_dev'
    mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql_dev'
  # end

  post 'api/v1/graphql', to: 'api/v1/graphql#execute'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users
    end
  end

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users

      resources :forms, only: [] do
        collection do
          get 'generate_otp'
          post 'verify_otp'
        end
      end
    end
  end
end

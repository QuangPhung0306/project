Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  constraints subdomain: 'admin' do
    devise_for :admin_users, ActiveAdmin::Devise.config.merge(path: '/')
    ActiveAdmin.routes(self)
  end

  constraints subdomain: 'api' do
    scope module: 'api/v1' do
      resources :categories, only: :index, defaults: {format: 'json'} do
        resources :posts, only: [:index, :show], defaults: {format: 'json'}
      end
      get '/posts/:id' => 'posts#show', defaults: {format: 'json'}, as: :post_detail
    end
  end
end

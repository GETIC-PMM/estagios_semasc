Rails.application.routes.draw do
  root "site#index"
  match '500', :to => 'errors#internal_server_error', :via => :all
  match '422', :to => 'errors#unacceptable', :via => :all
  match '404', :to => 'errors#not_found', :via => :all
  RESPOND_404.map { |r2|  get "/#{r2}", to: redirect("/404") } 

  post "estagiarios", controller: :site, action: :estagiarios, as: :site_estagiarios
  get "consulta", controller: :site, action: :consulta
  post "consultar", controller: :site, action: :consultar
  patch "update_curriculo/:id", to: "site#update_curriculo", as: "update_curriculo"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # rotas da Área Administrativa
  get "admin", controller: :admin, action: :index, as: :admin_root
  devise_for :usuarios, path: 'admin',
    path_names: { sign_in: 'entrar', sign_out: 'sair', password: 'alterar_senha' }
  namespace :admin do
    resources :audits, only: [:show]
    resources :usuarios do
      collection do
        get 'search'
        post 'datatable'
      end
    end
    resources :estagiarios do
      collection do
        get 'search'
        post 'datatable'
      end
    end
    resources :cursos do
      collection do
        get 'search'
        post 'datatable'
      end
    end
    resources :secretarias do
      collection do
        get 'search'
        post 'datatable'
      end
    end
    resources :solicitacoes do
      collection do
        get 'search'
        post 'datatable'
      end
    end
    resources :indicacoes do
      collection do
        get 'search'
        post 'datatable'
      end
      member do
        put 'selecionar'
        put 'nao_selecionar'
      end
    end
  end
end

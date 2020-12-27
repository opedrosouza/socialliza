Rails.application.routes.draw do
  get 'schedules/index'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, path: '/', 
    path_names: { 
      sign_in: 'entrar',
      sign_out: 'sair',
      password: 'secret',
      confirmation: 'verification',
      unlock: 'unblock',
      registration: 'cadastro',
      sign_up: 'cadastrar'
    }
  resources :rooms
  resources :schedules
  root to: 'pages#home'
end

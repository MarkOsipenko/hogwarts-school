Rails.application.routes.draw do
  resources :teachers do
    resources :teacher_subjects, shallow: true
  end

  resources :subjects
  resources :schedules
  resources :sections, only: :index

  root to: 'subjects#index'
end

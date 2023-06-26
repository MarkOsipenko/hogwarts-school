Rails.application.routes.draw do
  resources :teachers do
    resources :teacher_subjects, shallow: true
  end

  resources :subjects
  resources :schedule

  root to: 'subjects#index'
end

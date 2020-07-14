HealthAPI::App.controllers :reset do
  post :index do
    PlanRepository.new.delete_all
    'ok'
  end
end

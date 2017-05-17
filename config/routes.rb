Rails.application.routes.draw do
 #'regression/logistic_regression_best_theta', via: [:get, :post]
 match 'logistic_regression/find_best_thetas', to: 'logistic_regression#find_best_thetas', via: [:post]
 match 'logistic_regression/calcuate_cost', to: 'logistic_regression#calcuate_cost', via: [:post]
 match 'logistic_regression/cost_and_gradient_descent', to: 'logistic_regression#cost_and_gradient_descent', via: [:post]
 match 'linear_regression/calculate_cost', to: 'linear_regression#calculate_cost', via: [:post]
 match 'linear_regression/cost_and_gradient_descent', to: 'linear_regression#cost_and_gradient_descent', via: [:post]
 match 'linear_regression/find_best_thetas', to: 'linear_regression#find_best_thetas', via: [:post]
 #post 'regression/logistic_regression_best_theta'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

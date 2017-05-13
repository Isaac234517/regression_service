class RegressionController < ApplicationController
  def logistic_regression_best_theta
  	data_string = params['data'] || request.body.read
  	data = JSON.parse(data_string)
  	theta = []
  	data[0].length.times{ |num|
  		theta << 0
  	}
  	x_y = LogisticRegression.divide_data(data)
  	handler = LogisticRegression.new(x_y[0], x_y[1], theta)
  	p 'cost is', handler.cost_function
    #handler.grad_descent
  end
end

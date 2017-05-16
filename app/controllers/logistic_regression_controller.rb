class LogisticRegressionController < ApplicationController
  before_action :parse_params
  def find_best_thetas
    p 'calculate cost function'
  	p "cost is  #{@handler.cost_function}"
    p "run gradient descent at thetas #{@handler.thetas.inspect}"
    best_thetas = @handler.grad_descent
    p "new theta is #{best_thetas.inspect}"
    send_respond({'best_thetas' => best_thetas})
  end

  def calcuate_cost
    p "Calculate logistic regression cose at thetas #{@handler.thetas.inspect}"
    cost = @handler.cost_function
    p "Cost is #{cost}"
    send_respond({'cost' => cost})
  end

  def cost_and_grad_descent
    p 'calculate cost function'
    p "cost is  #{@handler.cost_function}"
    p "run gradient descent at thetas #{@handler.thetas.inspect}"
    best_thetas = @handler.grad_descent
    p "new theta is #{best_thetas.inspect}"
    send_respond({'best_thetas' => best_thetas})
  end

  def parse_params
    data_string = params['data'] || request.body.read
    data = JSON.parse(data_string)
    raise 'error' unless data.key?('dataset')
    unless data.key?('thetas')
      thetas = data['dataset'][0].map{|ele| 0}
    else
      thetas = data['thetas']
    end
    x_y = LogisticRegression.divide_data(data['dataset'])
    @handler = LogisticRegression.new(x_y[0], x_y[1], thetas)
  end
end

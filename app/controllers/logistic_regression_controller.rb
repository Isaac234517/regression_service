class LogisticRegressionController < ApplicationController
  before_action :parse_params
  def find_best_thetas
    raise 'error' if @iterations.nil?
    cost = @handler.cost_function
    arr = []
    (@iterations-1).times{ |num|
      gradient = @handler.gradient_descent
      @handler.update_thetas(gradient, 0.01)
      p "thetas #{@handler.thetas.inspect} at iteration #{num}"
      new_cost = @handler.cost_function
      p "new cost #{new_cost}"
      break if new_cost - cost>=0
      cost = new_cost
    }
    p "new theta is #{@handler.thetas.inspect}"
    send_respond({'best_thetas' => @handler.thetas})
  end

  def calcuate_cost
    p "Calculate logistic regression cose at thetas #{@handler.thetas.inspect}"
    cost = @handler.cost_function
    p "Cost is #{cost}"
    send_respond({'cost' => cost})
  end

  def cost_and_gradient_descent
    p 'calculate cost function at thetas #{@handler.thetas.inspect}'
    cost = @handler.cost_function
    p "cost is  #{@handler.cost_function}"
    p "run gradient descent at thetas #{@handler.thetas.inspect}"
    gradient = @handler.gradient_descent
    p "gradient is #{gradient.inspect}"
    send_respond({:cost => cost, :gradient => gradient})
  end

  def parse_params
    data_string = params[:data] || request.body.read
    data = MultiJson.load(data_string, :symbolize_keys => true)
    raise 'error' unless data.key?(:dataset)
    x_y = LogisticRegression.divide_data(data[:dataset])
    unless data.key?(:thetas)
      thetas = x_y[0][0].map{|ele| 0}
    else
      thetas = data[:thetas]
    end
    @handler = LogisticRegression.new(x_y[0], x_y[1], thetas)
    @iterations =  data[:iterations] if data.key?(:iterations)
  end
end

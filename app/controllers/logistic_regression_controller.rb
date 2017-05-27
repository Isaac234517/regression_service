class LogisticRegressionController < ApplicationController
  before_action :parse_params

  def find_best_thetas
    raise 'error' if @iterations.nil?
    if @standardization == true
      transpose_feature = MathUtil.transpose(@handler.x)
      after_standardization = transpose_feature.map.with_index do |element, index|
        MathUtil.standardization(element) if index !=0
      end
      transpose_feature = [transpose_feature[0]] + after_standardization.compact
      @handler.x = MathUtil.transpose(transpose_feature)
    end

    cost = @handler.cost_function
    p "Initial Thetas is #{@handler.thetas.inspect}"
    num = 0
    begin
      num+=1
      gradient = @handler.gradient_descent
      @handler.update_thetas(gradient, @learning_rate)
      p "thetas #{@handler.thetas.inspect} at iteration #{num}"
      new_cost = @handler.cost_function
      p "new cost #{new_cost}"
      break if new_cost - cost>=0.01
      cost = new_cost
    end while num < @iterations

    p "Best thetas is #{@handler.thetas.inspect} after running #{num} iterations"
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
    @iterations =  data[:iterations] || 1
    @standardization = data[:standardization] || false
    @learning_rate = data[:learning_rate] || 0.1
  end
end

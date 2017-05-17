class LinearRegressionController < ApplicationController
  before_action :parse_params

  def find_best_thetas
  	cost = @handler.cost_function
  	p "Initial thetas is #{@handler.thetas.inspect}"
  	num = 0
  	begin 
  	  gradient = @handler.gradient_descent
  	  p gradient
  	  @handler.update_thetas(gradient,0.01)
  	  p "After upate thetas at iteration #{num+1} #{@handler.thetas.inspect}"
  	  new_cost = @handler.cost_function
  	  p new_cost
  	  break if new_cost - cost >=0.01
  	  cost = new_cost
  	  num+=1
  	end while num < @iterations

  	p "Best thetas is #{@handler.thetas.inspect} after running interation #{num}"
  	send_respond({'best_thetas' => @handler.thetas})
  end

  def calculate_cost
  	p "Calculate cost at theats #{@handler.thetas.inspect}"
  	cost = @handler.cost_function
    p "Cost is #{cost}"
    send_respond({'cost' => cost})
  end

  def cost_and_gradient_descent
  	p "Calculate cost at theats #{@handler.thetas.inspect}"
  	cost = @handler.cost_function
  	p "Cost is #{cost}"
  	p "Calcuate its gradient at thetas#{@handler.thetas.inspect}"
  	gradient = @handler.gradient_descent
  	@handler.update_thetas(gradient,0.01)
  	p @handler.thetas
  	p "gradient is #{gradient.inspect}"
  	send_respond({'cost' => cost, 'grad' => gradient})
  end

  def parse_params
    data_string = params['data'] || request.body.read
    data = JSON.parse(data_string)
    raise 'error' unless data.key?('dataset')
    x_y = LinearRegression.divide_data(data['dataset'])
    unless data.key?('thetas')
      thetas = x_y[0][0].map{|ele| 0}
    else
      thetas = data['thetas']
    end
    @handler = LinearRegression.new(x_y[0], x_y[1], thetas)
    @iterations =  data['iterations'] if data.key?('iterations')
  end

end
